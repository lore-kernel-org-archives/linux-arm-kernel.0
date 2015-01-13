From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 13 Jan 2015 16:57:41 +0530
Subject: [PATCH V2 2/3] clk: samsung: exynos7: add clocks for SPI block
In-Reply-To: <1421148462-11755-1-git-send-email-padma.v@samsung.com>
References: <1421148462-11755-1-git-send-email-padma.v@samsung.com>
Message-ID: <1421148462-11755-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock support for 5 SPI channels.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 .../devicetree/bindings/clock/exynos7-clock.txt    |    5 ++
 drivers/clk/samsung/clk-exynos7.c                  |   73 ++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |   19 +++++-
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
index d0e048c..9282f71 100644
--- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
@@ -77,6 +77,11 @@ Input clocks for peric1 clock controller:
 	- sclk_uart1
 	- sclk_uart2
 	- sclk_uart3
+	- sclk_spi0
+	- sclk_spi1
+	- sclk_spi2
+	- sclk_spi3
+	- sclk_spi4
 
 Input clocks for peris clock controller:
 	- fin_pll
diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index d01d766..d40c09d 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -177,9 +177,15 @@ CLK_OF_DECLARE(exynos7_clk_topc, "samsung,exynos7-clock-topc",
 #define MUX_SEL_TOP00			0x0200
 #define MUX_SEL_TOP01			0x0204
 #define MUX_SEL_TOP03			0x020C
+#define MUX_SEL_TOP0_PERIC1		0x0234
+#define MUX_SEL_TOP0_PERIC2		0x0238
 #define MUX_SEL_TOP0_PERIC3		0x023C
 #define DIV_TOP03			0x060C
+#define DIV_TOP0_PERIC1			0x0634
+#define DIV_TOP0_PERIC2			0x0638
 #define DIV_TOP0_PERIC3			0x063C
+#define ENABLE_SCLK_TOP0_PERIC1		0x0A34
+#define ENABLE_SCLK_TOP0_PERIC2		0x0A38
 #define ENABLE_SCLK_TOP0_PERIC3		0x0A3C
 
 /* List of parent clocks for Muxes in CMU_TOP0 */
@@ -205,9 +211,15 @@ static unsigned long top0_clk_regs[] __initdata = {
 	MUX_SEL_TOP00,
 	MUX_SEL_TOP01,
 	MUX_SEL_TOP03,
+	MUX_SEL_TOP0_PERIC1,
+	MUX_SEL_TOP0_PERIC2,
 	MUX_SEL_TOP0_PERIC3,
 	DIV_TOP03,
+	DIV_TOP0_PERIC1,
+	DIV_TOP0_PERIC2,
 	DIV_TOP0_PERIC3,
+	ENABLE_SCLK_TOP0_PERIC1,
+	ENABLE_SCLK_TOP0_PERIC2,
 	ENABLE_SCLK_TOP0_PERIC3,
 };
 
@@ -229,10 +241,16 @@ static struct samsung_mux_clock top0_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk_peric1_66", mout_top0_group1, MUX_SEL_TOP03, 12, 2),
 	MUX(0, "mout_aclk_peric0_66", mout_top0_group1, MUX_SEL_TOP03, 20, 2),
 
+	MUX(0, "mout_sclk_spi1", mout_top0_group1, MUX_SEL_TOP0_PERIC1, 8, 2),
+	MUX(0, "mout_sclk_spi0", mout_top0_group1, MUX_SEL_TOP0_PERIC1, 20, 2),
+
+	MUX(0, "mout_sclk_spi3", mout_top0_group1, MUX_SEL_TOP0_PERIC2, 8, 2),
+	MUX(0, "mout_sclk_spi2", mout_top0_group1, MUX_SEL_TOP0_PERIC2, 20, 2),
 	MUX(0, "mout_sclk_uart3", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 4, 2),
 	MUX(0, "mout_sclk_uart2", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 8, 2),
 	MUX(0, "mout_sclk_uart1", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 12, 2),
 	MUX(0, "mout_sclk_uart0", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 16, 2),
+	MUX(0, "mout_sclk_spi4", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 20, 2),
 };
 
 static struct samsung_div_clock top0_div_clks[] __initdata = {
@@ -241,13 +259,29 @@ static struct samsung_div_clock top0_div_clks[] __initdata = {
 	DIV(DOUT_ACLK_PERIC0, "dout_aclk_peric0_66", "mout_aclk_peric0_66",
 		DIV_TOP03, 20, 6),
 
+	DIV(0, "dout_sclk_spi1", "mout_sclk_spi1", DIV_TOP0_PERIC1, 8, 12),
+	DIV(0, "dout_sclk_spi0", "mout_sclk_spi0", DIV_TOP0_PERIC1, 20, 12),
+
+	DIV(0, "dout_sclk_spi3", "mout_sclk_spi3", DIV_TOP0_PERIC2, 8, 12),
+	DIV(0, "dout_sclk_spi2", "mout_sclk_spi2", DIV_TOP0_PERIC2, 20, 12),
+
 	DIV(0, "dout_sclk_uart3", "mout_sclk_uart3", DIV_TOP0_PERIC3, 4, 4),
 	DIV(0, "dout_sclk_uart2", "mout_sclk_uart2", DIV_TOP0_PERIC3, 8, 4),
 	DIV(0, "dout_sclk_uart1", "mout_sclk_uart1", DIV_TOP0_PERIC3, 12, 4),
 	DIV(0, "dout_sclk_uart0", "mout_sclk_uart0", DIV_TOP0_PERIC3, 16, 4),
+	DIV(0, "dout_sclk_spi4", "mout_sclk_spi4", DIV_TOP0_PERIC3, 20, 12),
 };
 
 static struct samsung_gate_clock top0_gate_clks[] __initdata = {
+	GATE(CLK_SCLK_SPI1, "sclk_spi1", "dout_sclk_spi1",
+		ENABLE_SCLK_TOP0_PERIC1, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_SPI0, "sclk_spi0", "dout_sclk_spi0",
+		ENABLE_SCLK_TOP0_PERIC1, 20, CLK_SET_RATE_PARENT, 0),
+
+	GATE(CLK_SCLK_SPI3, "sclk_spi3", "dout_sclk_spi3",
+		ENABLE_SCLK_TOP0_PERIC2, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_SPI2, "sclk_spi2", "dout_sclk_spi2",
+		ENABLE_SCLK_TOP0_PERIC2, 20, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UART3, "sclk_uart3", "dout_sclk_uart3",
 		ENABLE_SCLK_TOP0_PERIC3, 4, 0, 0),
 	GATE(CLK_SCLK_UART2, "sclk_uart2", "dout_sclk_uart2",
@@ -256,6 +290,8 @@ static struct samsung_gate_clock top0_gate_clks[] __initdata = {
 		ENABLE_SCLK_TOP0_PERIC3, 12, 0, 0),
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_sclk_uart0",
 		ENABLE_SCLK_TOP0_PERIC3, 16, 0, 0),
+	GATE(CLK_SCLK_SPI4, "sclk_spi4", "dout_sclk_spi4",
+		ENABLE_SCLK_TOP0_PERIC3, 20, CLK_SET_RATE_PARENT, 0),
 };
 
 static struct samsung_fixed_factor_clock top0_fixed_factor_clks[] __initdata = {
@@ -531,6 +567,7 @@ static void __init exynos7_clk_peric0_init(struct device_node *np)
 /* Register Offset definitions for CMU_PERIC1 (0x14C80000) */
 #define MUX_SEL_PERIC10			0x0200
 #define MUX_SEL_PERIC11			0x0204
+#define MUX_SEL_PERIC12			0x0208
 #define ENABLE_PCLK_PERIC1		0x0900
 #define ENABLE_SCLK_PERIC10		0x0A00
 
@@ -542,10 +579,16 @@ PNAME(mout_aclk_peric1_66_p)	= { "fin_pll", "dout_aclk_peric1_66" };
 PNAME(mout_sclk_uart1_p)	= { "fin_pll", "sclk_uart1" };
 PNAME(mout_sclk_uart2_p)	= { "fin_pll", "sclk_uart2" };
 PNAME(mout_sclk_uart3_p)	= { "fin_pll", "sclk_uart3" };
+PNAME(mout_sclk_spi0_p)		= { "fin_pll", "sclk_spi0" };
+PNAME(mout_sclk_spi1_p)		= { "fin_pll", "sclk_spi1" };
+PNAME(mout_sclk_spi2_p)		= { "fin_pll", "sclk_spi2" };
+PNAME(mout_sclk_spi3_p)		= { "fin_pll", "sclk_spi3" };
+PNAME(mout_sclk_spi4_p)		= { "fin_pll", "sclk_spi4" };
 
 static unsigned long peric1_clk_regs[] __initdata = {
 	MUX_SEL_PERIC10,
 	MUX_SEL_PERIC11,
+	MUX_SEL_PERIC12,
 	ENABLE_PCLK_PERIC1,
 	ENABLE_SCLK_PERIC10,
 };
@@ -554,6 +597,16 @@ static struct samsung_mux_clock peric1_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk_peric1_66_user", mout_aclk_peric1_66_p,
 		MUX_SEL_PERIC10, 0, 1),
 
+	MUX_F(0, "mout_sclk_spi0_user", mout_sclk_spi0_p,
+		MUX_SEL_PERIC11, 0, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(0, "mout_sclk_spi1_user", mout_sclk_spi1_p,
+		MUX_SEL_PERIC11, 4, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(0, "mout_sclk_spi2_user", mout_sclk_spi2_p,
+		MUX_SEL_PERIC11, 8, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(0, "mout_sclk_spi3_user", mout_sclk_spi3_p,
+		MUX_SEL_PERIC11, 12, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(0, "mout_sclk_spi4_user", mout_sclk_spi4_p,
+		MUX_SEL_PERIC11, 16, 1, CLK_SET_RATE_PARENT, 0),
 	MUX(0, "mout_sclk_uart1_user", mout_sclk_uart1_p,
 		MUX_SEL_PERIC11, 20, 1),
 	MUX(0, "mout_sclk_uart2_user", mout_sclk_uart2_p,
@@ -579,6 +632,16 @@ static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
 		ENABLE_PCLK_PERIC1, 10, 0, 0),
 	GATE(PCLK_UART3, "pclk_uart3", "mout_aclk_peric1_66_user",
 		ENABLE_PCLK_PERIC1, 11, 0, 0),
+	GATE(PCLK_SPI0, "pclk_spi0", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 12, 0, 0),
+	GATE(PCLK_SPI1, "pclk_spi1", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 13, 0, 0),
+	GATE(PCLK_SPI2, "pclk_spi2", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 14, 0, 0),
+	GATE(PCLK_SPI3, "pclk_spi3", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 15, 0, 0),
+	GATE(PCLK_SPI4, "pclk_spi4", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 16, 0, 0),
 
 	GATE(SCLK_UART1, "sclk_uart1_user", "mout_sclk_uart1_user",
 		ENABLE_SCLK_PERIC10, 9, 0, 0),
@@ -586,6 +649,16 @@ static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
 		ENABLE_SCLK_PERIC10, 10, 0, 0),
 	GATE(SCLK_UART3, "sclk_uart3_user", "mout_sclk_uart3_user",
 		ENABLE_SCLK_PERIC10, 11, 0, 0),
+	GATE(SCLK_SPI0, "sclk_spi0_user", "mout_sclk_spi0_user",
+		ENABLE_SCLK_PERIC10, 12, CLK_SET_RATE_PARENT, 0),
+	GATE(SCLK_SPI1, "sclk_spi1_user", "mout_sclk_spi1_user",
+		ENABLE_SCLK_PERIC10, 13, CLK_SET_RATE_PARENT, 0),
+	GATE(SCLK_SPI2, "sclk_spi2_user", "mout_sclk_spi2_user",
+		ENABLE_SCLK_PERIC10, 14, CLK_SET_RATE_PARENT, 0),
+	GATE(SCLK_SPI3, "sclk_spi3_user", "mout_sclk_spi3_user",
+		ENABLE_SCLK_PERIC10, 15, CLK_SET_RATE_PARENT, 0),
+	GATE(SCLK_SPI4, "sclk_spi4_user", "mout_sclk_spi4_user",
+		ENABLE_SCLK_PERIC10, 16, CLK_SET_RATE_PARENT, 0),
 };
 
 static struct samsung_cmu_info peric1_cmu_info __initdata = {
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 05e2a47..75c5888 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -28,7 +28,12 @@
 #define CLK_SCLK_UART1			4
 #define CLK_SCLK_UART2			5
 #define CLK_SCLK_UART3			6
-#define TOP0_NR_CLK			7
+#define CLK_SCLK_SPI0			7
+#define CLK_SCLK_SPI1			8
+#define CLK_SCLK_SPI2			9
+#define CLK_SCLK_SPI3			10
+#define CLK_SCLK_SPI4			11
+#define TOP0_NR_CLK			12
 
 /* TOP1 */
 #define DOUT_ACLK_FSYS1_200		1
@@ -72,7 +77,17 @@
 #define PCLK_HSI2C6			9
 #define PCLK_HSI2C7			10
 #define PCLK_HSI2C8			11
-#define PERIC1_NR_CLK			12
+#define PCLK_SPI0			12
+#define PCLK_SPI1			13
+#define PCLK_SPI2			14
+#define PCLK_SPI3			15
+#define PCLK_SPI4			16
+#define SCLK_SPI0			17
+#define SCLK_SPI1			18
+#define SCLK_SPI2			19
+#define SCLK_SPI3			20
+#define SCLK_SPI4			21
+#define PERIC1_NR_CLK			22
 
 /* PERIS */
 #define PCLK_CHIPID			1
-- 
1.7.4.4
