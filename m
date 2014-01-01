From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 01 Jan 2014 14:44:38 +0100
Subject: [PATCH 2/3] clk: samsung: add clock controller driver for s3c2412
In-Reply-To: <1418190.fUL06mDNi6@phil>
References: <1418190.fUL06mDNi6@phil>
Message-ID: <1576389.iuZAhaSJxQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver can handle the clock controller in the s3c2412 soc.

The clock structure is built according to the manuals of the included
SoCs and might include changes in comparison to the previous clock
structure.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/samsung/Makefile                      |    1 +
 drivers/clk/samsung/clk-s3c2412.c                 |  221 +++++++++++++++++++++
 include/dt-bindings/clock/samsung,s3c2412-clock.h |   73 +++++++
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/clk/samsung/clk-s3c2412.c
 create mode 100644 include/dt-bindings/clock/samsung,s3c2412-clock.h

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 1731900..5248c27 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -11,5 +11,6 @@ obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
 obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-audss.o
 obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
 obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
+obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
 obj-$(CONFIG_S3C2443_COMMON_CLK)+= clk-s3c2443.o
 obj-$(CONFIG_ARCH_S3C64XX)	+= clk-s3c64xx.o
diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
new file mode 100644
index 0000000..84dc0d4
--- /dev/null
+++ b/drivers/clk/samsung/clk-s3c2412.c
@@ -0,0 +1,221 @@
+/*
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Common Clock Framework support for S3C2412 and S3C2413.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <dt-bindings/clock/samsung,s3c2412-clock.h>
+
+#include "clk.h"
+#include "clk-pll.h"
+
+#define LOCKTIME	0x00
+#define MPLLCON		0x04
+#define UPLLCON		0x08
+#define CLKCON		0x0c
+#define CLKDIVN		0x14
+#define CLKSRC		0x1c
+
+/* list of PLLs to be registered */
+enum s3c2412_plls {
+	mpll, upll,
+};
+
+/*
+ * list of controller registers to be saved and restored during a
+ * suspend/resume cycle.
+ */
+static unsigned long s3c2412_clk_regs[] __initdata = {
+	LOCKTIME,
+	MPLLCON,
+	UPLLCON,
+	CLKCON,
+	CLKDIVN,
+	CLKSRC,
+};
+
+static struct clk_div_table divxti_d[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 4 },
+	{ .val = 3, .div = 6 },
+	{ .val = 4, .div = 8 },
+	{ .val = 5, .div = 10 },
+	{ .val = 6, .div = 12 },
+	{ .val = 7, .div = 14 },
+	{ .div = 0 },
+};
+
+struct samsung_div_clock s3c2412_dividers[] __initdata = {
+	DIV_T(0, "div_xti", "xti", CLKSRC, 0, 3, divxti_d),
+	DIV(0, "div_cam", "mux_cam", CLKDIVN, 16, 4),
+	DIV(0, "div_i2s", "mux_i2s", CLKDIVN, 12, 4),
+	DIV(0, "div_uart", "mux_uart", CLKDIVN, 8, 4),
+	DIV(0, "div_usb", "mux_usb", CLKDIVN, 6, 1),
+	DIV(0, "div_hclk_half", "hclk", CLKDIVN, 5, 1),
+	DIV(ARMDIV, "armdiv", "msysclk", CLKDIVN, 3, 1),
+	DIV(PCLK, "pclk", "hclk", CLKDIVN, 2, 1),
+	DIV(HCLK, "hclk", "armdiv", CLKDIVN, 0, 2),
+};
+
+struct samsung_fixed_factor_clock s3c2412_ffactor[] __initdata = {
+	FFACTOR(0, "ff_hclk", "hclk", 2, 1, CLK_SET_RATE_PARENT),
+};
+
+/*
+ * The first two use the OM[4] setting, which is not readable from
+ * software, so assume it is set to xti.
+ */
+PNAME(erefclk_p) = { "xti", "xti", "xti", "ext" };
+PNAME(urefclk_p) = { "xti", "xti", "xti", "ext" };
+
+PNAME(camclk_p) = { "usysclk", "hclk" };
+PNAME(usbclk_p) = { "usysclk", "hclk" };
+PNAME(i2sclk_p) = { "erefclk", "mpll" };
+PNAME(uartclk_p) = { "erefclk", "mpll" };
+PNAME(usysclk_p) = { "urefclk", "upll" };
+PNAME(msysclk_p) = { "mdivclk", "mpll" };
+PNAME(mdivclk_p) = { "xti", "div_xti" };
+PNAME(armclk_p) = { "armdiv", "hclk" };
+
+struct samsung_mux_clock s3c2412_muxes[] __initdata = {
+	MUX(0, "erefclk", erefclk_p, CLKSRC, 14, 2),
+	MUX(0, "urefclk", urefclk_p, CLKSRC, 12, 2),
+	MUX(0, "mux_cam", camclk_p, CLKSRC, 11, 1),
+	MUX(0, "mux_usb", usbclk_p, CLKSRC, 10, 1),
+	MUX(0, "mux_i2s", i2sclk_p, CLKSRC, 9, 1),
+	MUX(0, "mux_uart", uartclk_p, CLKSRC, 8, 1),
+	MUX(USYSCLK, "usysclk", usysclk_p, CLKSRC, 5, 1),
+	MUX(MSYSCLK, "msysclk", msysclk_p, CLKSRC, 4, 1),
+	MUX(MDIVCLK, "mdivclk", mdivclk_p, CLKSRC, 3, 1),
+	MUX(ARMCLK, "armclk", armclk_p, CLKDIVN, 4, 1),
+};
+
+static struct samsung_pll_clock s3c2412_plls[] __initdata = {
+	[mpll] = PLL(pll_s3c2440_mpll, MPLL, "mpll", "xti",
+						LOCKTIME, MPLLCON, NULL),
+	[upll] = PLL(pll_s3c2410_upll, UPLL, "upll", "urefclk",
+						LOCKTIME, UPLLCON, NULL),
+};
+
+struct samsung_gate_clock s3c2412_gates[] __initdata = {
+	GATE(PCLK_WDT, "wdt", "pclk", CLKCON, 28, 0, 0),
+	GATE(PCLK_SPI, "spi", "pclk", CLKCON, 27, 0, 0),
+	GATE(PCLK_I2S, "i2s", "pclk", CLKCON, 26, 0, 0),
+	GATE(PCLK_I2C, "i2c", "pclk", CLKCON, 25, 0, 0),
+	GATE(PCLK_ADC, "adc", "pclk", CLKCON, 24, 0, 0),
+	GATE(PCLK_RTC, "rtc", "pclk", CLKCON, 23, 0, 0),
+	GATE(PCLK_GPIO, "gpio", "pclk", CLKCON, 22, CLK_IGNORE_UNUSED, 0),
+	GATE(PCLK_UART2, "uart2", "pclk", CLKCON, 21, 0, 0),
+	GATE(PCLK_UART1, "uart1", "pclk", CLKCON, 20, 0, 0),
+	GATE(PCLK_UART0, "uart0", "pclk", CLKCON, 19, 0, 0),
+	GATE(PCLK_SDI, "sdi", "pclk", CLKCON, 18, 0, 0),
+	GATE(PCLK_PWM, "pwm", "pclk", CLKCON, 17, 0, 0),
+	GATE(PCLK_USBD, "usb-device", "pclk", CLKCON, 16, 0, 0),
+	GATE(SCLK_CAM, "sclk_cam", "div_cam", CLKCON, 15, 0, 0),
+	GATE(SCLK_UART, "sclk_uart", "div_uart", CLKCON, 14, 0, 0),
+	GATE(SCLK_I2S, "sclk_i2s", "div_i2s", CLKCON, 13, 0, 0),
+	GATE(SCLK_USBH, "sclk_usbh", "div_usb", CLKCON, 12, 0, 0),
+	GATE(SCLK_USBD, "sclk_usbd", "div_usb", CLKCON, 11, 0, 0),
+	GATE(HCLK_HALF, "hclk_half", "div_hclk_half", CLKCON, 10, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_X2, "hclkx2", "ff_hclk", CLKCON, 9, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_SDRAM, "sdram", "hclk", CLKCON, 8, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_USBH, "usb-host", "hclk", CLKCON, 6, 0, 0),
+	GATE(HCLK_LCD, "lcd", "hclk", CLKCON, 5, 0, 0),
+	GATE(HCLK_NAND, "nand", "hclk", CLKCON, 4, 0, 0),
+	GATE(HCLK_DMA3, "dma3", "hclk", CLKCON, 3, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_DMA2, "dma2", "hclk", CLKCON, 2, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_DMA1, "dma1", "hclk", CLKCON, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_DMA0, "dma0", "hclk", CLKCON, 0, CLK_IGNORE_UNUSED, 0),
+};
+
+struct samsung_clock_alias s3c2412_aliases[] __initdata = {
+	ALIAS(PCLK_UART0, "s3c2412-uart.0", "uart"),
+	ALIAS(PCLK_UART1, "s3c2412-uart.1", "uart"),
+	ALIAS(PCLK_UART2, "s3c2412-uart.2", "uart"),
+	ALIAS(PCLK_UART0, "s3c2412-uart.0", "clk_uart_baud2"),
+	ALIAS(PCLK_UART1, "s3c2412-uart.1", "clk_uart_baud2"),
+	ALIAS(PCLK_UART2, "s3c2412-uart.2", "clk_uart_baud2"),
+	ALIAS(SCLK_UART, NULL, "clk_uart_baud3"),
+	ALIAS(PCLK_I2C, "s3c2410-i2c.0", "i2c"),
+	ALIAS(PCLK_ADC, NULL, "adc"),
+	ALIAS(PCLK_RTC, NULL, "rtc"),
+	ALIAS(PCLK_PWM, NULL, "timers"),
+	ALIAS(HCLK_LCD, NULL, "lcd"),
+	ALIAS(PCLK_USBD, NULL, "usb-device"),
+	ALIAS(SCLK_USBD, NULL, "usb-bus-gadget"),
+	ALIAS(HCLK_USBH, NULL, "usb-host"),
+	ALIAS(SCLK_USBH, NULL, "usb-bus-host"),
+	ALIAS(ARMCLK, NULL, "armclk"),
+	ALIAS(HCLK, NULL, "hclk"),
+	ALIAS(MPLL, NULL, "mpll"),
+	ALIAS(MSYSCLK, NULL, "fclk"),
+};
+
+/*
+ * fixed rate clocks generated outside the soc
+ * Only necessary until the devicetree-move is complete
+ */
+struct samsung_fixed_rate_clock s3c2412_common_frate_clks[] __initdata = {
+	FRATE(XTI, "xti", NULL, CLK_IS_ROOT, 0),
+	FRATE(0, "ext", NULL, CLK_IS_ROOT, 0),
+};
+
+static void __init s3c2412_common_clk_register_fixed_ext(unsigned long xti_f,
+							 unsigned long ext_f)
+{
+	struct samsung_clock_alias xti_alias = ALIAS(XTI, NULL, "xtal");
+
+	s3c2412_common_frate_clks[0].fixed_rate = xti_f;
+	s3c2412_common_frate_clks[1].fixed_rate = ext_f;
+	samsung_clk_register_fixed_rate(s3c2412_common_frate_clks,
+				ARRAY_SIZE(s3c2412_common_frate_clks));
+
+	samsung_clk_register_alias(&xti_alias, 1);
+}
+
+void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
+				    unsigned long ext_f, void __iomem *reg_base)
+{
+	if (np) {
+		reg_base = of_iomap(np, 0);
+		if (!reg_base)
+			panic("%s: failed to map registers\n", __func__);
+	}
+
+	samsung_clk_init(np, reg_base, NR_CLKS, s3c2412_clk_regs,
+			 ARRAY_SIZE(s3c2412_clk_regs), NULL, 0);
+
+	/* Register external clocks only in non-dt cases */
+	if (!np)
+		s3c2412_common_clk_register_fixed_ext(xti_f, ext_f);
+
+	/* Register PLLs. */
+	samsung_clk_register_pll(s3c2412_plls, ARRAY_SIZE(s3c2412_plls),
+				 reg_base);
+
+	/* Register common internal clocks. */
+	samsung_clk_register_mux(s3c2412_muxes, ARRAY_SIZE(s3c2412_muxes));
+	samsung_clk_register_div(s3c2412_dividers, ARRAY_SIZE(s3c2412_dividers));
+	samsung_clk_register_gate(s3c2412_gates, ARRAY_SIZE(s3c2412_gates));
+	samsung_clk_register_fixed_factor(s3c2412_ffactor,
+					  ARRAY_SIZE(s3c2412_ffactor));
+	samsung_clk_register_alias(s3c2412_aliases,
+				   ARRAY_SIZE(s3c2412_aliases));
+}
+
+static void __init s3c2412_clk_init(struct device_node *np)
+{
+	s3c2412_common_clk_init(np, 0, 0, 0);
+}
+CLK_OF_DECLARE(s3c2412_clk, "samsung,s3c2412-clock", s3c2412_clk_init);
diff --git a/include/dt-bindings/clock/samsung,s3c2412-clock.h b/include/dt-bindings/clock/samsung,s3c2412-clock.h
new file mode 100644
index 0000000..7c2c64e
--- /dev/null
+++ b/include/dt-bindings/clock/samsung,s3c2412-clock.h
@@ -0,0 +1,73 @@
+/*
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Device Tree binding constants clock controllers of Samsung S3C2412.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_SAMSUNG_S3C2412_CLOCK_H
+#define _DT_BINDINGS_CLOCK_SAMSUNG_S3C2412_CLOCK_H
+
+/*
+ * Let each exported clock get a unique index, which is used on DT-enabled
+ * platforms to lookup the clock from a clock specifier. These indices are
+ * therefore considered an ABI and so must not be changed. This implies
+ * that new clocks should be added either in free spaces between clock groups
+ * or at the end.
+ */
+
+/* Core clocks. */
+
+#define XTI			1
+#define MPLL			2
+#define UPLL			3
+#define MDIVCLK			4
+#define MSYSCLK			5
+#define USYSCLK			6
+#define HCLK			7
+#define PCLK			8
+#define ARMDIV			9
+#define ARMCLK			10
+
+
+/* Special clocks */
+#define SCLK_CAM		16
+#define SCLK_UART		17
+#define SCLK_I2S		18
+#define SCLK_USBD		19
+#define SCLK_USBH		20
+
+/* pclk-gates */
+#define PCLK_WDT		32
+#define PCLK_SPI		33
+#define PCLK_I2S		34
+#define PCLK_I2C		35
+#define PCLK_ADC		36
+#define PCLK_RTC		37
+#define PCLK_GPIO		38
+#define PCLK_UART2		39
+#define PCLK_UART1		40
+#define PCLK_UART0		41
+#define PCLK_SDI		42
+#define PCLK_PWM		43
+#define PCLK_USBD		44
+
+/* hclk-gates */
+#define HCLK_HALF		48
+#define HCLK_X2			49
+#define HCLK_SDRAM		50
+#define HCLK_USBH		51
+#define HCLK_LCD		52
+#define HCLK_NAND		53
+#define HCLK_DMA3		54
+#define HCLK_DMA2		55
+#define HCLK_DMA1		56
+#define HCLK_DMA0		57
+
+/* Total number of clocks. */
+#define NR_CLKS			(HCLK_DMA0 + 1)
+
+#endif /* _DT_BINDINGS_CLOCK_SAMSUNG_S3C2412_CLOCK_H */
-- 
1.7.10.4
