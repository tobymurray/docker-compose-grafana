CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE temperature (
  id SERIAL NOT NULL PRIMARY KEY,
  client_time TIMESTAMP NOT NULL,
  mac CHARACTER VARYING (17),
  temperature numeric NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_temperature_timestamp
BEFORE UPDATE ON temperature
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE humidity (
  id SERIAL NOT NULL PRIMARY KEY,
  client_time TIMESTAMP NOT NULL,
  mac CHARACTER VARYING (17),
  humidity numeric NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_humidity_timestamp
BEFORE UPDATE ON humidity
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();
