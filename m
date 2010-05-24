From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 24 May 2010 14:06:43 +0200
Subject: [PATCH] ARM: ux500 MTU clockrate correction
Message-ID: <1274702803-27908-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adjusts the clockrate for the MTU timer. On the different
UX500 variants this rate is different. The platform can also have
been set up at hardware initialization, bootloader or early init
for different clock speeds. To have the clock framework available
early so the timers can use them, the clock initialization for
Nomadik and ux500 is moved to IRQ init time. A custom per-clock
callback is added to handle special cases like this.

This solves a user-visible bug: without this patch the current
UX500 platforms will not be synchronized to wall-clock time and
the platform will drift in time.

Acked-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-nomadik/clock.c    |   11 +++--
 arch/arm/mach-nomadik/clock.h    |    2 +
 arch/arm/mach-nomadik/cpu-8815.c |    8 +++
 arch/arm/mach-ux500/clock.c      |  104 +++++++++++++++++++++++++++++++++++--
 arch/arm/mach-ux500/clock.h      |   22 ++++++++
 arch/arm/mach-ux500/cpu.c        |    6 ++
 arch/arm/plat-nomadik/timer.c    |   26 +++++++++-
 7 files changed, 167 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-nomadik/clock.c b/arch/arm/mach-nomadik/clock.c
index 60f5bee..96b62b3 100644
--- a/arch/arm/mach-nomadik/clock.c
+++ b/arch/arm/mach-nomadik/clock.c
@@ -32,7 +32,10 @@ void clk_disable(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_disable);
 
-/* We have a fixed clock alone, for now */
+static struct clk clk_24 = {
+	.rate = 2400000,
+};
+
 static struct clk clk_48 = {
 	.rate = 48 * 1000 * 1000,
 };
