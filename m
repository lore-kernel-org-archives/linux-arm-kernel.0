From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 10 Jul 2013 01:00:28 +0200
Subject: [PATCH v2 6/6] ARM: S3C24XX: Convert s3c2416 and s3c2443 to common
 clock framework
In-Reply-To: <201307100057.06061.heiko@sntech.de>
References: <201307100057.06061.heiko@sntech.de>
Message-ID: <201307100100.28992.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the mentioned platforms to use the newly introduced driver
for the common clock framework for them.

With this the whole legacy clock structure can go away too.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/s3c2416-smdk2416.dts  |    7 +
 arch/arm/boot/dts/s3c2416.dtsi          |   42 ++
 arch/arm/mach-s3c24xx/Kconfig           |   14 +-
 arch/arm/mach-s3c24xx/Makefile          |    5 +-
 arch/arm/mach-s3c24xx/clock-s3c2416.c   |  171 --------
 arch/arm/mach-s3c24xx/clock-s3c2443.c   |  212 ----------
 arch/arm/mach-s3c24xx/common-s3c2443.c  |  677 -------------------------------
 arch/arm/mach-s3c24xx/common.c          |   18 +-
 arch/arm/mach-s3c24xx/common.h          |    8 +
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |   45 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c   |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c   |    9 +-
 12 files changed, 102 insertions(+), 1115 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2443.c
 delete mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c

diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index 59594cf..9caeb89 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -19,6 +19,13 @@
 		reg =  <0x30000000 0x4000000>;
 	};
 
+	fixed-rate-clocks {
+		xti {
+			compatible = "samsung,clock-xti";
+			clock-frequency = <12000000>;
+		};
+	};
+
 	serial at 50000000 {
 		status = "okay";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index e6555bd..c19d99c 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/clock/samsung,s3c2443-clock.h>
 #include "s3c24xx.dtsi"
 #include "s3c2416-pinctrl.dtsi"
 
@@ -28,26 +29,53 @@
 		compatible = "samsung,s3c2416-irq";
 	};
 
+	clocks: clock-controller at 0x4c000000 {
+		compatible = "samsung,s3c2416-clock";
+		reg = <0x4c000000 0x40>;
+		#clock-cells = <1>;
+	};
+
 	pinctrl at 56000000 {
 		compatible = "samsung,s3c2416-pinctrl";
 	};
 
+	timer at 51000000 {
+		clocks = <&clocks PCLK_PWM>;
+		clock-names = "timers";
+	};
+
 	serial at 50000000 {
 		compatible = "samsung,s3c2440-uart";
+		clock-names = "uart", "clk_uart_baud2",
+				"clk_uart_baud3";
+		clocks = <&clocks PCLK_UART0>, <&clocks PCLK_UART0>,
+				<&clocks SCLK_UART>;
 	};
 
 	serial at 50004000 {
 		compatible = "samsung,s3c2440-uart";
+		clock-names = "uart", "clk_uart_baud2",
+				"clk_uart_baud3";
+		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
+				<&clocks SCLK_UART>;
 	};
 
 	serial at 50008000 {
 		compatible = "samsung,s3c2440-uart";
+		clock-names = "uart", "clk_uart_baud2",
+				"clk_uart_baud3";
+		clocks = <&clocks PCLK_UART2>, <&clocks PCLK_UART2>,
+				<&clocks SCLK_UART>;
 	};
 
 	serial at 5000C000 {
 		compatible = "samsung,s3c2440-uart";
 		reg = <0x5000C000 0x4000>;
 		interrupts = <1 18 24 4>, <1 18 25 4>;
+		clock-names = "uart", "clk_uart_baud2",
+				"clk_uart_baud3";
+		clocks = <&clocks PCLK_UART3>, <&clocks PCLK_UART3>,
+				<&clocks SCLK_UART>;
 		status = "disabled";
 	};
 
@@ -55,6 +83,10 @@
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4AC00000 0x100>;
 		interrupts = <0 0 21 3>;
+		clock-names = "hsmmc", "mmc_busclk.0",
+				"mmc_busclk.2";
+		clocks = <&clocks HCLK_HSMMC0>, <&clocks HCLK_HSMMC0>,
+				<&clocks MUX_HSMMC0>;
 		status = "disabled";
 	};
 
@@ -62,18 +94,28 @@
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4A800000 0x100>;
 		interrupts = <0 0 20 3>;
+		clock-names = "hsmmc", "mmc_busclk.0",
+				"mmc_busclk.2";
+		clocks = <&clocks HCLK_HSMMC1>, <&clocks HCLK_HSMMC1>,
+				<&clocks MUX_HSMMC1>;
 		status = "disabled";
 	};
 
 	watchdog at 53000000 {
 		interrupts = <1 9 27 3>;
+		clocks = <&clocks PCLK_WDT>;
+		clock-names = "watchdog";
 	};
 
 	rtc at 57000000 {
 		compatible = "samsung,s3c2416-rtc";
+		clocks = <&clocks PCLK_RTC>;
+		clock-names = "rtc";
 	};
 
 	i2c at 54000000 {
 		compatible = "samsung,s3c2440-i2c";
+		clocks = <&clocks PCLK_I2C0>;
+		clock-names = "i2c";
 	};
 };
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index b8ec0ec..37cbe5f 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -49,9 +49,9 @@ config CPU_S3C2416
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2416_PM if PM
-	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
-	select SAMSUNG_CLKSRC
+	select COMMON_CLK
+	select COMMON_CLK_S3C2443
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
 
