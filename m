From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 May 2017 22:17:04 +0200
Subject: [PATCH 7/8 v2] clocksource/drivers/fttmr010: Merge Moxa into FTTMR010
In-Reply-To: <20170518201705.28790-1-linus.walleij@linaro.org>
References: <20170518201705.28790-1-linus.walleij@linaro.org>
Message-ID: <20170518201705.28790-7-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This merges the Moxa Art timer driver into the Faraday FTTMR010
driver and replaces all Kconfig symbols to use the Faraday
driver instead. We are now so similar that the drivers can
be merged by just adding a few lines to the Faraday timer.

Differences:

- The Faraday driver explicitly sets the counter to count
  upwards for the clocksource, removing the need for the
  clocksource core to invert the value.

- The Faraday driver also handles sched_clock()

On the Aspeed, the counter can only count downwards, so support
the timers in downward-counting mode as well, and flag the
Aspeed to use this mode. This mode was tested on the Gemini so
I have high hopes that it'll work fine on the Aspeed as well.

After this we have one driver for all three SoCs and a generic
Faraday FTTMR010 timer driver, which is nice.

Cc: Joel Stanley <joel@jms.id.au>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- As it appears that the Aspeed timers can only count downwards,
  augment the code to deal with downward counting clockevent,
  clock source and sched_clock(), and flag the Aspeed for this
  mode.

ARM SoC folks: please ACK this so it can be merged with in the
clocksource subsystem once it works.

Joel: it would be super if you can test this. If you have some
vendor tree or similar that actually indicates where the
up/down counter bits are it's even better, but I'm hoping that
this half-assed guesswork will JustWork(TM) (yeah, famous
last words, sorry...)
---
 arch/arm/mach-aspeed/Kconfig         |   2 +-
 arch/arm/mach-moxart/Kconfig         |   2 +-
 drivers/clocksource/Kconfig          |   7 -
 drivers/clocksource/Makefile         |   1 -
 drivers/clocksource/moxart_timer.c   | 256 -----------------------------------
 drivers/clocksource/timer-fttmr010.c | 143 ++++++++++++++-----
 6 files changed, 108 insertions(+), 303 deletions(-)
 delete mode 100644 drivers/clocksource/moxart_timer.c

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index f3f8c5c658db..2d5570e6e186 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -4,7 +4,7 @@ menuconfig ARCH_ASPEED
 	select SRAM
 	select WATCHDOG
 	select ASPEED_WATCHDOG
-	select MOXART_TIMER
+	select FTTMR010_TIMER
 	select MFD_SYSCON
 	select PINCTRL
 	help
diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
index 70db2abf6163..a4a91f9a3301 100644
--- a/arch/arm/mach-moxart/Kconfig
+++ b/arch/arm/mach-moxart/Kconfig
@@ -4,7 +4,7 @@ menuconfig ARCH_MOXART
 	select CPU_FA526
 	select ARM_DMA_MEM_BUFFERABLE
 	select FARADAY_FTINTC010
-	select MOXART_TIMER
+	select FTTMR010_TIMER
 	select GPIOLIB
 	select PHYLIB if NETDEVICES
 	help
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 545d541ae20e..1b22ade4c8f1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -188,13 +188,6 @@ config ATLAS7_TIMER
 	help
 	  Enables support for the Atlas7 timer.
 
-config MOXART_TIMER
-	bool "Moxart timer driver" if COMPILE_TEST
-	depends on GENERIC_CLOCKEVENTS
-	select CLKSRC_MMIO
-	help
-	  Enables support for the Moxart timer.
-
 config MXS_TIMER
 	bool "Mxs timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 2b5b56a6f00f..cf0c30b6ec1f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
 obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
-obj-$(CONFIG_MOXART_TIMER)	+= moxart_timer.o
 obj-$(CONFIG_MXS_TIMER)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
 obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