@@ -50,6 +53,8 @@ static struct clk clk_default;
 	}
 
 static struct clk_lookup lookups[] = {
+	CLK(&clk_24, "mtu0"),
+	CLK(&clk_24, "mtu1"),
 	CLK(&clk_48, "uart0"),
 	CLK(&clk_48, "uart1"),
 	CLK(&clk_default, "gpio.0"),
@@ -58,10 +63,8 @@ static struct clk_lookup lookups[] = {
 	CLK(&clk_default, "gpio.3"),
 };
 
-static int __init clk_init(void)
+int __init clk_init(void)
 {
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 	return 0;
 }
-
-arch_initcall(clk_init);
diff --git a/arch/arm/mach-nomadik/clock.h b/arch/arm/mach-nomadik/clock.h
index 5563985..78da2e7 100644
--- a/arch/arm/mach-nomadik/clock.h
+++ b/arch/arm/mach-nomadik/clock.h
@@ -11,3 +11,5 @@
 struct clk {
 	unsigned long		rate;
 };
+
+int __init clk_init(void);
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 91c3c90..ac58e3b 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -31,6 +31,8 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#include "clock.h"
+
 #define __MEM_4K_RESOURCE(x) \
 	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
 
@@ -143,6 +145,12 @@ void __init cpu8815_init_irq(void)
 	/* This modified VIC cell has two register blocks, at 0 and 0x20 */
 	vic_init(io_p2v(NOMADIK_IC_BASE + 0x00), IRQ_VIC_START +  0, ~0, 0);
 	vic_init(io_p2v(NOMADIK_IC_BASE + 0x20), IRQ_VIC_START + 32, ~0, 0);
+
+	/*
+	 * Init clocks here so that they are available for system timer
+	 * initialization.
+	 */
+	clk_init();
 }
 
 /*
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 6544855..fe84b90 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -16,6 +16,7 @@
 
 #include <asm/clkdev.h>
 
+#include <plat/mtu.h>
 #include <mach/hardware.h>
 #include "clock.h"
 
@@ -59,6 +60,9 @@
 #define PRCM_DMACLK_MGT		0x074
 #define PRCM_B2R2CLK_MGT	0x078
 #define PRCM_TVCLK_MGT		0x07C
+#define PRCM_TCR		0x1C8
+#define PRCM_TCR_STOPPED	(1 << 16)
+#define PRCM_TCR_DOZE_MODE	(1 << 17)
 #define PRCM_UNIPROCLK_MGT	0x278
 #define PRCM_SSPCLK_MGT		0x280
 #define PRCM_RNGCLK_MGT		0x284
@@ -120,10 +124,95 @@ void clk_disable(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_disable);
 
+/*
+ * The MTU has a separate, rather complex muxing setup
+ * with alternative parents (peripheral cluster or
+ * ULP or fixed 32768 Hz) depending on settings
+ */
+static unsigned long clk_mtu_get_rate(struct clk *clk)
+{
+	void __iomem *addr = __io_address(U8500_PRCMU_BASE)
+		+ PRCM_TCR;
+	u32 tcr = readl(addr);
+	int mtu = (int) clk->data;
+	/*
+	 * One of these is selected eventually
+	 * TODO: Replace the constant with a reference
+	 * to the ULP source once this is modeled.
+	 */
+	unsigned long clk32k = 32768;
+	unsigned long mturate;
+	unsigned long retclk;
+
+	/* Get the rate from the parent as a default */
+	if (clk->parent_periph)
+		mturate = clk_get_rate(clk->parent_periph);
+	else if (clk->parent_cluster)
+		mturate = clk_get_rate(clk->parent_cluster);
+	else
+		/* We need to be connected SOMEWHERE */
+		BUG();
+
+	/*
+	 * Are we in doze mode?
+	 * In this mode the parent peripheral or the fixed 32768 Hz
+	 * clock is fed into the block.
+	 */
+	if (!(tcr & PRCM_TCR_DOZE_MODE)) {
+		/*
+		 * Here we're using the clock input from the APE ULP
+		 * clock domain. But first: are the timers stopped?
+		 */
+		if (tcr & PRCM_TCR_STOPPED) {
+			clk32k = 0;
+			mturate = 0;
+		} else {
+			/* Else default mode: 0 and 2.4 MHz */
+			clk32k = 0;
+			if (cpu_is_u5500())
+				/* DB5500 divides by 8 */
+				mturate /= 8;
+			else if (cpu_is_u8500ed()) {
+				/*
+				 * This clocking setting must not be used
+				 * in the ED chip, it is simply not
+				 * connected anywhere!
+				 */
+				mturate = 0;
+				BUG();
+			} else
+				/*
+				 * In this mode the ulp38m4 clock is divided
+				 * by a factor 16, on the DB8500 typically
+				 * 38400000 / 16 ~ 2.4 MHz.
+				 * TODO: Replace the constant with a reference
+				 * to the ULP source once this is modeled.
+				 */
+				mturate = 38400000 / 16;
+		}
+	}
+
+	/* Return the clock selected for this MTU */
+	if (tcr & (1 << mtu))
+		retclk = clk32k;
+	else
+		retclk = mturate;
+
+	pr_info("MTU%d clock rate: %lu Hz\n", mtu, retclk);
+	return retclk;
+}
+
 unsigned long clk_get_rate(struct clk *clk)
 {
 	unsigned long rate;
 
+	/*
+	 * If there is a custom getrate callback for this clock,
+	 * it will take precedence.
+	 */
+	if (clk->get_rate)
+		return clk->get_rate(clk);
+
 	if (clk->ops && clk->ops->get_rate)
 		return clk->ops->get_rate(clk);
 
@@ -341,8 +430,9 @@ static DEFINE_PRCC_CLK(5, usb_v1, 	0,  0, NULL);
 
 /* Peripheral Cluster #6 */
 
-static DEFINE_PRCC_CLK(6, mtu1_v1, 	8, -1, NULL);
-static DEFINE_PRCC_CLK(6, mtu0_v1, 	7, -1, NULL);
+/* MTU ID in data */
+static DEFINE_PRCC_CLK_CUSTOM(6, mtu1_v1, 8, -1, NULL, clk_mtu_get_rate, 1);
+static DEFINE_PRCC_CLK_CUSTOM(6, mtu0_v1, 7, -1, NULL, clk_mtu_get_rate, 0);
 static DEFINE_PRCC_CLK(6, cfgreg_v1, 	6,  6, NULL);
 static DEFINE_PRCC_CLK(6, dmc_ed, 	6,  6, NULL);
 static DEFINE_PRCC_CLK(6, hash1, 	5, -1, NULL);
@@ -357,8 +447,9 @@ static DEFINE_PRCC_CLK(6, rng_v1, 	0,  0, &clk_rngclk);
 /* Peripheral Cluster #7 */
 
 static DEFINE_PRCC_CLK(7, tzpc0_ed, 	4, -1, NULL);
-static DEFINE_PRCC_CLK(7, mtu1_ed, 	3, -1, NULL);
-static DEFINE_PRCC_CLK(7, mtu0_ed, 	2, -1, NULL);
+/* MTU ID in data */
+static DEFINE_PRCC_CLK_CUSTOM(7, mtu1_ed, 3, -1, NULL, clk_mtu_get_rate, 1);
+static DEFINE_PRCC_CLK_CUSTOM(7, mtu0_ed, 2, -1, NULL, clk_mtu_get_rate, 0);
 static DEFINE_PRCC_CLK(7, wdg_ed, 	1, -1, NULL);
 static DEFINE_PRCC_CLK(7, cfgreg_ed, 	0, -1, NULL);
 
@@ -503,15 +594,17 @@ static struct clk_lookup u8500_v1_clks[] = {
 	CLK(uiccclk,	"uicc",		NULL),
 };
 
-static int __init clk_init(void)
+int __init clk_init(void)
 {
 	if (cpu_is_u8500ed()) {
 		clk_prcmu_ops.enable = clk_prcmu_ed_enable;
 		clk_prcmu_ops.disable = clk_prcmu_ed_disable;
+		clk_per6clk.rate = 100000000;
 	} else if (cpu_is_u5500()) {
 		/* Clock tree for U5500 not implemented yet */
 		clk_prcc_ops.enable = clk_prcc_ops.disable = NULL;
 		clk_prcmu_ops.enable = clk_prcmu_ops.disable = NULL;
+		clk_per6clk.rate = 26000000;
 	}
 
 	clkdev_add_table(u8500_common_clks, ARRAY_SIZE(u8500_common_clks));
@@ -522,4 +615,3 @@ static int __init clk_init(void)
 
 	return 0;
 }
-arch_initcall(clk_init);
diff --git a/arch/arm/mach-ux500/clock.h b/arch/arm/mach-ux500/clock.h
index e4f99b6..a058025 100644
--- a/arch/arm/mach-ux500/clock.h
+++ b/arch/arm/mach-ux500/clock.h
@@ -28,6 +28,9 @@ struct clkops {
  * @ops:		pointer to clkops struct used to control this clock
  * @name:		name, for debugging
  * @enabled:		refcount. positive if enabled, zero if disabled
+ * @get_rate:		custom callback for getting the clock rate
+ * @data:		custom per-clock data for example for the get_rate
+ *			callback
  * @rate:		fixed rate for clocks which don't implement
  * 			ops->getrate
  * @prcmu_cg_off:	address offset of the combined enable/disable register
@@ -67,6 +70,8 @@ struct clk {
 	const struct clkops	*ops;
 	const char 		*name;
 	unsigned int		enabled;
+	unsigned long		(*get_rate)(struct clk *);
+	void			*data;
 
 	unsigned long		rate;
 	struct list_head	list;
@@ -117,9 +122,26 @@ struct clk clk_##_name = {						\
 		.parent_periph 	= _kernclk				\
 	}
 
+#define DEFINE_PRCC_CLK_CUSTOM(_pclust, _name, _bus_en, _kernel_en, _kernclk, _callback, _data) \
+struct clk clk_##_name = {						\
+		.name		= #_name,				\
+		.ops		= &clk_prcc_ops,			\
+		.cluster	= _pclust,				\
+		.prcc_bus	= _bus_en,				\
+		.prcc_kernel	= _kernel_en,				\
+		.parent_cluster = &clk_per##_pclust##clk,		\
+		.parent_periph	= _kernclk,				\
+		.get_rate	= _callback,				\
+		.data		= (void *) _data			\
+	}
+
+
 #define CLK(_clk, _devname, _conname)			\
 	{						\
 		.clk	= &clk_##_clk,			\
 		.dev_id	= _devname,			\
 		.con_id = _conname,			\
 	}
+
+int __init clk_db8500_ed_fixup(void);
+int __init clk_init(void);
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index d81ad02..e0fd747 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -62,6 +62,12 @@ void __init ux500_init_irq(void)
 {
 	gic_dist_init(0, __io_address(UX500_GIC_DIST_BASE), 29);
 	gic_cpu_init(0, __io_address(UX500_GIC_CPU_BASE));
+
+	/*
+	 * Init clocks here so that they are available for system timer
+	 * initialization.
+	 */
+	clk_init();
 }
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 0ff3798..08aaa4a 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -13,7 +13,9 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/clockchips.h>
+#include <linux/clk.h>
 #include <linux/jiffies.h>
+#include <linux/err.h>
 #include <asm/mach/time.h>
 
 #include <plat/mtu.h>
@@ -124,13 +126,25 @@ static struct irqaction nmdk_timer_irq = {
 void __init nmdk_timer_init(void)
 {
 	unsigned long rate;
-	u32 cr = MTU_CRn_32BITS;;
+	struct clk *clk0;
+	struct clk *clk1;
+	u32 cr;
+
+	clk0 = clk_get_sys("mtu0", NULL);
+	BUG_ON(IS_ERR(clk0));
+
+	clk1 = clk_get_sys("mtu1", NULL);
+	BUG_ON(IS_ERR(clk1));
+
+	clk_enable(clk0);
+	clk_enable(clk1);
 
 	/*
 	 * Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:
 	 * use a divide-by-16 counter if it's more than 16MHz
 	 */
-	rate = CLOCK_TICK_RATE;
+	cr = MTU_CRn_32BITS;;
+	rate = clk_get_rate(clk0);
 	if (rate > 16 << 20) {
 		rate /= 16;
 		cr |= MTU_CRn_PRESCALE_16;
@@ -153,6 +167,14 @@ void __init nmdk_timer_init(void)
 		       nmdk_clksrc.name);
 
 	/* Timer 1 is used for events, fix according to rate */
+	cr = MTU_CRn_32BITS;
+	rate = clk_get_rate(clk1);
+	if (rate > 16 << 20) {
+		rate /= 16;
+		cr |= MTU_CRn_PRESCALE_16;
+	} else {
+		cr |= MTU_CRn_PRESCALE_1;
+	}
 	writel(cr | MTU_CRn_ONESHOT, mtu_base + MTU_CR(1)); /* off, currently */
 	nmdk_clkevt.mult = div_sc(rate, NSEC_PER_SEC, nmdk_clkevt.shift);
 	nmdk_clkevt.max_delta_ns =
-- 
1.6.3.3
