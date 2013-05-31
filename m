From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:37 +0200
Subject: [PATCH 02/39] ARM: u300: device tree support for the timer
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-3-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds device tree support for the U300 timer, by making
the memory base offset and IRQ dynamically assigned, then
optionally looking them up from the device tree.

Since the timer needs to be registered before any platform
devices are created, we will go into the device tree and look
up the "/timer at c0014000" node and read our base address and
IRQ from there.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use CLOCKSOURCE_OF_DECLARE as suggested by Rob Herring, select
  this for the machine so we do not get compile warnings.
---
 .../bindings/timer/stericsson-u300-apptimer.txt    |  18 ++++
 arch/arm/Kconfig                                   |   1 +
 arch/arm/mach-u300/timer.c                         | 109 ++++++++++++++-------
 arch/arm/mach-u300/timer.h                         |   1 +
 4 files changed, 91 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt

diff --git a/Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt b/Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt
new file mode 100644
index 0000000..9499bc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt
@@ -0,0 +1,18 @@
+ST-Ericsson U300 apptimer
+
+Required properties:
+
+- compatible : should be "stericsson,u300-apptimer"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 4 interrupts; one for each subtimer. These
+  are, in order: OS (operating system), DD (device driver) both
+  adopted for EPOC/Symbian with two specific IRQs for these tasks,
+  then GP1 and GP2, which are general-purpose timers.
+
+Example:
+
+timer {
+	compatible = "stericsson,u300-apptimer";
+	reg = <0xc0014000 0x1000>;
+	interrupts = <24 25 26 27>;
+};
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d423d58..fbad333 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -821,6 +821,7 @@ config ARCH_U300
 	select ARM_VIC
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select CLKSRC_OF
 	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index c3d3802..df1e3b5 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -19,6 +19,8 @@
 #include <linux/err.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -190,6 +192,8 @@
 #define TICKS_PER_JIFFY ((CLOCK_TICK_RATE + (HZ/2)) / HZ)
 #define US_PER_TICK ((1000000 + (HZ/2)) / HZ)
 
+static void __iomem *u300_timer_base;
+
 /*
  * The u300_set_mode() function is always called first, if we
  * have oneshot timer active, the oneshot scheduling function
@@ -202,28 +206,28 @@ static void u300_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* Disable interrupts on GPT1 */
 		writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1IE);
+		       u300_timer_base + U300_TIMER_APP_GPT1IE);
 		/* Disable GP1 while we're reprogramming it. */
 		writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_DGPT1);
+		       u300_timer_base + U300_TIMER_APP_DGPT1);
 		/*
 		 * Set the periodic mode to a certain number of ticks per
 		 * jiffy.
 		 */
 		writel(TICKS_PER_JIFFY,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1TC);
+		       u300_timer_base + U300_TIMER_APP_GPT1TC);
 		/*
 		 * Set continuous mode, so the timer keeps triggering
 		 * interrupts.
 		 */
 		writel(U300_TIMER_APP_SGPT1M_MODE_CONTINUOUS,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_SGPT1M);
+		       u300_timer_base + U300_TIMER_APP_SGPT1M);
 		/* Enable timer interrupts */
 		writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1IE);
+		       u300_timer_base + U300_TIMER_APP_GPT1IE);
 		/* Then enable the OS timer again */
 		writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_EGPT1);
+		       u300_timer_base + U300_TIMER_APP_EGPT1);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* Just break; here? */
@@ -234,33 +238,33 @@ static void u300_set_mode(enum clock_event_mode mode,
 		 */
 		/* Disable interrupts on GPT1 */
 		writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1IE);
+		       u300_timer_base + U300_TIMER_APP_GPT1IE);
 		/* Disable GP1 while we're reprogramming it. */
 		writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_DGPT1);
+		       u300_timer_base + U300_TIMER_APP_DGPT1);
 		/*
 		 * Expire far in the future, u300_set_next_event() will be
 		 * called soon...
 		 */
-		writel(0xFFFFFFFF, U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1TC);
+		writel(0xFFFFFFFF, u300_timer_base + U300_TIMER_APP_GPT1TC);
 		/* We run one shot per tick here! */
 		writel(U300_TIMER_APP_SGPT1M_MODE_ONE_SHOT,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_SGPT1M);
