From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 17 Feb 2014 21:08:16 +0100
Subject: [PATCH v5 4/7] clk: samsung: add clock-driver for s3c2416,
 s3c2443 and s3c2450
In-Reply-To: <2678040.KALsQ0bZFm@phil>
References: <2678040.KALsQ0bZFm@phil>
Message-ID: <3019406.uc9nXtHdqy@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The three SoCs share a common clock tree which only differs in the
existence of some special clocks.

As with all parts common to these three SoCs the driver is named
after the s3c2443, as it was the first SoC introducing this structure
and there exists no other label to describe this s3c24xx epoch.

The clock structure is built according to the manuals of the included
SoCs and might include changes in comparison to the previous clock
structure. As an example the sclk_uart gate was never handled previously
and the div_uart was made to be the clock used by the serial driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s3c24xx/Kconfig       |   6 +
 drivers/clk/samsung/Makefile        |   1 +
 drivers/clk/samsung/clk-s3c2443.c   | 462 ++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/s3c2443.h |  92 +++++++
 4 files changed, 561 insertions(+)
 create mode 100644 drivers/clk/samsung/clk-s3c2443.c
 create mode 100644 include/dt-bindings/clock/s3c2443.h

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index d876431..4cbecaf 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -649,6 +649,12 @@ config S3C2443_COMMON
 	  Common code for the S3C2443 and similar processors, which includes
 	  the S3C2416 and S3C2450.
 
+config S3C2443_COMMON_CLK
+	bool
+	help
+	  Temporary symbol to build the clock driver based on the common clock
+	  framework.
+
 config S3C2443_DMA
 	bool
 	help
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 8eb4799..4c892c6 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
 obj-$(CONFIG_SOC_EXYNOS5420)	+= clk-exynos5420.o
 obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
 obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-audss.o
