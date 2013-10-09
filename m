From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 9 Oct 2013 16:12:39 +0300
Subject: [PATCH 3/3] ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers
In-Reply-To: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1381324359-28825-3-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dpll4_m3_ck and dpll4_m4_ck have divider bit fields which are 6 bits
wide. However, only values from 1 to 32 are allowed. This means we have
to add a divider tables and list the dividers explicitly.

I believe the same issue is there for other dpll4_mx_ck clocks, but as
I'm not familiar with them, I didn't touch them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c | 44 +++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index a51dd75..e94d635 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -381,6 +381,42 @@ static struct clk_hw_omap dpll4_ck_hw = {
 
 DEFINE_STRUCT_CLK(dpll4_ck, dpll3_ck_parent_names, dpll4_ck_ops);
 
+static const struct clk_div_table dpll4_mx_ck_div_table[] = {
+	{ .div = 1, .val = 1 },
+	{ .div = 2, .val = 2 },
+	{ .div = 3, .val = 3 },
+	{ .div = 4, .val = 4 },
+	{ .div = 5, .val = 5 },
+	{ .div = 6, .val = 6 },
+	{ .div = 7, .val = 7 },
+	{ .div = 8, .val = 8 },
+	{ .div = 9, .val = 9 },
+	{ .div = 10, .val = 10 },
+	{ .div = 11, .val = 11 },
+	{ .div = 12, .val = 12 },
+	{ .div = 13, .val = 13 },
+	{ .div = 14, .val = 14 },
+	{ .div = 15, .val = 15 },
+	{ .div = 16, .val = 16 },
+	{ .div = 17, .val = 17 },
+	{ .div = 18, .val = 18 },
+	{ .div = 19, .val = 19 },
+	{ .div = 20, .val = 20 },
+	{ .div = 21, .val = 21 },
+	{ .div = 22, .val = 22 },
+	{ .div = 23, .val = 23 },
+	{ .div = 24, .val = 24 },
+	{ .div = 25, .val = 25 },
+	{ .div = 26, .val = 26 },
+	{ .div = 27, .val = 27 },
+	{ .div = 28, .val = 28 },
+	{ .div = 29, .val = 29 },
+	{ .div = 30, .val = 30 },
+	{ .div = 31, .val = 31 },
+	{ .div = 32, .val = 32 },
+	{ .div = 0 },
+};
+
 DEFINE_CLK_DIVIDER(dpll4_m5_ck, "dpll4_ck", &dpll4_ck, 0x0,
 		   OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
 		   OMAP3430_CLKSEL_CAM_SHIFT, OMAP3630_CLKSEL_CAM_WIDTH,
@@ -524,10 +560,10 @@ static const struct clksel_rate clkout2_src_54m_rates[] = {
 	{ .div = 0 }
 };
 
-DEFINE_CLK_DIVIDER(dpll4_m3_ck, "dpll4_ck", &dpll4_ck, 0x0,
+DEFINE_CLK_DIVIDER_TABLE(dpll4_m3_ck, "dpll4_ck", &dpll4_ck, 0x0,
 		   OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 		   OMAP3430_CLKSEL_TV_SHIFT, OMAP3630_CLKSEL_TV_WIDTH,
-		   CLK_DIVIDER_ONE_BASED, NULL);
+		   0, dpll4_mx_ck_div_table, NULL);
 
 static struct clk dpll4_m3x2_ck;
 
@@ -847,10 +883,10 @@ static struct clk dpll3_m3x2_ck_3630 = {
 
 DEFINE_CLK_FIXED_FACTOR(dpll3_x2_ck, "dpll3_ck", &dpll3_ck, 0x0, 2, 1);
 
-DEFINE_CLK_DIVIDER(dpll4_m4_ck, "dpll4_ck", &dpll4_ck, 0x0,
+DEFINE_CLK_DIVIDER_TABLE(dpll4_m4_ck, "dpll4_ck", &dpll4_ck, 0x0,
 		   OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 		   OMAP3430_CLKSEL_DSS1_SHIFT, OMAP3630_CLKSEL_DSS1_WIDTH,
-		   CLK_DIVIDER_ONE_BASED, NULL);
+		   0, dpll4_mx_ck_div_table, NULL);
 
 static struct clk dpll4_m4x2_ck;
 
-- 
1.8.1.2
