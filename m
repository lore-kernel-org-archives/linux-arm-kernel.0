From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 08 May 2014 16:57:59 +0530
Subject: [PATCH v5 10/15] clk: exynos5420: update clocks for FSYS and FSYS2
 blocks
In-Reply-To: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
References: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399548484-20626-11-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds more clocks from FSYS and FSYS2 blocks
and uses GATE_IP_* registers for gating IPs.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   37 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index d37592d..9e04677 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -85,6 +85,7 @@
 #define GATE_BUS_TOP		0x10700
 #define GATE_BUS_GEN		0x1073c
 #define GATE_BUS_FSYS0		0x10740
+#define GATE_BUS_FSYS2		0x10748
 #define GATE_BUS_PERIC		0x10750
 #define GATE_BUS_PERIC1		0x10754
 #define GATE_BUS_PERIS0		0x10760
@@ -97,6 +98,7 @@
 #define GATE_IP_DISP1		0x10928
 #define GATE_IP_G3D		0x10930
 #define GATE_IP_GEN		0x10934
+#define GATE_IP_FSYS		0x10944
 #define GATE_IP_PERIC		0x10950
 #define GATE_IP_PERIS		0x10960
 #define GATE_IP_MSCL		0x10970
@@ -177,6 +179,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	GATE_BUS_TOP,
 	GATE_BUS_GEN,
 	GATE_BUS_FSYS0,
+	GATE_BUS_FSYS2,
 	GATE_BUS_PERIC,
 	GATE_BUS_PERIC1,
 	GATE_BUS_PERIS0,
@@ -189,6 +192,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	GATE_IP_DISP1,
 	GATE_IP_G3D,
 	GATE_IP_GEN,
+	GATE_IP_FSYS,
 	GATE_IP_PERIC,
 	GATE_IP_PERIS,
 	GATE_IP_MSCL,
@@ -269,6 +273,8 @@ PNAME(mout_sw_aclk66_p)	= {"dout_aclk66", "mout_sclk_spll"};
 PNAME(mout_user_aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66" };
 
 PNAME(mout_sw_aclk200_fsys_p) = {"dout_aclk200_fsys", "mout_sclk_spll"};
+PNAME(mout_sw_pclk200_fsys_p) = {"dout_pclk200_fsys", "mout_sclk_spll"};
+PNAME(mout_user_pclk200_fsys_p)	= {"fin_pll", "mout_sw_pclk200_fsys"};
 PNAME(mout_user_aclk200_fsys_p)	= {"fin_pll", "mout_sw_aclk200_fsys"};
 
 PNAME(mout_sw_aclk200_fsys2_p) = {"dout_aclk200_fsys2", "mout_sclk_spll"};
@@ -381,6 +387,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
 	MUX(0, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
 	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
+	MUX(0, "mout_pclk200_fsys", mout_group1_p, SRC_TOP0, 24, 2),
 	MUX(0, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
 
 	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
@@ -412,6 +419,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 			SRC_TOP3, 16, 1),
 	MUX(0, "mout_user_aclk100_noc", mout_user_aclk100_noc_p,
 			SRC_TOP3, 20, 1),
+	MUX(0, "mout_user_pclk200_fsys", mout_user_pclk200_fsys_p,
+			SRC_TOP3, 24, 1),
 	MUX(0, "mout_user_aclk200_fsys", mout_user_aclk200_fsys_p,
 			SRC_TOP3, 28, 1),
 
@@ -466,6 +475,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 			SRC_TOP10, 16, 1),
 	MUX(0, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
 			SRC_TOP10, 20, 1),
+	MUX(0, "mout_sw_pclk200_fsys", mout_sw_pclk200_fsys_p,
+			SRC_TOP10, 24, 1),
 	MUX(0, "mout_sw_aclk200_fsys", mout_sw_aclk200_fsys_p,
 			SRC_TOP10, 28, 1),
 
@@ -516,6 +527,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_mmc2", mout_group2_p, SRC_FSYS, 16, 3),
 	MUX(0, "mout_usbd300", mout_group2_p, SRC_FSYS, 20, 3),
 	MUX(0, "mout_unipro", mout_group2_p, SRC_FSYS, 24, 3),
+	MUX(0, "mout_mphy_refclk", mout_group2_p, SRC_FSYS, 28, 3),
 
 	/* PERIC Block */
 	MUX(0, "mout_uart0", mout_group2_p, SRC_PERIC0, 4, 3),
@@ -598,6 +610,7 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_mmc2", "mout_mmc2", DIV_FSYS1, 20, 10),
 
 	DIV(0, "dout_unipro", "mout_unipro", DIV_FSYS2, 24, 8),
+	DIV(0, "dout_mphy_refclk", "mout_mphy_refclk", DIV_FSYS2, 16, 8),
 
 	/* UART and PWM */
 	DIV(0, "dout_uart0", "mout_uart0", DIV_PERIC0, 8, 4),
@@ -738,9 +751,6 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_SCLK_USBD301, "sclk_usbd301", "dout_usbd301",
 		GATE_TOP_SCLK_FSYS, 10, CLK_SET_RATE_PARENT, 0),
 
-	GATE(CLK_SCLK_USBD301, "sclk_unipro", "dout_unipro",
-		SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
-
 	/* Display */
 	GATE(CLK_SCLK_FIMD1, "sclk_fimd1", "dout_fimd1",
 			GATE_TOP_SCLK_DISP1, 0, CLK_SET_RATE_PARENT, 0),
@@ -758,20 +768,23 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 		GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
 		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
-	/* FSYS */
+
+	/* FSYS Block */
 	GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
 	GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
 	GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
 	GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
-	GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_BUS_FSYS0, 5, 0, 0),
-	GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
-	GATE(CLK_MMC1, "mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
-	GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
+	GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_IP_FSYS, 9, 0, 0),
+	GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
+	GATE(CLK_MMC1, "mmc1", "aclk200_fsys2", GATE_IP_FSYS, 13, 0, 0),
+	GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
 	GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
-			GATE_BUS_FSYS0, 19, CLK_IGNORE_UNUSED, 0),
-	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_BUS_FSYS0, 20, 0, 0),
-	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_BUS_FSYS0, 21, 0, 0),
-	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_BUS_FSYS0, 28, 0, 0),
+			GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
+	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
+	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
+	GATE(CLK_SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
+			SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
 
 	/* PERIC Block */
 	GATE(CLK_UART0, "uart0", "aclk66_peric", GATE_IP_PERIC, 0, 0, 0),
-- 
1.7.9.5
