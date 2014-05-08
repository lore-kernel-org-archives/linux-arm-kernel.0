From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 08 May 2014 16:57:57 +0530
Subject: [PATCH v5 08/15] clk: exynos5420: update clocks for PERIS and GEN
 blocks
In-Reply-To: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
References: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399548484-20626-9-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes some parent-child relationships according
to the latest datasheet and adds more clocks related to
PERIS and GEN blocks.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   |   76 +++++++++++++++++++-------------
 include/dt-bindings/clock/exynos5420.h |    3 ++
 2 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 63fbb04..b87c58e 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -83,6 +83,7 @@
 #define SCLK_DIV_ISP1		0x10584
 #define DIV2_RATIO0		0x10590
 #define GATE_BUS_TOP		0x10700
+#define GATE_BUS_GEN		0x1073c
 #define GATE_BUS_FSYS0		0x10740
 #define GATE_BUS_PERIC		0x10750
 #define GATE_BUS_PERIC1		0x10754
@@ -96,6 +97,7 @@
 #define GATE_IP_G3D		0x10930
 #define GATE_IP_GEN		0x10934
 #define GATE_IP_PERIC		0x10950
+#define GATE_IP_PERIS		0x10960
 #define GATE_IP_MSCL		0x10970
 #define GATE_TOP_SCLK_GSCL	0x10820
 #define GATE_TOP_SCLK_DISP1	0x10828
@@ -172,6 +174,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	SCLK_DIV_ISP1,
 	DIV2_RATIO0,
 	GATE_BUS_TOP,
+	GATE_BUS_GEN,
 	GATE_BUS_FSYS0,
 	GATE_BUS_PERIC,
 	GATE_BUS_PERIC1,
@@ -185,6 +188,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	GATE_IP_G3D,
 	GATE_IP_GEN,
 	GATE_IP_PERIC,
+	GATE_IP_PERIS,
 	GATE_IP_MSCL,
 	GATE_TOP_SCLK_GSCL,
 	GATE_TOP_SCLK_DISP1,
@@ -606,6 +610,10 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	/* MSCL Block */
 	DIV(0, "dout_mscl_blk", "aclk400_mscl", DIV2_RATIO0, 28, 2),
 
+	/* PSGEN */
+	DIV(0, "dout_gen_blk", "mout_user_aclk266", DIV2_RATIO0, 8, 1),
+	DIV(0, "dout_jpg_blk", "aclk166", DIV2_RATIO0, 20, 1),
+
 	/* ISP Block */
 	DIV(0, "dout_isp_sensor0", "mout_isp_sensor", SCLK_DIV_ISP0, 8, 8),
 	DIV(0, "dout_isp_sensor1", "mout_isp_sensor", SCLK_DIV_ISP0, 16, 8),
@@ -621,10 +629,6 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 };
 
 static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
-	/* TODO: Re-verify the CG bits for all the gate clocks */
-	GATE_A(CLK_MCT, "pclk_st", "aclk66_psgen", GATE_BUS_PERIS1, 2, 0, 0,
-		"mct"),
-
 	GATE(0, "aclk200_fsys", "mout_user_aclk200_fsys",
 			GATE_BUS_FSYS0, 9, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk200_fsys2", "mout_user_aclk200_fsys2",
@@ -774,28 +778,46 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 
 	GATE(CLK_KEYIF, "keyif", "aclk66_peric", GATE_BUS_PERIC, 22, 0, 0),
 
+	/* PERIS Block */
 	GATE(CLK_CHIPID, "chipid", "aclk66_psgen",
-			GATE_BUS_PERIS0, 12, CLK_IGNORE_UNUSED, 0),
+			GATE_IP_PERIS, 0, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SYSREG, "sysreg", "aclk66_psgen",
-			GATE_BUS_PERIS0, 13, CLK_IGNORE_UNUSED, 0),
-	GATE(CLK_TZPC0, "tzpc0", "aclk66_psgen", GATE_BUS_PERIS0, 18, 0, 0),
-	GATE(CLK_TZPC1, "tzpc1", "aclk66_psgen", GATE_BUS_PERIS0, 19, 0, 0),
-	GATE(CLK_TZPC2, "tzpc2", "aclk66_psgen", GATE_BUS_PERIS0, 20, 0, 0),
-	GATE(CLK_TZPC3, "tzpc3", "aclk66_psgen", GATE_BUS_PERIS0, 21, 0, 0),
-	GATE(CLK_TZPC4, "tzpc4", "aclk66_psgen", GATE_BUS_PERIS0, 22, 0, 0),
-	GATE(CLK_TZPC5, "tzpc5", "aclk66_psgen", GATE_BUS_PERIS0, 23, 0, 0),
-	GATE(CLK_TZPC6, "tzpc6", "aclk66_psgen", GATE_BUS_PERIS0, 24, 0, 0),
-	GATE(CLK_TZPC7, "tzpc7", "aclk66_psgen", GATE_BUS_PERIS0, 25, 0, 0),
-	GATE(CLK_TZPC8, "tzpc8", "aclk66_psgen", GATE_BUS_PERIS0, 26, 0, 0),
-	GATE(CLK_TZPC9, "tzpc9", "aclk66_psgen", GATE_BUS_PERIS0, 27, 0, 0),
-
-	GATE(CLK_HDMI_CEC, "hdmi_cec", "aclk66_psgen", GATE_BUS_PERIS1, 0, 0,
-		0),
+			GATE_IP_PERIS, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_TZPC0, "tzpc0", "aclk66_psgen", GATE_IP_PERIS, 6, 0, 0),
+	GATE(CLK_TZPC1, "tzpc1", "aclk66_psgen", GATE_IP_PERIS, 7, 0, 0),
+	GATE(CLK_TZPC2, "tzpc2", "aclk66_psgen", GATE_IP_PERIS, 8, 0, 0),
+	GATE(CLK_TZPC3, "tzpc3", "aclk66_psgen", GATE_IP_PERIS, 9, 0, 0),
+	GATE(CLK_TZPC4, "tzpc4", "aclk66_psgen", GATE_IP_PERIS, 10, 0, 0),
+	GATE(CLK_TZPC5, "tzpc5", "aclk66_psgen", GATE_IP_PERIS, 11, 0, 0),
+	GATE(CLK_TZPC6, "tzpc6", "aclk66_psgen", GATE_IP_PERIS, 12, 0, 0),
+	GATE(CLK_TZPC7, "tzpc7", "aclk66_psgen", GATE_IP_PERIS, 13, 0, 0),
+	GATE(CLK_TZPC8, "tzpc8", "aclk66_psgen", GATE_IP_PERIS, 14, 0, 0),
+	GATE(CLK_TZPC9, "tzpc9", "aclk66_psgen", GATE_IP_PERIS, 15, 0, 0),
+	GATE(CLK_HDMI_CEC, "hdmi_cec", "aclk66_psgen", GATE_IP_PERIS, 16, 0, 0),
+	GATE(CLK_MCT, "mct", "aclk66_psgen", GATE_IP_PERIS, 18, 0, 0),
+	GATE(CLK_WDT, "wdt", "aclk66_psgen", GATE_IP_PERIS, 19, 0, 0),
+	GATE(CLK_RTC, "rtc", "aclk66_psgen", GATE_IP_PERIS, 20, 0, 0),
+	GATE(CLK_TMU, "tmu", "aclk66_psgen", GATE_IP_PERIS, 21, 0, 0),
+	GATE(CLK_TMU_GPU, "tmu_gpu", "aclk66_psgen", GATE_IP_PERIS, 22, 0, 0),
+
 	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
