From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Mon, 12 May 2014 18:50:17 +0530
Subject: [PATCH] clk: exynos5250: Add missing sysmmu clocks for DISP and ISP
 blocks
Message-ID: <1399900817-10544-1-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

This patch adds the missing sysmmu clocks for Display and
ISP blocks.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c   |   35 ++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos5250.h |   16 +++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 65cb966..3bc8f40 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -28,6 +28,8 @@
 #define MPLL_CON0		0x4100
 #define SRC_CORE1		0x4204
 #define GATE_IP_ACP		0x8800
+#define GATE_IP_ISP0		0xc800
+#define GATE_IP_ISP1		0xc804
 #define CPLL_LOCK		0x10020
 #define EPLL_LOCK		0x10030
 #define VPLL_LOCK		0x10040
@@ -145,6 +147,8 @@ static unsigned long exynos5250_clk_regs[] __initdata = {
 	PLL_DIV2_SEL,
 	GATE_IP_DISP1,
 	GATE_IP_ACP,
+	GATE_IP_ISP0,
+	GATE_IP_ISP1,
 };
 
 static int exynos5250_clk_suspend(void)
@@ -202,6 +206,7 @@ PNAME(mout_aclk400_p)	= { "mout_aclk400_g3d_mid", "mout_gpll" };
 PNAME(mout_aclk200_sub_p) = { "fin_pll", "div_aclk200" };
 PNAME(mout_aclk266_sub_p) = { "fin_pll", "div_aclk266" };
 PNAME(mout_aclk333_sub_p) = { "fin_pll", "div_aclk333" };
