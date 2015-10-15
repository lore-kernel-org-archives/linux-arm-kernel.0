From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:46:47 +0200
Subject: [PATCH 07/13] clk: versatile-icst: refactor to allocate regmap
 separately
In-Reply-To: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444916813-31024-8-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Break out the registration function so it creates a regmap and
pass to the setup function, so the latter can be shared with
a device tree probe function that already has a regmap.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm looking for an ACK from the CLK maintainers to take this
through the ARM SoC tree once the series stabilize.
---
 drivers/clk/versatile/clk-icst.c | 44 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index da5a3ccbbb96..ab5d5f73818b 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -20,6 +20,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include "clk-icst.h"
 
@@ -140,21 +141,16 @@ static const struct clk_ops icst_ops = {
 	.set_rate = icst_set_rate,
 };
 
-struct clk *icst_clk_register(struct device *dev,
+struct clk *icst_clk_setup(struct device *dev,
 			const struct clk_icst_desc *desc,
 			const char *name,
 			const char *parent_name,
-			void __iomem *base)
+			struct regmap *map)
 {
 	struct clk *clk;
 	struct clk_icst *icst;
 	struct clk_init_data init;
 	struct icst_params *pclone;
-	struct regmap_config icst_regmap_conf = {
-		.reg_bits = 32,
-		.val_bits = 32,
-		.reg_stride = 4,
-	};
 
 	icst = kzalloc(sizeof(struct clk_icst), GFP_KERNEL);
 	if (!icst) {
@@ -174,15 +170,7 @@ struct clk *icst_clk_register(struct device *dev,
 	init.flags = CLK_IS_ROOT;
 	init.parent_names = (parent_name ? &parent_name : NULL);
 	init.num_parents = (parent_name ? 1 : 0);
-	icst->map = regmap_init_mmio(NULL, base, &icst_regmap_conf);
-	if (IS_ERR(icst->map)) {
-		int ret;
-
-		pr_err("could not initialize ICST regmap\n");
-		kfree(icst);
-		ret = PTR_ERR(icst->map);
-		return ERR_PTR(ret);
-	}
+	icst->map = map;
 	icst->hw.init = &init;
 	icst->params = pclone;
 	icst->vcoreg_off = desc->vco_offset;
@@ -194,4 +182,28 @@ struct clk *icst_clk_register(struct device *dev,
 
 	return clk;
 }
+
+struct clk *icst_clk_register(struct device *dev,
+			const struct clk_icst_desc *desc,
+			const char *name,
+			const char *parent_name,
+			void __iomem *base)
+{
+	struct regmap_config icst_regmap_conf = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+	};
+	struct regmap *map;
+
+	map = regmap_init_mmio(NULL, base, &icst_regmap_conf);
+	if (IS_ERR(map)) {
+		int ret;
+
+		pr_err("could not initialize ICST regmap\n");
+		ret = PTR_ERR(map);
+		return ERR_PTR(ret);
+	}
+	return icst_clk_setup(dev, desc, name, parent_name, map);
+}
 EXPORT_SYMBOL_GPL(icst_clk_register);
-- 
2.4.3