diff --git a/drivers/clocksource/moxart_timer.c b/drivers/clocksource/moxart_timer.c
deleted file mode 100644
index 7f3430654fbd..000000000000
--- a/drivers/clocksource/moxart_timer.c
+++ /dev/null
@@ -1,256 +0,0 @@
-/*
- * MOXA ART SoCs timer handling.
- *
- * Copyright (C) 2013 Jonas Jensen
- *
- * Jonas Jensen <jonas.jensen@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqreturn.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/clocksource.h>
-#include <linux/bitops.h>
-#include <linux/slab.h>
-
-#define TIMER1_BASE		0x00
-#define TIMER2_BASE		0x10
-#define TIMER3_BASE		0x20
-
-#define REG_COUNT		0x0 /* writable */
-#define REG_LOAD		0x4
-#define REG_MATCH1		0x8
-#define REG_MATCH2		0xC
-
-#define TIMER_CR		0x30
-#define TIMER_INTR_STATE	0x34
-#define TIMER_INTR_MASK		0x38
-
-/*
- * Moxart TIMER_CR flags:
- *
- * MOXART_CR_*_CLOCK	0: PCLK, 1: EXT1CLK
- * MOXART_CR_*_INT	overflow interrupt enable bit
- */
-#define MOXART_CR_1_ENABLE	BIT(0)
-#define MOXART_CR_1_CLOCK	BIT(1)
-#define MOXART_CR_1_INT	BIT(2)
-#define MOXART_CR_2_ENABLE	BIT(3)
-#define MOXART_CR_2_CLOCK	BIT(4)
-#define MOXART_CR_2_INT	BIT(5)
-#define MOXART_CR_3_ENABLE	BIT(6)
-#define MOXART_CR_3_CLOCK	BIT(7)
-#define MOXART_CR_3_INT	BIT(8)
-#define MOXART_CR_COUNT_UP	BIT(9)
-
-#define MOXART_TIMER1_ENABLE	(MOXART_CR_2_ENABLE | MOXART_CR_1_ENABLE)
-#define MOXART_TIMER1_DISABLE	(MOXART_CR_2_ENABLE)
-
-/*
- * The ASpeed variant of the IP block has a different layout
- * for the control register
- */
-#define ASPEED_CR_1_ENABLE	BIT(0)
-#define ASPEED_CR_1_CLOCK	BIT(1)
-#define ASPEED_CR_1_INT		BIT(2)
-#define ASPEED_CR_2_ENABLE	BIT(4)
-#define ASPEED_CR_2_CLOCK	BIT(5)
-#define ASPEED_CR_2_INT		BIT(6)
-#define ASPEED_CR_3_ENABLE	BIT(8)
-#define ASPEED_CR_3_CLOCK	BIT(9)
-#define ASPEED_CR_3_INT		BIT(10)
-
-#define ASPEED_TIMER1_ENABLE   (ASPEED_CR_2_ENABLE | ASPEED_CR_1_ENABLE)
-#define ASPEED_TIMER1_DISABLE  (ASPEED_CR_2_ENABLE)
-
-struct moxart_timer {
-	void __iomem *base;
-	unsigned int t1_disable_val;
-	unsigned int t1_enable_val;
-	unsigned int count_per_tick;
-	struct clock_event_device clkevt;
-};
-
-static inline struct moxart_timer *to_moxart(struct clock_event_device *evt)
-{
-	return container_of(evt, struct moxart_timer, clkevt);
-}
-
-static inline void moxart_disable(struct clock_event_device *evt)
-{
-	struct moxart_timer *timer = to_moxart(evt);
-
-	writel(timer->t1_disable_val, timer->base + TIMER_CR);
-}
-
-static inline void moxart_enable(struct clock_event_device *evt)
-{
-	struct moxart_timer *timer = to_moxart(evt);
-
-	writel(timer->t1_enable_val, timer->base + TIMER_CR);
-}
-
-static int moxart_shutdown(struct clock_event_device *evt)
-{
-	moxart_disable(evt);
-	return 0;
-}
-
-static int moxart_set_oneshot(struct clock_event_device *evt)
-{
-	moxart_disable(evt);
-	writel(~0, to_moxart(evt)->base + TIMER1_BASE + REG_LOAD);
-	return 0;
-}
-
-static int moxart_set_periodic(struct clock_event_device *evt)
-{
-	struct moxart_timer *timer = to_moxart(evt);
-
-	moxart_disable(evt);
-	writel(timer->count_per_tick, timer->base + TIMER1_BASE + REG_LOAD);
-	writel(0, timer->base + TIMER1_BASE + REG_MATCH1);
-	moxart_enable(evt);
-	return 0;
-}
-
-static int moxart_clkevt_next_event(unsigned long cycles,
-				    struct clock_event_device *evt)
-{
-	struct moxart_timer *timer = to_moxart(evt);
-	u32 u;
-
-	moxart_disable(evt);
-
-	u = readl(timer->base + TIMER1_BASE + REG_COUNT) - cycles;
-	writel(u, timer->base + TIMER1_BASE + REG_MATCH1);
-
-	moxart_enable(evt);
-
-	return 0;
-}
-
-static irqreturn_t moxart_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-	evt->event_handler(evt);
-	return IRQ_HANDLED;
-}
-
-static int __init moxart_timer_init(struct device_node *node)
-{
-	int ret, irq;
-	unsigned long pclk;
-	struct clk *clk;
-	struct moxart_timer *timer;
-
-	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
-	if (!timer)
-		return -ENOMEM;
-
-	timer->base = of_iomap(node, 0);
-	if (!timer->base) {
-		pr_err("%s: of_iomap failed\n", node->full_name);
-		ret = -ENXIO;
-		goto out_free;
-	}
-
-	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0) {
-		pr_err("%s: irq_of_parse_and_map failed\n", node->full_name);
-		ret = -EINVAL;
-		goto out_unmap;
-	}
-
-	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk))  {
-		pr_err("%s: of_clk_get failed\n", node->full_name);
-		ret = PTR_ERR(clk);
-		goto out_unmap;
-	}
-
-	pclk = clk_get_rate(clk);
-
-	if (of_device_is_compatible(node, "moxa,moxart-timer")) {
-		timer->t1_enable_val = MOXART_TIMER1_ENABLE;
-		timer->t1_disable_val = MOXART_TIMER1_DISABLE;
-	} else if (of_device_is_compatible(node, "aspeed,ast2400-timer")) {
-		timer->t1_enable_val = ASPEED_TIMER1_ENABLE;
-		timer->t1_disable_val = ASPEED_TIMER1_DISABLE;
-	} else {
-		pr_err("%s: unknown platform\n", node->full_name);
-		ret = -EINVAL;
-		goto out_unmap;
-	}
-
-	timer->count_per_tick = DIV_ROUND_CLOSEST(pclk, HZ);
-
-	timer->clkevt.name = node->name;
-	timer->clkevt.rating = 200;
-	timer->clkevt.features = CLOCK_EVT_FEAT_PERIODIC |
-					CLOCK_EVT_FEAT_ONESHOT;
-	timer->clkevt.set_state_shutdown = moxart_shutdown;
-	timer->clkevt.set_state_periodic = moxart_set_periodic;
-	timer->clkevt.set_state_oneshot = moxart_set_oneshot;
-	timer->clkevt.tick_resume = moxart_set_oneshot;
-	timer->clkevt.set_next_event = moxart_clkevt_next_event;
-	timer->clkevt.cpumask = cpumask_of(0);
-	timer->clkevt.irq = irq;
-
-	ret = clocksource_mmio_init(timer->base + TIMER2_BASE + REG_COUNT,
-				    "moxart_timer", pclk, 200, 32,
-				    clocksource_mmio_readl_down);
-	if (ret) {
-		pr_err("%s: clocksource_mmio_init failed\n", node->full_name);
-		goto out_unmap;
-	}
-
-	ret = request_irq(irq, moxart_timer_interrupt, IRQF_TIMER,
-			  node->name, &timer->clkevt);
-	if (ret) {
-		pr_err("%s: setup_irq failed\n", node->full_name);
-		goto out_unmap;
-	}
-
-	/* Clear match registers */
-	writel(0, timer->base + TIMER1_BASE + REG_MATCH1);
-	writel(0, timer->base + TIMER1_BASE + REG_MATCH2);
-	writel(0, timer->base + TIMER2_BASE + REG_MATCH1);
-	writel(0, timer->base + TIMER2_BASE + REG_MATCH2);
-
-	/*
-	 * Start timer 2 rolling as our main wall clock source, keep timer 1
-	 * disabled
-	 */
-	writel(0, timer->base + TIMER_CR);
-	writel(~0, timer->base + TIMER2_BASE + REG_LOAD);
-	writel(timer->t1_disable_val, timer->base + TIMER_CR);
-
-	/*
-	 * documentation is not publicly available:
-	 * min_delta / max_delta obtained by trial-and-error,
-	 * max_delta 0xfffffffe should be ok because count
-	 * register size is u32
-	 */
-	clockevents_config_and_register(&timer->clkevt, pclk, 0x4, 0xfffffffe);
-
-	return 0;
-
-out_unmap:
-	iounmap(timer->base);
-out_free:
-	kfree(timer);
-	return ret;
-}
-CLOCKSOURCE_OF_DECLARE(moxart, "moxa,moxart-timer", moxart_timer_init);
-CLOCKSOURCE_OF_DECLARE(aspeed, "aspeed,ast2400-timer", moxart_timer_init);
diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 2d915d1455ab..f8801507a687 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -50,6 +50,20 @@
 #define TIMER_2_CR_UPDOWN	BIT(10)
 #define TIMER_3_CR_UPDOWN	BIT(11)
 