+		       u300_timer_base + U300_TIMER_APP_SGPT1M);
 		/* Enable interrupts for this timer */
 		writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1IE);
+		       u300_timer_base + U300_TIMER_APP_GPT1IE);
 		/* Enable timer */
 		writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_EGPT1);
+		       u300_timer_base + U300_TIMER_APP_EGPT1);
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		/* Disable interrupts on GP1 */
 		writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1IE);
+		       u300_timer_base + U300_TIMER_APP_GPT1IE);
 		/* Disable GP1 */
 		writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-		       U300_TIMER_APP_VBASE + U300_TIMER_APP_DGPT1);
+		       u300_timer_base + U300_TIMER_APP_DGPT1);
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		/* Ignore this call */
@@ -282,27 +286,27 @@ static int u300_set_next_event(unsigned long cycles,
 {
 	/* Disable interrupts on GPT1 */
 	writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-	       U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1IE);
+	       u300_timer_base + U300_TIMER_APP_GPT1IE);
 	/* Disable GP1 while we're reprogramming it. */
 	writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-	       U300_TIMER_APP_VBASE + U300_TIMER_APP_DGPT1);
+	       u300_timer_base + U300_TIMER_APP_DGPT1);
 	/* Reset the General Purpose timer 1. */
 	writel(U300_TIMER_APP_RGPT1_TIMER_RESET,
-	       U300_TIMER_APP_VBASE + U300_TIMER_APP_RGPT1);
+	       u300_timer_base + U300_TIMER_APP_RGPT1);
 	/* IRQ in n * cycles */
-	writel(cycles, U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1TC);
+	writel(cycles, u300_timer_base + U300_TIMER_APP_GPT1TC);
 	/*
 	 * We run one shot per tick here! (This is necessary to reconfigure,
 	 * the timer will tilt if you don't!)
 	 */
 	writel(U300_TIMER_APP_SGPT1M_MODE_ONE_SHOT,
-	       U300_TIMER_APP_VBASE + U300_TIMER_APP_SGPT1M);
+	       u300_timer_base + U300_TIMER_APP_SGPT1M);
 	/* Enable timer interrupts */
 	writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
-	       U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1IE);
+	       u300_timer_base + U300_TIMER_APP_GPT1IE);
 	/* Then enable the OS timer again */
 	writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
-	       U300_TIMER_APP_VBASE + U300_TIMER_APP_EGPT1);
+	       u300_timer_base + U300_TIMER_APP_EGPT1);
 	return 0;
 }
 
@@ -321,8 +325,9 @@ static irqreturn_t u300_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &clockevent_u300_1mhz;
 	/* ACK/Clear timer IRQ for the APP GPT1 Timer */
+
 	writel(U300_TIMER_APP_GPT1IA_IRQ_ACK,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT1IA);
+		u300_timer_base + U300_TIMER_APP_GPT1IA);
 	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
@@ -343,12 +348,12 @@ static struct irqaction u300_timer_irq = {
 
 static u32 notrace u300_read_sched_clock(void)
 {
-	return readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
+	return readl(u300_timer_base + U300_TIMER_APP_GPT2CC);
 }
 
 static unsigned long u300_read_current_timer(void)
 {
-	return readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
+	return readl(u300_timer_base + U300_TIMER_APP_GPT2CC);
 }
 
 static struct delay_timer u300_delay_timer;
@@ -356,11 +361,14 @@ static struct delay_timer u300_delay_timer;
 /*
  * This sets up the system timers, clock source and clock event.
  */
-void __init u300_timer_init(void)
+static void __init u300_timer_setup(void __iomem *base, int irq)
 {
 	struct clk *clk;
 	unsigned long rate;
 
+	u300_timer_base = base;
+	pr_info("U300 GP1 timer @ base: %p, IRQ: %d\n", u300_timer_base, irq);
+
 	/* Clock the interrupt controller */
 	clk = clk_get_sys("apptimer", NULL);
 	BUG_ON(IS_ERR(clk));
@@ -378,40 +386,40 @@ void __init u300_timer_init(void)
 	 * Example usage in cnh1601578 cpu subsystem pd_timer_app.c
 	 */
 	writel(U300_TIMER_APP_CRC_CLOCK_REQUEST_ENABLE,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_CRC);
+		u300_timer_base + U300_TIMER_APP_CRC);
 	writel(U300_TIMER_APP_ROST_TIMER_RESET,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_ROST);
+		u300_timer_base + U300_TIMER_APP_ROST);
 	writel(U300_TIMER_APP_DOST_TIMER_DISABLE,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_DOST);
