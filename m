From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Tue, 06 May 2014 21:56:49 +0530
Subject: [PATCH v4 14/15] clk: exynos5420: add misc clocks
In-Reply-To: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399393610-23394-15-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some missing miscellaneous clocks specific
to exynos5420.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   |   14 +++++++++++---
 include/dt-bindings/clock/exynos5420.h |    2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index e0e749d..e69e820 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -273,7 +273,8 @@ PNAME(mout_group5_p) = {"mout_sclk_vpll", "mout_sclk_dpll"};
 
 PNAME(mout_fimd1_final_p) = {"mout_fimd1", "mout_fimd1_opt"};
 PNAME(mout_sw_aclk66_p)	= {"dout_aclk66", "mout_sclk_spll"};
-PNAME(mout_user_aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66" };
+PNAME(mout_user_aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66"};
+PNAME(mout_user_pclk66_gpio_p) = {"mout_sw_aclk66", "ffactor_sw_aclk66"};
 
 PNAME(mout_sw_aclk200_fsys_p) = {"dout_aclk200_fsys", "mout_sclk_spll"};
 PNAME(mout_sw_pclk200_fsys_p) = {"dout_pclk200_fsys", "mout_sclk_spll"};
@@ -372,10 +373,13 @@ static struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata =
 };
 
 static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
-	FFACTOR(0, "sclk_hsic_12m", "fin_pll", 1, 2, 0),
+	FFACTOR(0, "ffactor_hsic_12m", "fin_pll", 1, 2, 0),
+	FFACTOR(0, "ffactor_sw_aclk66", "mout_sw_aclk66", 1, 2, 0),
 };
 
 static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
+	MUX(0, "mout_user_pclk66_gpio", mout_user_pclk66_gpio_p,
+			SRC_TOP7, 4, 1),
 	MUX(0, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
 	MUX(0, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
 	MUX_F(0, "mout_mau_epll_clk", mout_mau_epll_clk_p,
@@ -700,7 +704,7 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 			GATE_BUS_TOP, 7, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk333_432_isp", "mout_user_aclk333_432_isp",
 			GATE_BUS_TOP, 8, 0, 0),
-	GATE(0, "pclk66_gpio", "mout_sw_aclk66",
+	GATE(CLK_PCLK66_GPIO, "pclk66_gpio", "mout_user_pclk66_gpio",
 			GATE_BUS_TOP, 9, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk66_psgen", "mout_user_aclk66_psgen",
 			GATE_BUS_TOP, 10, CLK_IGNORE_UNUSED, 0),
@@ -718,6 +722,10 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 			GATE_BUS_TOP, 17, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_ACLK200_DISP1, "aclk200_disp1", "mout_user_aclk200_disp1",
 			GATE_BUS_TOP, 18, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_SCLK_MPHY_IXTAL24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
+			GATE_BUS_TOP, 28, 0, 0),
+	GATE(CLK_SCLK_HSIC_12M, "sclk_hsic_12m", "ffactor_hsic_12m",
+			GATE_BUS_TOP, 29, 0, 0),
 
 	GATE(CLK_ACLK300_DISP1, "aclk300_disp1", "mout_user_aclk300_disp1",
 			SRC_MASK_TOP2, 24, CLK_IGNORE_UNUSED, 0),
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 4831267..3f09da7 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -59,6 +59,8 @@
 #define CLK_SCLK_GSCL_WB	157
 #define CLK_SCLK_HDMIPHY	158
 #define CLK_MAU_EPLL		159
+#define CLK_SCLK_HSIC_12M	160
+#define CLK_SCLK_MPHY_IXTAL24	161
 
 /* gate clocks */
 #define CLK_ACLK66_PERIC	256
-- 
1.7.9.5
