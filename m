From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:51:44 +0200
Subject: [PATCH 03/23] ARM: u300: device tree support for the timer
Message-ID: <1366624304-6190-1-git-send-email-linus.walleij@stericsson.com>
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
 .../bindings/timer/stericsson-u300-apptimer.txt    | 18 ++++
 arch/arm/mach-u300/timer.c                         | 99 ++++++++++++++--------
 2 files changed, 80 insertions(+), 37 deletions(-)
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
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index c3d3802..5e60a5e 100644
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
@@ -360,6 +365,26 @@ void __init u300_timer_init(void)
 {
 	struct clk *clk;
 	unsigned long rate;
+	int irq = 0;
+
+#ifdef CONFIG_OF
+	struct device_node *timer = NULL;
+
+	timer = of_find_node_by_path("/timer0 at c0014000");
+	if (timer) {
+		struct resource irq_res;
+
+		u300_timer_base = of_iomap(timer, 0);
+		/* Get the IRQ for the GP1 timer */
+		irq = of_irq_to_resource(timer, 2, &irq_res);
+	}
+#endif
+	/* Fallback to static maps if base & IRQ not found in DT */
+	if (!u300_timer_base)
+		u300_timer_base = U300_TIMER_APP_VBASE;
+	if (irq <= 0)
+		irq = IRQ_U300_TIMER_APP_GP1;
+	pr_info("U300 GP1 timer @ base: %p, IRQ: %d\n", u300_timer_base, irq);
 
 	/* Clock the interrupt controller */
 	clk = clk_get_sys("apptimer", NULL);
@@ -378,40 +403,40 @@ void __init u300_timer_init(void)
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
 
-- 
1.7.11.3