@@ -83,9 +83,9 @@ config CPU_S3C2443
 	bool "SAMSUNG S3C2443"
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
-	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
-	select SAMSUNG_CLKSRC
+	select COMMON_CLK
+	select COMMON_CLK_S3C2443
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
 
@@ -663,12 +663,6 @@ endif	# CPU_S3C2442
 
 if CPU_S3C2443 || CPU_S3C2416
 
-config S3C2443_COMMON
-	bool
-	help
-	  Common code for the S3C2443 and similar processors, which includes
-	  the S3C2416 and S3C2450.
-
 config S3C2443_DMA
 	bool
 	help
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 7f54e5b..ba0e547 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_S3C2412_DMA)	+= dma-s3c2412.o
 obj-$(CONFIG_S3C2412_PM)	+= pm-s3c2412.o
 obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep-s3c2412.o
 
-obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o clock-s3c2416.o
+obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o
 obj-$(CONFIG_S3C2416_PM)	+= pm-s3c2416.o
 
 obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o clock-s3c2440.o
@@ -36,7 +36,7 @@ obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
 obj-$(CONFIG_S3C2440_PLL_12000000) += pll-s3c2440-12000000.o
 obj-$(CONFIG_S3C2440_PLL_16934400) += pll-s3c2440-16934400.o
 
-obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o clock-s3c2443.o
+obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o
 
 # PM
 
@@ -53,7 +53,6 @@ obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += cpufreq-utils.o
 obj-$(CONFIG_S3C2410_IOTIMING)	+= iotiming-s3c2410.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= iotiming-s3c2412.o
 
