From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sun, 24 Apr 2016 20:28:16 +0100
Subject: [PATCH 12/12] nvmem: 93xx46: remove nvmem regmap dependency
In-Reply-To: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1461526096-29584-13-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves to nvmem support in the driver to use callback
instead of regmap.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 90 ++++++++-----------------------------
 1 file changed, 18 insertions(+), 72 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 426fe2f..5004d72 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/nvmem-provider.h>
-#include <linux/regmap.h>
 #include <linux/eeprom_93xx46.h>
 
 #define OP_START	0x4
@@ -43,7 +42,6 @@ struct eeprom_93xx46_dev {
 	struct spi_device *spi;
 	struct eeprom_93xx46_platform_data *pdata;
 	struct mutex lock;
-	struct regmap_config regmap_config;
 	struct nvmem_config nvmem_config;
 	struct nvmem_device *nvmem;
 	int addrlen;
@@ -60,11 +58,12 @@ static inline bool has_quirk_instruction_length(struct eeprom_93xx46_dev *edev)
 	return edev->pdata->quirks & EEPROM_93XX46_QUIRK_INSTRUCTION_LENGTH;
 }
 
-static ssize_t
-eeprom_93xx46_read(struct eeprom_93xx46_dev *edev, char *buf,
-		   unsigned off, size_t count)
+static int eeprom_93xx46_read(void *priv, unsigned int off,
+			      void *val, size_t count)
 {
-	ssize_t ret = 0;
+	struct eeprom_93xx46_dev *edev = priv;
+	char *buf = val;
+	int err = 0;
 
 	if (unlikely(off >= edev->size))
 		return 0;
@@ -84,7 +83,6 @@ eeprom_93xx46_read(struct eeprom_93xx46_dev *edev, char *buf,
 		u16 cmd_addr = OP_READ << edev->addrlen;
 		size_t nbytes = count;
 		int bits;
-		int err;
 
 		if (edev->addrlen == 7) {
 			cmd_addr |= off & 0x7f;
@@ -120,21 +118,20 @@ eeprom_93xx46_read(struct eeprom_93xx46_dev *edev, char *buf,
 		if (err) {
 			dev_err(&edev->spi->dev, "read %zu bytes at %d: err. %d\n",
 				nbytes, (int)off, err);
-			ret = err;
 			break;
 		}
 
 		buf += nbytes;
 		off += nbytes;
 		count -= nbytes;
-		ret += nbytes;
 	}
 
 	if (edev->pdata->finish)
 		edev->pdata->finish(edev);
 
 	mutex_unlock(&edev->lock);
-	return ret;
+
+	return err;
 }
 
 static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
@@ -230,10 +227,11 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *edev,
 	return ret;
 }
 
-static ssize_t
-eeprom_93xx46_write(struct eeprom_93xx46_dev *edev, const char *buf,
-		    loff_t off, size_t count)
+static int eeprom_93xx46_write(void *priv, unsigned int off,
+				   void *val, size_t count)
 {
+	struct eeprom_93xx46_dev *edev = priv;
+	char *buf = val;
 	int i, ret, step = 1;
 
 	if (unlikely(off >= edev->size))
@@ -275,52 +273,9 @@ eeprom_93xx46_write(struct eeprom_93xx46_dev *edev, const char *buf,
 
 	/* erase/write disable */
 	eeprom_93xx46_ew(edev, 0);
-	return ret ? : count;
-}
-
-/*
- * Provide a regmap interface, which is registered with the NVMEM
- * framework
-*/
-static int eeprom_93xx46_regmap_read(void *context, const void *reg,
-				     size_t reg_size, void *val,
-				     size_t val_size)
-{
-	struct eeprom_93xx46_dev *eeprom_93xx46 = context;
-	off_t offset = *(u32 *)reg;
-	int err;
-
-	err = eeprom_93xx46_read(eeprom_93xx46, val, offset, val_size);
-	if (err)
-		return err;
-	return 0;
-}
-
-static int eeprom_93xx46_regmap_write(void *context, const void *data,
-				      size_t count)
-{
-	struct eeprom_93xx46_dev *eeprom_93xx46 = context;
-	const char *buf;
-	u32 offset;
-	size_t len;
-	int err;
-
-	memcpy(&offset, data, sizeof(offset));
-	buf = (const char *)data + sizeof(offset);
-	len = count - sizeof(offset);
-
-	err = eeprom_93xx46_write(eeprom_93xx46, buf, offset, len);
-	if (err)
-		return err;
-	return 0;
+	return ret;
 }
 
-static const struct regmap_bus eeprom_93xx46_regmap_bus = {
-	.read = eeprom_93xx46_regmap_read,
-	.write = eeprom_93xx46_regmap_write,
-	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
-};
-
 static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 {
 	struct eeprom_93xx46_platform_data *pd = edev->pdata;
@@ -480,7 +435,6 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 {
 	struct eeprom_93xx46_platform_data *pd;
 	struct eeprom_93xx46_dev *edev;
-	struct regmap *regmap;
 	int err;
 
 	if (spi->dev.of_node) {
@@ -515,20 +469,6 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	edev->pdata = pd;
 
 	edev->size = 128;
-
-	edev->regmap_config.reg_bits = 32;
-	edev->regmap_config.val_bits = 8;
-	edev->regmap_config.reg_stride = 1;
-	edev->regmap_config.max_register = edev->size - 1;
-
-	regmap = devm_regmap_init(&spi->dev, &eeprom_93xx46_regmap_bus, edev,
-				  &edev->regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "regmap init failed\n");
-		err = PTR_ERR(regmap);
-		goto fail;
-	}
-
 	edev->nvmem_config.name = dev_name(&spi->dev);
 	edev->nvmem_config.dev = &spi->dev;
 	edev->nvmem_config.read_only = pd->flags & EE_READONLY;
@@ -536,6 +476,12 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	edev->nvmem_config.owner = THIS_MODULE;
 	edev->nvmem_config.compat = true;
 	edev->nvmem_config.base_dev = &spi->dev;
+	edev->nvmem_config.reg_read = eeprom_93xx46_read;
+	edev->nvmem_config.reg_write = eeprom_93xx46_write;
+	edev->nvmem_config.priv = edev;
+	edev->nvmem_config.stride = 4;
+	edev->nvmem_config.word_size = 1;
+	edev->nvmem_config.size = edev->size;
 
 	edev->nvmem = nvmem_register(&edev->nvmem_config);
 	if (IS_ERR(edev->nvmem)) {
-- 
2.5.0
