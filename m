From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:05:53 +0200
Subject: [PATCH v2 08/22] clk: samsung: exynos5410: Add serial3,
 USB and PWM clocks
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <1462734367-5619-9-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like other Exynos5 family SoCs, this one has four UARTs. Add
missing UART3 clocks to the Exynso5410 clock driver.

Add clocks for USB and PWM.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5410.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index a7d714435307..40775f678f02 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -33,9 +33,11 @@
 #define SRC_CPERI1		0x4204
 #define DIV_TOP0		0x10510
 #define DIV_TOP1		0x10514
+#define DIV_FSYS0		0x10548
 #define DIV_FSYS1		0x1054c
 #define DIV_FSYS2		0x10550
 #define DIV_PERIC0		0x10558
+#define DIV_PERIC3		0x10564
 #define SRC_TOP0		0x10210
 #define SRC_TOP1		0x10214
 #define SRC_TOP2		0x10218
@@ -44,6 +46,8 @@
 #define SRC_MASK_FSYS		0x10340
 #define SRC_MASK_PERIC0		0x10350
 #define GATE_BUS_FSYS0		0x10740
+#define GATE_TOP_SCLK_FSYS	0x10840
+#define GATE_TOP_SCLK_PERIC	0x10850
 #define GATE_IP_FSYS		0x10944
 #define GATE_IP_PERIC		0x10950
 #define GATE_IP_PERIS		0x10960
@@ -71,6 +75,7 @@ PNAME(mout_kfc_p)	= { "mout_kpll", "sclk_mpll", };
 PNAME(mpll_user_p)	= { "fin_pll", "sclk_mpll", };
 PNAME(bpll_user_p)	= { "fin_pll", "sclk_bpll", };
 PNAME(mpll_bpll_p)	= { "sclk_mpll_muxed", "sclk_bpll_muxed", };
+PNAME(sclk_mpll_bpll_p)	= { "sclk_mpll_bpll", "fin_pll", };
 
 PNAME(group2_p)		= { "fin_pll", "fin_pll", "none", "none",
 			"none", "none", "sclk_mpll_bpll",
@@ -102,10 +107,14 @@ static struct samsung_mux_clock exynos5410_mux_clks[] __initdata = {
 	MUX(0, "mout_mmc0", group2_p, SRC_FSYS, 0, 4),
 	MUX(0, "mout_mmc1", group2_p, SRC_FSYS, 4, 4),
 	MUX(0, "mout_mmc2", group2_p, SRC_FSYS, 8, 4),
+	MUX(0, "mout_usbd300", sclk_mpll_bpll_p, SRC_FSYS, 28, 1),
+	MUX(0, "mout_usbd301", sclk_mpll_bpll_p, SRC_FSYS, 29, 1),
 
 	MUX(0, "mout_uart0", group2_p, SRC_PERIC0, 0, 4),
 	MUX(0, "mout_uart1", group2_p, SRC_PERIC0, 4, 4),
 	MUX(0, "mout_uart2", group2_p, SRC_PERIC0, 8, 4),
+	MUX(0, "mout_uart3", group2_p, SRC_PERIC0, 12, 4),
+	MUX(0, "mout_pwm", group2_p, SRC_PERIC0, 24, 4),
 
 	MUX(0, "mout_aclk200", mpll_bpll_p, SRC_TOP0, 12, 1),
 	MUX(0, "mout_aclk400", mpll_bpll_p, SRC_TOP0, 20, 1),
@@ -127,6 +136,11 @@ static struct samsung_div_clock exynos5410_div_clks[] __initdata = {
 	DIV(0, "aclk66_pre", "sclk_mpll_muxed", DIV_TOP1, 24, 3),
 	DIV(0, "aclk66", "aclk66_pre", DIV_TOP0, 0, 3),
 
+	DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
+	DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 20, 4),
+	DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
+	DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 28, 4),
+
 	DIV(0, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
 	DIV(0, "div_mmc1", "mout_mmc1", DIV_FSYS1, 16, 4),
 	DIV(0, "div_mmc2", "mout_mmc2", DIV_FSYS2, 0, 4),
@@ -143,6 +157,8 @@ static struct samsung_div_clock exynos5410_div_clks[] __initdata = {
 	DIV(0, "div_uart2", "mout_uart2", DIV_PERIC0, 8, 4),
 	DIV(0, "div_uart3", "mout_uart3", DIV_PERIC0, 12, 4),
 
+	DIV(0, "dout_pwm", "mout_pwm", DIV_PERIC3, 0, 4),
+
 	DIV(0, "aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
 	DIV(0, "aclk400", "mout_aclk400", DIV_TOP0, 24, 3),
 };
@@ -161,9 +177,23 @@ static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
 	GATE(CLK_MMC1, "sdmmc1", "aclk200", GATE_BUS_FSYS0, 13, 0, 0),
 	GATE(CLK_MMC2, "sdmmc2", "aclk200", GATE_BUS_FSYS0, 14, 0, 0),
 
+	GATE(CLK_SCLK_USBPHY301, "sclk_usbphy301", "dout_usbphy301",
+	     GATE_TOP_SCLK_FSYS, 7, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_USBPHY300, "sclk_usbphy300", "dout_usbphy300",
+	     GATE_TOP_SCLK_FSYS, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_USBD300, "sclk_usbd300", "dout_usbd300",
+	     GATE_TOP_SCLK_FSYS, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_USBD301, "sclk_usbd301", "dout_usbd301",
+	     GATE_TOP_SCLK_FSYS, 10, CLK_SET_RATE_PARENT, 0),
+
+	GATE(CLK_SCLK_PWM, "sclk_pwm", "dout_pwm",
+	     GATE_TOP_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
+
 	GATE(CLK_UART0, "uart0", "aclk66", GATE_IP_PERIC, 0, 0, 0),
 	GATE(CLK_UART1, "uart1", "aclk66", GATE_IP_PERIC, 1, 0, 0),
 	GATE(CLK_UART2, "uart2", "aclk66", GATE_IP_PERIC, 2, 0, 0),
+	GATE(CLK_UART3, "uart3", "aclk66", GATE_IP_PERIC, 3, 0, 0),
+	GATE(CLK_PWM, "pwm", "aclk66", GATE_IP_PERIC, 24, 0, 0),
 
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "div_uart0",
 			SRC_MASK_PERIC0, 0, CLK_SET_RATE_PARENT, 0),
@@ -171,6 +201,12 @@ static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
 			SRC_MASK_PERIC0, 4, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UART2, "sclk_uart2", "div_uart2",
 			SRC_MASK_PERIC0, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_UART3, "sclk_uart3", "div_uart3",
+			SRC_MASK_PERIC0, 12, CLK_SET_RATE_PARENT, 0),
+
+	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
+	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
+	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
 };
 
 static struct samsung_pll_clock exynos5410_plls[nr_plls] __initdata = {
-- 
2.5.0
