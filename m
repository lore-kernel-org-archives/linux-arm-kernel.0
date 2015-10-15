From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:46:46 +0200
Subject: [PATCH 06/13] clk: versatile-icst: convert to use regmap
In-Reply-To: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444916813-31024-7-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of passing around register bases, pass around a regmap
in this driver. This refactoring make things so much easier when
we later want to manage an ICST that is part of a syscon.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm looking for an ACK from the CLK maintainers to take this
through the ARM SoC tree once the series stabilize.
---
 drivers/clk/versatile/Kconfig    |  1 +
 drivers/clk/versatile/clk-icst.c | 88 +++++++++++++++++++++++++++-------------
 2 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index 1530c9352a76..e091bcec116c 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -1,6 +1,7 @@
 config COMMON_CLK_VERSATILE
 	bool "Clock driver for ARM Reference designs"
 	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || ARCH_VEXPRESS || ARM64
+	select REGMAP_MMIO
 	---help---
           Supports clocking on ARM Reference designs:
 	  - Integrator/AP and Integrator/CP
diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index a3893ea2199d..da5a3ccbbb96 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -19,9 +19,13 @@
 #include <linux/err.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
 
 #include "clk-icst.h"
 
+/* Magic unlocking token used on all Versatile boards */
+#define VERSATILE_LOCK_VAL	0xA05F
+
 /**
  * struct clk_icst - ICST VCO clock wrapper
  * @hw: corresponding clock hardware entry
@@ -32,8 +36,9 @@
  */
 struct clk_icst {
 	struct clk_hw hw;
-	void __iomem *vcoreg;
-	void __iomem *lockreg;
+	struct regmap *map;
+	u32 vcoreg_off;
+	u32 lockreg_off;
 	struct icst_params *params;
 	unsigned long rate;
 };
@@ -41,53 +46,67 @@ struct clk_icst {
 #define to_icst(_hw) container_of(_hw, struct clk_icst, hw)
 
 /**
- * vco_get() - get ICST VCO settings from a certain register
- * @vcoreg: register containing the VCO settings
+ * vco_get() - get ICST VCO settings from a certain ICST
+ * @icst: the ICST clock to get
+ * @vco: the VCO struct to return the value in
  */
-static struct icst_vco vco_get(void __iomem *vcoreg)
+static int vco_get(struct clk_icst *icst, struct icst_vco *vco)
 {
 	u32 val;
-	struct icst_vco vco;
-
-	val = readl(vcoreg);
-	vco.v = val & 0x1ff;
-	vco.r = (val >> 9) & 0x7f;
-	vco.s = (val >> 16) & 03;
-	return vco;
+	int ret;
+
+	ret = regmap_read(icst->map, icst->vcoreg_off, &val);
+	if (ret)
+		return ret;
+	vco->v = val & 0x1ff;
+	vco->r = (val >> 9) & 0x7f;
+	vco->s = (val >> 16) & 03;
+	return 0;
 }
 
 /**
  * vco_set() - commit changes to an ICST VCO
- * @locreg: register to poke to unlock the VCO for writing
- * @vcoreg: register containing the VCO settings
- * @vco: ICST VCO parameters to commit
+ * @icst: the ICST clock to set
+ * @vco: the VCO struct to set the changes from
  */
-static void vco_set(void __iomem *lockreg,
-			void __iomem *vcoreg,
-			struct icst_vco vco)
+static int vco_set(struct clk_icst *icst, struct icst_vco vco)
 {
 	u32 val;
+	int ret;
 
-	val = readl(vcoreg) & ~0x7ffff;
+	ret = regmap_read(icst->map, icst->vcoreg_off, &val);
+	if (ret)
+		return ret;
 	val |= vco.v | (vco.r << 9) | (vco.s << 16);
 
 	/* This magic unlocks the VCO so it can be controlled */
-	writel(0xa05f, lockreg);
-	writel(val, vcoreg);
+	ret = regmap_write(icst->map, icst->lockreg_off, VERSATILE_LOCK_VAL);
+	if (ret)
+		return ret;
+	ret = regmap_write(icst->map, icst->vcoreg_off, val);
+	if (ret)
+		return ret;
 	/* This locks the VCO again */
-	writel(0, lockreg);
+	ret = regmap_write(icst->map, icst->lockreg_off, 0);
+	if (ret)
+		return ret;
+	return 0;
 }
 
-
 static unsigned long icst_recalc_rate(struct clk_hw *hw,
 				      unsigned long parent_rate)
 {
 	struct clk_icst *icst = to_icst(hw);
 	struct icst_vco vco;
+	int ret;
 
 	if (parent_rate)
 		icst->params->ref = parent_rate;
-	vco = vco_get(icst->vcoreg);
+	ret = vco_get(icst, &vco);
+	if (ret) {
+		pr_err("ICST: could not get VCO setting\n");
+		return 0;
+	}
 	icst->rate = icst_hz(icst->params, vco);
 	return icst->rate;
 }
@@ -112,8 +131,7 @@ static int icst_set_rate(struct clk_hw *hw, unsigned long rate,
 		icst->params->ref = parent_rate;
 	vco = icst_hz_to_vco(icst->params, rate);
 	icst->rate = icst_hz(icst->params, vco);
-	vco_set(icst->lockreg, icst->vcoreg, vco);
-	return 0;
+	return vco_set(icst, vco);
 }
 
 static const struct clk_ops icst_ops = {
@@ -132,6 +150,11 @@ struct clk *icst_clk_register(struct device *dev,
 	struct clk_icst *icst;
 	struct clk_init_data init;
 	struct icst_params *pclone;
+	struct regmap_config icst_regmap_conf = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+	};
 
 	icst = kzalloc(sizeof(struct clk_icst), GFP_KERNEL);
 	if (!icst) {
@@ -151,10 +174,19 @@ struct clk *icst_clk_register(struct device *dev,
 	init.flags = CLK_IS_ROOT;
 	init.parent_names = (parent_name ? &parent_name : NULL);
 	init.num_parents = (parent_name ? 1 : 0);
+	icst->map = regmap_init_mmio(NULL, base, &icst_regmap_conf);
+	if (IS_ERR(icst->map)) {
+		int ret;
+
+		pr_err("could not initialize ICST regmap\n");
+		kfree(icst);
+		ret = PTR_ERR(icst->map);
+		return ERR_PTR(ret);
+	}
 	icst->hw.init = &init;
 	icst->params = pclone;
-	icst->vcoreg = base + desc->vco_offset;
-	icst->lockreg = base + desc->lock_offset;
+	icst->vcoreg_off = desc->vco_offset;
+	icst->lockreg_off = desc->lock_offset;
 
 	clk = clk_register(dev, &icst->hw);
 	if (IS_ERR(clk))
-- 
2.4.3