+/*
+ * The Aspeed AST2400 moves bits around in the control register
+ * and lacks bits for setting the timer to count upwards.
+ */
+#define TIMER_1_CR_ASPEED_ENABLE	BIT(0)
+#define TIMER_1_CR_ASPEED_CLOCK		BIT(1)
+#define TIMER_1_CR_ASPEED_INT		BIT(2)
+#define TIMER_2_CR_ASPEED_ENABLE	BIT(4)
+#define TIMER_2_CR_ASPEED_CLOCK		BIT(5)
+#define TIMER_2_CR_ASPEED_INT		BIT(6)
+#define TIMER_3_CR_ASPEED_ENABLE	BIT(8)
+#define TIMER_3_CR_ASPEED_CLOCK		BIT(9)
+#define TIMER_3_CR_ASPEED_INT		BIT(10)
+
 #define TIMER_1_INT_MATCH1	BIT(0)
 #define TIMER_1_INT_MATCH2	BIT(1)
 #define TIMER_1_INT_OVERFLOW	BIT(2)
@@ -64,6 +78,8 @@
 struct fttmr010 {
 	void __iomem *base;
 	unsigned int tick_rate;
+	bool count_down;
+	u32 t1_enable_val;
 	struct clock_event_device clkevt;
 };
 
@@ -77,6 +93,8 @@ static inline struct fttmr010 *to_fttmr010(struct clock_event_device *evt)
 
 static u64 notrace fttmr010_read_sched_clock(void)
 {
+	if (local_fttmr->count_down)
+		return ~readl(local_fttmr->base + TIMER2_COUNT);
 	return readl(local_fttmr->base + TIMER2_COUNT);
 }
 
