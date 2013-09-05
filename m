From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 05 Sep 2013 14:36:34 +0200
Subject: [PATCH 12/12] clk: exynos5440: replace clock ID private enums with IDs
 from DT header
In-Reply-To: <1378384594-4807-1-git-send-email-a.hajda@samsung.com>
References: <1378384594-4807-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1378384594-4807-17-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch replaces private enum clock IDs in the driver with macros provided
by the DT header.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5440.c | 81 +++++++++++++++---------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index 4ef38e0..7a08b2d 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -9,6 +9,7 @@
  * Common Clock Framework support for Exynos5440 SoC.
 */
 
+#include <dt-bindings/clock/exynos5440.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
@@ -22,79 +23,65 @@
 #define CPU_CLK_STATUS		0xfc
 #define MISC_DOUT1		0x558
 
-/*
- * Let each supported clock get a unique id. This id is used to lookup the clock
- * for device tree based platforms.
- */
-enum exynos5440_clks {
-	none, xtal, arm_clk,
-
-	spi_baud = 16, pb0_250, pr0_250, pr1_250, b_250, b_125, b_200, sata,
-	usb, gmac0, cs250, pb0_250_o, pr0_250_o, pr1_250_o, b_250_o, b_125_o,
-	b_200_o, sata_o, usb_o, gmac0_o, cs250_o,
-
-	nr_clks,
-};
-
 /* parent clock name list */
 PNAME(mout_armclk_p)	= { "cplla", "cpllb" };
 PNAME(mout_spi_p)	= { "div125", "div200" };
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock exynos5440_fixed_rate_ext_clks[] __initdata = {
-	FRATE(none, "xtal", NULL, CLK_IS_ROOT, 0),
+	FRATE(0, "xtal", NULL, CLK_IS_ROOT, 0),
 };
 
 /* fixed rate clocks */
 static struct samsung_fixed_rate_clock exynos5440_fixed_rate_clks[] __initdata = {
-	FRATE(none, "ppll", NULL, CLK_IS_ROOT, 1000000000),
-	FRATE(none, "usb_phy0", NULL, CLK_IS_ROOT, 60000000),
-	FRATE(none, "usb_phy1", NULL, CLK_IS_ROOT, 60000000),
-	FRATE(none, "usb_ohci12", NULL, CLK_IS_ROOT, 12000000),
-	FRATE(none, "usb_ohci48", NULL, CLK_IS_ROOT, 48000000),
+	FRATE(0, "ppll", NULL, CLK_IS_ROOT, 1000000000),
+	FRATE(0, "usb_phy0", NULL, CLK_IS_ROOT, 60000000),
+	FRATE(0, "usb_phy1", NULL, CLK_IS_ROOT, 60000000),
+	FRATE(0, "usb_ohci12", NULL, CLK_IS_ROOT, 12000000),
+	FRATE(0, "usb_ohci48", NULL, CLK_IS_ROOT, 48000000),
 };
 
 /* fixed factor clocks */
 static struct samsung_fixed_factor_clock exynos5440_fixed_factor_clks[] __initdata = {
-	FFACTOR(none, "div250", "ppll", 1, 4, 0),
-	FFACTOR(none, "div200", "ppll", 1, 5, 0),
-	FFACTOR(none, "div125", "div250", 1, 2, 0),
+	FFACTOR(0, "div250", "ppll", 1, 4, 0),
+	FFACTOR(0, "div200", "ppll", 1, 5, 0),
+	FFACTOR(0, "div125", "div250", 1, 2, 0),
 };
 
 /* mux clocks */
 static struct samsung_mux_clock exynos5440_mux_clks[] __initdata = {
-	MUX(none, "mout_spi", mout_spi_p, MISC_DOUT1, 5, 1),
-	MUX_A(arm_clk, "arm_clk", mout_armclk_p,
+	MUX(0, "mout_spi", mout_spi_p, MISC_DOUT1, 5, 1),
+	MUX_A(CLK_ARM_CLK, "arm_clk", mout_armclk_p,
 			CPU_CLK_STATUS, 0, 1, "armclk"),
 };
 
 /* divider clocks */
 static struct samsung_div_clock exynos5440_div_clks[] __initdata = {
-	DIV(spi_baud, "div_spi", "mout_spi", MISC_DOUT1, 3, 2),
+	DIV(CLK_SPI_BAUD, "div_spi", "mout_spi", MISC_DOUT1, 3, 2),
 };
 
 /* gate clocks */
 static struct samsung_gate_clock exynos5440_gate_clks[] __initdata = {
-	GATE(pb0_250, "pb0_250", "div250", CLKEN_OV_VAL, 3, 0, 0),
-	GATE(pr0_250, "pr0_250", "div250", CLKEN_OV_VAL, 4, 0, 0),
-	GATE(pr1_250, "pr1_250", "div250", CLKEN_OV_VAL, 5, 0, 0),
-	GATE(b_250, "b_250", "div250", CLKEN_OV_VAL, 9, 0, 0),
-	GATE(b_125, "b_125", "div125", CLKEN_OV_VAL, 10, 0, 0),
-	GATE(b_200, "b_200", "div200", CLKEN_OV_VAL, 11, 0, 0),
-	GATE(sata, "sata", "div200", CLKEN_OV_VAL, 12, 0, 0),
-	GATE(usb, "usb", "div200", CLKEN_OV_VAL, 13, 0, 0),
-	GATE(gmac0, "gmac0", "div200", CLKEN_OV_VAL, 14, 0, 0),
-	GATE(cs250, "cs250", "div250", CLKEN_OV_VAL, 19, 0, 0),
-	GATE(pb0_250_o, "pb0_250_o", "pb0_250", CLKEN_OV_VAL, 3, 0, 0),
-	GATE(pr0_250_o, "pr0_250_o", "pr0_250", CLKEN_OV_VAL, 4, 0, 0),
-	GATE(pr1_250_o, "pr1_250_o", "pr1_250", CLKEN_OV_VAL, 5, 0, 0),
-	GATE(b_250_o, "b_250_o", "b_250", CLKEN_OV_VAL, 9, 0, 0),
-	GATE(b_125_o, "b_125_o", "b_125", CLKEN_OV_VAL, 10, 0, 0),
-	GATE(b_200_o, "b_200_o", "b_200", CLKEN_OV_VAL, 11, 0, 0),
-	GATE(sata_o, "sata_o", "sata", CLKEN_OV_VAL, 12, 0, 0),
-	GATE(usb_o, "usb_o", "usb", CLKEN_OV_VAL, 13, 0, 0),
-	GATE(gmac0_o, "gmac0_o", "gmac", CLKEN_OV_VAL, 14, 0, 0),
-	GATE(cs250_o, "cs250_o", "cs250", CLKEN_OV_VAL, 19, 0, 0),
+	GATE(CLK_PB0_250, "pb0_250", "div250", CLKEN_OV_VAL, 3, 0, 0),
+	GATE(CLK_PR0_250, "pr0_250", "div250", CLKEN_OV_VAL, 4, 0, 0),
+	GATE(CLK_PR1_250, "pr1_250", "div250", CLKEN_OV_VAL, 5, 0, 0),
+	GATE(CLK_B_250, "b_250", "div250", CLKEN_OV_VAL, 9, 0, 0),
+	GATE(CLK_B_125, "b_125", "div125", CLKEN_OV_VAL, 10, 0, 0),
+	GATE(CLK_B_200, "b_200", "div200", CLKEN_OV_VAL, 11, 0, 0),
+	GATE(CLK_SATA, "sata", "div200", CLKEN_OV_VAL, 12, 0, 0),
+	GATE(CLK_USB, "usb", "div200", CLKEN_OV_VAL, 13, 0, 0),
+	GATE(CLK_GMAC0, "gmac0", "div200", CLKEN_OV_VAL, 14, 0, 0),
+	GATE(CLK_CS250, "cs250", "div250", CLKEN_OV_VAL, 19, 0, 0),
+	GATE(CLK_PB0_250_O, "pb0_250_o", "pb0_250", CLKEN_OV_VAL, 3, 0, 0),
+	GATE(CLK_PR0_250_O, "pr0_250_o", "pr0_250", CLKEN_OV_VAL, 4, 0, 0),
+	GATE(CLK_PR1_250_O, "pr1_250_o", "pr1_250", CLKEN_OV_VAL, 5, 0, 0),
+	GATE(CLK_B_250_O, "b_250_o", "b_250", CLKEN_OV_VAL, 9, 0, 0),
+	GATE(CLK_B_125_O, "b_125_o", "b_125", CLKEN_OV_VAL, 10, 0, 0),
+	GATE(CLK_B_200_O, "b_200_o", "b_200", CLKEN_OV_VAL, 11, 0, 0),
+	GATE(CLK_SATA_O, "sata_o", "sata", CLKEN_OV_VAL, 12, 0, 0),
+	GATE(CLK_USB_O, "usb_o", "usb", CLKEN_OV_VAL, 13, 0, 0),
+	GATE(CLK_GMAC0_O, "gmac0_o", "gmac", CLKEN_OV_VAL, 14, 0, 0),
+	GATE(CLK_CS250_O, "cs250_o", "cs250", CLKEN_OV_VAL, 19, 0, 0),
 };
 
 static struct of_device_id ext_clk_match[] __initdata = {
@@ -114,7 +101,7 @@ static void __init exynos5440_clk_init(struct device_node *np)
 		return;
 	}
 
-	samsung_clk_init(np, reg_base, nr_clks, NULL, 0, NULL, 0);
+	samsung_clk_init(np, reg_base, CLK_NR_CLKS, NULL, 0, NULL, 0);
 	samsung_clk_of_register_fixed_ext(exynos5440_fixed_rate_ext_clks,
 		ARRAY_SIZE(exynos5440_fixed_rate_ext_clks), ext_clk_match);
 
-- 
1.8.1.2
