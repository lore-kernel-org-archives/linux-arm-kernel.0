From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  7 Feb 2015 22:54:03 +0100
Subject: [PATCH 2/2] ARM: pxa: Transition pxa25x, pxa27x,
 pxa3xx to clk framework
In-Reply-To: <1423346043-7391-1-git-send-email-robert.jarzmik@free.fr>
References: <1423346043-7391-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423346043-7391-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Transition the PXA25x, PXA27x and PXA3xx CPUs to the clock framework.
This transition still enables legacy platforms to run without device
tree as before, ie relying on platform data encoded in board specific
files.

This is the last step of clock framework transition for pxa
platforms. It was tested on lubbock (pxa25x), mioa701 (pxa27x) and
zylonite (pxa3xx).

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/Kconfig                 |   2 +-
 arch/arm/mach-pxa/Makefile       |   2 +-
 arch/arm/mach-pxa/clock-pxa2xx.c |  55 ----------
 arch/arm/mach-pxa/clock-pxa3xx.c | 212 ---------------------------------------
 arch/arm/mach-pxa/clock.c        |  86 ----------------
 arch/arm/mach-pxa/clock.h        |  80 ---------------
 arch/arm/mach-pxa/eseries.c      |   1 -
 arch/arm/mach-pxa/generic.c      |   2 +
 arch/arm/mach-pxa/generic.h      |   1 +
 arch/arm/mach-pxa/lubbock.c      |   1 -
 arch/arm/mach-pxa/pxa25x.c       |   1 -
 arch/arm/mach-pxa/pxa300.c       |  20 +---
 arch/arm/mach-pxa/pxa320.c       |  10 --
 arch/arm/mach-pxa/pxa3xx.c       |  59 -----------
 arch/arm/mach-pxa/raumfeld.c     |   1 -
 arch/arm/mach-pxa/tosa.c         |   1 -
 16 files changed, 6 insertions(+), 528 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/clock-pxa2xx.c
 delete mode 100644 arch/arm/mach-pxa/clock-pxa3xx.c
 delete mode 100644 arch/arm/mach-pxa/clock.c
 delete mode 100644 arch/arm/mach-pxa/clock.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0eede73..bb358d2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -613,7 +613,7 @@ config ARCH_PXA
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
diff --git a/arch/arm/mach-pxa/clock-pxa2xx.c b/arch/arm/mach-pxa/clock-pxa2xx.c
deleted file mode 100644
index 9ee2ad6..0000000
--- a/arch/arm/mach-pxa/clock-pxa2xx.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * linux/arch/arm/mach-pxa/clock-pxa2xx.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/syscore_ops.h>
-
-#include <mach/pxa2xx-regs.h>
-
-#include "clock.h"
-
-void clk_pxa2xx_cken_enable(struct clk *clk)
-{
-	CKEN |= 1 << clk->cken;
-}
-
-void clk_pxa2xx_cken_disable(struct clk *clk)
-{
-	CKEN &= ~(1 << clk->cken);
-}
-
-const struct clkops clk_pxa2xx_cken_ops = {
-	.enable		= clk_pxa2xx_cken_enable,
-	.disable	= clk_pxa2xx_cken_disable,
-};
-
-#ifdef CONFIG_PM
-static uint32_t saved_cken;
-
-static int pxa2xx_clock_suspend(void)
-{
-	saved_cken = CKEN;
-	return 0;
-}
-
-static void pxa2xx_clock_resume(void)
-{
-	CKEN = saved_cken;
-}
-#else
-#define pxa2xx_clock_suspend	NULL
-#define pxa2xx_clock_resume	NULL
-#endif
-
-struct syscore_ops pxa2xx_clock_syscore_ops = {
-	.suspend	= pxa2xx_clock_suspend,
-	.resume		= pxa2xx_clock_resume,
-};
diff --git a/arch/arm/mach-pxa/clock-pxa3xx.c b/arch/arm/mach-pxa/clock-pxa3xx.c
deleted file mode 100644
index d4e9499..0000000
--- a/arch/arm/mach-pxa/clock-pxa3xx.c
+++ /dev/null
@@ -1,212 +0,0 @@
-/*
- * linux/arch/arm/mach-pxa/clock-pxa3xx.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/syscore_ops.h>
-
-#include <mach/smemc.h>
-#include <mach/pxa3xx-regs.h>
-
-#include "clock.h"
-
-/* Crystal clock: 13MHz */
-#define BASE_CLK	13000000
-
-/* Ring Oscillator Clock: 60MHz */
-#define RO_CLK		60000000
-
-#define ACCR_D0CS	(1 << 26)
-#define ACCR_PCCE	(1 << 11)
-
-/* crystal frequency to HSIO bus frequency multiplier (HSS) */
-static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
-
-/*
- * Get the clock frequency as reflected by CCSR and the turbo flag.
- * We assume these values have been applied via a fcs.
- * If info is not 0 we also display the current settings.
- */
-unsigned int pxa3xx_get_clk_frequency_khz(int info)
-{
-	unsigned long acsr, xclkcfg;
-	unsigned int t, xl, xn, hss, ro, XL, XN, CLK, HSS;
-
-	/* Read XCLKCFG register turbo bit */
-	__asm__ __volatile__("mrc\tp14, 0, %0, c6, c0, 0" : "=r"(xclkcfg));
-	t = xclkcfg & 0x1;
-
-	acsr = ACSR;
-
-	xl  = acsr & 0x1f;
-	xn  = (acsr >> 8) & 0x7;
-	hss = (acsr >> 14) & 0x3;
-
-	XL = xl * BASE_CLK;
-	XN = xn * XL;
-
-	ro = acsr & ACCR_D0CS;
-
-	CLK = (ro) ? RO_CLK : ((t) ? XN : XL);
-	HSS = (ro) ? RO_CLK : hss_mult[hss] * BASE_CLK;
-
-	if (info) {
-		pr_info("RO Mode clock: %d.%02dMHz (%sactive)\n",
-			RO_CLK / 1000000, (RO_CLK % 1000000) / 10000,
-			(ro) ? "" : "in");
-		pr_info("Run Mode clock: %d.%02dMHz (*%d)\n",
-			XL / 1000000, (XL % 1000000) / 10000, xl);
-		pr_info("Turbo Mode clock: %d.%02dMHz (*%d, %sactive)\n",
-			XN / 1000000, (XN % 1000000) / 10000, xn,
-			(t) ? "" : "in");
-		pr_info("HSIO bus clock: %d.%02dMHz\n",
-			HSS / 1000000, (HSS % 1000000) / 10000);
-	}
-
-	return CLK / 1000;
-}
-
-/*
- * Return the current AC97 clock frequency.
- */
-static unsigned long clk_pxa3xx_ac97_getrate(struct clk *clk)
-{
-	unsigned long rate = 312000000;
-	unsigned long ac97_div;
-
-	ac97_div = AC97_DIV;
-
-	/* This may loose precision for some rates but won't for the
-	 * standard 24.576MHz.
-	 */
-	rate /= (ac97_div >> 12) & 0x7fff;
-	rate *= (ac97_div & 0xfff);
-
-	return rate;
-}
-
-/*
- * Return the current HSIO bus clock frequency
- */
-static unsigned long clk_pxa3xx_hsio_getrate(struct clk *clk)
-{
-	unsigned long acsr;
-	unsigned int hss, hsio_clk;
-
-	acsr = ACSR;
-
-	hss = (acsr >> 14) & 0x3;
-	hsio_clk = (acsr & ACCR_D0CS) ? RO_CLK : hss_mult[hss] * BASE_CLK;
-
-	return hsio_clk;
-}
-
-/* crystal frequency to static memory controller multiplier (SMCFS) */
-static unsigned int smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
-static unsigned int df_clkdiv[4] = { 1, 2, 4, 1 };
-
-static unsigned long clk_pxa3xx_smemc_getrate(struct clk *clk)
-{
-	unsigned long acsr = ACSR;
-	unsigned long memclkcfg = __raw_readl(MEMCLKCFG);
-
-	return BASE_CLK * smcfs_mult[(acsr >> 23) & 0x7] /
-			df_clkdiv[(memclkcfg >> 16) & 0x3];
-}
-
-void clk_pxa3xx_cken_enable(struct clk *clk)
-{
-	unsigned long mask = 1ul << (clk->cken & 0x1f);
-
-	if (clk->cken < 32)
-		CKENA |= mask;
-	else if (clk->cken < 64)
-		CKENB |= mask;
-	else
-		CKENC |= mask;
-}
-
-void clk_pxa3xx_cken_disable(struct clk *clk)
-{
-	unsigned long mask = 1ul << (clk->cken & 0x1f);
-
-	if (clk->cken < 32)
-		CKENA &= ~mask;
-	else if (clk->cken < 64)
-		CKENB &= ~mask;
-	else
-		CKENC &= ~mask;
-}
-
-const struct clkops clk_pxa3xx_cken_ops = {
-	.enable		= clk_pxa3xx_cken_enable,
-	.disable	= clk_pxa3xx_cken_disable,
-};
-
-const struct clkops clk_pxa3xx_hsio_ops = {
-	.enable		= clk_pxa3xx_cken_enable,
-	.disable	= clk_pxa3xx_cken_disable,
-	.getrate	= clk_pxa3xx_hsio_getrate,
-};
-
-const struct clkops clk_pxa3xx_ac97_ops = {
-	.enable		= clk_pxa3xx_cken_enable,
-	.disable	= clk_pxa3xx_cken_disable,
-	.getrate	= clk_pxa3xx_ac97_getrate,
-};
-
-const struct clkops clk_pxa3xx_smemc_ops = {
-	.enable		= clk_pxa3xx_cken_enable,
-	.disable	= clk_pxa3xx_cken_disable,
-	.getrate	= clk_pxa3xx_smemc_getrate,
-};
-
-static void clk_pout_enable(struct clk *clk)
-{
-	OSCC |= OSCC_PEN;
-}
-
-static void clk_pout_disable(struct clk *clk)
-{
-	OSCC &= ~OSCC_PEN;
-}
-
-const struct clkops clk_pxa3xx_pout_ops = {
-	.enable		= clk_pout_enable,
-	.disable	= clk_pout_disable,
-};
-
-#ifdef CONFIG_PM
-static uint32_t cken[2];
-static uint32_t accr;
-
-static int pxa3xx_clock_suspend(void)
-{
-	cken[0] = CKENA;
-	cken[1] = CKENB;
-	accr = ACCR;
-	return 0;
-}
-
-static void pxa3xx_clock_resume(void)
-{
-	ACCR = accr;
-	CKENA = cken[0];
-	CKENB = cken[1];
-}
-#else
-#define pxa3xx_clock_suspend	NULL
-#define pxa3xx_clock_resume	NULL
-#endif
-
-struct syscore_ops pxa3xx_clock_syscore_ops = {
-	.suspend	= pxa3xx_clock_suspend,
-	.resume		= pxa3xx_clock_resume,
-};
diff --git a/arch/arm/mach-pxa/clock.c b/arch/arm/mach-pxa/clock.c
deleted file mode 100644
index 4d46610..0000000
--- a/arch/arm/mach-pxa/clock.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- *  linux/arch/arm/mach-sa1100/clock.c
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/spinlock.h>
-#include <linux/delay.h>
-#include <linux/clkdev.h>
-
-#include "clock.h"
-
-static DEFINE_SPINLOCK(clocks_lock);
-
-int clk_enable(struct clk *clk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&clocks_lock, flags);
-	if (clk->enabled++ == 0)
-		clk->ops->enable(clk);
-	spin_unlock_irqrestore(&clocks_lock, flags);
-
-	if (clk->delay)
-		udelay(clk->delay);
-
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-	unsigned long flags;
-
-	WARN_ON(clk->enabled == 0);
-
-	spin_lock_irqsave(&clocks_lock, flags);
-	if (--clk->enabled == 0)
-		clk->ops->disable(clk);
-	spin_unlock_irqrestore(&clocks_lock, flags);
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	unsigned long rate;
-
-	rate = clk->rate;
-	if (clk->ops->getrate)
-		rate = clk->ops->getrate(clk);
-
-	return rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long flags;
-	int ret = -EINVAL;
-
-	if (clk->ops->setrate) {
-		spin_lock_irqsave(&clocks_lock, flags);
-		ret = clk->ops->setrate(clk, rate);
-		spin_unlock_irqrestore(&clocks_lock, flags);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_rate);
-
-void clk_dummy_enable(struct clk *clk)
-{
-}
-
-void clk_dummy_disable(struct clk *clk)
-{
-}
-
-const struct clkops clk_dummy_ops = {
-	.enable		= clk_dummy_enable,
-	.disable	= clk_dummy_disable,
-};
-
-struct clk clk_dummy = {
-	.ops		= &clk_dummy_ops,
-};
diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
deleted file mode 100644
index 1f65d32..0000000
--- a/arch/arm/mach-pxa/clock.h
+++ /dev/null
@@ -1,80 +0,0 @@
-#include <linux/clkdev.h>
-#include <linux/syscore_ops.h>
-
-struct clkops {
-	void			(*enable)(struct clk *);
-	void			(*disable)(struct clk *);
-	unsigned long		(*getrate)(struct clk *);
-	int			(*setrate)(struct clk *, unsigned long);
-};
-
-struct clk {
-	const struct clkops	*ops;
-	unsigned long		rate;
-	unsigned int		cken;
-	unsigned int		delay;
-	unsigned int		enabled;
-};
-
-void clk_dummy_enable(struct clk *);
-void clk_dummy_disable(struct clk *);
-
-extern const struct clkops clk_dummy_ops;
-extern struct clk clk_dummy;
-
-#define INIT_CLKREG(_clk,_devname,_conname)		\
-	{						\
-		.clk		= _clk,			\
-		.dev_id		= _devname,		\
-		.con_id		= _conname,		\
-	}
-
-#define DEFINE_CK(_name, _cken, _ops)			\
-struct clk clk_##_name = {				\
-		.ops	= _ops,				\
-		.cken	= CKEN_##_cken,			\
-	}
-
-#define DEFINE_CLK(_name, _ops, _rate, _delay)		\
-struct clk clk_##_name = {				\
-		.ops	= _ops, 			\
-		.rate	= _rate,			\
-		.delay	= _delay,			\
-	}
-
-#define DEFINE_PXA2_CKEN(_name, _cken, _rate, _delay)	\
-struct clk clk_##_name = {				\
-		.ops	= &clk_pxa2xx_cken_ops,		\
-		.rate	= _rate,			\
-		.cken	= CKEN_##_cken,			\
-		.delay	= _delay,			\
-	}
-
-extern const struct clkops clk_pxa2xx_cken_ops;
-
-void clk_pxa2xx_cken_enable(struct clk *clk);
-void clk_pxa2xx_cken_disable(struct clk *clk);
-
-extern struct syscore_ops pxa2xx_clock_syscore_ops;
-
-#if defined(CONFIG_PXA3xx)
-#define DEFINE_PXA3_CKEN(_name, _cken, _rate, _delay)	\
-struct clk clk_##_name = {				\
-		.ops	= &clk_pxa3xx_cken_ops,		\
-		.rate	= _rate,			\
-		.cken	= CKEN_##_cken,			\
-		.delay	= _delay,			\
-	}
-
-extern const struct clkops clk_pxa3xx_cken_ops;
-extern const struct clkops clk_pxa3xx_hsio_ops;
-extern const struct clkops clk_pxa3xx_ac97_ops;
-extern const struct clkops clk_pxa3xx_pout_ops;
-extern const struct clkops clk_pxa3xx_smemc_ops;
-
-extern void clk_pxa3xx_cken_enable(struct clk *);
-extern void clk_pxa3xx_cken_disable(struct clk *);
-
-extern struct syscore_ops pxa3xx_clock_syscore_ops;
-
-#endif
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 9522265..11863be 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -40,7 +40,6 @@
 
 #include "devices.h"
 #include "generic.h"
