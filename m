From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Tue, 06 May 2014 21:56:42 +0530
Subject: [PATCH v4 07/15] clk: exynos5420: update clocks for PERIC block
In-Reply-To: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399393610-23394-8-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes,
    1] renaming of the HSI2C clocks
    2] renaming of spi clocks according to the datasheet
    3] fixes for child-parent relationships
    4] adding of more clocks related to PERIC block
    5] use GATE_IP_* offsets instead of GATE_BUS_*

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi      |   14 ++---
 drivers/clk/samsung/clk-exynos5420.c   |   92 +++++++++++++++-----------------
 include/dt-bindings/clock/exynos5420.h |   14 ++---
 3 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 0d1dea8..08835f9 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -549,7 +549,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c4_hs_bus>;
-		clocks = <&clock CLK_I2C4>;
+		clocks = <&clock CLK_USI0>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -562,7 +562,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c5_hs_bus>;
-		clocks = <&clock CLK_I2C5>;
+		clocks = <&clock CLK_USI1>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -575,7 +575,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c6_hs_bus>;
-		clocks = <&clock CLK_I2C6>;
+		clocks = <&clock CLK_USI2>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -588,7 +588,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c7_hs_bus>;
-		clocks = <&clock CLK_I2C7>;
+		clocks = <&clock CLK_USI3>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -601,7 +601,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c8_hs_bus>;
-		clocks = <&clock CLK_I2C8>;
+		clocks = <&clock CLK_USI4>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -614,7 +614,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c9_hs_bus>;
-		clocks = <&clock CLK_I2C9>;
+		clocks = <&clock CLK_USI5>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -627,7 +627,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c10_hs_bus>;
-		clocks = <&clock CLK_I2C10>;
+		clocks = <&clock CLK_USI6>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 9750659..c86ecbb 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -95,6 +95,7 @@
 #define GATE_IP_DISP1		0x10928
 #define GATE_IP_G3D		0x10930
 #define GATE_IP_GEN		0x10934
+#define GATE_IP_PERIC		0x10950
 #define GATE_IP_MSCL		0x10970
 #define GATE_TOP_SCLK_GSCL	0x10820
 #define GATE_TOP_SCLK_DISP1	0x10828
@@ -183,6 +184,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	GATE_IP_DISP1,
 	GATE_IP_G3D,
 	GATE_IP_GEN,
+	GATE_IP_PERIC,
 	GATE_IP_MSCL,
 	GATE_TOP_SCLK_GSCL,
 	GATE_TOP_SCLK_DISP1,
@@ -258,7 +260,7 @@ PNAME(mout_group5_p) = {"mout_sclk_vpll", "mout_sclk_dpll"};
 
 PNAME(mout_fimd1_final_p) = {"mout_fimd1", "mout_fimd1_opt"};
 PNAME(mout_sw_aclk66_p)	= {"dout_aclk66", "mout_sclk_spll"};
