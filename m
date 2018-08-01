From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  1 Aug 2018 09:09:08 +0530
Subject: [PATCH v2 03/10] clk: actions: Add syscon support for Actions Semi
 Owl SoCs
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180801033915.15880-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the clock and reset management units are sharing the same memory
map, convert the Owl common clock driver to support System Controller so
that the reset driver can reuse the same memory region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-common.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
index 61c1071b5180..080f980b2ec4 100644
--- a/drivers/clk/actions/owl-common.c
+++ b/drivers/clk/actions/owl-common.c
@@ -8,6 +8,7 @@
 // Copyright (c) 2018 Linaro Ltd.
 // Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 
+#include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -15,14 +16,6 @@
 
 #include "owl-common.h"
 
-static const struct regmap_config owl_regmap_config = {
-	.reg_bits	= 32,
-	.reg_stride	= 4,
-	.val_bits	= 32,
-	.max_register	= 0x00cc,
-	.fast_io	= true,
-};
-
 static void owl_clk_set_regmap(const struct owl_clk_desc *desc,
 			 struct regmap *regmap)
 {
@@ -41,18 +34,11 @@ static void owl_clk_set_regmap(const struct owl_clk_desc *desc,
 int owl_clk_regmap_init(struct platform_device *pdev,
 			 const struct owl_clk_desc *desc)
 {
-	void __iomem *base;
 	struct regmap *regmap;
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
 
-	regmap = devm_regmap_init_mmio(&pdev->dev, base, &owl_regmap_config);
+	regmap = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
 	if (IS_ERR(regmap)) {
-		pr_err("failed to init regmap\n");
+		dev_err(&pdev->dev, "failed to get regmap\n");
 		return PTR_ERR(regmap);
 	}
 
-- 
2.17.1