-	GATE(CLK_WDT, "wdt", "aclk66_psgen", GATE_BUS_PERIS1, 3, 0, 0),
-	GATE(CLK_RTC, "rtc", "aclk66_psgen", GATE_BUS_PERIS1, 4, 0, 0),
-	GATE(CLK_TMU, "tmu", "aclk66_psgen", GATE_BUS_PERIS1, 5, 0, 0),
-	GATE(CLK_TMU_GPU, "tmu_gpu", "aclk66_psgen", GATE_BUS_PERIS1, 6, 0, 0),
+
+	/* GEN Block */
+	GATE(CLK_ROTATOR, "rotator", "mout_user_aclk266", GATE_IP_GEN, 1, 0, 0),
+	GATE(CLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
+	GATE(CLK_JPEG2, "jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
+	GATE(CLK_MDMA1, "mdma1", "mout_user_aclk266", GATE_IP_GEN, 4, 0, 0),
+	GATE(CLK_TOP_RTC, "top_rtc", "aclk66_psgen", GATE_IP_GEN, 5, 0, 0),
+	GATE(CLK_SMMU_ROTATOR, "smmu_rotator", "dout_gen_blk",
+			GATE_IP_GEN, 6, 0, 0),
+	GATE(CLK_SMMU_JPEG, "smmu_jpeg", "dout_jpg_blk", GATE_IP_GEN, 7, 0, 0),
+	GATE(CLK_SMMU_MDMA1, "smmu_mdma1", "dout_gen_blk",
+			GATE_IP_GEN, 9, 0, 0),
+
+	/* GATE_IP_GEN doesn't list gates for smmu_jpeg2 and mc */
+	GATE(CLK_SMMU_JPEG2, "smmu_jpeg2", "dout_jpg_blk",
+			GATE_BUS_GEN, 28, 0, 0),
+	GATE(CLK_MC, "mc", "aclk66_psgen", GATE_BUS_GEN, 12, 0, 0),
 
 	/* GSCL Block */
 	GATE(CLK_SCLK_GSCL_WA, "sclk_gscl_wa", "mout_user_aclk333_432_gscl",
@@ -879,14 +901,6 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
 
 	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
-
-	GATE(CLK_ROTATOR, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
-	GATE(CLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
-	GATE(CLK_JPEG2, "jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
-	GATE(CLK_MDMA1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
-	GATE(CLK_SMMU_ROTATOR, "smmu_rotator", "aclk266", GATE_IP_GEN, 6, 0, 0),
-	GATE(CLK_SMMU_JPEG, "smmu_jpeg", "aclk300_jpeg", GATE_IP_GEN, 7, 0, 0),
-	GATE(CLK_SMMU_MDMA1, "smmu_mdma1", "aclk266", GATE_IP_GEN, 9, 0, 0),
 };
 
 static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index e688b64..16262da 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -153,6 +153,7 @@
 #define CLK_JPEG		451
 #define CLK_JPEG2		452
 #define CLK_SMMU_JPEG		453
+#define CLK_SMMU_JPEG2		454
 #define CLK_ACLK300_GSCL	460
 #define CLK_SMMU_GSCL0		461
 #define CLK_SMMU_GSCL1		462
@@ -180,6 +181,8 @@
 #define CLK_SMMU_MIXER		502
 #define CLK_SMMU_G2D		503
 #define CLK_SMMU_MDMA0		504
+#define CLK_MC			505
+#define CLK_TOP_RTC		506
 #define CLK_SCLK_UART_ISP	510
 #define CLK_SCLK_SPI0_ISP	511
 #define CLK_SCLK_SPI1_ISP	512
-- 
1.7.9.5
