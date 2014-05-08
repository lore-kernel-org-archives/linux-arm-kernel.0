From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 08 May 2014 16:57:54 +0530
Subject: [PATCH v5 05/15] clk: exynos5420: update clocks for G2D and G3D blocks
In-Reply-To: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
References: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399548484-20626-6-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing clocks of G2D block. It also removes
the aclkg3d alias from G3D block clocks.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   |   21 ++++++++++++++-------
 include/dt-bindings/clock/exynos5420.h |    2 ++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index de4431b..db998d8e 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -27,6 +27,7 @@
 #define DIV_CPU1		0x504
 #define GATE_BUS_CPU		0x700
 #define GATE_SCLK_CPU		0x800
+#define GATE_IP_G2D		0x8800
 #define CPLL_LOCK		0x10020
 #define DPLL_LOCK		0x10030
 #define EPLL_LOCK		0x10040
@@ -398,12 +399,12 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_user_aclk333", mout_user_aclk333_p, SRC_TOP4, 28, 1),
 
 	MUX(0, "mout_aclk66_psgen", mout_aclk66_peric_p, SRC_TOP5, 4, 1),
-	MUX(0, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p, SRC_TOP5,
-			8, 1),
-	MUX(0, "mout_user_aclk266_g2d", mout_user_aclk266_g2d_p, SRC_TOP5,
-			12, 1),
-	MUX_A(CLK_MOUT_G3D, "mout_user_aclk_g3d", mout_user_aclk_g3d_p,
-			SRC_TOP5, 16, 1, "aclkg3d"),
+	MUX(0, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p,
+			SRC_TOP5, 8, 1),
+	MUX(0, "mout_user_aclk266_g2d", mout_user_aclk266_g2d_p,
+			SRC_TOP5, 12, 1),
+	MUX(CLK_MOUT_G3D, "mout_user_aclk_g3d", mout_user_aclk_g3d_p,
+			SRC_TOP5, 16, 1),
 	MUX(0, "mout_user_aclk300_jpeg", mout_user_aclk300_jpeg_p,
 			SRC_TOP5, 20, 1),
 	MUX(0, "mout_user_aclk300_disp1", mout_user_aclk300_disp1_p,
@@ -830,6 +831,12 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_SMMU_FIMD1, "smmu_fimd1", "aclk300_disp1", GATE_IP_DISP1, 8, 0,
 		0),
 
+	/* G2D */
+	GATE(CLK_MDMA0, "mdma0", "aclk266_g2d", GATE_IP_G2D, 1, 0, 0),
+	GATE(CLK_G2D, "g2d", "aclk333_g2d", GATE_IP_G2D, 3, 0, 0),
+	GATE(CLK_SMMU_MDMA0, "smmu_mdma0", "aclk266_g2d", GATE_IP_G2D, 5, 0, 0),
+	GATE(CLK_SMMU_G2D, "smmu_g2d", "aclk333_g2d", GATE_IP_G2D, 7, 0, 0),
+
 	/* ISP */
 	GATE(CLK_SCLK_UART_ISP, "sclk_uart_isp", "dout_uart_isp",
 			GATE_TOP_SCLK_ISP, 0, CLK_SET_RATE_PARENT, 0),
@@ -850,7 +857,7 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
 	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
 
-	GATE(CLK_G3D, "g3d", "aclkg3d", GATE_IP_G3D, 9, 0, 0),
+	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
 
 	GATE(CLK_ROTATOR, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
 	GATE(CLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 6e22fdd..bf85418 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -177,6 +177,8 @@
 #define CLK_ACLK_G3D		500
 #define CLK_G3D			501
 #define CLK_SMMU_MIXER		502
+#define CLK_SMMU_G2D		503
+#define CLK_SMMU_MDMA0		504
 #define CLK_SCLK_UART_ISP	510
 #define CLK_SCLK_SPI0_ISP	511
 #define CLK_SCLK_SPI1_ISP	512
-- 
1.7.9.5