-obj-$(CONFIG_S3C2443_COMMON)	+= common-s3c2443.o
 obj-$(CONFIG_S3C2443_DMA)	+= dma-s3c2443.o
 
 #
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2416.c b/arch/arm/mach-s3c24xx/clock-s3c2416.c
deleted file mode 100644
index d421a72..0000000
--- a/arch/arm/mach-s3c24xx/clock-s3c2416.c
+++ /dev/null
@@ -1,171 +0,0 @@
-/* linux/arch/arm/mach-s3c2416/clock.c
- *
- * Copyright (c) 2010 Simtec Electronics
- * Copyright (c) 2010 Ben Dooks <ben-linux@fluff.org>
- *
- * S3C2416 Clock control support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/clk.h>
-
-#include <plat/clock.h>
-#include <plat/clock-clksrc.h>
-#include <plat/cpu.h>
-
-#include <plat/cpu-freq.h>
-#include <plat/pll.h>
-
-#include <asm/mach/map.h>
-
-#include <mach/regs-clock.h>
-#include <mach/regs-s3c2443-clock.h>
-
-/* armdiv
- *
- * this clock is sourced from msysclk and can have a number of
- * divider values applied to it to then be fed into armclk.
- * The real clock definition is done in s3c2443-clock.c,
- * only the armdiv divisor table must be defined here.
-*/
-
-static unsigned int armdiv[8] = {
-	[0] = 1,
-	[1] = 2,
-	[2] = 3,
-	[3] = 4,
-	[5] = 6,
-	[7] = 8,
-};
-
-static struct clksrc_clk hsspi_eplldiv = {
-	.clk = {
-		.name	= "hsspi-eplldiv",
-		.parent	= &clk_esysclk.clk,
-		.ctrlbit = (1 << 14),
-		.enable = s3c2443_clkcon_enable_s,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 24 },
-};
-
-static struct clk *hsspi_sources[] = {
-	[0] = &hsspi_eplldiv.clk,
-	[1] = NULL, /* to fix */
-};
-
-static struct clksrc_clk hsspi_mux = {
-	.clk	= {
-		.name	= "hsspi-if",
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = hsspi_sources,
-		.nr_sources = ARRAY_SIZE(hsspi_sources),
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 18 },
-};
-
-static struct clksrc_clk hsmmc_div[] = {
-	[0] = {
-		.clk = {
-			.name	= "hsmmc-div",
-			.devname	= "s3c-sdhci.0",
-			.parent	= &clk_esysclk.clk,
-		},
-		.reg_div = { .reg = S3C2416_CLKDIV2, .size = 2, .shift = 6 },
-	},
-	[1] = {
-		.clk = {
-			.name	= "hsmmc-div",
-			.devname	= "s3c-sdhci.1",
-			.parent	= &clk_esysclk.clk,
-		},
-		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 6 },
-	},
-};
-
-static struct clksrc_clk hsmmc_mux0 = {
-	.clk	= {
-		.name		= "hsmmc-if",
-		.devname	= "s3c-sdhci.0",
-		.ctrlbit	= (1 << 6),
-		.enable		= s3c2443_clkcon_enable_s,
-	},
-	.sources	= &(struct clksrc_sources) {
-		.nr_sources	= 2,
-		.sources	= (struct clk * []) {
-			[0]	= &hsmmc_div[0].clk,
-			[1]	= NULL, /* to fix */
-		},
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 16 },
-};
-
-static struct clksrc_clk hsmmc_mux1 = {
-	.clk	= {
-		.name		= "hsmmc-if",
-		.devname	= "s3c-sdhci.1",
-		.ctrlbit	= (1 << 12),
-		.enable		= s3c2443_clkcon_enable_s,
-	},
-	.sources	= &(struct clksrc_sources) {
-		.nr_sources	= 2,
-		.sources	= (struct clk * []) {
-			[0]	= &hsmmc_div[1].clk,
-			[1]	= NULL, /* to fix */
-		},
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 17 },
-};
-
-static struct clk hsmmc0_clk = {
-	.name		= "hsmmc",
-	.devname	= "s3c-sdhci.0",
-	.parent		= &clk_h,
-	.enable		= s3c2443_clkcon_enable_h,
-	.ctrlbit	= S3C2416_HCLKCON_HSMMC0,
-};
-
-static struct clksrc_clk *clksrcs[] __initdata = {
-	&hsspi_eplldiv,
-	&hsspi_mux,
-	&hsmmc_div[0],
-	&hsmmc_div[1],
-	&hsmmc_mux0,
-	&hsmmc_mux1,
-};
-
-static struct clk_lookup s3c2416_clk_lookup[] = {
-	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
-	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk),
-	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk),
-	/* s3c2443-spi.0 is used on s3c2416 and s3c2450 as well */
-	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk2", &hsspi_mux.clk),
-};
-
-void __init s3c2416_init_clocks(int xtal)
-{
-	u32 epllcon = __raw_readl(S3C2443_EPLLCON);
-	u32 epllcon1 = __raw_readl(S3C2443_EPLLCON+4);
-	int ptr;
-
-	/* s3c2416 EPLL compatible with s3c64xx */
-	clk_epll.rate = s3c_get_pll6553x(xtal, epllcon, epllcon1);
-
-	clk_epll.parent = &clk_epllref.clk;
-
-	s3c2443_common_init_clocks(xtal, s3c2416_get_pll,
-				   armdiv, ARRAY_SIZE(armdiv),
-				   S3C2416_CLKDIV0_ARMDIV_MASK);
-
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
-		s3c_register_clksrc(clksrcs[ptr], 1);
-
-	s3c24xx_register_clock(&hsmmc0_clk);
-	clkdev_add_table(s3c2416_clk_lookup, ARRAY_SIZE(s3c2416_clk_lookup));
-
-}
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2443.c b/arch/arm/mach-s3c24xx/clock-s3c2443.c
deleted file mode 100644
index 76cd31f..0000000
--- a/arch/arm/mach-s3c24xx/clock-s3c2443.c
+++ /dev/null
@@ -1,212 +0,0 @@
-/* linux/arch/arm/mach-s3c2443/clock.c
- *
- * Copyright (c) 2007, 2010 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2443 Clock control support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
-
-#include <linux/init.h>
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/device.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-#include <linux/serial_core.h>
-#include <linux/io.h>
-
-#include <asm/mach/map.h>
-
-#include <mach/hardware.h>
-
-#include <mach/regs-s3c2443-clock.h>
-
-#include <plat/cpu-freq.h>
-
-#include <plat/clock.h>
-#include <plat/clock-clksrc.h>
-#include <plat/cpu.h>
-
-/* We currently have to assume that the system is running
- * from the XTPll input, and that all ***REFCLKs are being
- * fed from it, as we cannot read the state of OM[4] from
- * software.
- *
- * It would be possible for each board initialisation to
- * set the correct muxing at initialisation
-*/
-
-/* clock selections */
-
-/* armdiv
- *
- * this clock is sourced from msysclk and can have a number of
- * divider values applied to it to then be fed into armclk.
- * The real clock definition is done in s3c2443-clock.c,
- * only the armdiv divisor table must be defined here.
-*/
-
-static unsigned int armdiv[16] = {
-	[S3C2443_CLKDIV0_ARMDIV_1 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 1,
-	[S3C2443_CLKDIV0_ARMDIV_2 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 2,
-	[S3C2443_CLKDIV0_ARMDIV_3 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 3,
-	[S3C2443_CLKDIV0_ARMDIV_4 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 4,
-	[S3C2443_CLKDIV0_ARMDIV_6 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 6,
-	[S3C2443_CLKDIV0_ARMDIV_8 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 8,
-	[S3C2443_CLKDIV0_ARMDIV_12 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 12,
-	[S3C2443_CLKDIV0_ARMDIV_16 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 16,
-};
-
-/* hsspi
- *
- * high-speed spi clock, sourced from esysclk
-*/
-
-static struct clksrc_clk clk_hsspi = {
-	.clk	= {
-		.name		= "hsspi-if",
-		.parent		= &clk_esysclk.clk,
-		.ctrlbit	= S3C2443_SCLKCON_HSSPICLK,
-		.enable		= s3c2443_clkcon_enable_s,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 4 },
-};
-
-
-/* clk_hsmcc_div
- *
- * this clock is sourced from epll, and is fed through a divider,
- * to a mux controlled by sclkcon where either it or a extclk can
- * be fed to the hsmmc block
-*/
-
-static struct clksrc_clk clk_hsmmc_div = {
-	.clk	= {
-		.name		= "hsmmc-div",
-		.devname	= "s3c-sdhci.1",
-		.parent		= &clk_esysclk.clk,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 6 },
-};
-
-static int s3c2443_setparent_hsmmc(struct clk *clk, struct clk *parent)
-{
-	unsigned long clksrc = __raw_readl(S3C2443_SCLKCON);
-
-	clksrc &= ~(S3C2443_SCLKCON_HSMMCCLK_EXT |
-		    S3C2443_SCLKCON_HSMMCCLK_EPLL);
-
-	if (parent == &clk_epll)
-		clksrc |= S3C2443_SCLKCON_HSMMCCLK_EPLL;
-	else if (parent == &clk_ext)
-		clksrc |= S3C2443_SCLKCON_HSMMCCLK_EXT;
-	else
-		return -EINVAL;
-
-	if (clk->usage > 0) {
-		__raw_writel(clksrc, S3C2443_SCLKCON);
-	}
-
-	clk->parent = parent;
-	return 0;
-}
-
-static int s3c2443_enable_hsmmc(struct clk *clk, int enable)
-{
-	return s3c2443_setparent_hsmmc(clk, clk->parent);
-}
-
-static struct clk clk_hsmmc = {
-	.name		= "hsmmc-if",
-	.devname	= "s3c-sdhci.1",
-	.parent		= &clk_hsmmc_div.clk,
-	.enable		= s3c2443_enable_hsmmc,
-	.ops		= &(struct clk_ops) {
-		.set_parent	= s3c2443_setparent_hsmmc,
-	},
-};
-
-/* standard clock definitions */
-
-static struct clk init_clocks_off[] = {
-	{
-		.name		= "sdi",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_SDI,
-	}, {
-		.name		= "spi",
-		.devname	= "s3c2410-spi.0",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_SPI1,
-	}
-};
-
-/* clocks to add straight away */
-
-static struct clksrc_clk *clksrcs[] __initdata = {
-	&clk_hsspi,
-	&clk_hsmmc_div,
-};
-
-static struct clk *clks[] __initdata = {
-	&clk_hsmmc,
-};
-
-static struct clk_lookup s3c2443_clk_lookup[] = {
-	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_hsmmc),
-	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk2", &clk_hsspi.clk),
-};
-
-void __init s3c2443_init_clocks(int xtal)
-{
-	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
-	int ptr;
-
-	clk_epll.rate = s3c2443_get_epll(epllcon, xtal);
-	clk_epll.parent = &clk_epllref.clk;
-
-	s3c2443_common_init_clocks(xtal, s3c2443_get_mpll,
-				   armdiv, ARRAY_SIZE(armdiv),
-				   S3C2443_CLKDIV0_ARMDIV_MASK);
-
-	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
-
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
-		s3c_register_clksrc(clksrcs[ptr], 1);
-
-	/* We must be careful disabling the clocks we are not intending to
-	 * be using at boot time, as subsystems such as the LCD which do
-	 * their own DMA requests to the bus can cause the system to lockup
-	 * if they where in the middle of requesting bus access.
-	 *
-	 * Disabling the LCD clock if the LCD is active is very dangerous,
-	 * and therefore the bootloader should be careful to not enable
-	 * the LCD clock if it is not needed.
-	*/
-
-	/* install (and disable) the clocks we do not need immediately */
-
-	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-	clkdev_add_table(s3c2443_clk_lookup, ARRAY_SIZE(s3c2443_clk_lookup));
-}
diff --git a/arch/arm/mach-s3c24xx/common-s3c2443.c b/arch/arm/mach-s3c24xx/common-s3c2443.c
deleted file mode 100644
index b5bbeb7..0000000
--- a/arch/arm/mach-s3c24xx/common-s3c2443.c
+++ /dev/null
@@ -1,677 +0,0 @@
-/*
- * Common code for SoCs starting with the S3C2443
- *
- * Copyright (c) 2007, 2010 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <mach/regs-s3c2443-clock.h>
-
-#include <plat/clock.h>
-#include <plat/clock-clksrc.h>
-#include <plat/cpu.h>
-
-#include <plat/cpu-freq.h>
-
-
-#ifdef CONFIG_SAMSUNG_CLOCK
-static int s3c2443_gate(void __iomem *reg, struct clk *clk, int enable)
-{
-	u32 ctrlbit = clk->ctrlbit;
-	u32 con = __raw_readl(reg);
-
-	if (enable)
-		con |= ctrlbit;
-	else
-		con &= ~ctrlbit;
-
-	__raw_writel(con, reg);
-	return 0;
-}
-
-int s3c2443_clkcon_enable_h(struct clk *clk, int enable)
-{
-	return s3c2443_gate(S3C2443_HCLKCON, clk, enable);
-}
-
-int s3c2443_clkcon_enable_p(struct clk *clk, int enable)
-{
-	return s3c2443_gate(S3C2443_PCLKCON, clk, enable);
-}
-
-int s3c2443_clkcon_enable_s(struct clk *clk, int enable)
-{
-	return s3c2443_gate(S3C2443_SCLKCON, clk, enable);
-}
-
-/* mpllref is a direct descendant of clk_xtal by default, but it is not
- * elided as the EPLL can be either sourced by the XTAL or EXTCLK and as
- * such directly equating the two source clocks is impossible.
- */
-static struct clk clk_mpllref = {
-	.name		= "mpllref",
-	.parent		= &clk_xtal,
-};
-
-static struct clk *clk_epllref_sources[] = {
-	[0] = &clk_mpllref,
-	[1] = &clk_mpllref,
-	[2] = &clk_xtal,
-	[3] = &clk_ext,
-};
-
-struct clksrc_clk clk_epllref = {
-	.clk	= {
-		.name		= "epllref",
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_epllref_sources,
-		.nr_sources = ARRAY_SIZE(clk_epllref_sources),
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 7 },
-};
-
-/* esysclk
- *
- * this is sourced from either the EPLL or the EPLLref clock
-*/
-
-static struct clk *clk_sysclk_sources[] = {
-	[0] = &clk_epllref.clk,
-	[1] = &clk_epll,
-};
-
-struct clksrc_clk clk_esysclk = {
-	.clk	= {
-		.name		= "esysclk",
-		.parent		= &clk_epll,
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_sysclk_sources,
-		.nr_sources = ARRAY_SIZE(clk_sysclk_sources),
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 6 },
-};
-
-static unsigned long s3c2443_getrate_mdivclk(struct clk *clk)
-{
-	unsigned long parent_rate = clk_get_rate(clk->parent);
-	unsigned long div = __raw_readl(S3C2443_CLKDIV0);
-
-	div  &= S3C2443_CLKDIV0_EXTDIV_MASK;
-	div >>= (S3C2443_CLKDIV0_EXTDIV_SHIFT-1);	/* x2 */
-
-	return parent_rate / (div + 1);
-}
-
-static struct clk clk_mdivclk = {
-	.name		= "mdivclk",
-	.parent		= &clk_mpllref,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s3c2443_getrate_mdivclk,
-	},
-};
-
-static struct clk *clk_msysclk_sources[] = {
-	[0] = &clk_mpllref,
-	[1] = &clk_mpll,
-	[2] = &clk_mdivclk,
-	[3] = &clk_mpllref,
-};
-
-static struct clksrc_clk clk_msysclk = {
-	.clk	= {
-		.name		= "msysclk",
-		.parent		= &clk_xtal,
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_msysclk_sources,
-		.nr_sources = ARRAY_SIZE(clk_msysclk_sources),
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 3 },
-};
-
-/* prediv
- *
- * this divides the msysclk down to pass to h/p/etc.
- */
-
-static unsigned long s3c2443_prediv_getrate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
-
-	clkdiv0 &= S3C2443_CLKDIV0_PREDIV_MASK;
-	clkdiv0 >>= S3C2443_CLKDIV0_PREDIV_SHIFT;
-
-	return rate / (clkdiv0 + 1);
-}
-
-static struct clk clk_prediv = {
-	.name		= "prediv",
-	.parent		= &clk_msysclk.clk,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s3c2443_prediv_getrate,
-	},
-};
-
-/* hclk divider
- *
- * divides the prediv and provides the hclk.
- */
-
-static unsigned long s3c2443_hclkdiv_getrate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
-
-	clkdiv0 &= S3C2443_CLKDIV0_HCLKDIV_MASK;
-
-	return rate / (clkdiv0 + 1);
-}
-
-static struct clk_ops clk_h_ops = {
-	.get_rate	= s3c2443_hclkdiv_getrate,
-};
-
-/* pclk divider
- *
- * divides the hclk and provides the pclk.
- */
-
-static unsigned long s3c2443_pclkdiv_getrate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
-
-	clkdiv0 = ((clkdiv0 & S3C2443_CLKDIV0_HALF_PCLK) ? 1 : 0);
-
-	return rate / (clkdiv0 + 1);
-}
-
-static struct clk_ops clk_p_ops = {
-	.get_rate	= s3c2443_pclkdiv_getrate,
-};
-
-/* armdiv
- *
- * this clock is sourced from msysclk and can have a number of
- * divider values applied to it to then be fed into armclk.
-*/
-
-static unsigned int *armdiv;
-static int nr_armdiv;
-static int armdivmask;
-
-static unsigned long s3c2443_armclk_roundrate(struct clk *clk,
-					      unsigned long rate)
-{
-	unsigned long parent = clk_get_rate(clk->parent);
-	unsigned long calc;
-	unsigned best = 256; /* bigger than any value */
-	unsigned div;
-	int ptr;
-
-	if (!nr_armdiv)
-		return -EINVAL;
-
-	for (ptr = 0; ptr < nr_armdiv; ptr++) {
-		div = armdiv[ptr];
-		if (div) {
-			/* cpufreq provides 266mhz as 266666000 not 266666666 */
-			calc = (parent / div / 1000) * 1000;
-			if (calc <= rate && div < best)
-				best = div;
-		}
-	}
-
-	return parent / best;
-}
-
-static unsigned long s3c2443_armclk_getrate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned long clkcon0;
-	int val;
-
-	if (!nr_armdiv || !armdivmask)
-		return -EINVAL;
-
-	clkcon0 = __raw_readl(S3C2443_CLKDIV0);
-	clkcon0 &= armdivmask;
-	val = clkcon0 >> S3C2443_CLKDIV0_ARMDIV_SHIFT;
-
-	return rate / armdiv[val];
-}
-
-static int s3c2443_armclk_setrate(struct clk *clk, unsigned long rate)
-{
-	unsigned long parent = clk_get_rate(clk->parent);
-	unsigned long calc;
-	unsigned div;
-	unsigned best = 256; /* bigger than any value */
-	int ptr;
-	int val = -1;
-
-	if (!nr_armdiv || !armdivmask)
-		return -EINVAL;
-
-	for (ptr = 0; ptr < nr_armdiv; ptr++) {
-		div = armdiv[ptr];
-		if (div) {
-			/* cpufreq provides 266mhz as 266666000 not 266666666 */
-			calc = (parent / div / 1000) * 1000;
-			if (calc <= rate && div < best) {
-				best = div;
-				val = ptr;
-			}
-		}
-	}
-
-	if (val >= 0) {
-		unsigned long clkcon0;
-
-		clkcon0 = __raw_readl(S3C2443_CLKDIV0);
-		clkcon0 &= ~armdivmask;
-		clkcon0 |= val << S3C2443_CLKDIV0_ARMDIV_SHIFT;
-		__raw_writel(clkcon0, S3C2443_CLKDIV0);
-	}
-
-	return (val == -1) ? -EINVAL : 0;
-}
-
-static struct clk clk_armdiv = {
-	.name		= "armdiv",
-	.parent		= &clk_msysclk.clk,
-	.ops		= &(struct clk_ops) {
-		.round_rate = s3c2443_armclk_roundrate,
-		.get_rate = s3c2443_armclk_getrate,
-		.set_rate = s3c2443_armclk_setrate,
-	},
-};
-
-/* armclk
- *
- * this is the clock fed into the ARM core itself, from armdiv or from hclk.
- */
-
-static struct clk *clk_arm_sources[] = {
-	[0] = &clk_armdiv,
-	[1] = &clk_h,
-};
-
-static struct clksrc_clk clk_arm = {
-	.clk	= {
-		.name		= "armclk",
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_arm_sources,
-		.nr_sources = ARRAY_SIZE(clk_arm_sources),
-	},
-	.reg_src = { .reg = S3C2443_CLKDIV0, .size = 1, .shift = 13 },
-};
-
-/* usbhost
- *
- * usb host bus-clock, usually 48MHz to provide USB bus clock timing
-*/
-
-static struct clksrc_clk clk_usb_bus_host = {
-	.clk	= {
-		.name		= "usb-bus-host-parent",
-		.parent		= &clk_esysclk.clk,
-		.ctrlbit	= S3C2443_SCLKCON_USBHOST,
-		.enable		= s3c2443_clkcon_enable_s,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 4 },
-};
-
-/* common clksrc clocks */
-
-static struct clksrc_clk clksrc_clks[] = {
-	{
-		/* camera interface bus-clock, divided down from esysclk */
-		.clk	= {
-			.name		= "camif-upll",	/* same as 2440 name */
-			.parent		= &clk_esysclk.clk,
-			.ctrlbit	= S3C2443_SCLKCON_CAMCLK,
-			.enable		= s3c2443_clkcon_enable_s,
-		},
-		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 26 },
-	}, {
-		.clk	= {
-			.name		= "display-if",
-			.parent		= &clk_esysclk.clk,
-			.ctrlbit	= S3C2443_SCLKCON_DISPCLK,
-			.enable		= s3c2443_clkcon_enable_s,
-		},
-		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 8, .shift = 16 },
-	},
-};
-
-static struct clksrc_clk clk_esys_uart = {
-	/* ART baud-rate clock sourced from esysclk via a divisor */
-	.clk	= {
-		.name		= "uartclk",
-		.parent		= &clk_esysclk.clk,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 8 },
-};
-
-static struct clk clk_i2s_ext = {
-	.name		= "i2s-ext",
-};
-
-/* i2s_eplldiv
- *
- * This clock is the output from the I2S divisor of ESYSCLK, and is separate
- * from the mux that comes after it (cannot merge into one single clock)
-*/
-
-static struct clksrc_clk clk_i2s_eplldiv = {
-	.clk	= {
-		.name		= "i2s-eplldiv",
-		.parent		= &clk_esysclk.clk,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 12, },
-};
-
-/* i2s-ref
- *
- * i2s bus reference clock, selectable from external, esysclk or epllref
- *
- * Note, this used to be two clocks, but was compressed into one.
-*/
-
-static struct clk *clk_i2s_srclist[] = {
-	[0] = &clk_i2s_eplldiv.clk,
-	[1] = &clk_i2s_ext,
-	[2] = &clk_epllref.clk,
-	[3] = &clk_epllref.clk,
-};
-
-static struct clksrc_clk clk_i2s = {
-	.clk	= {
-		.name		= "i2s-if",
-		.ctrlbit	= S3C2443_SCLKCON_I2SCLK,
-		.enable		= s3c2443_clkcon_enable_s,
-
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_i2s_srclist,
-		.nr_sources = ARRAY_SIZE(clk_i2s_srclist),
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 14 },
-};
-
-static struct clk init_clocks_off[] = {
-	{
-		.name		= "iis",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_IIS,
-	}, {
-		.name		= "adc",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_ADC,
-	}, {
-		.name		= "i2c",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_IIC,
-	}
-};
-
-static struct clk init_clocks[] = {
-	{
-		.name		= "dma",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA0,
-	}, {
-		.name		= "dma",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA1,
-	}, {
-		.name		= "dma",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA2,
-	}, {
-		.name		= "dma",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA3,
-	}, {
-		.name		= "dma",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA4,
-	}, {
-		.name		= "dma",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA5,
-	}, {
-		.name		= "gpio",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_GPIO,
-	}, {
-		.name		= "usb-host",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_USBH,
-	}, {
-		.name		= "usb-device",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_USBD,
-	}, {
-		.name		= "lcd",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_LCDC,
-
-	}, {
-		.name		= "timers",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_PWMT,
-	}, {
-		.name		= "cfc",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_CFC,
-	}, {
-		.name		= "ssmc",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_SSMC,
-	}, {
-		.name		= "uart",
-		.devname	= "s3c2440-uart.0",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_UART0,
-	}, {
-		.name		= "uart",
-		.devname	= "s3c2440-uart.1",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_UART1,
-	}, {
-		.name		= "uart",
-		.devname	= "s3c2440-uart.2",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_UART2,
-	}, {
-		.name		= "uart",
-		.devname	= "s3c2440-uart.3",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_UART3,
-	}, {
-		.name		= "rtc",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_RTC,
-	}, {
-		.name		= "watchdog",
-		.parent		= &clk_p,
-		.ctrlbit	= S3C2443_PCLKCON_WDT,
-	}, {
-		.name		= "ac97",
-		.parent		= &clk_p,
-		.ctrlbit	= S3C2443_PCLKCON_AC97,
-	}, {
-		.name		= "nand",
-		.parent		= &clk_h,
-	}, {
-		.name		= "usb-bus-host",
-		.parent		= &clk_usb_bus_host.clk,
-	}
-};
-
-static struct clk hsmmc1_clk = {
-	.name		= "hsmmc",
-	.devname	= "s3c-sdhci.1",
-	.parent		= &clk_h,
-	.enable		= s3c2443_clkcon_enable_h,
-	.ctrlbit	= S3C2443_HCLKCON_HSMMC,
-};
-
-static struct clk hsspi_clk = {
-	.name		= "spi",
-	.devname	= "s3c2443-spi.0",
-	.parent		= &clk_p,
-	.enable		= s3c2443_clkcon_enable_p,
-	.ctrlbit	= S3C2443_PCLKCON_HSSPI,
-};
-
-/* EPLLCON compatible enough to get on/off information */
-
-void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
-{
-	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
-	unsigned long mpllcon = __raw_readl(S3C2443_MPLLCON);
-	struct clk *xtal_clk;
-	unsigned long xtal;
-	unsigned long pll;
-	int ptr;
-
-	xtal_clk = clk_get(NULL, "xtal");
-	xtal = clk_get_rate(xtal_clk);
-	clk_put(xtal_clk);
-
-	pll = get_mpll(mpllcon, xtal);
-	clk_msysclk.clk.rate = pll;
-	clk_mpll.rate = pll;
-
-	printk("CPU: MPLL %s %ld.%03ld MHz, cpu %ld.%03ld MHz, mem %ld.%03ld MHz, pclk %ld.%03ld MHz\n",
-	       (mpllcon & S3C2443_PLLCON_OFF) ? "off" : "on",
-	       print_mhz(pll), print_mhz(clk_get_rate(&clk_armdiv)),
-	       print_mhz(clk_get_rate(&clk_h)),
-	       print_mhz(clk_get_rate(&clk_p)));
-
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_clks); ptr++)
-		s3c_set_clksrc(&clksrc_clks[ptr], true);
-
-	/* ensure usb bus clock is within correct rate of 48MHz */
-
-	if (clk_get_rate(&clk_usb_bus_host.clk) != (48 * 1000 * 1000)) {
-		printk(KERN_INFO "Warning: USB host bus not at 48MHz\n");
-		clk_set_rate(&clk_usb_bus_host.clk, 48*1000*1000);
-	}
-
-	printk("CPU: EPLL %s %ld.%03ld MHz, usb-bus %ld.%03ld MHz\n",
-	       (epllcon & S3C2443_PLLCON_OFF) ? "off" : "on",
-	       print_mhz(clk_get_rate(&clk_epll)),
-	       print_mhz(clk_get_rate(&clk_usb_bus)));
-}
-
-static struct clk *clks[] __initdata = {
-	&clk_prediv,
-	&clk_mpllref,
-	&clk_mdivclk,
-	&clk_ext,
-	&clk_epll,
-	&clk_usb_bus,
-	&clk_armdiv,
-	&hsmmc1_clk,
-	&hsspi_clk,
-};
-
-static struct clksrc_clk *clksrcs[] __initdata = {
-	&clk_i2s_eplldiv,
-	&clk_i2s,
-	&clk_usb_bus_host,
-	&clk_epllref,
-	&clk_esysclk,
-	&clk_msysclk,
-	&clk_arm,
-};
-
-static struct clk_lookup s3c2443_clk_lookup[] = {
-	CLKDEV_INIT(NULL, "clk_uart_baud1", &s3c24xx_uclk),
-	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
-	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_esys_uart.clk),
-	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &hsmmc1_clk),
-	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk0", &hsspi_clk),
-};
-
-void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
-				       unsigned int *divs, int nr_divs,
-				       int divmask)
-{
-	int ptr;
-
-	armdiv = divs;
-	nr_armdiv = nr_divs;
-	armdivmask = divmask;
-
-	/* s3c2443 parents h clock from prediv */
-	clk_h.parent = &clk_prediv;
-	clk_h.ops = &clk_h_ops;
-
-	/* and p clock from h clock */
-	clk_p.parent = &clk_h;
-	clk_p.ops = &clk_p_ops;
-
-	clk_usb_bus.parent = &clk_usb_bus_host.clk;
-	clk_epll.parent = &clk_epllref.clk;
-
-	s3c24xx_register_baseclocks(xtal);
-	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
-
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
-		s3c_register_clksrc(clksrcs[ptr], 1);
-
-	s3c_register_clksrc(clksrc_clks, ARRAY_SIZE(clksrc_clks));
-	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
-
-	/* See s3c2443/etc notes on disabling clocks@init time */
-	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-	clkdev_add_table(s3c2443_clk_lookup, ARRAY_SIZE(s3c2443_clk_lookup));
-
-	s3c2443_common_setup_clocks(get_mpll);
-}
-#endif
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 0fe0254..6eae7a1 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -143,7 +143,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= 0x32450003,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2416_map_io,
-		.init_clocks	= s3c2416_init_clocks,
 		.init_uarts	= s3c2416_init_uarts,
 		.init		= s3c2416_init,
 		.name		= name_s3c2416,
