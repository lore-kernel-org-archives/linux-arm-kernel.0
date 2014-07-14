From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 14 Jul 2014 17:54:23 +0200
Subject: [PATCH v2 6/6] arm: pxa: Transition pxa27x to clk framework
In-Reply-To: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
References: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1405353263-13424-7-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Transition the PXA27x CPUs to the clock framework.
This transition still enables legacy platforms to run without device
tree as before, ie relying on platform data encoded in board specific
files.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/Kconfig           |   1 +
 arch/arm/mach-pxa/Makefile |   8 +-
 arch/arm/mach-pxa/pxa27x.c | 186 +++------------------------------------------
 3 files changed, 17 insertions(+), 178 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87b63fd..96bdc7b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -642,6 +642,7 @@ config ARCH_PXA
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_CPU_SUSPEND if PM
 	select AUTO_ZRELADDR
+	select COMMON_CLK if PXA27x
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 648867a..ce15823 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -3,16 +3,16 @@
 #
 
 # Common support (must be linked before board specific support)
-obj-y				+= clock.o devices.o generic.o irq.o \
+obj-y				+= devices.o generic.o irq.o \
 				   time.o reset.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o standby.o
 
 # Generic drivers that other drivers may depend upon
 
 # SoC-specific code
-obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa25x.o
-obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa27x.o
-obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o clock-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
+obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o clock.o clock-pxa2xx.o pxa2xx.o pxa25x.o
+obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
+obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o clock.o clock-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
 obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 301471a..6beb32cd 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -37,7 +37,8 @@
 
 #include "generic.h"
 #include "devices.h"
-#include "clock.h"
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 
 void pxa27x_clear_otgph(void)
 {
@@ -73,174 +74,6 @@ void pxa27x_configure_ac97reset(int reset_gpio, bool to_gpio)
 }
 EXPORT_SYMBOL_GPL(pxa27x_configure_ac97reset);
 