@@ -86,11 +104,23 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	struct fttmr010 *fttmr010 = to_fttmr010(evt);
 	u32 cr;
 
-	/* Setup the match register */
+	/* Stop */
+	cr = readl(fttmr010->base + TIMER_CR);
+	cr &= ~fttmr010->t1_enable_val;
+	writel(cr, fttmr010->base + TIMER_CR);
+
+	/* Setup the match register forward/backward in time */
 	cr = readl(fttmr010->base + TIMER1_COUNT);
-	writel(cr + cycles, fttmr010->base + TIMER1_MATCH1);
-	if (readl(fttmr010->base + TIMER1_COUNT) - cr > cycles)
-		return -ETIME;
+	if (fttmr010->count_down)
+		cr -= cycles;
+	else
+		cr += cycles;
+	writel(cr, fttmr010->base + TIMER1_MATCH1);
+
+	/* Start */
+	cr = readl(fttmr010->base + TIMER_CR);
+	cr |= fttmr010->t1_enable_val;
+	writel(cr, fttmr010->base + TIMER_CR);
 
 	return 0;
 }
@@ -100,9 +130,9 @@ static int fttmr010_timer_shutdown(struct clock_event_device *evt)
 	struct fttmr010 *fttmr010 = to_fttmr010(evt);
 	u32 cr;
 
