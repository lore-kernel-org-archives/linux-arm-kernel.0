From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sun, 24 Apr 2016 20:28:14 +0100
Subject: [PATCH 10/12] nvmem: lpc18xx-eeprom: remove nvmem regmap dependency
In-Reply-To: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1461526096-29584-11-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves to nvmem support in the driver to use callback
instead of regmap.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/lpc18xx_eeprom.c | 94 ++++++++++++------------------------------
 1 file changed, 26 insertions(+), 68 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index 878fce7..c81ae4c 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 #include <linux/reset.h>
 
 /* Registers */
@@ -51,12 +50,7 @@ struct lpc18xx_eeprom_dev {
 	struct nvmem_device *nvmem;
 	unsigned reg_bytes;
 	unsigned val_bytes;
-};
-
-static struct regmap_config lpc18xx_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
+	int size;
 };
 
 static inline void lpc18xx_eeprom_writel(struct lpc18xx_eeprom_dev *eeprom,
@@ -95,30 +89,35 @@ static int lpc18xx_eeprom_busywait_until_prog(struct lpc18xx_eeprom_dev *eeprom)
 	return -ETIMEDOUT;
 }
 
-static int lpc18xx_eeprom_gather_write(void *context, const void *reg,
-				       size_t reg_size, const void *val,
-				       size_t val_size)
+static int lpc18xx_eeprom_gather_write(void *context, unsigned int reg,
+				       void *val, size_t bytes)
 {
 	struct lpc18xx_eeprom_dev *eeprom = context;
-	unsigned int offset = *(u32 *)reg;
+	unsigned int offset = reg;
 	int ret;
 
-	if (offset % lpc18xx_regmap_config.reg_stride)
+	/*
+	 * The last page contains the EEPROM initialization data and is not
+	 * writable.
+	 */
+	if ((reg > eeprom->size - LPC18XX_EEPROM_PAGE_SIZE) ||
+			(reg + bytes > eeprom->size - LPC18XX_EEPROM_PAGE_SIZE))
 		return -EINVAL;
 
+
 	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
 			      LPC18XX_EEPROM_PWRDWN_NO);
 
 	/* Wait 100 us while the EEPROM wakes up */
 	usleep_range(100, 200);
 
-	while (val_size) {
+	while (bytes) {
 		writel(*(u32 *)val, eeprom->mem_base + offset);
 		ret = lpc18xx_eeprom_busywait_until_prog(eeprom);
 		if (ret < 0)
 			return ret;
 
-		val_size -= eeprom->val_bytes;
+		bytes -= eeprom->val_bytes;
 		val += eeprom->val_bytes;
 		offset += eeprom->val_bytes;
 	}
@@ -129,23 +128,10 @@ static int lpc18xx_eeprom_gather_write(void *context, const void *reg,
 	return 0;
 }
 
-static int lpc18xx_eeprom_write(void *context, const void *data, size_t count)
+static int lpc18xx_eeprom_read(void *context, unsigned int offset,
+			       void *val, size_t bytes)
 {
 	struct lpc18xx_eeprom_dev *eeprom = context;
-	unsigned int offset = eeprom->reg_bytes;
-
-	if (count <= offset)
-		return -EINVAL;
-
-	return lpc18xx_eeprom_gather_write(context, data, eeprom->reg_bytes,
-					   data + offset, count - offset);
-}
-
-static int lpc18xx_eeprom_read(void *context, const void *reg, size_t reg_size,
-			       void *val, size_t val_size)
-{
-	struct lpc18xx_eeprom_dev *eeprom = context;
-	unsigned int offset = *(u32 *)reg;
 
 	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
 			      LPC18XX_EEPROM_PWRDWN_NO);
@@ -153,9 +139,9 @@ static int lpc18xx_eeprom_read(void *context, const void *reg, size_t reg_size,
 	/* Wait 100 us while the EEPROM wakes up */
 	usleep_range(100, 200);
 
-	while (val_size) {
+	while (bytes) {
 		*(u32 *)val = readl(eeprom->mem_base + offset);
-		val_size -= eeprom->val_bytes;
+		bytes -= eeprom->val_bytes;
 		val += eeprom->val_bytes;
 		offset += eeprom->val_bytes;
 	}
@@ -166,31 +152,13 @@ static int lpc18xx_eeprom_read(void *context, const void *reg, size_t reg_size,
 	return 0;
 }
 
-static struct regmap_bus lpc18xx_eeprom_bus = {
-	.write = lpc18xx_eeprom_write,
-	.gather_write = lpc18xx_eeprom_gather_write,
-	.read = lpc18xx_eeprom_read,
-	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
-	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
-};
-
-static bool lpc18xx_eeprom_writeable_reg(struct device *dev, unsigned int reg)
-{
-	/*
-	 * The last page contains the EEPROM initialization data and is not
-	 * writable.
-	 */
-	return reg <= lpc18xx_regmap_config.max_register -
-						LPC18XX_EEPROM_PAGE_SIZE;
-}
-
-static bool lpc18xx_eeprom_readable_reg(struct device *dev, unsigned int reg)
-{
-	return reg <= lpc18xx_regmap_config.max_register;
-}
 
 static struct nvmem_config lpc18xx_nvmem_config = {
 	.name = "lpc18xx-eeprom",
+	.stride = 4,
+	.word_size = 4,
+	.reg_read = lpc18xx_eeprom_read,
+	.reg_write = lpc18xx_eeprom_gather_write,
 	.owner = THIS_MODULE,
 };
 
@@ -200,7 +168,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct reset_control *rst;
 	unsigned long clk_rate;
-	struct regmap *regmap;
 	struct resource *res;
 	int ret;
 
@@ -243,8 +210,8 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	eeprom->val_bytes = lpc18xx_regmap_config.val_bits / BITS_PER_BYTE;
-	eeprom->reg_bytes = lpc18xx_regmap_config.reg_bits / BITS_PER_BYTE;
+	eeprom->val_bytes = 4;
+	eeprom->reg_bytes = 4;
 
 	/*
 	 * Clock rate is generated by dividing the system bus clock by the
@@ -264,19 +231,10 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
 			      LPC18XX_EEPROM_PWRDWN_YES);
 
-	lpc18xx_regmap_config.max_register = resource_size(res) - 1;
-	lpc18xx_regmap_config.writeable_reg = lpc18xx_eeprom_writeable_reg;
-	lpc18xx_regmap_config.readable_reg = lpc18xx_eeprom_readable_reg;
-
-	regmap = devm_regmap_init(dev, &lpc18xx_eeprom_bus, eeprom,
-				  &lpc18xx_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "regmap init failed: %ld\n", PTR_ERR(regmap));
-		ret = PTR_ERR(regmap);
-		goto err_clk;
-	}
-
+	eeprom->size = resource_size(res);
+	lpc18xx_nvmem_config.size = resource_size(res);
 	lpc18xx_nvmem_config.dev = dev;
+	lpc18xx_nvmem_config.priv = eeprom;
 
 	eeprom->nvmem = nvmem_register(&lpc18xx_nvmem_config);
 	if (IS_ERR(eeprom->nvmem)) {
-- 
2.5.0