-/* Crystal clock: 13MHz */
-#define BASE_CLK	13000000
-
-/*
- * Get the clock frequency as reflected by CCSR and the turbo flag.
- * We assume these values have been applied via a fcs.
- * If info is not 0 we also display the current settings.
- */
-unsigned int pxa27x_get_clk_frequency_khz(int info)
-{
-	unsigned long ccsr, clkcfg;
-	unsigned int l, L, m, M, n2, N, S;
-       	int cccr_a, t, ht, b;
-
-	ccsr = CCSR;
-	cccr_a = CCCR & (1 << 25);
-
-	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
-	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
-	t  = clkcfg & (1 << 0);
-	ht = clkcfg & (1 << 2);
-	b  = clkcfg & (1 << 3);
-
-	l  = ccsr & 0x1f;
-	n2 = (ccsr>>7) & 0xf;
-	m  = (l <= 10) ? 1 : (l <= 20) ? 2 : 4;
-
-	L  = l * BASE_CLK;
-	N  = (L * n2) / 2;
-	M  = (!cccr_a) ? (L/m) : ((b) ? L : (L/2));
-	S  = (b) ? L : (L/2);
-
-	if (info) {
-		printk( KERN_INFO "Run Mode clock: %d.%02dMHz (*%d)\n",
-			L / 1000000, (L % 1000000) / 10000, l );
-		printk( KERN_INFO "Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
-			N / 1000000, (N % 1000000)/10000, n2 / 2, (n2 % 2)*5,
-			(t) ? "" : "in" );
-		printk( KERN_INFO "Memory clock: %d.%02dMHz (/%d)\n",
-			M / 1000000, (M % 1000000) / 10000, m );
-		printk( KERN_INFO "System bus clock: %d.%02dMHz \n",
-			S / 1000000, (S % 1000000) / 10000 );
-	}
-
-	return (t) ? (N/1000) : (L/1000);
-}
-
-/*
- * Return the current mem clock frequency as reflected by CCCR[A], B, and L
- */
-static unsigned long clk_pxa27x_mem_getrate(struct clk *clk)
-{
-	unsigned long ccsr, clkcfg;
-	unsigned int l, L, m, M;
-       	int cccr_a, b;
-
-	ccsr = CCSR;
-	cccr_a = CCCR & (1 << 25);
-
-	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
-	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
-	b = clkcfg & (1 << 3);
-
-	l = ccsr & 0x1f;
-	m = (l <= 10) ? 1 : (l <= 20) ? 2 : 4;
-
-	L = l * BASE_CLK;
-	M = (!cccr_a) ? (L/m) : ((b) ? L : (L/2));
-
-	return M;
-}
-
-static const struct clkops clk_pxa27x_mem_ops = {
-	.enable		= clk_dummy_enable,
-	.disable	= clk_dummy_disable,
-	.getrate	= clk_pxa27x_mem_getrate,
-};
-
-/*
- * Return the current LCD clock frequency in units of 10kHz as
- */
-static unsigned int pxa27x_get_lcdclk_frequency_10khz(void)
-{
-	unsigned long ccsr;
-	unsigned int l, L, k, K;
-
-	ccsr = CCSR;
-
-	l = ccsr & 0x1f;
-	k = (l <= 7) ? 1 : (l <= 16) ? 2 : 4;
-
-	L = l * BASE_CLK;
-	K = L / k;
-
-	return (K / 10000);
-}
-
-static unsigned long clk_pxa27x_lcd_getrate(struct clk *clk)
-{
-	return pxa27x_get_lcdclk_frequency_10khz() * 10000;
-}
-
-static const struct clkops clk_pxa27x_lcd_ops = {
-	.enable		= clk_pxa2xx_cken_enable,
-	.disable	= clk_pxa2xx_cken_disable,
-	.getrate	= clk_pxa27x_lcd_getrate,
-};
-
-static DEFINE_PXA2_CKEN(pxa27x_ffuart, FFUART, 14857000, 1);
-static DEFINE_PXA2_CKEN(pxa27x_btuart, BTUART, 14857000, 1);
-static DEFINE_PXA2_CKEN(pxa27x_stuart, STUART, 14857000, 1);
-static DEFINE_PXA2_CKEN(pxa27x_i2s, I2S, 14682000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_i2c, I2C, 32842000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_usb, USB, 48000000, 5);
-static DEFINE_PXA2_CKEN(pxa27x_mmc, MMC, 19500000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_ficp, FICP, 48000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_usbhost, USBHOST, 48000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_pwri2c, PWRI2C, 13000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_keypad, KEYPAD, 32768, 0);
-static DEFINE_PXA2_CKEN(pxa27x_ssp1, SSP1, 13000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_ssp2, SSP2, 13000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_ssp3, SSP3, 13000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_pwm0, PWM0, 13000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_pwm1, PWM1, 13000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_ac97, AC97, 24576000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_ac97conf, AC97CONF, 24576000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_msl, MSL, 48000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_usim, USIM, 48000000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_memstk, MEMSTK, 19500000, 0);
-static DEFINE_PXA2_CKEN(pxa27x_im, IM, 0, 0);
-static DEFINE_PXA2_CKEN(pxa27x_memc, MEMC, 0, 0);
-
-static DEFINE_CK(pxa27x_lcd, LCD, &clk_pxa27x_lcd_ops);
-static DEFINE_CK(pxa27x_camera, CAMERA, &clk_pxa27x_lcd_ops);
-static DEFINE_CLK(pxa27x_mem, &clk_pxa27x_mem_ops, 0, 0);
-
-static struct clk_lookup pxa27x_clkregs[] = {
-	INIT_CLKREG(&clk_pxa27x_lcd, "pxa2xx-fb", NULL),
-	INIT_CLKREG(&clk_pxa27x_camera, "pxa27x-camera.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_ffuart, "pxa2xx-uart.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_btuart, "pxa2xx-uart.1", NULL),
-	INIT_CLKREG(&clk_pxa27x_stuart, "pxa2xx-uart.2", NULL),
-	INIT_CLKREG(&clk_pxa27x_i2s, "pxa2xx-i2s", NULL),
-	INIT_CLKREG(&clk_pxa27x_i2c, "pxa2xx-i2c.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_usb, "pxa27x-udc", NULL),
-	INIT_CLKREG(&clk_pxa27x_mmc, "pxa2xx-mci.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_stuart, "pxa2xx-ir", "UARTCLK"),
-	INIT_CLKREG(&clk_pxa27x_ficp, "pxa2xx-ir", "FICPCLK"),
-	INIT_CLKREG(&clk_pxa27x_usbhost, "pxa27x-ohci", NULL),
-	INIT_CLKREG(&clk_pxa27x_pwri2c, "pxa2xx-i2c.1", NULL),
-	INIT_CLKREG(&clk_pxa27x_keypad, "pxa27x-keypad", NULL),
-	INIT_CLKREG(&clk_pxa27x_ssp1, "pxa27x-ssp.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_ssp2, "pxa27x-ssp.1", NULL),
-	INIT_CLKREG(&clk_pxa27x_ssp3, "pxa27x-ssp.2", NULL),
-	INIT_CLKREG(&clk_pxa27x_pwm0, "pxa27x-pwm.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_pwm1, "pxa27x-pwm.1", NULL),
-	INIT_CLKREG(&clk_pxa27x_ac97, NULL, "AC97CLK"),
-	INIT_CLKREG(&clk_pxa27x_ac97conf, NULL, "AC97CONFCLK"),
-	INIT_CLKREG(&clk_pxa27x_msl, NULL, "MSLCLK"),
-	INIT_CLKREG(&clk_pxa27x_usim, NULL, "USIMCLK"),
-	INIT_CLKREG(&clk_pxa27x_memstk, NULL, "MSTKCLK"),
-	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
-	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
-	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_dummy, "pxa27x-gpio", NULL),
-	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
-};
-
 #ifdef CONFIG_PM
 
 #define SAVE(x)		sleep_save[SLEEP_SAVE_##x] = x
@@ -460,8 +293,6 @@ static int __init pxa27x_init(void)
 
 		reset_status = RCSR;
 
-		clkdev_add_table(pxa27x_clkregs, ARRAY_SIZE(pxa27x_clkregs));
-
 		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
 			return ret;
 
@@ -469,10 +300,17 @@ static int __init pxa27x_init(void)
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
-		register_syscore_ops(&pxa2xx_clock_syscore_ops);
 
-		pxa_register_device(&pxa27x_device_gpio, &pxa27x_gpio_info);
-		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+		if (!of_have_populated_dt()) {
+			ret = clk_register_clkdev(NULL, NULL,
+						  "pxa27x-gpio");
+			if (!ret)
+				pxa_register_device(&pxa27x_device_gpio,
+						    &pxa27x_gpio_info);
+			if (!ret)
+				ret = platform_add_devices(devices,
+							   ARRAY_SIZE(devices));
+		}
 	}
 
 	return ret;
-- 
2.0.0.rc2