@@ -152,7 +151,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= 0x32443001,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2443_map_io,
-		.init_clocks	= s3c2443_init_clocks,
 		.init_uarts	= s3c2443_init_uarts,
 		.init		= s3c2443_init,
 		.name		= name_s3c2443,
@@ -331,3 +329,19 @@ void __init_or_cpufreq s3c24xx_setup_clocks(unsigned long fclk,
 	clk_f.rate = fclk;
 }
 #endif
+
+#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_CPU_S3C2416)
+void __init s3c2416_init_clocks(int xtal)
+{
+	s3c2443_common_clk_init(NULL, 0, S3C24XX_VA_CLKPWR);
+	s3c2443_clk_register_fixed_ext(xtal, 0, 0, 0);
+}
+#endif
+
+#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_CPU_S3C2443)
+void __init s3c2443_init_clocks(int xtal)
+{
+	s3c2443_common_clk_init(NULL, 1, S3C24XX_VA_CLKPWR);
+	s3c2443_clk_register_fixed_ext(xtal, 0, 0, 0);
+}
+#endif
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 307c371..2cbcec3 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -107,4 +107,12 @@ extern void s3c2443_init_irq(void);
 
 extern struct syscore_ops s3c24xx_irq_syscore_ops;
 
+#ifdef CONFIG_COMMON_CLK_S3C2443
+extern void s3c2443_clk_register_fixed_ext(unsigned long xti_f,
+				unsigned long ext_f, unsigned long i2s_f,
+				unsigned long uart_f);
+void __init s3c2443_common_clk_init(struct device_node *np, int current_soc,
+			     void __iomem *reg_base);
+#endif
+
 #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
