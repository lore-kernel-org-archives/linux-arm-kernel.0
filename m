From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  6 Jan 2015 21:45:39 +0100
Subject: [PATCH 2/2] arm: pxa: switch pxa3xx to clock framework
In-Reply-To: <1420577139-30556-1-git-send-email-robert.jarzmik@free.fr>
References: <1420577139-30556-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1420577139-30556-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa3xx clocks being now in place in the clock framework, remove now
useless clock code. All clock handling is now in driver/clk/pxa.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/Kconfig            |  2 +-
 arch/arm/mach-pxa/Makefile  |  2 +-
 arch/arm/mach-pxa/generic.c |  2 ++
 arch/arm/mach-pxa/generic.h |  1 +
 arch/arm/mach-pxa/pxa300.c  | 19 +--------------
 arch/arm/mach-pxa/pxa320.c  |  9 -------
 arch/arm/mach-pxa/pxa3xx.c  | 59 ---------------------------------------------
 7 files changed, 6 insertions(+), 88 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 466ebc2..5afd70b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -611,7 +611,7 @@ config ARCH_PXA
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_CPU_SUSPEND if PM
 	select AUTO_ZRELADDR
-	select COMMON_CLK if PXA27x || PXA25x
+	select COMMON_CLK
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_OF
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 1566a27..4591c11 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_PM)		+= pm.o sleep.o standby.o
 # SoC-specific code
 obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
-obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o clock.o clock-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
+obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
 obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index d988c53..ec510ec 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -67,6 +67,8 @@ void __init pxa_timer_init(void)
 		pxa25x_clocks_init();
 	if (cpu_is_pxa27x())
 		pxa27x_clocks_init();
+	if (cpu_is_pxa3xx())
+		pxa3xx_clocks_init();
 	pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x40a00000),
 			    get_clock_tick_rate());
 }
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 149087c..0b1dbb5 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -39,6 +39,7 @@ extern void __init pxa27x_init_irq(void);
 extern void __init pxa27x_map_io(void);
 
 #define pxa3xx_handle_irq ichp_handle_irq
+extern int __init pxa3xx_clocks_init(void);
 extern void __init pxa3xx_dt_init_irq(void);
 extern void __init pxa3xx_init_irq(void);
 extern void __init pxa3xx_map_io(void);
diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
index 17cbc0c..a8af7cb 100644
--- a/arch/arm/mach-pxa/pxa300.c
+++ b/arch/arm/mach-pxa/pxa300.c
@@ -84,32 +84,15 @@ static struct mfp_addr_map pxa310_mfp_addr_map[] __initdata = {
 	MFP_ADDR_END,
 };
 
