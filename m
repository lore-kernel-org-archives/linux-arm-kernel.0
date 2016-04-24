From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sun, 24 Apr 2016 20:28:07 +0100
Subject: [PATCH 03/12] eeprom: at25: remove nvmem regmap dependency
In-Reply-To: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1461526096-29584-4-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves to nvmem support in the driver to use callback instead
of regmap.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/eeprom/Kconfig |  1 -
 drivers/misc/eeprom/at25.c  | 89 ++++++++++-----------------------------------
 2 files changed, 19 insertions(+), 71 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 2d70464..c4e41c2 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -31,7 +31,6 @@ config EEPROM_AT24
 config EEPROM_AT25
 	tristate "SPI EEPROMs from most vendors"
 	depends on SPI && SYSFS
-	select REGMAP
 	select NVMEM
 	help
 	  Enable this driver to get read/write support to most SPI EEPROMs,
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index fa36a6e..a2858b3 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -17,7 +17,6 @@
 #include <linux/sched.h>
 
 #include <linux/nvmem-provider.h>
-#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/property.h>
@@ -34,7 +33,6 @@ struct at25_data {
 	struct mutex		lock;
 	struct spi_eeprom	chip;
 	unsigned		addrlen;
-	struct regmap_config	regmap_config;
 	struct nvmem_config	nvmem_config;
 	struct nvmem_device	*nvmem;
 };
@@ -65,14 +63,11 @@ struct at25_data {
 
 #define	io_limit	PAGE_SIZE	/* bytes */
 
-static ssize_t
-at25_ee_read(
-	struct at25_data	*at25,
-	char			*buf,
-	unsigned		offset,
-	size_t			count
-)
+static int at25_ee_read(void *priv, unsigned int offset,
+			void *val, size_t count)
 {
+	struct at25_data *at25 = priv;
+	char *buf = val;
 	u8			command[EE_MAXADDRLEN + 1];
 	u8			*cp;
 	ssize_t			status;
@@ -81,11 +76,11 @@ at25_ee_read(
 	u8			instr;
 
 	if (unlikely(offset >= at25->chip.byte_len))
-		return 0;
+		return -EINVAL;
 	if ((offset + count) > at25->chip.byte_len)
 		count = at25->chip.byte_len - offset;
 	if (unlikely(!count))
-		return count;
+		return -EINVAL;
 
 	cp = command;
 
@@ -131,28 +126,14 @@ at25_ee_read(
 		count, offset, (int) status);
 
 	mutex_unlock(&at25->lock);
-	return status ? status : count;
+	return status;
 }
 
-static int at25_regmap_read(void *context, const void *reg, size_t reg_size,
-			    void *val, size_t val_size)
+static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 {
-	struct at25_data *at25 = context;
-	off_t offset = *(u32 *)reg;
-	int err;
-
-	err = at25_ee_read(at25, val, offset, val_size);
-	if (err)
-		return err;
-	return 0;
-}
-
-static ssize_t
-at25_ee_write(struct at25_data *at25, const char *buf, loff_t off,
-	      size_t count)
-{
-	ssize_t			status = 0;
-	unsigned		written = 0;
+	struct at25_data *at25 = priv;
+	const char *buf = val;
+	int			status = 0;
 	unsigned		buf_size;
 	u8			*bounce;
 
@@ -161,7 +142,7 @@ at25_ee_write(struct at25_data *at25, const char *buf, loff_t off,
 	if ((off + count) > at25->chip.byte_len)
 		count = at25->chip.byte_len - off;
 	if (unlikely(!count))
-		return count;
+		return -EINVAL;
 
 	/* Temp buffer starts with command and address */
 	buf_size = at25->chip.page_size;
@@ -256,40 +237,15 @@ at25_ee_write(struct at25_data *at25, const char *buf, loff_t off,
 		off += segment;
 		buf += segment;
 		count -= segment;
-		written += segment;
 
 	} while (count > 0);
 
 	mutex_unlock(&at25->lock);
 
 	kfree(bounce);
-	return written ? written : status;
+	return status;
 }
 
-static int at25_regmap_write(void *context, const void *data, size_t count)
-{
-	struct at25_data *at25 = context;
-	const char *buf;
-	u32 offset;
-	size_t len;
-	int err;
-
-	memcpy(&offset, data, sizeof(offset));
-	buf = (const char *)data + sizeof(offset);
-	len = count - sizeof(offset);
-
-	err = at25_ee_write(at25, buf, offset, len);
-	if (err)
-		return err;
-	return 0;
-}
-
-static const struct regmap_bus at25_regmap_bus = {
-	.read = at25_regmap_read,
-	.write = at25_regmap_write,
-	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
-};
-
 /*-------------------------------------------------------------------------*/
 
 static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
@@ -349,7 +305,6 @@ static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
 	struct spi_eeprom	chip;
-	struct regmap		*regmap;
 	int			err;
 	int			sr;
 	int			addrlen;
@@ -394,18 +349,6 @@ static int at25_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, at25);
 	at25->addrlen = addrlen;
 
-	at25->regmap_config.reg_bits = 32;
-	at25->regmap_config.val_bits = 8;
-	at25->regmap_config.reg_stride = 1;
-	at25->regmap_config.max_register = chip.byte_len - 1;
-
-	regmap = devm_regmap_init(&spi->dev, &at25_regmap_bus, at25,
-				  &at25->regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "regmap init failed\n");
-		return PTR_ERR(regmap);
-	}
-
 	at25->nvmem_config.name = dev_name(&spi->dev);
 	at25->nvmem_config.dev = &spi->dev;
 	at25->nvmem_config.read_only = chip.flags & EE_READONLY;
@@ -413,6 +356,12 @@ static int at25_probe(struct spi_device *spi)
 	at25->nvmem_config.owner = THIS_MODULE;
 	at25->nvmem_config.compat = true;
 	at25->nvmem_config.base_dev = &spi->dev;
+	at25->nvmem_config.reg_read = at25_ee_read;
+	at25->nvmem_config.reg_write = at25_ee_write;
+	at25->nvmem_config.priv = at25;
+	at25->nvmem_config.stride = 4;
+	at25->nvmem_config.word_size = 1;
+	at25->nvmem_config.size = chip.byte_len;
 
 	at25->nvmem = nvmem_register(&at25->nvmem_config);
 	if (IS_ERR(at25->nvmem))
-- 
2.5.0
