From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 08 May 2014 16:57:52 +0530
Subject: [PATCH v5 03/15] clk: exynos5420: update clocks for GSCL and MSCL
 blocks
In-Reply-To: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
References: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399548484-20626-4-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing GSCL and MSCL block clocks
and corrects some wrong parent-child relationships.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   |   71 ++++++++++++++++++++------------
 include/dt-bindings/clock/exynos5420.h |    4 +-
 2 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 9f77d56..68e98d4 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -79,6 +79,7 @@
 #define DIV_PERIC4		0x10568
 #define SCLK_DIV_ISP0		0x10580
 #define SCLK_DIV_ISP1		0x10584
+#define DIV2_RATIO0		0x10590
 #define GATE_BUS_TOP		0x10700
 #define GATE_BUS_FSYS0		0x10740
 #define GATE_BUS_PERIC		0x10750
@@ -164,6 +165,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	DIV_PERIC4,
 	SCLK_DIV_ISP0,
 	SCLK_DIV_ISP1,
+	DIV2_RATIO0,
 	GATE_BUS_TOP,
 	GATE_BUS_FSYS0,
 	GATE_BUS_PERIC,
@@ -575,6 +577,11 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_pre_spi1", "dout_spi1", DIV_PERIC4, 16, 8),
 	DIV(0, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
 
+	/* GSCL Block */
+	DIV(0, "dout_gscl_blk_300", "mout_user_aclk300_gscl",
+			DIV2_RATIO0, 4, 2),
+	DIV(0, "dout_gscl_blk_333", "aclk333_432_gscl", DIV2_RATIO0, 6, 2),
+
 	/* ISP Block */
 	DIV(0, "dout_isp_sensor0", "mout_isp_sensor", SCLK_DIV_ISP0, 8, 8),
 	DIV(0, "dout_isp_sensor1", "mout_isp_sensor", SCLK_DIV_ISP0, 16, 8),
@@ -627,6 +634,8 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 			GATE_BUS_TOP, 15, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk400_isp", "mout_user_aclk400_isp",
 			GATE_BUS_TOP, 16, 0, 0),
+	GATE(0, "aclk400_mscl", "mout_user_aclk400_mscl",
+			GATE_BUS_TOP, 17, 0, 0),
 
 	/* sclk */
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_uart0",
@@ -674,11 +683,6 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_SCLK_USBD301, "sclk_unipro", "dout_unipro",
 		SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
 
-	GATE(CLK_SCLK_GSCL_WA, "sclk_gscl_wa", "aclK333_432_gscl",
-		GATE_TOP_SCLK_GSCL, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_GSCL_WB, "sclk_gscl_wb", "aclk333_432_gscl",
-		GATE_TOP_SCLK_GSCL, 7, CLK_SET_RATE_PARENT, 0),
-
 	/* Display */
 	GATE(CLK_SCLK_FIMD1, "sclk_fimd1", "dout_fimd1",
 		GATE_TOP_SCLK_DISP1, 0, CLK_SET_RATE_PARENT, 0),
@@ -772,27 +776,49 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_TMU, "tmu", "aclk66_psgen", GATE_BUS_PERIS1, 5, 0, 0),
 	GATE(CLK_TMU_GPU, "tmu_gpu", "aclk66_psgen", GATE_BUS_PERIS1, 6, 0, 0),
 
+	/* GSCL Block */
+	GATE(CLK_SCLK_GSCL_WA, "sclk_gscl_wa", "mout_user_aclk333_432_gscl",
+			GATE_TOP_SCLK_GSCL, 6, 0, 0),
+	GATE(CLK_SCLK_GSCL_WB, "sclk_gscl_wb", "mout_user_aclk333_432_gscl",
+			GATE_TOP_SCLK_GSCL, 7, 0, 0),
+
 	GATE(CLK_GSCL0, "gscl0", "aclk300_gscl", GATE_IP_GSCL0, 0, 0, 0),
 	GATE(CLK_GSCL1, "gscl1", "aclk300_gscl", GATE_IP_GSCL0, 1, 0, 0),
