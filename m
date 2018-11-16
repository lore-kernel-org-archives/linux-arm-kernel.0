From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 16 Nov 2018 21:53:02 +0100
Subject: [PATCH 2/3] clk: meson: meson8b: rename cpu_div2/cpu_div3 to
 cpu_in_div2/cpu_in_div3
In-Reply-To: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
References: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181116205303.6354-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "cpu_div2" and "cpu_div3" take "cpu_in" as input and divide that by
2 or 3. The clock controller can also generate various CPU clock
post-dividers (2, 3, 4, 5, 6, 7, 8) which are derived from "cpu_clk".
When adding support for these post-dividers our clock naming could be
misleading as we have "cpu_div2" as well as "cpu_clk_div2".
Rename the existing "cpu_in" dividers so the name of the divider's
parent is part of the divider clock's name.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 20 ++++++++++----------
 drivers/clk/meson/meson8b.h |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index b3bdc7e05441..010dccc86b5d 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -560,11 +560,11 @@ static struct clk_regmap meson8b_cpu_in_sel = {
 	},
 };
 
-static struct clk_fixed_factor meson8b_cpu_div2 = {
+static struct clk_fixed_factor meson8b_cpu_in_div2 = {
 	.mult = 1,
 	.div = 2,
 	.hw.init = &(struct clk_init_data){
-		.name = "cpu_div2",
+		.name = "cpu_in_div2",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "cpu_in_sel" },
 		.num_parents = 1,
@@ -572,11 +572,11 @@ static struct clk_fixed_factor meson8b_cpu_div2 = {
 	},
 };
 
-static struct clk_fixed_factor meson8b_cpu_div3 = {
+static struct clk_fixed_factor meson8b_cpu_in_div3 = {
 	.mult = 1,
 	.div = 3,
 	.hw.init = &(struct clk_init_data){
-		.name = "cpu_div3",
+		.name = "cpu_in_div3",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "cpu_in_sel" },
 		.num_parents = 1,
@@ -626,12 +626,12 @@ static struct clk_regmap meson8b_cpu_scale_out_sel = {
 		.ops = &clk_regmap_mux_ops,
 		/*
 		 * NOTE: We are skipping the parent with value 0x2 (which is
-		 * "cpu_div3") because it results in a duty cycle of 33% which
-		 * makes the system unstable and can result in a lockup of the
-		 * whole system.
+		 * "cpu_in_div3") because it results in a duty cycle of 33%
+		 * which makes the system unstable and can result in a lockup
+		 * of the whole system.
 		 */
 		.parent_names = (const char *[]) { "cpu_in_sel",
-						   "cpu_div2",
+						   "cpu_in_div2",
 						   "cpu_scale_div" },
 		.num_parents = 3,
 		.flags = CLK_SET_RATE_PARENT,
@@ -889,8 +889,8 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_MPLL1_DIV]	    = &meson8b_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]	    = &meson8b_mpll2_div.hw,
 		[CLKID_CPU_IN_SEL]	    = &meson8b_cpu_in_sel.hw,
-		[CLKID_CPU_DIV2]	    = &meson8b_cpu_div2.hw,
-		[CLKID_CPU_DIV3]	    = &meson8b_cpu_div3.hw,
+		[CLKID_CPU_IN_DIV2]	    = &meson8b_cpu_in_div2.hw,
+		[CLKID_CPU_IN_DIV3]	    = &meson8b_cpu_in_div3.hw,
 		[CLKID_CPU_SCALE_DIV]	    = &meson8b_cpu_scale_div.hw,
 		[CLKID_CPU_SCALE_OUT_SEL]   = &meson8b_cpu_scale_out_sel.hw,
 		[CLKID_MPLL_PREDIV]	    = &meson8b_mpll_prediv.hw,
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 1c6fb180e6a2..9cba34c6cb92 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -63,8 +63,8 @@
 #define CLKID_MPLL1_DIV		97
 #define CLKID_MPLL2_DIV		98
 #define CLKID_CPU_IN_SEL	99
-#define CLKID_CPU_DIV2		100
-#define CLKID_CPU_DIV3		101
+#define CLKID_CPU_IN_DIV2	100
+#define CLKID_CPU_IN_DIV3	101
 #define CLKID_CPU_SCALE_DIV	102
 #define CLKID_CPU_SCALE_OUT_SEL	103
 #define CLKID_MPLL_PREDIV	104
-- 
2.19.1