-	/* Stop timer and interrupt. */
+	/* Stop */
 	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
+	cr &= ~fttmr010->t1_enable_val;
 	writel(cr, fttmr010->base + TIMER_CR);
 
 	return 0;
@@ -113,14 +143,17 @@ static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
 	struct fttmr010 *fttmr010 = to_fttmr010(evt);
 	u32 cr;
 
-	/* Stop timer and interrupt. */
+	/* Stop */
 	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
+	cr &= ~fttmr010->t1_enable_val;
 	writel(cr, fttmr010->base + TIMER_CR);
 
-	/* Setup counter start from 0 */
+	/* Setup counter start from 0 or ~0 */
 	writel(0, fttmr010->base + TIMER1_COUNT);
-	writel(0, fttmr010->base + TIMER1_LOAD);
+	if (fttmr010->count_down)
+		writel(~0, fttmr010->base + TIMER1_LOAD);
+	else
+		writel(0, fttmr010->base + TIMER1_LOAD);
 
 	/* Enable interrupt */
 	cr = readl(fttmr010->base + TIMER_INTR_MASK);
@@ -128,11 +161,6 @@ static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
 	cr |= TIMER_1_INT_MATCH1;
 	writel(cr, fttmr010->base + TIMER_INTR_MASK);
 
-	/* Start the timer */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr |= TIMER_1_CR_ENABLE;
-	writel(cr, fttmr010->base + TIMER_CR);
-
 	return 0;
 }
 
@@ -142,26 +170,30 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
 	u32 period = DIV_ROUND_CLOSEST(fttmr010->tick_rate, HZ);
 	u32 cr;
 
-	/* Stop timer and interrupt */
+	/* Stop */
 	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
+	cr &= ~fttmr010->t1_enable_val;
 	writel(cr, fttmr010->base + TIMER_CR);
 
-	/* Setup timer to fire at 1/HT intervals. */
-	cr = 0xffffffff - (period - 1);
-	writel(cr, fttmr010->base + TIMER1_COUNT);
-	writel(cr, fttmr010->base + TIMER1_LOAD);
-
-	/* enable interrupt on overflow */
-	cr = readl(fttmr010->base + TIMER_INTR_MASK);
-	cr &= ~(TIMER_1_INT_MATCH1 | TIMER_1_INT_MATCH2);
-	cr |= TIMER_1_INT_OVERFLOW;
-	writel(cr, fttmr010->base + TIMER_INTR_MASK);
+	/* Setup timer to fire at 1/HZ intervals. */
+	if (fttmr010->count_down) {
+		writel(period, fttmr010->base + TIMER1_LOAD);
+		writel(0, fttmr010->base + TIMER1_MATCH1);
+	} else {
+		cr = 0xffffffff - (period - 1);
+		writel(cr, fttmr010->base + TIMER1_COUNT);
+		writel(cr, fttmr010->base + TIMER1_LOAD);
+
+		/* Enable interrupt on overflow */
+		cr = readl(fttmr010->base + TIMER_INTR_MASK);
+		cr &= ~(TIMER_1_INT_MATCH1 | TIMER_1_INT_MATCH2);
+		cr |= TIMER_1_INT_OVERFLOW;
+		writel(cr, fttmr010->base + TIMER_INTR_MASK);
+	}
 
 	/* Start the timer */
 	cr = readl(fttmr010->base + TIMER_CR);
-	cr |= TIMER_1_CR_ENABLE;
-	cr |= TIMER_1_CR_INT;
+	cr |= fttmr010->t1_enable_val;
 	writel(cr, fttmr010->base + TIMER_CR);
 
 	return 0;
