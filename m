From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 01:43:58 +0100
Subject: [PATCH 4/7] clk: samsung: add clock-driver for s3c2416,
 s3c2443 and s3c2450
In-Reply-To: <201303120141.31262.heiko@sntech.de>
References: <201303120141.31262.heiko@sntech.de>
Message-ID: <201303120143.58563.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The three SoCs share a common clock tree which only differs in the
existence of some special clocks. The s3c2450 specific clocks will
only be reachable via DT in the near future, as there is no generic
way to distinguish between the similar s3c2416 and s3c2450 SoCs.

As with all parts common to these three SoCs the driver is named
after the s3c2443, as it was the first SoC introducing this structure
and there exists no other label to describe this s3c24xx epoch.

The clock structure is built according to the manuals of the included
SoCs and might include changes in comparison to the previous clock
structure. As an example the sclk_uart was never handled previously and
the div_uart was made the clock used by the serial driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/samsung/Makefile      |    1 +
 drivers/clk/samsung/clk-s3c2443.c |  463 +++++++++++++++++++++++++++++++++++++
 2 files changed, 464 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-s3c2443.c

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index b7c232e..7462ec5 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o
 obj-$(CONFIG_ARCH_EXYNOS4)	+= clk-exynos4.o
 obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
 obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
