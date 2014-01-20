From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 21:55:32 +0100
Subject: [PATCH 5/5] clk: versatile: respect parent rate in ICST clock
Message-ID: <1390251332-6411-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the ICST clock has a parent, respect the rate of the parent
when calculating the clock frequency. Alter const arguments
as this involves modifying the ICST parameter struct, and do
not define the reference clock on the Integrator as we have
the reference clock from the device tree. Keep it everywhere
else.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Mike, looking for an ACK for this one as well.
---
 drivers/clk/versatile/clk-icst.c       | 10 +++++++---
 drivers/clk/versatile/clk-icst.h       |  2 +-
 drivers/clk/versatile/clk-impd1.c      |  4 ++--
 drivers/clk/versatile/clk-integrator.c |  3 +--
 drivers/clk/versatile/clk-realview.c   |  2 +-
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index c98adbe62733..4bbfbf49b009 100644
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
@@ -135,8 +139,8 @@ struct clk *icst_clk_register(struct device *dev,
 	init.name = name;
 	init.ops = &icst_ops;
 	init.flags = CLK_IS_ROOT;
-	init.parent_names = NULL;
-	init.num_parents = 0;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
 	icst->hw.init = &init;
 	icst->params = desc->params;
 	icst->vcoreg = base + desc->vco_offset;
diff --git a/drivers/clk/versatile/clk-icst.h b/drivers/clk/versatile/clk-icst.h
index 04e6f0aef588..e72b1c15d084 100644
--- a/drivers/clk/versatile/clk-icst.h
+++ b/drivers/clk/versatile/clk-icst.h
@@ -8,7 +8,7 @@
  *	memory base
  */
 struct clk_icst_desc {
-	const struct icst_params *params;
+	struct icst_params *params;
 	u32 vco_offset;
 	u32 lock_offset;
 };
diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
index 6d8b8e1a080a..a3edc0463517 100644
--- a/drivers/clk/versatile/clk-impd1.c
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -39,7 +39,7 @@ static struct impd1_clk impd1_clks[4];
  * There are two VCO's on the IM-PD1
  */
 
-static const struct icst_params impd1_vco1_params = {
+static struct icst_params impd1_vco1_params = {
 	.ref		= 24000000,	/* 24 MHz */
 	.vco_max	= ICST525_VCO_MAX_3V,
 	.vco_min	= ICST525_VCO_MIN,
@@ -57,7 +57,7 @@ static const struct clk_icst_desc impd1_icst1_desc = {
 	.lock_offset = IMPD1_LOCK,
 };
 
-static const struct icst_params impd1_vco2_params = {
+static struct icst_params impd1_vco2_params = {
 	.ref		= 24000000,	/* 24 MHz */
 	.vco_max	= ICST525_VCO_MAX_3V,
 	.vco_min	= ICST525_VCO_MIN,
diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
index 5d36a719fefb..b1f46d5154ea 100644
--- a/drivers/clk/versatile/clk-integrator.c
+++ b/drivers/clk/versatile/clk-integrator.c
@@ -20,8 +20,7 @@
 /* Base offset for the core module */
 static void __iomem *cm_base;
 
-static const struct icst_params cp_auxosc_params = {
-	.ref		= 24000000,
+static struct icst_params cp_auxosc_params = {
 	.vco_max	= ICST525_VCO_MAX_5V,
 	.vco_min	= ICST525_VCO_MIN,
 	.vd_min 	= 8,
diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
index c8b523117fb7..a1491590e028 100644
--- a/drivers/clk/versatile/clk-realview.c
+++ b/drivers/clk/versatile/clk-realview.c
@@ -21,7 +21,7 @@
  * Implementation of the ARM RealView clock trees.
  */
 
-static const struct icst_params realview_oscvco_params = {
+static struct icst_params realview_oscvco_params = {
 	.ref		= 24000000,
 	.vco_max	= ICST307_VCO_MAX,
 	.vco_min	= ICST307_VCO_MIN,
-- 
1.8.4.2
