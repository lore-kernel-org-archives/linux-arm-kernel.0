From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 24 Apr 2014 18:33:49 +0530
Subject: [PATCH v3 13/16] clk: exynos5420: cleanup core and misc clocks
In-Reply-To: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1398344632-18623-14-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch renames some of the clocks according to the
datasheet. It also adds and updates some core and misc
clocks.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   |   29 +++++++++++++++++++++++------
 include/dt-bindings/clock/exynos5420.h |    3 +++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 3afc112..0323b34 100755
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -62,7 +62,8 @@
 #define SRC_TOP11		0x10284
 #define SRC_TOP12		0x10288
 #define SRC_MASK_TOP2		0x10308
-#define	SRC_MASK_DISP10		0x1032c
+#define SRC_MASK_DISP10		0x1032c
+#define SRC_MASK_MAU		0x10334
 #define SRC_MASK_FSYS		0x10340
 #define SRC_MASK_PERIC0		0x10350
 #define SRC_MASK_PERIC1		0x10354
@@ -271,6 +272,7 @@ PNAME(mout_group5_p) = {"mout_sclk_vpll", "mout_sclk_dpll"};
 PNAME(mout_fimd1_final_p) = {"mout_fimd1", "mout_fimd1_opt"};
 PNAME(mout_sw_aclk66_p)	= {"dout_aclk66", "mout_sclk_spll"};
 PNAME(mout_user_aclk66_peric_p) = {"fin_pll", "mout_sw_aclk66"};
+PNAME(mout_user_aclk66_gpio_p) = {"mout_sw_aclk66", "ffactor_sw_aclk66"};
 
 PNAME(mout_sw_aclk200_fsys_p) = {"dout_aclk200_fsys", "mout_sclk_spll"};
 PNAME(mout_sw_pclk200_fsys_p) = {"dout_pclk200_fsys", "mout_sclk_spll"};
@@ -351,6 +353,8 @@ PNAME(mout_hdmi_p) = {"dout_hdmi_pixel", "sclk_hdmiphy"};
 PNAME(mout_maudio0_p) = {"fin_pll", "maudio_clk", "mout_sclk_dpll",
 			 "mout_sclk_mpll", "mout_sclk_spll", "mout_sclk_ipll",
 			 "mout_sclk_epll", "mout_sclk_rpll"};
+PNAME(mout_mau_epll_clk_p) = {"mout_sclk_epll", "mout_sclk_dpll",
+				"mout_sclk_mpll", "mout_sclk_spll"};
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[] __initdata = {
@@ -367,7 +371,8 @@ static struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata =
 };
 
 static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
-	FFACTOR(0, "sclk_hsic_12m", "fin_pll", 1, 2, 0),
+	FFACTOR(0, "ffactor_hsic_12m", "fin_pll", 1, 2, 0),
+	FFACTOR(0, "ffactor_sw_aclk66", "mout_sw_aclk66", 1, 2, 0),
 };
 
 static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
@@ -478,7 +483,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 			TOP_SPARE2, 8, 1, CLK_SET_RATE_PARENT, 0),
 
 	/* MAU Block */
-	MUX(0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3),
+	MUX_F(CLK_MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3,
+						CLK_SET_RATE_PARENT, 0),
 
 	/* FSYS Block */
 	MUX(0, "mout_usbd301", mout_group2_p, SRC_FSYS, 4, 3),
@@ -502,6 +508,11 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
 	MUX(0, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
 	MUX(0, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
+
+	MUX(0, "mout_user_aclk66_gpio", mout_user_aclk66_gpio_p,
+		SRC_TOP7, 4, 1),
+	MUX_F(0, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2,
+		CLK_SET_RATE_PARENT, 0),
 	MUX(0, "mout_pclk200_fsys", mout_group1_p, SRC_TOP0, 24, 2),
 	MUX(0, "mout_sw_pclk200_fsys", mout_sw_pclk200_fsys_p,
 		SRC_TOP10, 24, 1),
@@ -552,10 +563,10 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 };
 
 static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
-	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
+	DIV(0, "dout_armclk1", "mout_cpu", DIV_CPU0, 0, 3),
 	DIV(0, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV(0, "armclk2", "div_arm", DIV_CPU0, 28, 3),
-	DIV(0, "div_kfc", "mout_cpu_kfc", DIV_KFC0, 0, 3),
+	DIV(0, "dout_armclk2", "dout_armclk1", DIV_CPU0, 28, 3),
+	DIV(0, "dout_kfc", "mout_kfc", DIV_KFC0, 0, 3),
 	DIV(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
 
 	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
@@ -908,6 +919,8 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 			GATE_IP_MSCL, 10, 0, 0),
 	GATE(CLK_SMMU_MIXER, "smmu_mixer", "aclk200_disp1",
 			GATE_IP_DISP1, 9, 0, 0),
+
+	/* aclk333 gates internal MFC busses and should not be gated. */
 	/* aclk266 also gates other IPs in psgen. It should not be gated. */
 	GATE(0, "aclk266", "mout_user_aclk266",
 			GATE_BUS_NOC, 22, CLK_IGNORE_UNUSED, 0),
@@ -928,6 +941,10 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 			"mout_user_aclk333_432_isp", GATE_BUS_TOP, 8, 0, 0),
 	GATE(CLK_MC, "mc", "aclk66_psgen", GATE_BUS_GEN, 12, 0, 0),
 	GATE(CLK_TOP_RTC, "top_rtc", "aclk66_psgen", GATE_IP_GEN, 5, 0, 0),
+	GATE(CLK_SCLK_HSIC_12M, "sclk_hsic_12m", "ffactor_hsic_12m",
+			GATE_BUS_TOP, 29, 0, 0),
+	GATE(CLK_SCLK_MPHY_IXTAL24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
+			GATE_BUS_TOP, 28, 0, 0),
 
 	/* G2D */
 	GATE(CLK_G2D, "g2d", "aclk333_g2d",
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index db1aace..c36c7c6 100755
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -58,6 +58,8 @@
 #define CLK_SCLK_GSCL_WA	156
 #define CLK_SCLK_GSCL_WB	157
 #define CLK_SCLK_HDMIPHY	158
+#define CLK_SCLK_HSIC_12M	167
+#define CLK_SCLK_MPHY_IXTAL24	168
 
 /* gate clocks */
 #define CLK_ACLK66_PERIC	256
@@ -187,6 +189,7 @@
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
+#define CLK_MOUT_MAUDIO0	642
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
-- 
1.7.9.5
