From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 21 May 2014 13:52:15 +0200
Subject: [PATCH] clk: exynos4: Improve handling of the xxti, xusbxti,
 fin_pll clocks
Message-ID: <1400673135-31777-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure the Exynos custom fixed rate clocks registration function
is called only when there are any of those clocks specified in the
device tree. This allows to switch to the standard fixed rate clocks
for oscillators connected to the XXTI or XUSBXTI pins.

This patch also changes CLK_FIN_PLL clock from a fixed rate clock to
a proper read-only mux clock.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
This patch superseeded my previous one:
http://www.spinics.net/lists/arm-kernel/msg333211.html

 drivers/clk/samsung/clk-exynos4.c |   73 ++++++++++++++++++++-----------------
 drivers/clk/samsung/clk.c         |    5 ++-
 2 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 05fc93c..904a413 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1026,50 +1026,55 @@ static struct samsung_clock_alias exynos4x12_aliases[] __initdata = {
  * controller is first remapped and the value of XOM[0] bit is read to
  * determine the parent clock.
  */
-static unsigned long exynos4_get_xom(void)
+static u8 __fin_pll_mux_get_parent(struct clk_hw *hw)
 {
-	unsigned long xom = 0;
-	void __iomem *chipid_base;
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
-	if (np) {
-		chipid_base = of_iomap(np, 0);
-
-		if (chipid_base)
-			xom = readl(chipid_base + 8);
-
-		iounmap(chipid_base);
+	static int xom = -1;
+
+	if (xom < 0) {
+		void __iomem *addr;
+		struct device_node *np;
+
+		xom = 0;
+		np = of_find_compatible_node(NULL, NULL,
+					"samsung,exynos4210-chipid");
+		if (np) {
+			addr = of_iomap(np, 0);
+			if (addr) {
+				xom = readl(addr + 8) & 0x1;
+				iounmap(addr);
+			}
+		}
 	}
-
 	return xom;
 }

+/* FIN_PLL is a read-only MUX clock */
+const struct clk_ops __fin_pll_clk_mux_ops = {
+	.get_parent = __fin_pll_mux_get_parent,
+};
+
 static void __init exynos4_clk_register_finpll(void)
 {
-	struct samsung_fixed_rate_clock fclk;
+	const char *parent_names[] = { "xxti", "xusbxti"};
+	static struct clk_hw *hw;
+	struct clk_init_data init;
 	struct clk *clk;
-	unsigned long finpll_f = 24000000;
-	char *parent_name;
-	unsigned int xom = exynos4_get_xom();
-
-	parent_name = xom & 1 ? "xusbxti" : "xxti";
-	clk = clk_get(NULL, parent_name);
-	if (IS_ERR(clk)) {
-		pr_err("%s: failed to lookup parent clock %s, assuming "
-			"fin_pll clock frequency is 24MHz\n", __func__,
-			parent_name);
-	} else {
-		finpll_f = clk_get_rate(clk);
-	}

-	fclk.id = CLK_FIN_PLL;
-	fclk.name = "fin_pll";
-	fclk.parent_name = NULL;
-	fclk.flags = CLK_IS_ROOT;
-	fclk.fixed_rate = finpll_f;
-	samsung_clk_register_fixed_rate(&fclk, 1);
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	if (WARN_ON(!hw))
+		return;
+
+	init.name = "fin_pll";
+	init.ops = &__fin_pll_clk_mux_ops;
+	init.parent_names = parent_names;
+	init.num_parents = ARRAY_SIZE(parent_names);
+	init.flags = 0;
+	hw->init = &init;
+
+	clk = clk_register(NULL, hw);
+	WARN_ON(IS_ERR(clk));

+	samsung_clk_add_lookup(clk, CLK_FIN_PLL);
 }

 static struct of_device_id exynos4_clkout_ids[] __initdata = {
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 91bec3e..31fcf5f 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -273,14 +273,17 @@ void __init samsung_clk_of_register_fixed_ext(
 {
 	const struct of_device_id *match;
 	struct device_node *np;
+	unsigned int count = 0;
 	u32 freq;

 	for_each_matching_node_and_match(np, clk_matches, &match) {
 		if (of_property_read_u32(np, "clock-frequency", &freq))
 			continue;
 		fixed_rate_clk[(u32)match->data].fixed_rate = freq;
+		count++;
 	}
-	samsung_clk_register_fixed_rate(fixed_rate_clk, nr_fixed_rate_clk);
+	if (count > 0)
+		samsung_clk_register_fixed_rate(fixed_rate_clk, count);
 }
 #endif

--
1.7.9.5