index f50454a..fc6823a 100644
--- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
@@ -19,6 +19,7 @@
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
+#include <linux/clk-provider.h>
 
 #include <asm/mach/arch.h>
 #include <mach/map.h>
@@ -29,48 +30,20 @@
 
 #include "common.h"
 
-/*
- * The following lookup table is used to override device names when devices
- * are registered from device tree. This is temporarily added to enable
- * device tree support addition for the S3C2416 architecture.
- *
- * For drivers that require platform data to be provided from the machine
- * file, a platform data pointer can also be supplied along with the
- * devices names. Usually, the platform data elements that cannot be parsed
- * from the device tree by the drivers (example: function pointers) are
- * supplied. But it should be noted that this is a temporary mechanism and
- * at some point, the drivers should be capable of parsing all the platform
- * data from the device tree.
- */
-static const struct of_dev_auxdata s3c2416_auxdata_lookup[] __initconst = {
-	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C24XX_PA_UART,
-				"s3c2440-uart.0", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C24XX_PA_UART + 0x4000,
-				"s3c2440-uart.1", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C24XX_PA_UART + 0x8000,
-				"s3c2440-uart.2", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C24XX_PA_UART + 0xC000,
-				"s3c2440-uart.3", NULL),
-	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", S3C_PA_HSMMC0,
-				"s3c-sdhci.0", NULL),
-	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", S3C_PA_HSMMC1,
-				"s3c-sdhci.1", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", S3C_PA_IIC,
-				"s3c2440-i2c.0", NULL),
-	{},
-};
-
 static void __init s3c2416_dt_map_io(void)
 {
 	s3c24xx_init_io(NULL, 0);
-	s3c24xx_init_clocks(12000000);
 }
 