+		u300_timer_base + U300_TIMER_APP_DOST);
 	writel(U300_TIMER_APP_RDDT_TIMER_RESET,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_RDDT);
+		u300_timer_base + U300_TIMER_APP_RDDT);
 	writel(U300_TIMER_APP_DDDT_TIMER_DISABLE,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_DDDT);
+		u300_timer_base + U300_TIMER_APP_DDDT);
 
 	/* Reset the General Purpose timer 1. */
 	writel(U300_TIMER_APP_RGPT1_TIMER_RESET,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_RGPT1);
+		u300_timer_base + U300_TIMER_APP_RGPT1);
 
 	/* Set up the IRQ handler */
-	setup_irq(IRQ_U300_TIMER_APP_GP1, &u300_timer_irq);
+	setup_irq(irq, &u300_timer_irq);
 
 	/* Reset the General Purpose timer 2 */
 	writel(U300_TIMER_APP_RGPT2_TIMER_RESET,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_RGPT2);
+		u300_timer_base + U300_TIMER_APP_RGPT2);
 	/* Set this timer to run around forever */
-	writel(0xFFFFFFFFU, U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2TC);
+	writel(0xFFFFFFFFU, u300_timer_base + U300_TIMER_APP_GPT2TC);
 	/* Set continuous mode so it wraps around */
 	writel(U300_TIMER_APP_SGPT2M_MODE_CONTINUOUS,
-	       U300_TIMER_APP_VBASE + U300_TIMER_APP_SGPT2M);
+	       u300_timer_base + U300_TIMER_APP_SGPT2M);
 	/* Disable timer interrupts */
 	writel(U300_TIMER_APP_GPT2IE_IRQ_DISABLE,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2IE);
+		u300_timer_base + U300_TIMER_APP_GPT2IE);
 	/* Then enable the GP2 timer to use as a free running us counter */
 	writel(U300_TIMER_APP_EGPT2_TIMER_ENABLE,
-		U300_TIMER_APP_VBASE + U300_TIMER_APP_EGPT2);
+		u300_timer_base + U300_TIMER_APP_EGPT2);
 
 	/* Use general purpose timer 2 as clock source */
-	if (clocksource_mmio_init(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC,
+	if (clocksource_mmio_init(u300_timer_base + U300_TIMER_APP_GPT2CC,
 			"GPT2", rate, 300, 32, clocksource_mmio_readl_up))
 		pr_err("timer: failed to initialize U300 clock source\n");
 
@@ -424,3 +432,28 @@ void __init u300_timer_init(void)
 	 * used by hrtimers!
 	 */
 }
+
+
+void __init u300_timer_init()
+{
+	u300_timer_setup(U300_TIMER_APP_VBASE, IRQ_U300_TIMER_APP_GP1);
+}
+
+#ifdef CONFIG_OF
+
+static void __init u300_timer_init_of(struct device_node *np)
+{
+	void __iomem *base;
+	struct resource irq_res;
+	int irq;
+
+	base = of_iomap(np, 0);
+	/* Get the IRQ for the GP1 timer */
+	irq = of_irq_to_resource(np, 2, &irq_res);
+	u300_timer_setup(base, irq);
+}
+
+CLOCKSOURCE_OF_DECLARE(u300_timer, "stericsson,u300-apptimer",
+		       u300_timer_init_of);
+
+#endif
diff --git a/arch/arm/mach-u300/timer.h b/arch/arm/mach-u300/timer.h
index d34287b..7766dfa 100644
--- a/arch/arm/mach-u300/timer.h
+++ b/arch/arm/mach-u300/timer.h
@@ -1 +1,2 @@
 extern void u300_timer_init(void);
+
-- 
1.7.11.3
