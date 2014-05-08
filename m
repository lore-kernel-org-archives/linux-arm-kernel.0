From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 08 May 2014 16:57:51 +0530
Subject: [PATCH v5 02/15] clk: exynos5420: add clocks for ISP block
In-Reply-To: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
References: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399548484-20626-3-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds minimum set of clocks to gate ISP block for
power saving.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   |   86 ++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h |    7 +++
 2 files changed, 93 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 831670d..9f77d56 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -56,6 +56,7 @@
 #define SRC_FSYS		0x10244
 #define SRC_PERIC0		0x10250
 #define SRC_PERIC1		0x10254
+#define SRC_ISP			0x10270
 #define SRC_TOP10		0x10280
 #define SRC_TOP11		0x10284
 #define SRC_TOP12		0x10288
@@ -76,12 +77,15 @@
 #define DIV_PERIC2		0x10560
 #define DIV_PERIC3		0x10564
 #define DIV_PERIC4		0x10568
+#define SCLK_DIV_ISP0		0x10580
+#define SCLK_DIV_ISP1		0x10584
 #define GATE_BUS_TOP		0x10700
 #define GATE_BUS_FSYS0		0x10740
 #define GATE_BUS_PERIC		0x10750
 #define GATE_BUS_PERIC1		0x10754
 #define GATE_BUS_PERIS0		0x10760
 #define GATE_BUS_PERIS1		0x10764
+#define GATE_TOP_SCLK_ISP	0x10870
 #define GATE_IP_GSCL0		0x10910
 #define GATE_IP_GSCL1		0x10920
 #define GATE_IP_MFC		0x1092c
@@ -144,6 +148,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	SRC_MASK_FSYS,
 	SRC_MASK_PERIC0,
 	SRC_MASK_PERIC1,
+	SRC_ISP,
 	DIV_TOP0,
 	DIV_TOP1,
 	DIV_TOP2,
@@ -157,12 +162,15 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	DIV_PERIC2,
 	DIV_PERIC3,
 	DIV_PERIC4,
+	SCLK_DIV_ISP0,
+	SCLK_DIV_ISP1,
 	GATE_BUS_TOP,
 	GATE_BUS_FSYS0,
 	GATE_BUS_PERIC,
 	GATE_BUS_PERIC1,
 	GATE_BUS_PERIS0,
 	GATE_BUS_PERIS1,
+	GATE_TOP_SCLK_ISP,
 	GATE_IP_GSCL0,
 	GATE_IP_GSCL1,
 	GATE_IP_MFC,
@@ -249,6 +257,15 @@ PNAME(mout_user_aclk200_fsys_p)	= {"fin_pll", "mout_sw_aclk200_fsys"};
 
 PNAME(mout_sw_aclk200_fsys2_p) = {"dout_aclk200_fsys2", "mout_sclk_spll"};
 PNAME(mout_user_aclk200_fsys2_p) = {"fin_pll", "mout_sw_aclk200_fsys2"};
+PNAME(mout_sw_aclk400_isp_p) = {"dout_aclk400_isp", "mout_sclk_spll"};
+PNAME(mout_user_aclk400_isp_p) = {"fin_pll", "mout_sw_aclk400_isp"};
+
+PNAME(mout_sw_aclk333_432_isp0_p) = {"dout_aclk333_432_isp0",
+					"mout_sclk_spll"};
+PNAME(mout_user_aclk333_432_isp0_p) = {"fin_pll", "mout_sw_aclk333_432_isp0"};
+
+PNAME(mout_sw_aclk333_432_isp_p) = {"dout_aclk333_432_isp", "mout_sclk_spll"};
+PNAME(mout_user_aclk333_432_isp_p) = {"fin_pll", "mout_sw_aclk333_432_isp"};
 
 PNAME(mout_sw_aclk200_p) = {"dout_aclk200", "mout_sclk_spll"};
 PNAME(mout_aclk200_disp1_p) = {"fin_pll", "mout_sw_aclk200"};
