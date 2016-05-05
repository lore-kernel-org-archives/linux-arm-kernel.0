From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu,  5 May 2016 15:53:26 +0000
Subject: [PATCH 3/5] clk: bcm2835: enable default filtering for parent clocks
In-Reply-To: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
References: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1462463608-22940-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Depending on the type of clock define a default set of
parent clocks that are uses during parent clock selection.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 1b1657d..8a44ebf 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -836,6 +836,7 @@ struct bcm2835_clock {
 	struct clk_hw hw;
 	struct bcm2835_cprman *cprman;
 	const struct bcm2835_clock_data *data;
+	u32 flags;
 };
 
 static struct bcm2835_clock *bcm2835_clock_from_hw(struct clk_hw *hw)
@@ -1023,6 +1024,8 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 		parent = clk_hw_get_parent_by_index(hw, i);
 		if (!parent)
 			continue;
+		if (!(clock->flags & BIT(i)))
+			continue;
 		prate = clk_hw_get_rate(parent);
 		div = bcm2835_clock_choose_div(hw, req->rate, prate, true);
 		rate = bcm2835_clock_rate_from_divisor(clock, prate, div);
@@ -1216,6 +1219,10 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 	return clk;
 }
 
+static u32 bcm2835_register_clock_default_parents(
+	struct device *dev,
+	const struct bcm2835_clock_data *data);
+
 static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 					  const struct bcm2835_clock_data *data)
 {
@@ -1263,6 +1270,8 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	clock->cprman = cprman;
 	clock->data = data;
 	clock->hw.init = &init;
+	clock->flags = bcm2835_register_clock_default_parents(
+		cprman->dev, data);
 
 	return devm_clk_register(cprman->dev, &clock->hw);
 }
@@ -1349,6 +1358,44 @@ static const char *const bcm2835_clock_vpu_parents[] = {
 	.parents = bcm2835_clock_vpu_parents,				\
 	__VA_ARGS__)
 
+/* calc the default flags for different clocks based on the parent array */
+static u32 bcm2835_register_clock_default_parents(
+	struct device *dev,
+	const struct bcm2835_clock_data *data)
+{
+	/* by default we disable the testdebug clocks for all known types */
+	if (data->parents == bcm2835_clock_osc_parents)
+		return
+			BIT(BCM2835_OSC_PARENT_GND) |
+			BIT(BCM2835_OSC_PARENT_OSC);
+	if (data->parents == bcm2835_clock_vpu_parents)
+		return
+			BIT(BCM2835_VPU_PARENT_GND) |
+			BIT(BCM2835_VPU_PARENT_OSC) |
+			BIT(BCM2835_VPU_PARENT_PLLA_CORE) |
+			BIT(BCM2835_VPU_PARENT_PLLC_CORE0) |
+			BIT(BCM2835_VPU_PARENT_PLLD_CORE) |
+			BIT(BCM2835_VPU_PARENT_PLLH_AUX) |
+			BIT(BCM2835_VPU_PARENT_PLLC_CORE1) |
+			BIT(BCM2835_VPU_PARENT_PLLC_CORE2);
+	if (data->parents == bcm2835_clock_per_parents)
+		return
+			BIT(BCM2835_PER_PARENT_GND) |
+			BIT(BCM2835_PER_PARENT_OSC) |
+			BIT(BCM2835_PER_PARENT_PLLA_PER) |
+			/* by default do not use PLLC_PER */
+			BIT(BCM2835_PER_PARENT_PLLD_PER) |
+			BIT(BCM2835_PER_PARENT_PLLH_AUX);
+
+	/* warn about unknown parents */
+	dev_warn(dev,
+		 "unknown clock parents for clock %s - enabling all %d parents\n",
+		 data->name, data->num_mux_parents);
+
+	/* return enable all clocks */
+	return BIT(data->num_mux_parents) - 1;
+}
+
 /*
  * the real definition of all the pll, pll_dividers and clocks
  * these make use of the above REGISTER_* macros
-- 
2.1.4