-static DEFINE_PXA3_CKEN(common_nand, NAND, 156000000, 0);
-static DEFINE_PXA3_CKEN(gcu, PXA300_GCU, 0, 0);
-
-static struct clk_lookup common_clkregs[] = {
-	INIT_CLKREG(&clk_common_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
-};
-
-static DEFINE_PXA3_CKEN(pxa310_mmc3, MMC3, 19500000, 0);
-
-static struct clk_lookup pxa310_clkregs[] = {
-	INIT_CLKREG(&clk_pxa310_mmc3, "pxa2xx-mci.2", NULL),
-};
-
 static int __init pxa300_init(void)
 {
 	if (cpu_is_pxa300() || cpu_is_pxa310()) {
 		mfp_init_base(io_p2v(MFPR_BASE));
 		mfp_init_addr(pxa300_mfp_addr_map);
-		clkdev_add_table(ARRAY_AND_SIZE(common_clkregs));
 	}
 
-	if (cpu_is_pxa310()) {
+	if (cpu_is_pxa310())
 		mfp_init_addr(pxa310_mfp_addr_map);
-		clkdev_add_table(ARRAY_AND_SIZE(pxa310_clkregs));
-	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
index 6dc99d4..395c12a 100644
--- a/arch/arm/mach-pxa/pxa320.c
+++ b/arch/arm/mach-pxa/pxa320.c
@@ -78,20 +78,11 @@ static struct mfp_addr_map pxa320_mfp_addr_map[] __initdata = {
 	MFP_ADDR_END,
 };
 
-static DEFINE_PXA3_CKEN(pxa320_nand, NAND, 104000000, 0);
-static DEFINE_PXA3_CKEN(gcu, PXA320_GCU, 0, 0);
-
-static struct clk_lookup pxa320_clkregs[] = {
-	INIT_CLKREG(&clk_pxa320_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
-};
-
 static int __init pxa320_init(void)
 {
 	if (cpu_is_pxa320()) {
 		mfp_init_base(io_p2v(MFPR_BASE));
 		mfp_init_addr(pxa320_mfp_addr_map);
-		clkdev_add_table(ARRAY_AND_SIZE(pxa320_clkregs));
 	}
 
 	return 0;
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index edcbd9c..bd4cbef 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -37,67 +37,11 @@
 
 #include "generic.h"
 #include "devices.h"
-#include "clock.h"
 
 #define PECR_IE(n)	((1 << ((n) * 2)) << 28)
 #define PECR_IS(n)	((1 << ((n) * 2)) << 29)
 
 extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int));
-
-static DEFINE_PXA3_CKEN(pxa3xx_ffuart, FFUART, 14857000, 1);
-static DEFINE_PXA3_CKEN(pxa3xx_btuart, BTUART, 14857000, 1);
-static DEFINE_PXA3_CKEN(pxa3xx_stuart, STUART, 14857000, 1);
-static DEFINE_PXA3_CKEN(pxa3xx_i2c, I2C, 32842000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_udc, UDC, 48000000, 5);
-static DEFINE_PXA3_CKEN(pxa3xx_usbh, USBH, 48000000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_u2d, USB2, 48000000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_keypad, KEYPAD, 32768, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_ssp1, SSP1, 13000000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_ssp2, SSP2, 13000000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_ssp3, SSP3, 13000000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_ssp4, SSP4, 13000000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_pwm0, PWM0, 13000000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_pwm1, PWM1, 13000000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_mmc1, MMC1, 19500000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_mmc2, MMC2, 19500000, 0);
-static DEFINE_PXA3_CKEN(pxa3xx_gpio, GPIO, 13000000, 0);
-
-static DEFINE_CK(pxa3xx_lcd, LCD, &clk_pxa3xx_hsio_ops);
-static DEFINE_CK(pxa3xx_smemc, SMC, &clk_pxa3xx_smemc_ops);
-static DEFINE_CK(pxa3xx_camera, CAMERA, &clk_pxa3xx_hsio_ops);
-static DEFINE_CK(pxa3xx_ac97, AC97, &clk_pxa3xx_ac97_ops);
-static DEFINE_CLK(pxa3xx_pout, &clk_pxa3xx_pout_ops, 13000000, 70);
-
-static struct clk_lookup pxa3xx_clkregs[] = {
-	INIT_CLKREG(&clk_pxa3xx_pout, NULL, "CLK_POUT"),
-	/* Power I2C clock is always on */
-	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_lcd, "pxa2xx-fb", NULL),
-	INIT_CLKREG(&clk_pxa3xx_camera, NULL, "CAMCLK"),
-	INIT_CLKREG(&clk_pxa3xx_ac97, NULL, "AC97CLK"),
-	INIT_CLKREG(&clk_pxa3xx_ffuart, "pxa2xx-uart.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_btuart, "pxa2xx-uart.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_stuart, "pxa2xx-uart.2", NULL),
-	INIT_CLKREG(&clk_pxa3xx_stuart, "pxa2xx-ir", "UARTCLK"),
-	INIT_CLKREG(&clk_pxa3xx_i2c, "pxa2xx-i2c.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_udc, "pxa27x-udc", NULL),
-	INIT_CLKREG(&clk_pxa3xx_usbh, "pxa27x-ohci", NULL),
-	INIT_CLKREG(&clk_pxa3xx_u2d, "pxa3xx-u2d", NULL),
-	INIT_CLKREG(&clk_pxa3xx_keypad, "pxa27x-keypad", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp1, "pxa3xx-ssp.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp2, "pxa3xx-ssp.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp3, "pxa3xx-ssp.2", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp4, "pxa3xx-ssp.3", NULL),
-	INIT_CLKREG(&clk_pxa3xx_pwm0, "pxa27x-pwm.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_pwm1, "pxa27x-pwm.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_mmc1, "pxa2xx-mci.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_mmc2, "pxa2xx-mci.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_smemc, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_pxa3xx_gpio, "pxa3xx-gpio", NULL),
-	INIT_CLKREG(&clk_pxa3xx_gpio, "pxa93x-gpio", NULL),
-	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
-};
-
 #ifdef CONFIG_PM
 
 #define ISRAM_START	0x5c000000
@@ -476,8 +420,6 @@ static int __init pxa3xx_init(void)
 		 */
 		ASCR &= ~(ASCR_RDH | ASCR_D1S | ASCR_D2S | ASCR_D3S);
 
-		clkdev_add_table(pxa3xx_clkregs, ARRAY_SIZE(pxa3xx_clkregs));
-
 		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
 			return ret;
 
@@ -485,7 +427,6 @@ static int __init pxa3xx_init(void)
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa3xx_mfp_syscore_ops);
-		register_syscore_ops(&pxa3xx_clock_syscore_ops);
 
 		if (of_have_populated_dt())
 			return 0;
-- 
2.1.0