+obj-$(CONFIG_S3C2443_COMMON)	+= clk-s3c2443.o
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
new file mode 100644
index 0000000..45681f1
--- /dev/null
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -0,0 +1,463 @@
+/*
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Common Clock Framework support for S3C2416 SoCs.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <plat/cpu.h>
+#include "clk.h"
+#include "clk-pll.h"
+
+/* S3C2416 clock controller register offsets */
+#define MPLLCON		0x10
+#define EPLLCON		0x18
+#define EPLLCON_K	0x1C
+#define CLKSRC		0x20
+#define CLKDIV0		0x24
+#define CLKDIV1		0x28
+#define CLKDIV2		0x2C
+#define HCLKCON		0x30
+#define PCLKCON		0x34
+#define SCLKCON		0x38
+
+/* the soc types */
+enum supported_socs {
+	S3C2416,
+	S3C2443,
+	S3C2450,
+};
+
+/*
+ * Let each supported clock get a unique id. This id is used to lookup the clock
+ * for device tree based platforms. The clocks are categorized into four
+ * sections: core, sclk gate, bus interface gate and mux clocks.
+ *
+ * When adding a new clock to this list, it is advised to choose a clock
+ * category and add it to the end of that category. That is because the the
+ * device tree source file is referring to these ids and any change in the
+ * sequence number of existing clocks will require corresponding change in the
+ * device tree files. This limitation would go away when pre-processor support
+ * for dtc would be available.
+ */
+enum s3c2443_clks {
+	none,
+
+	/* core clocks */
+	xti, ext, ext_i2s, ext_uart, msysclk, esysclk, armdiv, armclk, hclk,
+
+	/* gate for special clocks (sclk) */
+	sclk_hsspi0 = 128, sclk_fimd, sclk_i2s0, sclk_i2s1, sclk_hsmmc1,
+	sclk_hsmmcext, sclk_cam, sclk_uart, sclk_usbh,
+
+	/* gate clocks */
+	hsmmc0 = 256, hsmmc1, nand, ssmc, usbh, usbd, lcd, dma0, dma1, dma2,
+	dma3, dma4, dma5, dma6, dma7, gpio, rtc, wdt, pwm, i2s0, i2s1, ac97,
+	pcm, adc, spi0, spi1, i2c0, i2c1, uart0, uart1, uart2, uart3, cfc,
+	sdi, cam, chipid,
+
+	/* mux clocks */
+	mux_hsspi0 = 384, mux_hsspi1, mux_hsmmc0, mux_hsmmc1,
+
+	nr_clks,
+};
+/*
+ * list of controller registers to be saved and restored during a
+ * suspend/resume cycle.
+ */
+static __initdata unsigned long s3c2443_clk_regs[] = {
+	MPLLCON,
+	EPLLCON,
+	EPLLCON_K,
+	CLKSRC,
+	CLKDIV0,
+	CLKDIV1,
+	CLKDIV2,
+	PCLKCON,
+	HCLKCON,
+	SCLKCON,
+};
+
+PNAME(epllref_p) = { "mpllref", "mpllref", "xti", "ext" };
+PNAME(esysclk_p) = { "epllref", "epll" };
+PNAME(msysclk_p) = { "mpllref, mdivclk", "mpll", "mpll" };
+PNAME(armclk_p) = { "armdiv" , "hclk" };
+PNAME(i2s0_p) = { "div_i2s0", "ext_i2s", "epllref", "epllref" };
+
+/* fixed rate clocks generated outside the soc */
+struct samsung_fixed_rate_clock s3c2443_common_frate_clks[] __initdata = {
+	FRATE(xti, "xti", NULL, CLK_IS_ROOT, 0),
+	FRATE(ext, "ext", NULL, CLK_IS_ROOT, 0),
+	FRATE(ext_i2s, "ext_i2s", NULL, CLK_IS_ROOT, 0),
+	FRATE(ext_uart, "ext_uart", NULL, CLK_IS_ROOT, 0),
+};
+
+/* mpllref is a direct descendant of clk_xtal by default, but it is not
+ * elided as the EPLL can be either sourced by the XTAL or EXTCLK and as
+ * such directly equating the two source clocks is impossible.
+ */
+struct samsung_fixed_factor_clock s3c2443_common_ffactor[] __initdata = {
+	FFACTOR(none, "mpllref", "xti", 1, 1, 0),
+};
+
+struct samsung_mux_clock s3c2443_common_muxes[] __initdata = {
+	MUX(none, "epllref", epllref_p, CLKSRC, 7, 2),
+	MUX(esysclk, "esysclk", esysclk_p, CLKSRC, 6, 1),
+	MUX_A(msysclk, "msysclk", msysclk_p, CLKSRC, 3, 2, "msysclk"),
+	MUX_A(armclk, "armclk", armclk_p, CLKDIV0, 13, 1, "armclk"),
+	MUX(none, "mux_i2s0", i2s0_p, CLKSRC, 14, 2),
+};
+
+static struct clk_div_table hclk_d[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 3, .div = 4 },
+	{ .div = 0 },
+};
+
+static struct clk_div_table mdivclk_d[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 3 },
+	{ .val = 2, .div = 5 },
+	{ .val = 3, .div = 7 },
+	{ .val = 4, .div = 9 },
+	{ .val = 5, .div = 11 },
+	{ .val = 6, .div = 13 },
+	{ .val = 7, .div = 15 },
+	{ .div = 0 },
+};
+
+struct samsung_div_clock s3c2443_common_dividers[] __initdata = {
+	DIV_T(none, "mdivclk", "mpllref", CLKDIV0, 6, 3, mdivclk_d),
+	DIV(none, "prediv", "msysclk", CLKDIV0, 4, 2),
+	DIV_T(hclk, "hclk", "prediv", CLKDIV0, 0, 2, hclk_d),
+	DIV(none, "pclk", "hclk", CLKDIV0, 2, 1),
+	DIV(none, "div_hsspi0_epll", "esysclk", CLKDIV1, 24, 2),
+	DIV(none, "div_fimd", "esysclk", CLKDIV1, 16, 8),
+	DIV(none, "div_i2s0", "esysclk", CLKDIV1, 12, 4),
+	DIV(none, "div_uart", "esysclk", CLKDIV1, 8, 4),
+	DIV(none, "div_hsmmc1", "esysclk", CLKDIV1, 6, 2),
+	DIV(none, "div_usbhost", "esysclk", CLKDIV1, 4, 2),
+};
+
+struct samsung_gate_clock s3c2443_common_gates[] __initdata = {
+	GATE(sclk_hsmmcext, "sclk_hsmmcext", "ext", SCLKCON, 13, 0, 0),
+	GATE(sclk_hsmmc1, "sclk_hsmmc1", "div_hsmmc1", SCLKCON, 12, 0, 0),
+	GATE(sclk_fimd, "sclk_fimd", "div_fimd", SCLKCON, 10, 0, 0),
+	GATE(sclk_i2s0, "sclk_i2s0", "mux_i2s0", SCLKCON, 9, 0, 0),
+	GATE(sclk_uart, "sclk_uart", "div_uart", SCLKCON, 8, 0, 0),
+	GATE(sclk_usbh, "sclk_usbhost", "div_usbhost", SCLKCON, 1, 0, 0),
+	GATE(ssmc, "ssmc", "hclk", HCLKCON, 18, CLK_IGNORE_UNUSED, 0),
+	GATE(hsmmc1, "hsmmc1", "hclk", HCLKCON, 16, 0, 0),
+	GATE(usbd, "usb-device", "hclk", HCLKCON, 12, 0, 0),
+	GATE(usbh, "usb-host", "hclk", HCLKCON, 11, 0, 0),
+	GATE(lcd, "lcd", "hclk", HCLKCON, 9, 0, 0),
+	GATE(dma5, "dma5", "hclk", HCLKCON, 5, CLK_IGNORE_UNUSED, 0),
+	GATE(dma4, "dma4", "hclk", HCLKCON, 4, CLK_IGNORE_UNUSED, 0),
+	GATE(dma3, "dma3", "hclk", HCLKCON, 3, CLK_IGNORE_UNUSED, 0),
+	GATE(dma2, "dma2", "hclk", HCLKCON, 2, CLK_IGNORE_UNUSED, 0),
+	GATE(dma1, "dma1", "hclk", HCLKCON, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(dma0, "dma0", "hclk", HCLKCON, 0, CLK_IGNORE_UNUSED, 0),
+	GATE(gpio, "gpio", "pclk", PCLKCON, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(rtc, "rtc", "pclk", PCLKCON, 12, 0, 0),
+	GATE(wdt, "wdt", "pclk", PCLKCON, 11, 0, 0),
+	GATE(pwm, "pwm", "pclk", PCLKCON, 10, 0, 0),
+	GATE(i2s0, "i2s0", "pclk", PCLKCON, 9, 0, 0),
+	GATE(ac97, "ac97", "pclk", PCLKCON, 8, 0, 0),
+	GATE(adc, "adc", "pclk", PCLKCON, 7, 0, 0),
+	GATE(spi0, "spi0", "pclk", PCLKCON, 6, 0, 0),
+	GATE(i2c0, "i2c0", "pclk", PCLKCON, 4, 0, 0),
+	GATE(uart3, "uart3", "pclk", PCLKCON, 3, 0, 0),
+	GATE(uart2, "uart2", "pclk", PCLKCON, 2, 0, 0),
+	GATE(uart1, "uart1", "pclk", PCLKCON, 1, 0, 0),
+	GATE(uart0, "uart0", "pclk", PCLKCON, 0, 0, 0),
+};
+
+struct samsung_clock_alias s3c2443_common_aliases[] __initdata = {
+	ALIAS(hclk, NULL, "hclk"),
+	/* the nand is supplied by the hclk without gating possibility */
+	ALIAS(hclk, NULL, "nand"),
+	ALIAS(uart0, "s3c2440-uart.0", "uart"),
+	ALIAS(uart1, "s3c2440-uart.1", "uart"),
+	ALIAS(uart2, "s3c2440-uart.2", "uart"),
+	ALIAS(uart3, "s3c2440-uart.3", "uart"),
+	ALIAS(ext_uart, NULL, "clk_uart_baud1"),
+	ALIAS(uart0, "s3c2440-uart.0", "clk_uart_baud2"),
+	ALIAS(uart1, "s3c2440-uart.1", "clk_uart_baud2"),
+	ALIAS(uart2, "s3c2440-uart.2", "clk_uart_baud2"),
+	ALIAS(uart3, "s3c2440-uart.3", "clk_uart_baud2"),
+	ALIAS(sclk_uart, NULL, "clk_uart_baud3"),
+	ALIAS(pwm, NULL, "timers"),
+	ALIAS(rtc, NULL, "rtc"),
+	ALIAS(wdt, NULL, "watchdog"),
+	ALIAS(adc, NULL, "adc"),
+	ALIAS(i2c0, "s3c2410-i2c.0", "i2c"),
+	ALIAS(usbd, NULL, "usb-device"),
+	ALIAS(usbh, NULL, "usb-host"),
+	ALIAS(sclk_usbh, NULL, "usb-bus-host"),
+	ALIAS(spi0, "s3c2443-spi.0", "spi"),
+	ALIAS(spi0, "s3c2443-spi.0", "spi_busclk0"),
+	ALIAS(hsmmc1, "s3c-sdhci.1", "hsmmc"),
+	ALIAS(hsmmc1, "s3c-sdhci.1", "mmc_busclk.0"),
+	ALIAS(i2s0, "samsung-i2s.0", "iis"),
+	ALIAS(sclk_i2s0, NULL, "i2s-if"),
+	ALIAS(lcd, NULL, "lcd"),
+	ALIAS(sclk_fimd, NULL, "sclk_fimd"),
+};
+
+/* S3C2416 specific clocks */
+
+PNAME(s3c2416_hsmmc0_p) = { "sclk_hsmmc0", "sclk_hsmmcext" };
+PNAME(s3c2416_hsmmc1_p) = { "sclk_hsmmc1", "sclk_hsmmcext" };
+PNAME(s3c2416_hsspi0_p) = { "hsspi0_epll", "hsspi0_mpll" };
+
+static struct clk_div_table armdiv_s3c2416_d[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 3 },
+	{ .val = 3, .div = 4 },
+	{ .val = 5, .div = 6 },
+	{ .val = 7, .div = 8 },
+	{ .div = 0 },
+};
+
+struct samsung_div_clock s3c2416_dividers[] __initdata = {
+	DIV_T(armdiv, "armdiv", "msysclk", CLKDIV0, 9, 3, armdiv_s3c2416_d),
+	DIV(none, "div_hsspi0_mpll", "msysclk", CLKDIV2, 0, 4),
+	DIV(none, "div_hsmmc0", "esysclk", CLKDIV2, 6, 2),
+};
+
+struct samsung_mux_clock s3c2416_muxes[] __initdata = {
+	MUX(mux_hsmmc0, "mux_hsmmc0", s3c2416_hsmmc0_p, CLKSRC, 16, 1),
+	MUX(mux_hsmmc1, "mux_hsmmc1", s3c2416_hsmmc1_p, CLKSRC, 17, 1),
+	MUX(mux_hsspi0, "mux_hsspi0", s3c2416_hsspi0_p, CLKSRC, 18, 1),
+};
+
+struct samsung_gate_clock s3c2416_gates[] __initdata = {
+	GATE(none, "hsspi0_mpll", "div_hsspi0_mpll", SCLKCON, 19, 0, 0),
+	GATE(none, "hsspi0_epll", "div_hsspi0_epll", SCLKCON, 14, 0, 0),
+	GATE(none, "sclk_hsmmc0", "div_hsmmc0", SCLKCON, 6, 0, 0),
+	GATE(hsmmc0, "hsmmc0", "hclk", HCLKCON, 15, 0, 0),
+	GATE(pcm, "pcm", "pclk", PCLKCON, 19, 0, 0),
+};
+
+struct samsung_clock_alias s3c2416_aliases[] __initdata = {
+	ALIAS(hsmmc0, "s3c-sdhci.0", "hsmmc"),
+	ALIAS(hsmmc0, "s3c-sdhci.0", "mmc_busclk.0"),
+	ALIAS(mux_hsmmc0, "s3c-sdhci.0", "mmc_busclk.2"),
+	ALIAS(mux_hsmmc1, "s3c-sdhci.1", "mmc_busclk.2"),
+	ALIAS(mux_hsspi0, "s3c2443-spi.0", "spi_busclk2"),
+	ALIAS(armdiv, NULL, "armdiv"),
+};
+
+/* S3C2443 specific clocks */
+
+static struct clk_div_table armdiv_s3c2443_d[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 8, .div = 2 },
+	{ .val = 2, .div = 3 },
+	{ .val = 9, .div = 4 },
+	{ .val = 10, .div = 6 },
+	{ .val = 11, .div = 8 },
+	{ .val = 13, .div = 12 },
+	{ .val = 15, .div = 16 },
+	{ .div = 0 },
+};
+
+struct samsung_div_clock s3c2443_dividers[] __initdata = {
+	DIV_T(armdiv, "armdiv", "msysclk", CLKDIV0, 9, 4, armdiv_s3c2443_d),
+	DIV(none, "div_cam", "esysclk", CLKDIV1, 26, 4),
+};
+
+struct samsung_gate_clock s3c2443_gates[] __initdata = {
+	GATE(sclk_hsspi0, "sclk_hsspi0", "div_hsspi0_epll", SCLKCON, 14, 0, 0),
+	GATE(sclk_cam, "sclk_cam", "div_cam", SCLKCON, 11, 0, 0),
+	GATE(cfc, "cfc", "hclk", HCLKCON, 17, CLK_IGNORE_UNUSED, 0),
+	GATE(cam, "cam", "hclk", HCLKCON, 8, 0, 0),
+	GATE(spi1, "spi1", "pclk", PCLKCON, 15, 0, 0),
+	GATE(sdi, "sdi", "pclk", PCLKCON, 5, 0, 0),
+};
+
+struct samsung_clock_alias s3c2443_aliases[] __initdata = {
+	ALIAS(spi1, "s3c2410-spi.0", "spi"),
+	ALIAS(sclk_hsspi0, "s3c2443-spi.0", "spi_busclk2"),
+	ALIAS(sclk_hsmmc1, "s3c-sdhci.1", "mmc_busclk.2"),
+	ALIAS(sclk_cam, NULL, "camif-upll"),
+	ALIAS(sdi, NULL, "sdi"),
+	ALIAS(cfc, NULL, "cfc"),
+	ALIAS(armdiv, NULL, "armdiv"),
+};
+
+/* S3C2450 specific clocks */
+
+PNAME(s3c2450_cam_p) = { "div_cam", "hclk" };
+PNAME(s3c2450_hsspi1_p) = { "hsspi1_epll", "hsspi1_mpll" };
+PNAME(i2s1_p) = { "div_i2s1", "ext_i2s", "epllref", "epllref" };
+
+struct samsung_div_clock s3c2450_dividers[] __initdata = {
+	DIV(none, "div_cam", "esysclk", CLKDIV1, 26, 4),
+	DIV(none, "div_hsspi1_epll", "esysclk", CLKDIV2, 24, 2),
+	DIV(none, "div_hsspi1_mpll", "msysclk", CLKDIV2, 16, 4),
+	DIV(none, "div_i2s1", "esysclk", CLKDIV2, 12, 4),
+};
+
+struct samsung_mux_clock s3c2450_muxes[] __initdata = {
+	MUX(none, "mux_cam", s3c2450_cam_p, CLKSRC, 20, 1),
+	MUX(mux_hsspi1, "mux_hsspi1", s3c2450_hsspi1_p, CLKSRC, 19, 1),
+	MUX(none, "mux_i2s1", i2s1_p, CLKSRC, 12, 2),
+};
+
+struct samsung_gate_clock s3c2450_gates[] __initdata = {
+	GATE(sclk_i2s1, "sclk_i2s1", "div_i2s1", SCLKCON, 5, 0, 0),
+	GATE(cfc, "cfc", "hclk", HCLKCON, 17, 0, 0),
+	GATE(cam, "cam", "hclk", HCLKCON, 8, 0, 0),
+	GATE(dma7, "dma7", "hclk", HCLKCON, 7, CLK_IGNORE_UNUSED, 0),
+	GATE(dma6, "dma6", "hclk", HCLKCON, 6, CLK_IGNORE_UNUSED, 0),
+	GATE(i2s1, "i2s1", "pclk", PCLKCON, 17, 0, 0),
+	GATE(i2c1, "i2c1", "pclk", PCLKCON, 16, 0, 0),
+	GATE(spi1, "spi1", "pclk", PCLKCON, 14, 0, 0),
+};
+
+struct samsung_clock_alias s3c2450_aliases[] __initdata = {
+	ALIAS(spi1, "s3c2443-spi.1", "spi"),
+	ALIAS(spi1, "s3c2443-spi.1", "spi_busclk0"),
+	ALIAS(mux_hsspi1, "s3c2443-spi.1", "spi_busclk2"),
+	ALIAS(i2c1, "s3c2410-i2c.1", "i2c"),
+};
+
+/*
+ * This function allows non-dt platforms to specify the clock speed of the
+ * xti and ext clocks.
+ */
+void __init s3c2443_clk_register_fixed_ext(unsigned long xti_f,
+				unsigned long ext_f, unsigned long i2s_f,
+				unsigned long uart_f)
+{
+	s3c2443_common_frate_clks[0].fixed_rate = xti_f;
+	s3c2443_common_frate_clks[1].fixed_rate = ext_f;
+	s3c2443_common_frate_clks[2].fixed_rate = i2s_f;
+	s3c2443_common_frate_clks[3].fixed_rate = uart_f;
+
+	samsung_clk_register_fixed_rate(s3c2443_common_frate_clks,
+			ARRAY_SIZE(s3c2443_common_frate_clks));
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id s3c2443_clk_ids[] __initdata = {
+	{ .compatible = "samsung,s3c2416-clock",
+			.data = (void *)S3C2416, },
+	{ .compatible = "samsung,s3c2443-clock",
+			.data = (void *)S3C2443, },
+	{ .compatible = "samsung,s3c2450-clock",
+			.data = (void *)S3C2450, },
+	{ },
+};
+
+static __initdata struct of_device_id ext_clk_match[] = {
+	{ .compatible = "samsung,clock-xti", .data = (void *)0, },
+	{ .compatible = "samsung,clock-ext", .data = (void *)1, },
+	{ .compatible = "samsung,clock-ext-i2s", .data = (void *)2, },
+	{ .compatible = "samsung,clock-ext-uart", .data = (void *)3, },
+	{},
+};
+#endif
+
+void __init s3c2443_clk_init(struct device_node *np)
+{
+	void __iomem *reg_base;
+	struct clk *mpll, *epll;
+	u32 current_soc;
+
+	if (np) {
+		const struct of_device_id *match;
+		match = of_match_node(s3c2443_clk_ids, np);
+		current_soc = (u32)match->data;
+
+		reg_base = of_iomap(np, 0);
+		if (!reg_base)
+			panic("%s: failed to map registers\n", __func__);
+	} else {
+		reg_base = S3C24XX_VA_CLKPWR;
+
+		/* It's not possible to distinguish a s3c2450 from a s3c2416
+		 * programatically.
+		 */
+		if (soc_is_s3c2416())
+			current_soc = S3C2416;
+		else if (soc_is_s3c2443())
+			current_soc = S3C2443;
+		else
+			panic("%s: unable to determine soc\n", __func__);
+	}
+
+	samsung_clk_init(np, reg_base, nr_clks,
+		s3c2443_clk_regs, ARRAY_SIZE(s3c2443_clk_regs));
+
+	if (np)
+		samsung_clk_of_register_fixed_ext(s3c2443_common_frate_clks,
+			ARRAY_SIZE(s3c2443_common_frate_clks),
+			ext_clk_match);
+
+	samsung_clk_register_fixed_factor(s3c2443_common_ffactor,
+			ARRAY_SIZE(s3c2443_common_ffactor));
+
+	if (current_soc == S3C2416 || current_soc == S3C2450) {
+		mpll = samsung_clk_register_pll6552x("mpll", "mpllref",
+					reg_base + MPLLCON);
+		epll = samsung_clk_register_pll6553x("epll", "epllref",
+					reg_base + EPLLCON);
+	} else {
+		mpll = samsung_clk_register_pll3000x("mpll", "mpllref",
+					reg_base + MPLLCON);
+		epll = samsung_clk_register_pll2126x("epll", "epllref",
+					reg_base + EPLLCON);
+	}
+
+	samsung_clk_register_mux(s3c2443_common_muxes,
+			ARRAY_SIZE(s3c2443_common_muxes));
+	samsung_clk_register_div(s3c2443_common_dividers,
+			ARRAY_SIZE(s3c2443_common_dividers));
+	samsung_clk_register_gate(s3c2443_common_gates,
+		ARRAY_SIZE(s3c2443_common_gates));
+	samsung_clk_register_alias(s3c2443_common_aliases,
+		ARRAY_SIZE(s3c2443_common_aliases));
+
+	if (current_soc == S3C2416 || current_soc == S3C2450) {
+		samsung_clk_register_div(s3c2416_dividers,
+				ARRAY_SIZE(s3c2416_dividers));
+		samsung_clk_register_mux(s3c2416_muxes,
+				ARRAY_SIZE(s3c2416_muxes));
+		samsung_clk_register_gate(s3c2416_gates,
+				ARRAY_SIZE(s3c2416_gates));
+		samsung_clk_register_alias(s3c2416_aliases,
+				ARRAY_SIZE(s3c2416_aliases));
+	} else {
+		samsung_clk_register_div(s3c2443_dividers,
+				ARRAY_SIZE(s3c2443_dividers));
+		samsung_clk_register_gate(s3c2443_gates,
+				ARRAY_SIZE(s3c2443_gates));
+		samsung_clk_register_alias(s3c2443_aliases,
+				ARRAY_SIZE(s3c2443_aliases));
+	}
+
+	/* s3c2450 extends the s3c2416 clocks */
+	if (current_soc == S3C2450) {
+		samsung_clk_register_div(s3c2450_dividers,
+				ARRAY_SIZE(s3c2450_dividers));
+		samsung_clk_register_mux(s3c2450_muxes,
+				ARRAY_SIZE(s3c2450_muxes));
+		samsung_clk_register_gate(s3c2450_gates,
+				ARRAY_SIZE(s3c2450_gates));
+		samsung_clk_register_alias(s3c2450_aliases,
+				ARRAY_SIZE(s3c2450_aliases));
+	}
+}
-- 
1.7.2.3
