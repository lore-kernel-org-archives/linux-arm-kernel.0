From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sun, 24 Apr 2016 20:28:08 +0100
Subject: [PATCH 04/12] nvmem: qfprom: remove nvmem regmap dependency
In-Reply-To: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1461526096-29584-5-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves to nvmem support in the driver to use callback instead of
regmap.

Reported-by: Rajendra Nayak <rjendra@qti.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig  |  1 -
 drivers/nvmem/qfprom.c | 56 +++++++++++++++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 36f4f4b..a87273b 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -60,7 +60,6 @@ config QCOM_QFPROM
 	tristate "QCOM QFPROM Support"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HAS_IOMEM
-	select REGMAP_MMIO
 	help
 	  Say y here to enable QFPROM support. The QFPROM provides access
 	  functions for QFPROM data to rest of the drivers via nvmem interface.
diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 3829e5f..b5305f0 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -13,21 +13,35 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
-static struct regmap_config qfprom_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 8,
-	.reg_stride = 1,
-	.val_format_endian = REGMAP_ENDIAN_LITTLE,
-};
+static int qfprom_reg_read(void *context,
+			unsigned int reg, void *_val, size_t bytes)
+{
+	void __iomem *base = context;
+	u32 *val = _val;
+	int i = 0, words = bytes / 4;
 
-static struct nvmem_config econfig = {
-	.name = "qfprom",
-	.owner = THIS_MODULE,
-};
+	while (words--)
+		*val++ = readl(base + reg + (i++ * 4));
+
+	return 0;
+}
+
+static int qfprom_reg_write(void *context,
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
 
 static int qfprom_remove(struct platform_device *pdev)
 {
@@ -36,12 +50,20 @@ static int qfprom_remove(struct platform_device *pdev)
 	return nvmem_unregister(nvmem);
 }
 
+static struct nvmem_config econfig = {
+	.name = "qfprom",
+	.owner = THIS_MODULE,
+	.stride = 4,
+	.word_size = 1,
+	.reg_read = qfprom_reg_read,
+	.reg_write = qfprom_reg_write,
+};
+
 static int qfprom_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct nvmem_device *nvmem;
-	struct regmap *regmap;
 	void __iomem *base;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -49,14 +71,10 @@ static int qfprom_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	qfprom_regmap_config.max_register = resource_size(res) - 1;
-
-	regmap = devm_regmap_init_mmio(dev, base, &qfprom_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(regmap);
-	}
+	econfig.size = resource_size(res);
 	econfig.dev = dev;
+	econfig.priv = base;
+
 	nvmem = nvmem_register(&econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
-- 
2.5.0
