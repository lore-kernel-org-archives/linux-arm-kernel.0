From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sun, 24 Apr 2016 20:28:06 +0100
Subject: [PATCH 02/12] eeprom: at24: remove nvmem regmap dependency
In-Reply-To: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1461526096-29584-3-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves to nvmem support in the driver to use callback instead
of regmap.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/eeprom/Kconfig |   1 -
 drivers/misc/eeprom/at24.c  | 103 ++++++++++----------------------------------
 2 files changed, 22 insertions(+), 82 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index cfc493c..2d70464 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -3,7 +3,6 @@ menu "EEPROM support"
 config EEPROM_AT24
 	tristate "I2C EEPROMs / RAMs / ROMs from most vendors"
 	depends on I2C && SYSFS
-	select REGMAP
 	select NVMEM
 	help
 	  Enable this driver to get read/write support to most I2C EEPROMs
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 089d694..de550a6 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -23,7 +23,6 @@
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/nvmem-provider.h>
-#include <linux/regmap.h>
 #include <linux/platform_data/at24.h>
 
 /*
@@ -69,7 +68,6 @@ struct at24_data {
 	unsigned write_max;
 	unsigned num_addresses;
 
-	struct regmap_config regmap_config;
 	struct nvmem_config nvmem_config;
 	struct nvmem_device *nvmem;
 
@@ -252,10 +250,10 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	return -ETIMEDOUT;
 }
 
-static ssize_t at24_read(struct at24_data *at24,
-		char *buf, loff_t off, size_t count)
+static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 {
-	ssize_t retval = 0;
+	struct at24_data *at24 = priv;
+	char *buf = val;
 
 	if (unlikely(!count))
 		return count;
@@ -267,23 +265,21 @@ static ssize_t at24_read(struct at24_data *at24,
 	mutex_lock(&at24->lock);
 
 	while (count) {
-		ssize_t	status;
+		int	status;
 
 		status = at24_eeprom_read(at24, buf, off, count);
-		if (status <= 0) {
-			if (retval == 0)
-				retval = status;
-			break;
+		if (status < 0) {
+			mutex_unlock(&at24->lock);
+			return status;
 		}
 		buf += status;
 		off += status;
 		count -= status;
-		retval += status;
 	}
 
 	mutex_unlock(&at24->lock);
 
-	return retval;
+	return 0;
 }
 
 /*
@@ -372,13 +368,13 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 	return -ETIMEDOUT;
 }
 
-static ssize_t at24_write(struct at24_data *at24, const char *buf, loff_t off,
-			  size_t count)
+static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 {
-	ssize_t retval = 0;
+	struct at24_data *at24 = priv;
+	char *buf = val;
 
 	if (unlikely(!count))
-		return count;
+		return -EINVAL;
 
 	/*
 	 * Write data to chip, protecting against concurrent updates
@@ -387,70 +383,23 @@ static ssize_t at24_write(struct at24_data *at24, const char *buf, loff_t off,
 	mutex_lock(&at24->lock);
 
 	while (count) {
-		ssize_t	status;
+		int status;
 
 		status = at24_eeprom_write(at24, buf, off, count);
-		if (status <= 0) {
-			if (retval == 0)
-				retval = status;
-			break;
+		if (status < 0) {
+			mutex_unlock(&at24->lock);
+			return status;
 		}
 		buf += status;
 		off += status;
 		count -= status;
-		retval += status;
 	}
 
 	mutex_unlock(&at24->lock);
 
-	return retval;
-}
-
-/*-------------------------------------------------------------------------*/
-
-/*
- * Provide a regmap interface, which is registered with the NVMEM
- * framework
-*/
-static int at24_regmap_read(void *context, const void *reg, size_t reg_size,
-			    void *val, size_t val_size)
-{
-	struct at24_data *at24 = context;
-	off_t offset = *(u32 *)reg;
-	int err;
-
-	err = at24_read(at24, val, offset, val_size);
-	if (err)
-		return err;
-	return 0;
-}
-
-static int at24_regmap_write(void *context, const void *data, size_t count)
-{
-	struct at24_data *at24 = context;
-	const char *buf;
-	u32 offset;
-	size_t len;
-	int err;
-
-	memcpy(&offset, data, sizeof(offset));
-	buf = (const char *)data + sizeof(offset);
-	len = count - sizeof(offset);
-
-	err = at24_write(at24, buf, offset, len);
-	if (err)
-		return err;
 	return 0;
 }
 
-static const struct regmap_bus at24_regmap_bus = {
-	.read = at24_regmap_read,
-	.write = at24_regmap_write,
-	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
-};
-
-/*-------------------------------------------------------------------------*/
-
 #ifdef CONFIG_OF
 static void at24_get_ofdata(struct i2c_client *client,
 		struct at24_platform_data *chip)
@@ -482,7 +431,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
-	struct regmap *regmap;
 
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
@@ -612,19 +560,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
-	at24->regmap_config.reg_bits = 32;
-	at24->regmap_config.val_bits = 8;
-	at24->regmap_config.reg_stride = 1;
-	at24->regmap_config.max_register = chip.byte_len - 1;
-
-	regmap = devm_regmap_init(&client->dev, &at24_regmap_bus, at24,
-				  &at24->regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "regmap init failed\n");
-		err = PTR_ERR(regmap);
-		goto err_clients;
-	}
-
 	at24->nvmem_config.name = dev_name(&client->dev);
 	at24->nvmem_config.dev = &client->dev;
 	at24->nvmem_config.read_only = !writable;
@@ -632,6 +567,12 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->nvmem_config.owner = THIS_MODULE;
 	at24->nvmem_config.compat = true;
 	at24->nvmem_config.base_dev = &client->dev;
+	at24->nvmem_config.reg_read = at24_read;
+	at24->nvmem_config.reg_write = at24_write;
+	at24->nvmem_config.priv = at24;
+	at24->nvmem_config.stride = 4;
+	at24->nvmem_config.word_size = 1;
+	at24->nvmem_config.size = chip.byte_len;
 
 	at24->nvmem = nvmem_register(&at24->nvmem_config);
 
-- 
2.5.0