-	GATE(CLK_CLK_3AA, "clk_3aa", "aclk300_gscl", GATE_IP_GSCL0, 4, 0, 0),
-
-	GATE(CLK_SMMU_3AA, "smmu_3aa", "aclk333_432_gscl", GATE_IP_GSCL1, 2, 0,
-		0),
-	GATE(CLK_SMMU_FIMCL0, "smmu_fimcl0", "aclk333_432_gscl",
+	GATE(CLK_FIMC_3AA, "fimc_3aa", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 4, 0, 0),
+	GATE(CLK_FIMC_LITE0, "fimc_lite0", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 5, 0, 0),
+	GATE(CLK_FIMC_LITE1, "fimc_lite1", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 6, 0, 0),
+
+	GATE(CLK_SMMU_3AA, "smmu_3aa", "dout_gscl_blk_333",
+			GATE_IP_GSCL1, 2, 0, 0),
+	GATE(CLK_SMMU_FIMCL0, "smmu_fimcl0", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 3, 0, 0),
-	GATE(CLK_SMMU_FIMCL1, "smmu_fimcl1", "aclk333_432_gscl",
+	GATE(CLK_SMMU_FIMCL1, "smmu_fimcl1", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 4, 0, 0),
-	GATE(CLK_SMMU_GSCL0, "smmu_gscl0", "aclk300_gscl", GATE_IP_GSCL1, 6, 0,
-		0),
-	GATE(CLK_SMMU_GSCL1, "smmu_gscl1", "aclk300_gscl", GATE_IP_GSCL1, 7, 0,
-		0),
-	GATE(CLK_GSCL_WA, "gscl_wa", "aclk300_gscl", GATE_IP_GSCL1, 12, 0, 0),
-	GATE(CLK_GSCL_WB, "gscl_wb", "aclk300_gscl", GATE_IP_GSCL1, 13, 0, 0),
-	GATE(CLK_SMMU_FIMCL3, "smmu_fimcl3,", "aclk333_432_gscl",
+	GATE(CLK_SMMU_GSCL0, "smmu_gscl0", "dout_gscl_blk_300",
+			GATE_IP_GSCL1, 6, 0, 0),
+	GATE(CLK_SMMU_GSCL1, "smmu_gscl1", "dout_gscl_blk_300",
+			GATE_IP_GSCL1, 7, 0, 0),
+	GATE(CLK_GSCL_WA, "gscl_wa", "sclk_gscl_wa", GATE_IP_GSCL1, 12, 0, 0),
+	GATE(CLK_GSCL_WB, "gscl_wb", "sclk_gscl_wb", GATE_IP_GSCL1, 13, 0, 0),
+	GATE(CLK_SMMU_FIMCL3, "smmu_fimcl3,", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 16, 0, 0),
 	GATE(CLK_FIMC_LITE3, "fimc_lite3", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 17, 0, 0),
 
+	/* MSCL Block */
+	GATE(CLK_MSCL0, "mscl0", "aclk400_mscl", GATE_IP_MSCL, 0, 0, 0),
+	GATE(CLK_MSCL1, "mscl1", "aclk400_mscl", GATE_IP_MSCL, 1, 0, 0),
+	GATE(CLK_MSCL2, "mscl2", "aclk400_mscl", GATE_IP_MSCL, 2, 0, 0),
+	GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "aclk400_mscl",
+			GATE_IP_MSCL, 8, 0, 0),
+	GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "aclk400_mscl",
+			GATE_IP_MSCL, 9, 0, 0),
+	GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "aclk400_mscl",
+			GATE_IP_MSCL, 10, 0, 0),
+
 	GATE(CLK_FIMD1, "fimd1", "aclk300_disp1", GATE_IP_DISP1, 0, 0, 0),
 	GATE(CLK_DSIM1, "dsim1", "aclk200_disp1", GATE_IP_DISP1, 3, 0, 0),
 	GATE(CLK_DP1, "dp1", "aclk200_disp1", GATE_IP_DISP1, 4, 0, 0),
@@ -831,15 +857,6 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_SMMU_JPEG, "smmu_jpeg", "aclk300_jpeg", GATE_IP_GEN, 7, 0, 0),
 	GATE(CLK_SMMU_MDMA1, "smmu_mdma1", "aclk266", GATE_IP_GEN, 9, 0, 0),
 
-	GATE(CLK_MSCL0, "mscl0", "aclk400_mscl", GATE_IP_MSCL, 0, 0, 0),
-	GATE(CLK_MSCL1, "mscl1", "aclk400_mscl", GATE_IP_MSCL, 1, 0, 0),
-	GATE(CLK_MSCL2, "mscl2", "aclk400_mscl", GATE_IP_MSCL, 2, 0, 0),
-	GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "aclk400_mscl", GATE_IP_MSCL, 8, 0,
-		0),
-	GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "aclk400_mscl", GATE_IP_MSCL, 9, 0,
-		0),
-	GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0,
-		0),
 	GATE(CLK_SMMU_MIXER, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1, 9, 0,
 		0),
 };
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index bddf549..6e22fdd 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -159,7 +159,7 @@
 #define CLK_GSCL_WB		464
 #define CLK_GSCL0		465
 #define CLK_GSCL1		466
-#define CLK_CLK_3AA		467
+#define CLK_FIMC_3AA		467
 #define CLK_ACLK266_G2D		470
 #define CLK_SSS			471
 #define CLK_SLIM_SSS		472
@@ -172,6 +172,8 @@
 #define CLK_SMMU_FIMCL1		493
 #define CLK_SMMU_FIMCL3		494
 #define CLK_FIMC_LITE3		495
+#define CLK_FIMC_LITE0		496
+#define CLK_FIMC_LITE1		497
 #define CLK_ACLK_G3D		500
 #define CLK_G3D			501
 #define CLK_SMMU_MIXER		502
-- 
1.7.9.5
