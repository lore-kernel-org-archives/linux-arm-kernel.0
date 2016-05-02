From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon,  2 May 2016 16:22:57 +0100
Subject: [PATCH v2 1/2] nvmem: mtk-efuse: remove nvmem regmap dependency
In-Reply-To: <1462202578-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1462202578-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1462202578-15433-2-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves to nvmem support in the driver to use callback
instead of regmap.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig     |  1 -
 drivers/nvmem/mtk-efuse.c | 47 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 3041d48..5ff2189 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -50,7 +50,6 @@ config MTK_EFUSE
 	tristate "Mediatek SoCs EFUSE support"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on HAS_IOMEM
-	select REGMAP_MMIO
 	help
 	  This is a driver to access hardware related data like sensor
 	  calibration, HDMI impedance etc.
diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 9c49369..32fd572 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -14,15 +14,35 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
-static struct regmap_config mtk_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-};
+static int mtk_reg_read(void *context,
+			unsigned int reg, void *_val, size_t bytes)
+{
+	void __iomem *base = context;
+	u32 *val = _val;
+	int i = 0, words = bytes / 4;
+
+	while (words--)
+		*val++ = readl(base + reg + (i++ * 4));
+
+	return 0;
+}
+
+static int mtk_reg_write(void *context,
+			 unsigned int reg, void *_val, size_t bytes)
+{
+	void __iomem *base = context;
+	u32 *val = _val;
+	int i = 0, words = bytes / 4;
+
+	while (words--)
+		writel(*val++, base + reg + (i++ * 4));
+
+	return 0;
+}
 
 static int mtk_efuse_probe(struct platform_device *pdev)
 {
@@ -30,7 +50,6 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct nvmem_config *econfig;
-	struct regmap *regmap;
 	void __iomem *base;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -42,14 +61,12 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	if (!econfig)
 		return -ENOMEM;
 
-	mtk_regmap_config.max_register = resource_size(res) - 1;
-
-	regmap = devm_regmap_init_mmio(dev, base, &mtk_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(regmap);
-	}
-
+	econfig->stride = 4;
+	econfig->word_size = 4;
+	econfig->reg_read = mtk_reg_read;
+	econfig->reg_write = mtk_reg_write;
+	econfig->size = resource_size(res);
+	econfig->priv = base;
 	econfig->dev = dev;
 	econfig->owner = THIS_MODULE;
 	nvmem = nvmem_register(econfig);
-- 
2.5.0
