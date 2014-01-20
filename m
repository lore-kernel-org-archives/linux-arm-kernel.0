From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 22:54:25 +0100
Subject: [PATCH 5/5 v2] clk: versatile: respect parent rate in ICST clock
Message-ID: <1390254865-15488-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the ICST clock has a parent, respect the rate of the parent
when calculating the clock frequency. As this involves modifying
the ICST parameter struct, make a cloned copy (the divisor
arrays should be safe) so we can update the .ref field.

Do not define the reference clock on the Integrator as we have
the reference clock from the device tree. Keep it everywhere
else.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- As Russell observed: the params are static objects, so if
  we want to alter them, we better make a copy of them.

Hi Mike, looking for an ACK for this one as well.
---
 drivers/clk/versatile/clk-icst.c       | 20 ++++++++++++++++----
 drivers/clk/versatile/clk-integrator.c |  1 -
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index c98adbe62733..a820b0cfcf57 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -33,7 +33,7 @@ struct clk_icst {
 	struct clk_hw hw;
 	void __iomem *vcoreg;
 	void __iomem *lockreg;
-	const struct icst_params *params;
+	struct icst_params *params;
 	unsigned long rate;
 };
 
@@ -84,6 +84,8 @@ static unsigned long icst_recalc_rate(struct clk_hw *hw,
 	struct clk_icst *icst = to_icst(hw);
 	struct icst_vco vco;
 
+	if (parent_rate)
+		icst->params->ref = parent_rate;
 	vco = vco_get(icst->vcoreg);
 	icst->rate = icst_hz(icst->params, vco);
 	return icst->rate;
@@ -105,6 +107,8 @@ static int icst_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_icst *icst = to_icst(hw);
 	struct icst_vco vco;
 
+	if (parent_rate)
+		icst->params->ref = parent_rate;
 	vco = icst_hz_to_vco(icst->params, rate);
 	icst->rate = icst_hz(icst->params, vco);
 	vco_set(icst->lockreg, icst->vcoreg, vco);
@@ -126,19 +130,27 @@ struct clk *icst_clk_register(struct device *dev,
 	struct clk *clk;
 	struct clk_icst *icst;
 	struct clk_init_data init;
+	struct icst_params *pclone;
 
 	icst = kzalloc(sizeof(struct clk_icst), GFP_KERNEL);
 	if (!icst) {
 		pr_err("could not allocate ICST clock!\n");
 		return ERR_PTR(-ENOMEM);
 	}
+
+	pclone = kmemdup(desc->params, sizeof(*pclone), GFP_KERNEL);
+	if (!pclone) {
+		pr_err("could not clone ICST params\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
 	init.name = name;
 	init.ops = &icst_ops;
 	init.flags = CLK_IS_ROOT;
-	init.parent_names = NULL;
-	init.num_parents = 0;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
 	icst->hw.init = &init;
-	icst->params = desc->params;
+	icst->params = pclone;
 	icst->vcoreg = base + desc->vco_offset;
 	icst->lockreg = base + desc->lock_offset;
 
diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
index 5d36a719fefb..734c4b8fe6ab 100644
--- a/drivers/clk/versatile/clk-integrator.c
+++ b/drivers/clk/versatile/clk-integrator.c
@@ -21,7 +21,6 @@
 static void __iomem *cm_base;
 
 static const struct icst_params cp_auxosc_params = {
-	.ref		= 24000000,
 	.vco_max	= ICST525_VCO_MAX_5V,
 	.vco_min	= ICST525_VCO_MIN,
 	.vd_min 	= 8,
-- 
1.8.4.2