@@ -181,9 +213,11 @@ static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 static int __init fttmr010_timer_init(struct device_node *np)
 {
 	struct fttmr010 *fttmr010;
+	bool is_ast2400;
 	int irq;
 	struct clk *clk;
 	int ret;
+	u32 val;
 
 	/*
 	 * These implementations require a clock reference.
@@ -223,13 +257,37 @@ static int __init fttmr010_timer_init(struct device_node *np)
 	}
 
 	/*
+	 * The Aspeed AST2400 moves bits around in the control register,
+	 * otherwise it works the same.
+	 */
+	is_ast2400 = of_device_is_compatible(np, "aspeed,ast2400-timer");
+	if (is_ast2400) {
+		fttmr010->t1_enable_val = TIMER_1_CR_ASPEED_ENABLE |
+			TIMER_1_CR_ASPEED_INT;
+		/* Downward not available */
+		fttmr010->count_down = true;
+	} else {
+		fttmr010->t1_enable_val = TIMER_1_CR_ENABLE | TIMER_1_CR_INT;
+	}
+
+	/*
 	 * Reset the interrupt mask and status
 	 */
 	writel(TIMER_INT_ALL_MASK, fttmr010->base + TIMER_INTR_MASK);
 	writel(0, fttmr010->base + TIMER_INTR_STATE);
-	/* Enable timer 1 count up, timer 2 count up */
-	writel((TIMER_1_CR_UPDOWN | TIMER_2_CR_ENABLE | TIMER_2_CR_UPDOWN),
-	       fttmr010->base + TIMER_CR);
+
+	/*
+	 * Enable timer 1 count up, timer 2 count up, except on Aspeed,
+	 * where everything just counts down.
+	 */
+	if (is_ast2400)
+		val = TIMER_2_CR_ASPEED_ENABLE;
+	else {
+		val = TIMER_2_CR_ENABLE;
+		if (!fttmr010->count_down)
+			val |= TIMER_1_CR_UPDOWN | TIMER_2_CR_UPDOWN;
+	}
+	writel(val, fttmr010->base + TIMER_CR);
 
 	/*
 	 * Setup free-running clocksource timer (interrupts
@@ -237,13 +295,22 @@ static int __init fttmr010_timer_init(struct device_node *np)
 	 */
 	local_fttmr = fttmr010;
 	writel(0, fttmr010->base + TIMER2_COUNT);
-	writel(0, fttmr010->base + TIMER2_LOAD);
 	writel(0, fttmr010->base + TIMER2_MATCH1);
 	writel(0, fttmr010->base + TIMER2_MATCH2);
-	clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
-			      "FTTMR010-TIMER2",
-			      fttmr010->tick_rate,
-			      300, 32, clocksource_mmio_readl_up);
+
+	if (fttmr010->count_down) {
+		writel(~0, fttmr010->base + TIMER2_LOAD);
+		clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
+				      "FTTMR010-TIMER2",
+				      fttmr010->tick_rate,
+				      300, 32, clocksource_mmio_readl_down);
+	} else {
+		writel(0, fttmr010->base + TIMER2_LOAD);
+		clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
+				      "FTTMR010-TIMER2",
+				      fttmr010->tick_rate,
+				      300, 32, clocksource_mmio_readl_up);
+	}
 	sched_clock_register(fttmr010_read_sched_clock, 32,
 			     fttmr010->tick_rate);
 
@@ -290,3 +357,5 @@ static int __init fttmr010_timer_init(struct device_node *np)
 }
 CLOCKSOURCE_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
 CLOCKSOURCE_OF_DECLARE(gemini, "cortina,gemini-timer", fttmr010_timer_init);
+CLOCKSOURCE_OF_DECLARE(moxart, "moxa,moxart-timer", fttmr010_timer_init);
+CLOCKSOURCE_OF_DECLARE(aspeed, "aspeed,ast2400-timer", fttmr010_timer_init);
-- 
2.9.3