-#include "clock.h"
 
 /* Only e800 has 128MB RAM */
 void __init eseries_fixup(struct tag *tags, char **cmdline)
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
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index b742708..53b1d25 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -56,7 +56,6 @@
 #include <mach/smemc.h>
 
 #include "generic.h"
-#include "clock.h"
 #include "devices.h"
 
 static unsigned long lubbock_pin_config[] __initdata = {
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 70e6d0e..23a90c6 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -38,7 +38,6 @@
 
 #include "generic.h"
 #include "devices.h"
-#include "clock.h"
 
 /*
  * Various clock factors driven by the CCCR register.
diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
index 17cbc0c..28c5b56 100644
--- a/arch/arm/mach-pxa/pxa300.c
+++ b/arch/arm/mach-pxa/pxa300.c
@@ -22,7 +22,6 @@
 
 #include "generic.h"
 #include "devices.h"
-#include "clock.h"
 
 static struct mfp_addr_map pxa300_mfp_addr_map[] __initdata = {
 
@@ -84,32 +83,15 @@ static struct mfp_addr_map pxa310_mfp_addr_map[] __initdata = {
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
index 6dc99d4..2f55bb4 100644
--- a/arch/arm/mach-pxa/pxa320.c
+++ b/arch/arm/mach-pxa/pxa320.c
@@ -22,7 +22,6 @@
 
 #include "generic.h"
 #include "devices.h"
-#include "clock.h"
 
 static struct mfp_addr_map pxa320_mfp_addr_map[] __initdata = {
 
@@ -78,20 +77,11 @@ static struct mfp_addr_map pxa320_mfp_addr_map[] __initdata = {
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
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index a762b23..2bc9a3f 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -56,7 +56,6 @@
 
 #include "generic.h"
 #include "devices.h"
-#include "clock.h"
 
 /* common GPIO	definitions */
 
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 7780d1fa..93bf4ef 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -58,7 +58,6 @@
 #include <asm/mach/sharpsl_param.h>
 
 #include "generic.h"
-#include "clock.h"
 #include "devices.h"
 
 static unsigned long tosa_pin_config[] = {
-- 
2.1.0
