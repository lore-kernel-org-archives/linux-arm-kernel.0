From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 01:46:14 +0100
Subject: [PATCH 7/7] DO_NOT_APPLY: convert s3c2416 to use the common clock
 framework
In-Reply-To: <201303120141.31262.heiko@sntech.de>
References: <201303120141.31262.heiko@sntech.de>
Message-ID: <201303120146.14592.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the s3c2416 and smdk2416 from using the Samsung clocks to
the common clock framework. This is not meant to be the final result,
as it uses the temporary pwm clocks and the clock init itself also
needs changes, especially as the _init_time function stolen from exynos
is currently board specific due to the xtal frequency which needs
to be set.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig          |    2 +-
 arch/arm/mach-s3c24xx/Makefile         |    2 +-
 arch/arm/mach-s3c24xx/clock-s3c2416.c  |  173 --------------------------------
 arch/arm/mach-s3c24xx/common-s3c2443.c |   10 ++
 arch/arm/mach-s3c24xx/common.h         |    9 ++
 arch/arm/mach-s3c24xx/mach-smdk2416.c  |    9 ++-
 6 files changed, 28 insertions(+), 177 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 0a8663c..351c198 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -54,7 +54,7 @@ config CPU_S3C2416
 	select S3C2416_PM if PM
 	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
-	select SAMSUNG_CLKSRC
+	select COMMON_CLK
 	select SAMSUNG_HRT
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index be6e4d0..820524e 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_S3C2412_DMA)	+= dma-s3c2412.o
 obj-$(CONFIG_S3C2412_PM)	+= pm-s3c2412.o
 obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep-s3c2412.o
 
-obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o clock-s3c2416.o
+obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o
 obj-$(CONFIG_S3C2416_PM)	+= pm-s3c2416.o
 
 obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o clock-s3c2440.o
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2416.c b/arch/arm/mach-s3c24xx/clock-s3c2416.c
deleted file mode 100644
index 036056ce..0000000
--- a/arch/arm/mach-s3c24xx/clock-s3c2416.c
+++ /dev/null
@@ -1,173 +0,0 @@
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
-	s3c_pwmclk_init();
-
-}
diff --git a/arch/arm/mach-s3c24xx/common-s3c2443.c b/arch/arm/mach-s3c24xx/common-s3c2443.c
index b5bbeb7..d34b7ea 100644
--- a/arch/arm/mach-s3c24xx/common-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/common-s3c2443.c
@@ -27,6 +27,7 @@
 
 #include <plat/cpu-freq.h>
 
+#include "common.h"
 
 #ifdef CONFIG_SAMSUNG_CLOCK
 static int s3c2443_gate(void __iomem *reg, struct clk *clk, int enable)
@@ -675,3 +676,12 @@ void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 	s3c2443_common_setup_clocks(get_mpll);
 }
 #endif
+
+#ifdef CONFIG_COMMON_CLK
+void __init s3c2416_init_clocks(int xtal)
+{
+	s3c2443_clk_init(NULL);
+	s3c2443_clk_register_fixed_ext(xtal, 0, 0, 0);
+	samsung_pwm_clk_init(NULL);
+}
+#endif
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 307c371..9e59a3e 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -107,4 +107,13 @@ extern void s3c2443_init_irq(void);
 
 extern struct syscore_ops s3c24xx_irq_syscore_ops;
 
+#ifdef CONFIG_S3C2443_COMMON
+extern void s3c2443_clk_register_fixed_ext(unsigned long xti_f,
+				unsigned long ext_f, unsigned long i2s_f,
+				unsigned long uart_f);
+extern void __init s3c2443_clk_init(struct device_node *np);
+#endif
+
+extern void __init samsung_pwm_clk_init(struct device_node *np);
+
 #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index cb46847..a0035f2 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -217,10 +217,15 @@ static struct platform_device *smdk2416_devices[] __initdata = {
 	&s3c_device_usb_hsudc,
 };
 
+static void __init smdk2416_init_time(void)
+{
+	s3c24xx_init_clocks(12000000);
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
-- 
1.7.2.3