+PNAME(mout_aclk400_isp_sub_p) = { "fin_pll", "div_aclk400_isp" };
 PNAME(mout_hdmi_p)	= { "div_hdmi_pixel", "sclk_hdmiphy" };
 PNAME(mout_usb3_p)	= { "mout_mpll_user", "mout_cpll" };
 PNAME(mout_group1_p)	= { "fin_pll", "fin_pll", "sclk_hdmi27m",
@@ -281,6 +286,7 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
 	MUX(0, "mout_aclk400_g3d_mid", mout_aclk200_p, SRC_TOP0, 20, 1),
 
+	MUX(0, "mout_aclk400_isp", mout_aclk200_p, SRC_TOP1, 24, 1),
 	MUX(0, "mout_aclk400_g3d", mout_aclk400_p, SRC_TOP1, 28, 1),
 
 	MUX(0, "mout_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
@@ -292,6 +298,9 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 
 	MUX(0, "mout_aclk200_disp1_sub", mout_aclk200_sub_p, SRC_TOP3, 4, 1),
 	MUX(0, "mout_aclk266_gscl_sub", mout_aclk266_sub_p, SRC_TOP3, 8, 1),
+	MUX(0, "mout_aclk_266_isp_sub", mout_aclk266_sub_p, SRC_TOP3, 16, 1),
+	MUX(0, "mout_aclk_400_isp_sub", mout_aclk400_isp_sub_p,
+			SRC_TOP3, 20, 1),
 	MUX(0, "mout_aclk333_sub", mout_aclk333_sub_p, SRC_TOP3, 24, 1),
 
 	MUX(0, "mout_cam_bayer", mout_group1_p, SRC_GSCL, 12, 4),
@@ -364,6 +373,7 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	DIV(0, "div_aclk400_g3d", "mout_aclk400_g3d", DIV_TOP0,
 							24, 3),
 
+	DIV(0, "div_aclk400_isp", "mout_aclk400_isp", DIV_TOP1, 20, 3),
 	DIV(0, "div_aclk66_pre", "mout_mpll_user", DIV_TOP1, 24, 3),
 
 	DIV(0, "div_cam_bayer", "mout_cam_bayer", DIV_GSCL, 12, 4),
@@ -629,6 +639,31 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(CLK_WDT, "wdt", "div_aclk66", GATE_IP_PERIS, 19, 0, 0),
 	GATE(CLK_RTC, "rtc", "div_aclk66", GATE_IP_PERIS, 20, 0, 0),
 	GATE(CLK_TMU, "tmu", "div_aclk66", GATE_IP_PERIS, 21, 0, 0),
+	GATE(CLK_SMMU_TV, "smmu_tv", "mout_aclk200_disp1_sub",
+			GATE_IP_DISP1, 2, 0, 0),
+	GATE(CLK_SMMU_FIMD1, "smmu_fimd1", "mout_aclk200_disp1_sub",
+			GATE_IP_DISP1, 8, 0, 0),
+	GATE(CLK_SMMU_2D, "smmu_2d", "div_aclk200", GATE_IP_ACP, 7, 0, 0),
+	GATE(CLK_SMMU_FIMC_ISP, "smmu_fimc_isp", "mout_aclk_266_isp_sub",
+			GATE_IP_ISP0, 8, 0, 0),
+	GATE(CLK_SMMU_FIMC_DRC, "smmu_fimc_drc", "mout_aclk_266_isp_sub",
+			GATE_IP_ISP0, 9, 0, 0),
+	GATE(CLK_SMMU_FIMC_FD, "smmu_fimc_fd", "mout_aclk_266_isp_sub",
+			GATE_IP_ISP0, 10, 0, 0),
+	GATE(CLK_SMMU_FIMC_SCC, "smmu_fimc_scc", "mout_aclk_266_isp_sub",
+			GATE_IP_ISP0, 11, 0, 0),
+	GATE(CLK_SMMU_FIMC_SCP, "smmu_fimc_scp", "mout_aclk_266_isp_sub",
+			GATE_IP_ISP0, 12, 0, 0),
+	GATE(CLK_SMMU_FIMC_MCU, "smmu_fimc_mcu", "mout_aclk_400_isp_sub",
+			GATE_IP_ISP0, 13, 0, 0),
+	GATE(CLK_SMMU_FIMC_ODC, "smmu_fimc_odc", "mout_aclk_266_isp_sub",
+			GATE_IP_ISP1, 4, 0, 0),
+	GATE(CLK_SMMU_FIMC_DIS0, "smmu_fimc_dis0", "mout_aclk_266_isp_sub",
+			GATE_IP_ISP1, 5, 0, 0),
+	GATE(CLK_SMMU_FIMC_DIS1, "smmu_fimc_dis1", "mout_aclk_266_isp_sub",
+			GATE_IP_ISP1, 6, 0, 0),
+	GATE(CLK_SMMU_FIMC_3DNR, "smmu_fimc_3dnr", "mout_aclk_266_isp_sub",
+			GATE_IP_ISP1, 7, 0, 0),
 };
 
 static struct samsung_pll_rate_table vpll_24mhz_tbl[] __initdata = {
diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
index 415d447..be6e97c 100644
--- a/include/dt-bindings/clock/exynos5250.h
+++ b/include/dt-bindings/clock/exynos5250.h
@@ -152,6 +152,22 @@
 #define CLK_SMMU_MDMA0		347
 #define CLK_SSS			348
 #define CLK_G3D			349
+#define CLK_SMMU_TV		350
+#define CLK_SMMU_FIMD1		351
+#define CLK_SMMU_2D		352
+#define CLK_SMMU_FIMC_ISP	353
+#define CLK_SMMU_FIMC_DRC	354
+#define CLK_SMMU_FIMC_SCC	355
+#define CLK_SMMU_FIMC_SCP	356
+#define CLK_SMMU_FIMC_FD	357
+#define CLK_SMMU_FIMC_MCU	358
+#define CLK_SMMU_FIMC_ODC	359
+#define CLK_SMMU_FIMC_DIS0	360
+#define CLK_SMMU_FIMC_DIS1	361
+#define CLK_SMMU_FIMC_3DNR	362
+#define CLK_SMMU_FIMC_LITE0	363
+#define CLK_SMMU_FIMC_LITE1	364
+#define CLK_CAMIF_TOP		365
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		1024
-- 
1.7.9.5