-PNAME(mout_aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66" };
+PNAME(mout_user_aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66" };
 
 PNAME(mout_sw_aclk200_fsys_p) = {"dout_aclk200_fsys", "mout_sclk_spll"};
 PNAME(mout_user_aclk200_fsys_p)	= {"fin_pll", "mout_sw_aclk200_fsys"};
@@ -398,7 +400,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 			SRC_TOP4, 0, 1),
 	MUX(0, "mout_user_aclk333_432_isp", mout_user_aclk333_432_isp_p,
 			SRC_TOP4, 4, 1),
-	MUX(0, "mout_aclk66_peric", mout_aclk66_peric_p, SRC_TOP4, 8, 1),
+	MUX(0, "mout_user_aclk66_peric", mout_user_aclk66_peric_p,
+			SRC_TOP4, 8, 1),
 	MUX(0, "mout_user_aclk333_432_isp0", mout_user_aclk333_432_isp0_p,
 			SRC_TOP4, 12, 1),
 	MUX(0, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
@@ -409,7 +412,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 
 	MUX(0, "mout_user_aclk400_disp1", mout_user_aclk400_disp1_p,
 			SRC_TOP5, 0, 1),
-	MUX(0, "mout_aclk66_psgen", mout_aclk66_peric_p, SRC_TOP5, 4, 1),
+	MUX(0, "mout_user_aclk66_psgen", mout_user_aclk66_peric_p, SRC_TOP5,
+			4, 1),
 	MUX(0, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p, SRC_TOP5,
 			8, 1),
 	MUX(0, "mout_user_aclk266_g2d", mout_user_aclk266_g2d_p, SRC_TOP5,
@@ -592,9 +596,9 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_audio2", "mout_audio2", DIV_PERIC3, 28, 4),
 
 	/* SPI Pre-Ratio */
-	DIV(0, "dout_pre_spi0", "dout_spi0", DIV_PERIC4, 8, 8),
-	DIV(0, "dout_pre_spi1", "dout_spi1", DIV_PERIC4, 16, 8),
-	DIV(0, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
+	DIV(0, "dout_spi0_pre", "dout_spi0", DIV_PERIC4, 8, 8),
+	DIV(0, "dout_spi1_pre", "dout_spi1", DIV_PERIC4, 16, 8),
+	DIV(0, "dout_spi2_pre", "dout_spi2", DIV_PERIC4, 24, 8),
 
 	/* GSCL Block */
 	DIV(0, "dout_gscl_blk_300", "mout_user_aclk300_gscl",
@@ -644,10 +648,10 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 			GATE_BUS_TOP, 8, 0, 0),
 	GATE(0, "pclk66_gpio", "mout_sw_aclk66",
 			GATE_BUS_TOP, 9, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk66_psgen", "mout_aclk66_psgen",
+	GATE(0, "aclk66_psgen", "mout_user_aclk66_psgen",
 			GATE_BUS_TOP, 10, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk66_peric", "mout_aclk66_peric",
-			GATE_BUS_TOP, 11, 0, 0),
+	GATE(CLK_ACLK66_PERIC, "aclk66_peric", "mout_user_aclk66_peric",
+			GATE_BUS_TOP, 11, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk266_isp", "mout_user_aclk266_isp",
 			GATE_BUS_TOP, 13, 0, 0),
 	GATE(0, "aclk166", "mout_user_aclk166",
@@ -673,11 +677,11 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 		GATE_TOP_SCLK_PERIC, 2, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UART3, "sclk_uart3", "dout_uart3",
 		GATE_TOP_SCLK_PERIC, 3, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_SPI0, "sclk_spi0", "dout_pre_spi0",
+	GATE(CLK_SCLK_SPI0, "sclk_spi0", "dout_spi0_pre",
 		GATE_TOP_SCLK_PERIC, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_SPI1, "sclk_spi1", "dout_pre_spi1",
+	GATE(CLK_SCLK_SPI1, "sclk_spi1", "dout_spi1_pre",
 		GATE_TOP_SCLK_PERIC, 7, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_SPI2, "sclk_spi2", "dout_pre_spi2",
+	GATE(CLK_SCLK_SPI2, "sclk_spi2", "dout_spi2_pre",
 		GATE_TOP_SCLK_PERIC, 8, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "mout_spdif",
 		GATE_TOP_SCLK_PERIC, 9, CLK_SET_RATE_PARENT, 0),
@@ -742,43 +746,35 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_BUS_FSYS0, 21, 0, 0),
 	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_BUS_FSYS0, 28, 0, 0),
 
-	/* UART */
-	GATE(CLK_UART0, "uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
-	GATE(CLK_UART1, "uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
-	GATE_A(CLK_UART2, "uart2", "aclk66_peric",
-		GATE_BUS_PERIC, 6, CLK_IGNORE_UNUSED, 0, "uart2"),
-	GATE(CLK_UART3, "uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
-	/* I2C */
-	GATE(CLK_I2C0, "i2c0", "aclk66_peric", GATE_BUS_PERIC, 9, 0, 0),
-	GATE(CLK_I2C1, "i2c1", "aclk66_peric", GATE_BUS_PERIC, 10, 0, 0),
-	GATE(CLK_I2C2, "i2c2", "aclk66_peric", GATE_BUS_PERIC, 11, 0, 0),
-	GATE(CLK_I2C3, "i2c3", "aclk66_peric", GATE_BUS_PERIC, 12, 0, 0),
-	GATE(CLK_I2C4, "i2c4", "aclk66_peric", GATE_BUS_PERIC, 13, 0, 0),
-	GATE(CLK_I2C5, "i2c5", "aclk66_peric", GATE_BUS_PERIC, 14, 0, 0),
-	GATE(CLK_I2C6, "i2c6", "aclk66_peric", GATE_BUS_PERIC, 15, 0, 0),
-	GATE(CLK_I2C7, "i2c7", "aclk66_peric", GATE_BUS_PERIC, 16, 0, 0),
-	GATE(CLK_I2C_HDMI, "i2c_hdmi", "aclk66_peric", GATE_BUS_PERIC, 17, 0,
-		0),
-	GATE(CLK_TSADC, "tsadc", "aclk66_peric", GATE_BUS_PERIC, 18, 0, 0),
-	/* SPI */
-	GATE(CLK_SPI0, "spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
-	GATE(CLK_SPI1, "spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
-	GATE(CLK_SPI2, "spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
+	/* PERIC Block */
+	GATE(CLK_UART0, "uart0", "aclk66_peric", GATE_IP_PERIC, 0, 0, 0),
+	GATE(CLK_UART1, "uart1", "aclk66_peric", GATE_IP_PERIC, 1, 0, 0),
+	GATE(CLK_UART2, "uart2", "aclk66_peric", GATE_IP_PERIC, 2, 0, 0),
+	GATE(CLK_UART3, "uart3", "aclk66_peric", GATE_IP_PERIC, 3, 0, 0),
+	GATE(CLK_I2C0, "i2c0", "aclk66_peric", GATE_IP_PERIC, 6, 0, 0),
+	GATE(CLK_I2C1, "i2c1", "aclk66_peric", GATE_IP_PERIC, 7, 0, 0),
+	GATE(CLK_I2C2, "i2c2", "aclk66_peric", GATE_IP_PERIC, 8, 0, 0),
+	GATE(CLK_I2C3, "i2c3", "aclk66_peric", GATE_IP_PERIC, 9, 0, 0),
+	GATE(CLK_USI0, "usi0", "aclk66_peric", GATE_IP_PERIC, 10, 0, 0),
+	GATE(CLK_USI1, "usi1", "aclk66_peric", GATE_IP_PERIC, 11, 0, 0),
+	GATE(CLK_USI2, "usi2", "aclk66_peric", GATE_IP_PERIC, 12, 0, 0),
+	GATE(CLK_USI3, "usi3", "aclk66_peric", GATE_IP_PERIC, 13, 0, 0),
+	GATE(CLK_I2C_HDMI, "i2c_hdmi", "aclk66_peric", GATE_IP_PERIC, 14, 0, 0),
+	GATE(CLK_TSADC, "tsadc", "aclk66_peric", GATE_IP_PERIC, 15, 0, 0),
+	GATE(CLK_SPI0, "spi0", "aclk66_peric", GATE_IP_PERIC, 16, 0, 0),
+	GATE(CLK_SPI1, "spi1", "aclk66_peric", GATE_IP_PERIC, 17, 0, 0),
+	GATE(CLK_SPI2, "spi2", "aclk66_peric", GATE_IP_PERIC, 18, 0, 0),
+	GATE(CLK_I2S1, "i2s1", "aclk66_peric", GATE_IP_PERIC, 20, 0, 0),
+	GATE(CLK_I2S2, "i2s2", "aclk66_peric", GATE_IP_PERIC, 21, 0, 0),
+	GATE(CLK_PCM1, "pcm1", "aclk66_peric", GATE_IP_PERIC, 22, 0, 0),
+	GATE(CLK_PCM2, "pcm2", "aclk66_peric", GATE_IP_PERIC, 23, 0, 0),
+	GATE(CLK_PWM, "pwm", "aclk66_peric", GATE_IP_PERIC, 24, 0, 0),
+	GATE(CLK_SPDIF, "spdif", "aclk66_peric", GATE_IP_PERIC, 26, 0, 0),
+	GATE(CLK_USI4, "usi4", "aclk66_peric", GATE_IP_PERIC, 28, 0, 0),
+	GATE(CLK_USI5, "usi5", "aclk66_peric", GATE_IP_PERIC, 30, 0, 0),
+	GATE(CLK_USI6, "usi6", "aclk66_peric", GATE_IP_PERIC, 31, 0, 0),
+
 	GATE(CLK_KEYIF, "keyif", "aclk66_peric", GATE_BUS_PERIC, 22, 0, 0),
-	/* I2S */
-	GATE(CLK_I2S1, "i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
-	GATE(CLK_I2S2, "i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
-	/* PCM */
-	GATE(CLK_PCM1, "pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
-	GATE(CLK_PCM2, "pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
-	/* PWM */
-	GATE(CLK_PWM, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
-	/* SPDIF */
-	GATE(CLK_SPDIF, "spdif", "aclk66_peric", GATE_BUS_PERIC, 29, 0, 0),
-
-	GATE(CLK_I2C8, "i2c8", "aclk66_peric", GATE_BUS_PERIC1, 0, 0, 0),
-	GATE(CLK_I2C9, "i2c9", "aclk66_peric", GATE_BUS_PERIC1, 1, 0, 0),
-	GATE(CLK_I2C10, "i2c10", "aclk66_peric", GATE_BUS_PERIC1, 2, 0, 0),
 
 	GATE(CLK_CHIPID, "chipid", "aclk66_psgen",
 			GATE_BUS_PERIS0, 12, CLK_IGNORE_UNUSED, 0),
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 2a28a86..e688b64 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -69,10 +69,10 @@
 #define CLK_I2C1		262
 #define CLK_I2C2		263
 #define CLK_I2C3		264
-#define CLK_I2C4		265
-#define CLK_I2C5		266
-#define CLK_I2C6		267
-#define CLK_I2C7		268
+#define CLK_USI0		265
+#define CLK_USI1		266
+#define CLK_USI2		267
+#define CLK_USI3		268
 #define CLK_I2C_HDMI		269
 #define CLK_TSADC		270
 #define CLK_SPI0		271
@@ -85,9 +85,9 @@
 #define CLK_PCM2		278
 #define CLK_PWM			279
 #define CLK_SPDIF		280
-#define CLK_I2C8		281
-#define CLK_I2C9		282
-#define CLK_I2C10		283
+#define CLK_USI4		281
+#define CLK_USI5		282
+#define CLK_USI6		283
 #define CLK_ACLK66_PSGEN	300
 #define CLK_CHIPID		301
 #define CLK_SYSREG		302
-- 
1.7.9.5