+obj-$(CONFIG_S3C2443_COMMON_CLK)+= clk-s3c2443.o
 obj-$(CONFIG_ARCH_S3C64XX)	+= clk-s3c64xx.o
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
new file mode 100644
index 0000000..8e4f451
--- /dev/null
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -0,0 +1,462 @@
+/*
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Common Clock Framework support for S3C2443 and following SoCs.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/syscore_ops.h>
+
+#include <dt-bindings/clock/s3c2443.h>
+
+#include "clk.h"
+#include "clk-pll.h"
+
+/* S3C2416 clock controller register offsets */
+#define LOCKCON0	0x00
+#define LOCKCON1	0x04
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
+/* list of PLLs to be registered */
+enum s3c2443_plls {
+	mpll, epll,
+};
+
+static void __iomem *reg_base;
+
+#ifdef CONFIG_PM_SLEEP
+static struct samsung_clk_reg_dump *s3c2443_save;
+
+/*
+ * list of controller registers to be saved and restored during a
+ * suspend/resume cycle.
+ */
+static unsigned long s3c2443_clk_regs[] __initdata = {
+	LOCKCON0,
+	LOCKCON1,
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
+static int s3c2443_clk_suspend(void)
+{
+	samsung_clk_save(reg_base, s3c2443_save,
+				ARRAY_SIZE(s3c2443_clk_regs));
+
+	return 0;
+}
+
+static void s3c2443_clk_resume(void)
+{
+	samsung_clk_restore(reg_base, s3c2443_save,
+				ARRAY_SIZE(s3c2443_clk_regs));
+}
+
+static struct syscore_ops s3c2443_clk_syscore_ops = {
+	.suspend = s3c2443_clk_suspend,
+	.resume = s3c2443_clk_resume,
+};
+
+static void s3c2443_clk_sleep_init(void)
+{
+	s3c2443_save = samsung_clk_alloc_reg_dump(s3c2443_clk_regs,
+						ARRAY_SIZE(s3c2443_clk_regs));
+	if (!s3c2443_save) {
+		pr_warn("%s: failed to allocate sleep save data, no sleep support!\n",
+			__func__);
+		return;
+	}
+
+	register_syscore_ops(&s3c2443_clk_syscore_ops);
+	return;
+}
+#else
+static void s3c2443_clk_sleep_init(void) {}
+#endif
+
+PNAME(epllref_p) = { "mpllref", "mpllref", "xti", "ext" };
+PNAME(esysclk_p) = { "epllref", "epll" };
+PNAME(mpllref_p) = { "xti", "mdivclk" };
+PNAME(msysclk_p) = { "mpllref", "mpll" };
+PNAME(armclk_p) = { "armdiv" , "hclk" };
+PNAME(i2s0_p) = { "div_i2s0", "ext_i2s", "epllref", "epllref" };
+
+struct samsung_mux_clock s3c2443_common_muxes[] __initdata = {
+	MUX(0, "epllref", epllref_p, CLKSRC, 7, 2),
+	MUX(ESYSCLK, "esysclk", esysclk_p, CLKSRC, 6, 1),
+	MUX(0, "mpllref", mpllref_p, CLKSRC, 3, 1),
+	MUX_A(MSYSCLK, "msysclk", msysclk_p, CLKSRC, 4, 1, "msysclk"),
+	MUX_A(ARMCLK, "armclk", armclk_p, CLKDIV0, 13, 1, "armclk"),
+	MUX(0, "mux_i2s0", i2s0_p, CLKSRC, 14, 2),
+};
+
+static struct clk_div_table hclk_d[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 3, .div = 4 },
+	{ /* sentinel */ },
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
+	{ /* sentinel */ },
+};
+
+struct samsung_div_clock s3c2443_common_dividers[] __initdata = {
+	DIV_T(0, "mdivclk", "xti", CLKDIV0, 6, 3, mdivclk_d),
+	DIV(0, "prediv", "msysclk", CLKDIV0, 4, 2),
+	DIV_T(HCLK, "hclk", "prediv", CLKDIV0, 0, 2, hclk_d),
+	DIV(PCLK, "pclk", "hclk", CLKDIV0, 2, 1),
+	DIV(0, "div_hsspi0_epll", "esysclk", CLKDIV1, 24, 2),
+	DIV(0, "div_fimd", "esysclk", CLKDIV1, 16, 8),
+	DIV(0, "div_i2s0", "esysclk", CLKDIV1, 12, 4),
+	DIV(0, "div_uart", "esysclk", CLKDIV1, 8, 4),
+	DIV(0, "div_hsmmc1", "esysclk", CLKDIV1, 6, 2),
+	DIV(0, "div_usbhost", "esysclk", CLKDIV1, 4, 2),
+};
+
+struct samsung_gate_clock s3c2443_common_gates[] __initdata = {
+	GATE(SCLK_HSMMC_EXT, "sclk_hsmmcext", "ext", SCLKCON, 13, 0, 0),
+	GATE(SCLK_HSMMC1, "sclk_hsmmc1", "div_hsmmc1", SCLKCON, 12, 0, 0),
+	GATE(SCLK_FIMD, "sclk_fimd", "div_fimd", SCLKCON, 10, 0, 0),
+	GATE(SCLK_I2S0, "sclk_i2s0", "mux_i2s0", SCLKCON, 9, 0, 0),
+	GATE(SCLK_UART, "sclk_uart", "div_uart", SCLKCON, 8, 0, 0),
+	GATE(SCLK_USBH, "sclk_usbhost", "div_usbhost", SCLKCON, 1, 0, 0),
+	GATE(HCLK_DRAM, "dram", "hclk", HCLKCON, 19, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_SSMC, "ssmc", "hclk", HCLKCON, 18, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_HSMMC1, "hsmmc1", "hclk", HCLKCON, 16, 0, 0),
+	GATE(HCLK_USBD, "usb-device", "hclk", HCLKCON, 12, 0, 0),
+	GATE(HCLK_USBH, "usb-host", "hclk", HCLKCON, 11, 0, 0),
+	GATE(HCLK_LCD, "lcd", "hclk", HCLKCON, 9, 0, 0),
+	GATE(HCLK_DMA5, "dma5", "hclk", HCLKCON, 5, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_DMA4, "dma4", "hclk", HCLKCON, 4, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_DMA3, "dma3", "hclk", HCLKCON, 3, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_DMA2, "dma2", "hclk", HCLKCON, 2, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_DMA1, "dma1", "hclk", HCLKCON, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_DMA0, "dma0", "hclk", HCLKCON, 0, CLK_IGNORE_UNUSED, 0),
+	GATE(PCLK_GPIO, "gpio", "pclk", PCLKCON, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(PCLK_RTC, "rtc", "pclk", PCLKCON, 12, 0, 0),
+	GATE(PCLK_WDT, "wdt", "pclk", PCLKCON, 11, 0, 0),
+	GATE(PCLK_PWM, "pwm", "pclk", PCLKCON, 10, 0, 0),
+	GATE(PCLK_I2S0, "i2s0", "pclk", PCLKCON, 9, 0, 0),
+	GATE(PCLK_AC97, "ac97", "pclk", PCLKCON, 8, 0, 0),
+	GATE(PCLK_ADC, "adc", "pclk", PCLKCON, 7, 0, 0),
+	GATE(PCLK_SPI0, "spi0", "pclk", PCLKCON, 6, 0, 0),
+	GATE(PCLK_I2C0, "i2c0", "pclk", PCLKCON, 4, 0, 0),
+	GATE(PCLK_UART3, "uart3", "pclk", PCLKCON, 3, 0, 0),
+	GATE(PCLK_UART2, "uart2", "pclk", PCLKCON, 2, 0, 0),
+	GATE(PCLK_UART1, "uart1", "pclk", PCLKCON, 1, 0, 0),
+	GATE(PCLK_UART0, "uart0", "pclk", PCLKCON, 0, 0, 0),
+};
+
+struct samsung_clock_alias s3c2443_common_aliases[] __initdata = {
+	ALIAS(HCLK, NULL, "hclk"),
+	ALIAS(HCLK_SSMC, NULL, "nand"),
+	ALIAS(PCLK_UART0, "s3c2440-uart.0", "uart"),
+	ALIAS(PCLK_UART1, "s3c2440-uart.1", "uart"),
+	ALIAS(PCLK_UART2, "s3c2440-uart.2", "uart"),
+	ALIAS(PCLK_UART3, "s3c2440-uart.3", "uart"),
+	ALIAS(PCLK_UART0, "s3c2440-uart.0", "clk_uart_baud2"),
+	ALIAS(PCLK_UART1, "s3c2440-uart.1", "clk_uart_baud2"),
+	ALIAS(PCLK_UART2, "s3c2440-uart.2", "clk_uart_baud2"),
+	ALIAS(PCLK_UART3, "s3c2440-uart.3", "clk_uart_baud2"),
+	ALIAS(SCLK_UART, NULL, "clk_uart_baud3"),
+	ALIAS(PCLK_PWM, NULL, "timers"),
+	ALIAS(PCLK_RTC, NULL, "rtc"),
+	ALIAS(PCLK_WDT, NULL, "watchdog"),
+	ALIAS(PCLK_ADC, NULL, "adc"),
+	ALIAS(PCLK_I2C0, "s3c2410-i2c.0", "i2c"),
+	ALIAS(HCLK_USBD, NULL, "usb-device"),
+	ALIAS(HCLK_USBH, NULL, "usb-host"),
+	ALIAS(SCLK_USBH, NULL, "usb-bus-host"),
+	ALIAS(PCLK_SPI0, "s3c2443-spi.0", "spi"),
+	ALIAS(PCLK_SPI0, "s3c2443-spi.0", "spi_busclk0"),
+	ALIAS(HCLK_HSMMC1, "s3c-sdhci.1", "hsmmc"),
+	ALIAS(HCLK_HSMMC1, "s3c-sdhci.1", "mmc_busclk.0"),
+	ALIAS(PCLK_I2S0, "samsung-i2s.0", "iis"),
+	ALIAS(SCLK_I2S0, NULL, "i2s-if"),
+	ALIAS(HCLK_LCD, NULL, "lcd"),
+	ALIAS(SCLK_FIMD, NULL, "sclk_fimd"),
+};
+
+/* S3C2416 specific clocks */
+
+static struct samsung_pll_clock s3c2416_pll_clks[] __initdata = {
+	[mpll] = PLL(pll_6552_s3c2416, 0, "mpll", "mpllref",
+						LOCKCON0, MPLLCON, NULL),
+	[epll] = PLL(pll_6553, 0, "epll", "epllref",
+						LOCKCON1, EPLLCON, NULL),
+};
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
+	{ /* sentinel */ },
+};
+
+struct samsung_div_clock s3c2416_dividers[] __initdata = {
+	DIV_T(ARMDIV, "armdiv", "msysclk", CLKDIV0, 9, 3, armdiv_s3c2416_d),
+	DIV(0, "div_hsspi0_mpll", "msysclk", CLKDIV2, 0, 4),
+	DIV(0, "div_hsmmc0", "esysclk", CLKDIV2, 6, 2),
+};
+
+struct samsung_mux_clock s3c2416_muxes[] __initdata = {
+	MUX(MUX_HSMMC0, "mux_hsmmc0", s3c2416_hsmmc0_p, CLKSRC, 16, 1),
+	MUX(MUX_HSMMC1, "mux_hsmmc1", s3c2416_hsmmc1_p, CLKSRC, 17, 1),
+	MUX(MUX_HSSPI0, "mux_hsspi0", s3c2416_hsspi0_p, CLKSRC, 18, 1),
+};
+
+struct samsung_gate_clock s3c2416_gates[] __initdata = {
+	GATE(0, "hsspi0_mpll", "div_hsspi0_mpll", SCLKCON, 19, 0, 0),
+	GATE(0, "hsspi0_epll", "div_hsspi0_epll", SCLKCON, 14, 0, 0),
+	GATE(0, "sclk_hsmmc0", "div_hsmmc0", SCLKCON, 6, 0, 0),
+	GATE(HCLK_2D, "2d", "hclk", HCLKCON, 20, 0, 0),
+	GATE(HCLK_HSMMC0, "hsmmc0", "hclk", HCLKCON, 15, 0, 0),
+	GATE(HCLK_IROM, "irom", "hclk", HCLKCON, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(PCLK_PCM, "pcm", "pclk", PCLKCON, 19, 0, 0),
+};
+
+struct samsung_clock_alias s3c2416_aliases[] __initdata = {
+	ALIAS(HCLK_HSMMC0, "s3c-sdhci.0", "hsmmc"),
+	ALIAS(HCLK_HSMMC0, "s3c-sdhci.0", "mmc_busclk.0"),
+	ALIAS(MUX_HSMMC0, "s3c-sdhci.0", "mmc_busclk.2"),
+	ALIAS(MUX_HSMMC1, "s3c-sdhci.1", "mmc_busclk.2"),
+	ALIAS(MUX_HSSPI0, "s3c2443-spi.0", "spi_busclk2"),
+	ALIAS(ARMDIV, NULL, "armdiv"),
+};
+
+/* S3C2443 specific clocks */
+
+static struct samsung_pll_clock s3c2443_pll_clks[] __initdata = {
+	[mpll] = PLL(pll_3000, 0, "mpll", "mpllref",
+						LOCKCON0, MPLLCON, NULL),
+	[epll] = PLL(pll_2126, 0, "epll", "epllref",
+						LOCKCON1, EPLLCON, NULL),
+};
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
+	{ /* sentinel */ },
+};
+
+struct samsung_div_clock s3c2443_dividers[] __initdata = {
+	DIV_T(ARMDIV, "armdiv", "msysclk", CLKDIV0, 9, 4, armdiv_s3c2443_d),
+	DIV(0, "div_cam", "esysclk", CLKDIV1, 26, 4),
+};
+
+struct samsung_gate_clock s3c2443_gates[] __initdata = {
+	GATE(SCLK_HSSPI0, "sclk_hsspi0", "div_hsspi0_epll", SCLKCON, 14, 0, 0),
+	GATE(SCLK_CAM, "sclk_cam", "div_cam", SCLKCON, 11, 0, 0),
+	GATE(HCLK_CFC, "cfc", "hclk", HCLKCON, 17, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_CAM, "cam", "hclk", HCLKCON, 8, 0, 0),
+	GATE(PCLK_SPI1, "spi1", "pclk", PCLKCON, 15, 0, 0),
+	GATE(PCLK_SDI, "sdi", "pclk", PCLKCON, 5, 0, 0),
+};
+
+struct samsung_clock_alias s3c2443_aliases[] __initdata = {
+	ALIAS(SCLK_HSSPI0, "s3c2443-spi.0", "spi_busclk2"),
+	ALIAS(SCLK_HSMMC1, "s3c-sdhci.1", "mmc_busclk.2"),
+	ALIAS(SCLK_CAM, NULL, "camif-upll"),
+	ALIAS(PCLK_SPI1, "s3c2410-spi.0", "spi"),
+	ALIAS(PCLK_SDI, NULL, "sdi"),
+	ALIAS(HCLK_CFC, NULL, "cfc"),
+	ALIAS(ARMDIV, NULL, "armdiv"),
+};
+
+/* S3C2450 specific clocks */
+
+PNAME(s3c2450_cam_p) = { "div_cam", "hclk" };
+PNAME(s3c2450_hsspi1_p) = { "hsspi1_epll", "hsspi1_mpll" };
+PNAME(i2s1_p) = { "div_i2s1", "ext_i2s", "epllref", "epllref" };
+
+struct samsung_div_clock s3c2450_dividers[] __initdata = {
+	DIV(0, "div_cam", "esysclk", CLKDIV1, 26, 4),
+	DIV(0, "div_hsspi1_epll", "esysclk", CLKDIV2, 24, 2),
+	DIV(0, "div_hsspi1_mpll", "msysclk", CLKDIV2, 16, 4),
+	DIV(0, "div_i2s1", "esysclk", CLKDIV2, 12, 4),
+};
+
+struct samsung_mux_clock s3c2450_muxes[] __initdata = {
+	MUX(0, "mux_cam", s3c2450_cam_p, CLKSRC, 20, 1),
+	MUX(MUX_HSSPI1, "mux_hsspi1", s3c2450_hsspi1_p, CLKSRC, 19, 1),
+	MUX(0, "mux_i2s1", i2s1_p, CLKSRC, 12, 2),
+};
+
+struct samsung_gate_clock s3c2450_gates[] __initdata = {
+	GATE(SCLK_I2S1, "sclk_i2s1", "div_i2s1", SCLKCON, 5, 0, 0),
+	GATE(HCLK_CFC, "cfc", "hclk", HCLKCON, 17, 0, 0),
+	GATE(HCLK_CAM, "cam", "hclk", HCLKCON, 8, 0, 0),
+	GATE(HCLK_DMA7, "dma7", "hclk", HCLKCON, 7, CLK_IGNORE_UNUSED, 0),
+	GATE(HCLK_DMA6, "dma6", "hclk", HCLKCON, 6, CLK_IGNORE_UNUSED, 0),
+	GATE(PCLK_I2S1, "i2s1", "pclk", PCLKCON, 17, 0, 0),
+	GATE(PCLK_I2C1, "i2c1", "pclk", PCLKCON, 16, 0, 0),
+	GATE(PCLK_SPI1, "spi1", "pclk", PCLKCON, 14, 0, 0),
+};
+
+struct samsung_clock_alias s3c2450_aliases[] __initdata = {
+	ALIAS(PCLK_SPI1, "s3c2443-spi.1", "spi"),
+	ALIAS(PCLK_SPI1, "s3c2443-spi.1", "spi_busclk0"),
+	ALIAS(MUX_HSSPI1, "s3c2443-spi.1", "spi_busclk2"),
+	ALIAS(PCLK_I2C1, "s3c2410-i2c.1", "i2c"),
+};
+
+/*
+ * fixed rate clocks generated outside the soc
+ * Only necessary until the devicetree-move is complete
+ */
+struct samsung_fixed_rate_clock s3c2443_common_frate_clks[] __initdata = {
+	FRATE(0, "xti", NULL, CLK_IS_ROOT, 0),
+	FRATE(0, "ext", NULL, CLK_IS_ROOT, 0),
+	FRATE(0, "ext_i2s", NULL, CLK_IS_ROOT, 0),
+	FRATE(0, "ext_uart", NULL, CLK_IS_ROOT, 0),
+};
+
+static void __init s3c2443_common_clk_register_fixed_ext(unsigned long xti_f)
+{
+	s3c2443_common_frate_clks[0].fixed_rate = xti_f;
+	samsung_clk_register_fixed_rate(s3c2443_common_frate_clks,
+				ARRAY_SIZE(s3c2443_common_frate_clks));
+}
+
+void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
+				    int current_soc,
+				    void __iomem *base)
+{
+	reg_base = base;
+
+	if (np) {
+		reg_base = of_iomap(np, 0);
+		if (!reg_base)
+			panic("%s: failed to map registers\n", __func__);
+	}
+
+	samsung_clk_init(np, reg_base, NR_CLKS);
+
+	/* Register external clocks only in non-dt cases */
+	if (!np)
+		s3c2443_common_clk_register_fixed_ext(xti_f);
+
+	/* Register PLLs. */
+	if (current_soc == S3C2416 || current_soc == S3C2450)
+		samsung_clk_register_pll(s3c2416_pll_clks,
+				ARRAY_SIZE(s3c2416_pll_clks), reg_base);
+	else
+		samsung_clk_register_pll(s3c2443_pll_clks,
+				ARRAY_SIZE(s3c2443_pll_clks), reg_base);
+
+	/* Register common internal clocks. */
+	samsung_clk_register_mux(s3c2443_common_muxes,
+			ARRAY_SIZE(s3c2443_common_muxes));
+	samsung_clk_register_div(s3c2443_common_dividers,
+			ARRAY_SIZE(s3c2443_common_dividers));
+	samsung_clk_register_gate(s3c2443_common_gates,
+		ARRAY_SIZE(s3c2443_common_gates));
+	samsung_clk_register_alias(s3c2443_common_aliases,
+		ARRAY_SIZE(s3c2443_common_aliases));
+
+	/* Register SoC-specific clocks. */
+	switch (current_soc) {
+	case S3C2450:
+		samsung_clk_register_div(s3c2450_dividers,
+				ARRAY_SIZE(s3c2450_dividers));
+		samsung_clk_register_mux(s3c2450_muxes,
+				ARRAY_SIZE(s3c2450_muxes));
+		samsung_clk_register_gate(s3c2450_gates,
+				ARRAY_SIZE(s3c2450_gates));
+		samsung_clk_register_alias(s3c2450_aliases,
+				ARRAY_SIZE(s3c2450_aliases));
+		/* fall through, as s3c2450 extends the s3c2416 clocks */
+	case S3C2416:
+		samsung_clk_register_div(s3c2416_dividers,
+				ARRAY_SIZE(s3c2416_dividers));
+		samsung_clk_register_mux(s3c2416_muxes,
+				ARRAY_SIZE(s3c2416_muxes));
+		samsung_clk_register_gate(s3c2416_gates,
+				ARRAY_SIZE(s3c2416_gates));
+		samsung_clk_register_alias(s3c2416_aliases,
+				ARRAY_SIZE(s3c2416_aliases));
+		break;
+	case S3C2443:
+		samsung_clk_register_div(s3c2443_dividers,
+				ARRAY_SIZE(s3c2443_dividers));
+		samsung_clk_register_gate(s3c2443_gates,
+				ARRAY_SIZE(s3c2443_gates));
+		samsung_clk_register_alias(s3c2443_aliases,
+				ARRAY_SIZE(s3c2443_aliases));
+		break;
+	}
+
+	s3c2443_clk_sleep_init();
+}
+
+static void __init s3c2416_clk_init(struct device_node *np)
+{
+	s3c2443_common_clk_init(np, 0, S3C2416, 0);
+}
+CLK_OF_DECLARE(s3c2416_clk, "samsung,s3c2416-clock", s3c2416_clk_init);
+
+static void __init s3c2443_clk_init(struct device_node *np)
+{
+	s3c2443_common_clk_init(np, 0, S3C2443, 0);
+}
+CLK_OF_DECLARE(s3c2443_clk, "samsung,s3c2443-clock", s3c2443_clk_init);
+
+static void __init s3c2450_clk_init(struct device_node *np)
+{
+	s3c2443_common_clk_init(np, 0, S3C2450, 0);
+}
+CLK_OF_DECLARE(s3c2450_clk, "samsung,s3c2450-clock", s3c2450_clk_init);
diff --git a/include/dt-bindings/clock/s3c2443.h b/include/dt-bindings/clock/s3c2443.h
new file mode 100644
index 0000000..37e66b0
--- /dev/null
+++ b/include/dt-bindings/clock/s3c2443.h
@@ -0,0 +1,92 @@
+/*
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Device Tree binding constants clock controllers of Samsung S3C2443 and later.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_SAMSUNG_S3C2443_CLOCK_H
+#define _DT_BINDINGS_CLOCK_SAMSUNG_S3C2443_CLOCK_H
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
+#define MSYSCLK			1
+#define ESYSCLK			2
+#define ARMDIV			3
+#define ARMCLK			4
+#define HCLK			5
+#define PCLK			6
+
+/* Special clocks */
+#define SCLK_HSSPI0		16
+#define SCLK_FIMD		17
+#define SCLK_I2S0		18
+#define SCLK_I2S1		19
+#define SCLK_HSMMC1		20
+#define SCLK_HSMMC_EXT		21
+#define SCLK_CAM		22
+#define SCLK_UART		23
+#define SCLK_USBH		24
+
+/* Muxes */
+#define MUX_HSSPI0		32
+#define MUX_HSSPI1		33
+#define MUX_HSMMC0		34
+#define MUX_HSMMC1		35
+
+/* hclk-gates */
+#define HCLK_DMA0		48
+#define HCLK_DMA1		49
+#define HCLK_DMA2		50
+#define HCLK_DMA3		51
+#define HCLK_DMA4		52
+#define HCLK_DMA5		53
+#define HCLK_DMA6		54
+#define HCLK_DMA7		55
+#define HCLK_CAM		56
+#define HCLK_LCD		57
+#define HCLK_USBH		58
+#define HCLK_USBD		59
+#define HCLK_IROM		60
+#define HCLK_HSMMC0		61
+#define HCLK_HSMMC1		62
+#define HCLK_CFC		63
+#define HCLK_SSMC		64
+#define HCLK_DRAM		65
+#define HCLK_2D			66
+
+/* pclk-gates */
+#define PCLK_UART0		72
+#define PCLK_UART1		73
+#define PCLK_UART2		74
+#define PCLK_UART3		75
+#define PCLK_I2C0		76
+#define PCLK_SDI		77
+#define PCLK_SPI0		78
+#define PCLK_ADC		79
+#define PCLK_AC97		80
+#define PCLK_I2S0		81
+#define PCLK_PWM		82
+#define PCLK_WDT		83
+#define PCLK_RTC		84
+#define PCLK_GPIO		85
+#define PCLK_SPI1		86
+#define PCLK_CHIPID		87
+#define PCLK_I2C1		88
+#define PCLK_I2S1		89
+#define PCLK_PCM		90
+
+/* Total number of clocks. */
+#define NR_CLKS			(PCLK_PCM + 1)
+
+#endif /* _DT_BINDINGS_CLOCK_SAMSUNG_S3C2443_CLOCK_H */
-- 
1.8.5.3
