From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Sep 2014 17:15:03 +0200
Subject: [PATCH] clk: mvebu: fix sscg node lookup
Message-ID: <1410880503-2322-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 15917b16022427c53755abff4dc7051f3076dd7a ("clk: mvebu: Fix clk
frequency value if SSCG is enabled") introduced some logic in the
common mvebu clock code to adjust the clock frequency according to the
configuration of the SSCG.

In order to do this, it looks up for a DT node called "sscg" and maps
it before accessing the SSCG configuration register.

However, the lookup is currently done using:

	 sscg_np = of_find_node_by_name(np, "sscg");

where "np" is a pointer to the DT node of the clock for which we are
calculating the adjusted frequency. This means that if the "sscg" node
is *after* the clock node in the Device Tree, it works fine (and
that's the case for Armada 370).

However, if it turns out that the "sscg" node is *before* the clock
node in the Device Tree, it won't work because the sscg node will not
be found.

What we really want here is a search of the entire Device Tree, not
only starting from the clock node, so instead of passing "np" as first
argument of of_find_node_by_name(), we simply need to pass
NULL. Passing a non-NULL argument is typically used in a loop, so that
the search for the next matching node starts right after the node that
was matched.

This makes the "np" argument to the kirkwood_fix_sscg_deviation()
function unnecessary, which leads to further cleanups.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Fixes: 15917b1602242 ("clk: mvebu: Fix clk frequency value if SSCG is enabled")
---
Jason, this is a fix that applies on your mvebu/drivers-clk branch.

 drivers/clk/mvebu/common.c | 6 +++---
 drivers/clk/mvebu/common.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 354bbad..f902c18 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -41,7 +41,7 @@ static struct clk_onecell_data clk_data;
  * chosen following the dt convention: using the first known SoC
  * compatible with it.
  */
-u32 kirkwood_fix_sscg_deviation(struct device_node *np, u32 system_clk)
+u32 kirkwood_fix_sscg_deviation(u32 system_clk)
 {
 	struct device_node *sscg_np = NULL;
 	void __iomem *sscg_map;
@@ -49,7 +49,7 @@ u32 kirkwood_fix_sscg_deviation(struct device_node *np, u32 system_clk)
 	s32 low_bound, high_bound;
 	u64 freq_swing_half;
 
-	sscg_np = of_find_node_by_name(np, "sscg");
+	sscg_np = of_find_node_by_name(NULL, "sscg");
 	if (sscg_np == NULL) {
 		pr_err("cannot get SSCG register node\n");
 		return system_clk;
@@ -142,7 +142,7 @@ void __init mvebu_coreclk_setup(struct device_node *np,
 
 	if (desc->is_sscg_enabled && desc->fix_sscg_deviation
 		&& desc->is_sscg_enabled(base))
-		rate = desc->fix_sscg_deviation(np, rate);
+		rate = desc->fix_sscg_deviation(rate);
 
 	clk_data.clks[1] = clk_register_fixed_rate(NULL, cpuclk_name, NULL,
 						   CLK_IS_ROOT, rate);
diff --git a/drivers/clk/mvebu/common.h b/drivers/clk/mvebu/common.h
index 59efaa8..989ab14 100644
--- a/drivers/clk/mvebu/common.h
+++ b/drivers/clk/mvebu/common.h
@@ -29,7 +29,7 @@ struct coreclk_soc_desc {
 	u32 (*get_cpu_freq)(void __iomem *sar);
 	void (*get_clk_ratio)(void __iomem *sar, int id, int *mult, int *div);
 	bool (*is_sscg_enabled)(void __iomem *sar);
-	u32 (*fix_sscg_deviation)(struct device_node *np, u32 system_clk);
+	u32 (*fix_sscg_deviation)(u32 system_clk);
 	const struct coreclk_ratio *ratios;
 	int num_ratios;
 };
@@ -51,5 +51,5 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
  * This function is shared among the Kirkwood, Armada 370, Armada XP
  * and Armada 375 SoC
  */
-u32 kirkwood_fix_sscg_deviation(struct device_node *np, u32 system_clk);
+u32 kirkwood_fix_sscg_deviation(u32 system_clk);
 #endif
-- 
2.0.0