@@ -264,6 +281,7 @@ PNAME(mout_user_aclk166_p) = {"fin_pll", "mout_sw_aclk166"};
 
 PNAME(mout_sw_aclk266_p) = {"dout_aclk266", "mout_sclk_spll"};
 PNAME(mout_user_aclk266_p) = {"fin_pll", "mout_sw_aclk266"};
+PNAME(mout_user_aclk266_isp_p) = {"fin_pll", "mout_sw_aclk266"};
 
 PNAME(mout_sw_aclk333_432_gscl_p) = {"dout_aclk333_432_gscl", "mout_sclk_spll"};
 PNAME(mout_user_aclk333_432_gscl_p) = {"fin_pll", "mout_sw_aclk333_432_gscl"};
@@ -331,6 +349,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 
 	MUX(0, "sclk_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
 
+	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
 	MUX_A(0, "mout_aclk400_mscl", mout_group1_p,
 			SRC_TOP0, 4, 2, "aclk400_mscl"),
 	MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
@@ -338,7 +357,10 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
 
 	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
+	MUX(0, "mout_aclk333_432_isp", mout_group4_p,
+			SRC_TOP1, 4, 2),
 	MUX(0, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2),
+	MUX(0, "mout_aclk333_432_isp0", mout_group4_p, SRC_TOP1, 12, 2),
 	MUX(0, "mout_aclk266", mout_group1_p, SRC_TOP1, 20, 2),
 	MUX(0, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2),
 	MUX(0, "mout_aclk333", mout_group1_p, SRC_TOP1, 28, 2),
@@ -350,6 +372,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
 	MUX(0, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
 
+	MUX(0, "mout_user_aclk400_isp", mout_user_aclk400_isp_p,
+			SRC_TOP3, 0, 1),
 	MUX(0, "mout_user_aclk400_mscl", mout_user_aclk400_mscl_p,
 			SRC_TOP3, 4, 1),
 	MUX(0, "mout_aclk200_disp1", mout_aclk200_disp1_p, SRC_TOP3, 8, 1),
@@ -360,7 +384,13 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 
 	MUX(0, "mout_user_aclk333_432_gscl", mout_user_aclk333_432_gscl_p,
 			SRC_TOP4, 0, 1),
+	MUX(0, "mout_user_aclk333_432_isp", mout_user_aclk333_432_isp_p,
+			SRC_TOP4, 4, 1),
 	MUX(0, "mout_aclk66_peric", mout_aclk66_peric_p, SRC_TOP4, 8, 1),
+	MUX(0, "mout_user_aclk333_432_isp0", mout_user_aclk333_432_isp0_p,
+			SRC_TOP4, 12, 1),
+	MUX(0, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
+			SRC_TOP4, 16, 1),
 	MUX(0, "mout_user_aclk266", mout_user_aclk266_p, SRC_TOP4, 20, 1),
 	MUX(0, "mout_user_aclk166", mout_user_aclk166_p, SRC_TOP4, 24, 1),
 	MUX(0, "mout_user_aclk333", mout_user_aclk333_p, SRC_TOP4, 28, 1),
@@ -388,6 +418,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
 	MUX(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
 
+	MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
+			SRC_TOP10, 0, 1),
 	MUX(0, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
 			SRC_TOP10, 4, 1),
 	MUX(0, "mout_sw_aclk200", mout_sw_aclk200_p, SRC_TOP10, 8, 1),
@@ -395,9 +427,14 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 			SRC_TOP10, 12, 1),
 	MUX(0, "mout_sw_aclk200_fsys", mout_sw_aclk200_fsys_p,
 			SRC_TOP10, 28, 1),
+
 	MUX(0, "mout_sw_aclk333_432_gscl", mout_sw_aclk333_432_gscl_p,
 			SRC_TOP11, 0, 1),
+	MUX(0, "mout_sw_aclk333_432_isp", mout_sw_aclk333_432_isp_p,
+			SRC_TOP11, 4, 1),
 	MUX(0, "mout_sw_aclk66", mout_sw_aclk66_p, SRC_TOP11, 8, 1),
+	MUX(0, "mout_sw_aclk333_432_isp0", mout_sw_aclk333_432_isp0_p,
+			SRC_TOP11, 12, 1),
 	MUX(0, "mout_sw_aclk266", mout_sw_aclk266_p, SRC_TOP11, 20, 1),
 	MUX(0, "mout_sw_aclk166", mout_sw_aclk166_p, SRC_TOP11, 24, 1),
 	MUX(0, "mout_sw_aclk333", mout_sw_aclk333_p, SRC_TOP11, 28, 1),
@@ -445,6 +482,13 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
 	MUX(0, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
 	MUX(0, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
+
+	/* ISP Block */
+	MUX(0, "mout_pwm_isp", mout_group2_p, SRC_ISP, 24, 3),
+	MUX(0, "mout_uart_isp", mout_group2_p, SRC_ISP, 20, 3),
+	MUX(0, "mout_spi0_isp", mout_group2_p, SRC_ISP, 12, 3),
+	MUX(0, "mout_spi1_isp", mout_group2_p, SRC_ISP, 16, 3),
+	MUX(0, "mout_isp_sensor", mout_group2_p, SRC_ISP, 28, 3),
 };
 
 static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
@@ -454,6 +498,7 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "div_kfc", "mout_kfc", DIV_KFC0, 0, 3),
 	DIV(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
 
+	DIV(0, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
 	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
 	DIV(0, "dout_aclk200", "mout_aclk200", DIV_TOP0, 8, 3),
 	DIV(0, "dout_aclk200_fsys2", "mout_aclk200_fsys2", DIV_TOP0, 12, 3),
@@ -462,7 +507,11 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 
 	DIV(0, "dout_aclk333_432_gscl", "mout_aclk333_432_gscl",
 			DIV_TOP1, 0, 3),
+	DIV(0, "dout_aclk333_432_isp", "mout_aclk333_432_isp",
+			DIV_TOP1, 4, 3),
 	DIV(0, "dout_aclk66", "mout_aclk66", DIV_TOP1, 8, 6),
+	DIV(0, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
+			DIV_TOP1, 16, 3),
 	DIV(0, "dout_aclk266", "mout_aclk266", DIV_TOP1, 20, 3),
 	DIV(0, "dout_aclk166", "mout_aclk166", DIV_TOP1, 24, 3),
 	DIV(0, "dout_aclk333", "mout_aclk333", DIV_TOP1, 28, 3),
@@ -525,6 +574,19 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_pre_spi0", "dout_spi0", DIV_PERIC4, 8, 8),
 	DIV(0, "dout_pre_spi1", "dout_spi1", DIV_PERIC4, 16, 8),
 	DIV(0, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
+
+	/* ISP Block */
+	DIV(0, "dout_isp_sensor0", "mout_isp_sensor", SCLK_DIV_ISP0, 8, 8),
+	DIV(0, "dout_isp_sensor1", "mout_isp_sensor", SCLK_DIV_ISP0, 16, 8),
+	DIV(0, "dout_isp_sensor2", "mout_isp_sensor", SCLK_DIV_ISP0, 24, 8),
+	DIV(0, "dout_pwm_isp", "mout_pwm_isp", SCLK_DIV_ISP1, 28, 4),
+	DIV(0, "dout_uart_isp", "mout_uart_isp", SCLK_DIV_ISP1, 24, 4),
+	DIV(0, "dout_spi0_isp", "mout_spi0_isp", SCLK_DIV_ISP1, 16, 4),
+	DIV(0, "dout_spi1_isp", "mout_spi1_isp", SCLK_DIV_ISP1, 20, 4),
+	DIV_F(0, "dout_spi0_isp_pre", "dout_spi0_isp", SCLK_DIV_ISP1, 0, 8,
+			CLK_SET_RATE_PARENT, 0),
+	DIV_F(0, "dout_spi1_isp_pre", "dout_spi1_isp", SCLK_DIV_ISP1, 8, 8,
+			CLK_SET_RATE_PARENT, 0),
 };
 
 static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
@@ -543,20 +605,28 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 			GATE_BUS_TOP, 1, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk300_jpeg", "mout_user_aclk300_jpeg",
 			GATE_BUS_TOP, 4, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "aclk333_432_isp0", "mout_user_aclk333_432_isp0",
+			GATE_BUS_TOP, 5, 0, 0),
 	GATE(0, "aclk300_gscl", "mout_user_aclk300_gscl",
 			GATE_BUS_TOP, 6, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk333_432_gscl", "mout_user_aclk333_432_gscl",
 			GATE_BUS_TOP, 7, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "aclk333_432_isp", "mout_user_aclk333_432_isp",
+			GATE_BUS_TOP, 8, 0, 0),
 	GATE(0, "pclk66_gpio", "mout_sw_aclk66",
 			GATE_BUS_TOP, 9, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk66_psgen", "mout_aclk66_psgen",
 			GATE_BUS_TOP, 10, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk66_peric", "mout_aclk66_peric",
 			GATE_BUS_TOP, 11, 0, 0),
+	GATE(0, "aclk266_isp", "mout_user_aclk266_isp",
+			GATE_BUS_TOP, 13, 0, 0),
 	GATE(0, "aclk166", "mout_user_aclk166",
 			GATE_BUS_TOP, 14, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk333", "mout_aclk333",
 			GATE_BUS_TOP, 15, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "aclk400_isp", "mout_user_aclk400_isp",
+			GATE_BUS_TOP, 16, 0, 0),
 
 	/* sclk */
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_uart0",
@@ -731,6 +801,22 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_SMMU_FIMD1, "smmu_fimd1", "aclk300_disp1", GATE_IP_DISP1, 8, 0,
 		0),
 
+	/* ISP */
+	GATE(CLK_SCLK_UART_ISP, "sclk_uart_isp", "dout_uart_isp",
+			GATE_TOP_SCLK_ISP, 0, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_SPI0_ISP, "sclk_spi0_isp", "dout_spi0_isp_pre",
+			GATE_TOP_SCLK_ISP, 1, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_SPI1_ISP, "sclk_spi1_isp", "dout_spi1_isp_pre",
+			GATE_TOP_SCLK_ISP, 2, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_PWM_ISP, "sclk_pwm_isp", "dout_pwm_isp",
+			GATE_TOP_SCLK_ISP, 3, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_ISP_SENSOR0, "sclk_isp_sensor0", "dout_isp_sensor0",
+			GATE_TOP_SCLK_ISP, 4, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_ISP_SENSOR1, "sclk_isp_sensor1", "dout_isp_sensor1",
+			GATE_TOP_SCLK_ISP, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_ISP_SENSOR2, "sclk_isp_sensor2", "dout_isp_sensor2",
+			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
+
 	GATE(CLK_MFC, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
 	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
 	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 54db8b3..bddf549 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -175,6 +175,13 @@
 #define CLK_ACLK_G3D		500
 #define CLK_G3D			501
 #define CLK_SMMU_MIXER		502
+#define CLK_SCLK_UART_ISP	510
+#define CLK_SCLK_SPI0_ISP	511
+#define CLK_SCLK_SPI1_ISP	512
+#define CLK_SCLK_PWM_ISP	513
+#define CLK_SCLK_ISP_SENSOR0	514
+#define CLK_SCLK_ISP_SENSOR1	515
+#define CLK_SCLK_ISP_SENSOR2	516
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
-- 
1.7.9.5