-static void __init s3c2416_dt_machine_init(void)
+static void __init s3c2416_dt_init_time(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-				s3c2416_auxdata_lookup, NULL);
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
 
+static void __init s3c2416_dt_machine_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	s3c_pm_init();
 }
 
@@ -86,6 +59,6 @@ DT_MACHINE_START(S3C2416_DT, "Samsung S3C2416 (Flattened Device Tree)")
 	.map_io		= s3c2416_dt_map_io,
 	.init_irq	= irqchip_init,
 	.init_machine	= s3c2416_dt_machine_init,
-	 .init_time	= clocksource_of_init,
+	.init_time	= s3c2416_dt_init_time,
 	.restart	= s3c2416_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index cb46847..077d44c 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -217,10 +217,15 @@ static struct platform_device *smdk2416_devices[] __initdata = {
 	&s3c_device_usb_hsudc,
 };
 
+static void __init smdk2416_init_time(void)
+{
+	s3c2416_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init smdk2416_map_io(void)
 {
 	s3c24xx_init_io(smdk2416_iodesc, ARRAY_SIZE(smdk2416_iodesc));
-	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdk2416_uartcfgs, ARRAY_SIZE(smdk2416_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
@@ -255,6 +260,6 @@ MACHINE_START(SMDK2416, "SMDK2416")
 	.init_irq	= s3c2416_init_irq,
 	.map_io		= smdk2416_map_io,
 	.init_machine	= smdk2416_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= smdk2416_init_time,
 	.restart	= s3c2416_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index 9435c3b..0dbf470 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -120,11 +120,16 @@ static struct platform_device *smdk2443_devices[] __initdata = {
 static void __init smdk2443_map_io(void)
 {
 	s3c24xx_init_io(smdk2443_iodesc, ARRAY_SIZE(smdk2443_iodesc));
-	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdk2443_uartcfgs, ARRAY_SIZE(smdk2443_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init smdk2443_init_time(void)
+{
+	s3c2443_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init smdk2443_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
@@ -144,6 +149,6 @@ MACHINE_START(SMDK2443, "SMDK2443")
 	.init_irq	= s3c2443_init_irq,
 	.map_io		= smdk2443_map_io,
 	.init_machine	= smdk2443_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= smdk2443_init_time,
 	.restart	= s3c2443_restart,
 MACHINE_END
-- 
1.7.10.4
