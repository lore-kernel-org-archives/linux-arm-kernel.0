From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:17:17 +0100
Subject: [PATCH 05/22] clocksource: Add driver for the Cortina Gemini
Message-ID: <20170122121717.10249-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a rewrite of the Gemini timer
driver in arch/arm/mach-gemini/timer.c trying to do everything
the device tree way:

- Make every IO-access relative to a base address and dynamic
  so we can do a dynamic ioremap and get going.
- Do not poke around directly in the global syscon registers,
  access them using the syscon regmap style design pattern for
  the one register we need to check.
- Find register range and interrupt from the device tree.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
clocksource maintainers: please just apply this when you feel
pleased with it. These portions are functionally orthogonal to
the series, it is just in a series for context.
---
 drivers/clocksource/Kconfig        |  10 ++
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-gemini.c | 277 +++++++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)
 create mode 100644 drivers/clocksource/timer-gemini.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4866f7aa32e6..60989d5b5135 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -60,6 +60,16 @@ config DW_APB_TIMER_OF
 	select DW_APB_TIMER
 	select CLKSRC_OF
 
+config GEMINI_TIMER
+	bool "Cortina Gemini timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
+	select CLKSRC_MMIO
+	select CLKSRC_OF
+	select MFD_SYSCON
+	help
+	  Enables support for the Gemini timer
+
 config ROCKCHIP_TIMER
 	bool "Rockchip timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index a14111e1f087..a6dc6466bfa7 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
+obj-$(CONFIG_GEMINI_TIMER)	+= timer-gemini.o
 obj-$(CONFIG_ROCKCHIP_TIMER)      += rockchip_timer.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
diff --git a/drivers/clocksource/timer-gemini.c b/drivers/clocksource/timer-gemini.c
new file mode 100644
index 000000000000..dda27b7bf1a1
--- /dev/null
+++ b/drivers/clocksource/timer-gemini.c
@@ -0,0 +1,277 @@
+/*
+ * Gemini timer driver
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * Based on a rewrite of arch/arm/mach-gemini/timer.c:
+ * Copyright (C) 2001-2006 Storlink, Corp.
+ * Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
+ */
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/sched_clock.h>
+
+/*
+ * Relevant registers in the global syscon
+ */
+#define GLOBAL_STATUS		0x04
+#define CPU_AHB_RATIO_MASK	(0x3 << 18)
+#define CPU_AHB_1_1		(0x0 << 18)
+#define CPU_AHB_3_2		(0x1 << 18)
+#define CPU_AHB_24_13		(0x2 << 18)
+#define CPU_AHB_2_1		(0x3 << 18)
+#define REG_TO_AHB_SPEED(reg)	((((reg) >> 15) & 0x7) * 10 + 130)
+
+/*
+ * Register definitions for the timers
+ */
+#define TIMER1_COUNT		(0x00)
+#define TIMER1_LOAD		(0x04)
+#define TIMER1_MATCH1		(0x08)
+#define TIMER1_MATCH2		(0x0c)
+#define TIMER2_COUNT		(0x10)
+#define TIMER2_LOAD		(0x14)
+#define TIMER2_MATCH1		(0x18)
+#define TIMER2_MATCH2		(0x1c)
+#define TIMER3_COUNT		(0x20)
+#define TIMER3_LOAD		(0x24)
+#define TIMER3_MATCH1		(0x28)
+#define TIMER3_MATCH2		(0x2c)
+#define TIMER_CR		(0x30)
+#define TIMER_INTR_STATE	(0x34)
+#define TIMER_INTR_MASK		(0x38)
+
+#define TIMER_1_CR_ENABLE	(1 << 0)
+#define TIMER_1_CR_CLOCK	(1 << 1)
+#define TIMER_1_CR_INT		(1 << 2)
+#define TIMER_2_CR_ENABLE	(1 << 3)
+#define TIMER_2_CR_CLOCK	(1 << 4)
+#define TIMER_2_CR_INT		(1 << 5)
+#define TIMER_3_CR_ENABLE	(1 << 6)
+#define TIMER_3_CR_CLOCK	(1 << 7)
+#define TIMER_3_CR_INT		(1 << 8)
+#define TIMER_1_CR_UPDOWN	(1 << 9)
+#define TIMER_2_CR_UPDOWN	(1 << 10)
+#define TIMER_3_CR_UPDOWN	(1 << 11)
+#define TIMER_DEFAULT_FLAGS	(TIMER_1_CR_UPDOWN | \
+				 TIMER_3_CR_ENABLE | \
+				 TIMER_3_CR_UPDOWN)
+
+#define TIMER_1_INT_MATCH1	(1 << 0)
+#define TIMER_1_INT_MATCH2	(1 << 1)
+#define TIMER_1_INT_OVERFLOW	(1 << 2)
+#define TIMER_2_INT_MATCH1	(1 << 3)
+#define TIMER_2_INT_MATCH2	(1 << 4)
+#define TIMER_2_INT_OVERFLOW	(1 << 5)
+#define TIMER_3_INT_MATCH1	(1 << 6)
+#define TIMER_3_INT_MATCH2	(1 << 7)
+#define TIMER_3_INT_OVERFLOW	(1 << 8)
+#define TIMER_INT_ALL_MASK	0x1ff
+
+static unsigned int tick_rate;
+static void __iomem *base;
+
+static u64 notrace gemini_read_sched_clock(void)
+{
+	return readl(base + TIMER3_COUNT);
+}
+
+static int gemini_timer_set_next_event(unsigned long cycles,
+				       struct clock_event_device *evt)
+{
+	u32 cr;
+
+	/* Setup the match register */
+	cr = readl(base + TIMER1_COUNT);
+	writel(cr + cycles, base + TIMER1_MATCH1);
+	if (readl(base + TIMER1_COUNT) - cr > cycles)
+		return -ETIME;
+
+	return 0;
+}
+
+static int gemini_timer_shutdown(struct clock_event_device *evt)
+{
+	u32 cr;
+
+	/*
+	 * Disable also for oneshot: the set_next() call will arm the timer
+	 * instead.
+	 */
+	/* Stop timer and interrupt. */
+	cr = readl(base + TIMER_CR);
+	cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
+	writel(cr, base + TIMER_CR);
+
+	/* Setup counter start from 0 */
+	writel(0, base + TIMER1_COUNT);
+	writel(0, base + TIMER1_LOAD);
+
+	/* enable interrupt */
+	cr = readl(base + TIMER_INTR_MASK);
+	cr &= ~(TIMER_1_INT_OVERFLOW | TIMER_1_INT_MATCH2);
+	cr |= TIMER_1_INT_MATCH1;
+	writel(cr, base + TIMER_INTR_MASK);
+
+	/* start the timer */
+	cr = readl(base + TIMER_CR);
+	cr |= TIMER_1_CR_ENABLE;
+	writel(cr, base + TIMER_CR);
+
+	return 0;
+}
+
+static int gemini_timer_set_periodic(struct clock_event_device *evt)
+{
+	u32 period = DIV_ROUND_CLOSEST(tick_rate, HZ);
+	u32 cr;
+
+	/* Stop timer and interrupt */
+	cr = readl(base + TIMER_CR);
+	cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
+	writel(cr, base + TIMER_CR);
+
+	/* Setup timer to fire at 1/HT intervals. */
+	cr = 0xffffffff - (period - 1);
+	writel(cr, base + TIMER1_COUNT);
+	writel(cr, base + TIMER1_LOAD);
+
+	/* enable interrupt on overflow */
+	cr = readl(base + TIMER_INTR_MASK);
+	cr &= ~(TIMER_1_INT_MATCH1 | TIMER_1_INT_MATCH2);
+	cr |= TIMER_1_INT_OVERFLOW;
+	writel(cr, base + TIMER_INTR_MASK);
+
+	/* Start the timer */
+	cr = readl(base + TIMER_CR);
+	cr |= TIMER_1_CR_ENABLE;
+	cr |= TIMER_1_CR_INT;
+	writel(cr, base + TIMER_CR);
+
+	return 0;
+}
+
+/* Use TIMER1 as clock event */
+static struct clock_event_device gemini_clockevent = {
+	.name			= "TIMER1",
+	/* Reasonably fast and accurate clock event */
+	.rating			= 300,
+	.shift                  = 32,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event		= gemini_timer_set_next_event,
+	.set_state_shutdown	= gemini_timer_shutdown,
+	.set_state_periodic	= gemini_timer_set_periodic,
+	.set_state_oneshot	= gemini_timer_shutdown,
+	.tick_resume		= gemini_timer_shutdown,
+};
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t gemini_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &gemini_clockevent;
+
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction gemini_timer_irq = {
+	.name		= "Gemini Timer Tick",
+	.flags		= IRQF_TIMER,
+	.handler	= gemini_timer_interrupt,
+};
+
+static int __init gemini_timer_of_init(struct device_node *np)
+{
+	static struct regmap *map;
+	int irq;
+	int ret;
+	u32 val;
+
+	map = syscon_regmap_lookup_by_phandle(np, "syscon");
+	if (IS_ERR(map)) {
+		pr_err("Can't get regmap for syscon handle");
+		return -ENODEV;
+	}
+	ret = regmap_read(map, GLOBAL_STATUS, &val);
+	if (ret) {
+		pr_err("Can't read syscon status register");
+		return -ENXIO;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("Can't remap registers");
+		return -ENXIO;
+	}
+	/* IRQ for timer 1 */
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0) {
+		pr_err("Can't parse IRQ");
+		return -EINVAL;
+	}
+
+	tick_rate = REG_TO_AHB_SPEED(val) * 1000000;
+	printk(KERN_INFO "Bus: %dMHz", tick_rate / 1000000);
+
+	tick_rate /= 6;		/* APB bus run AHB*(1/6) */
+
+	switch (val & CPU_AHB_RATIO_MASK) {
+	case CPU_AHB_1_1:
+		printk(KERN_CONT "(1/1)\n");
+		break;
+	case CPU_AHB_3_2:
+		printk(KERN_CONT "(3/2)\n");
+		break;
+	case CPU_AHB_24_13:
+		printk(KERN_CONT "(24/13)\n");
+		break;
+	case CPU_AHB_2_1:
+		printk(KERN_CONT "(2/1)\n");
+		break;
+	}
+
+	/*
+	 * Reset the interrupt mask and status
+	 */
+	writel(TIMER_INT_ALL_MASK, base + TIMER_INTR_MASK);
+	writel(0, base + TIMER_INTR_STATE);
+	writel(TIMER_DEFAULT_FLAGS, base + TIMER_CR);
+
+	/*
+	 * Setup free-running clocksource timer (interrupts
+	 * disabled.)
+	 */
+	writel(0, base + TIMER3_COUNT);
+	writel(0, base + TIMER3_LOAD);
+	writel(0, base + TIMER3_MATCH1);
+	writel(0, base + TIMER3_MATCH2);
+	clocksource_mmio_init(base + TIMER3_COUNT,
+			      "gemini_clocksource", tick_rate,
+			      300, 32, clocksource_mmio_readl_up);
+	sched_clock_register(gemini_read_sched_clock, 32, tick_rate);
+
+	/*
+	 * Setup clockevent timer (interrupt-driven.)
+	 */
+	writel(0, base + TIMER1_COUNT);
+	writel(0, base + TIMER1_LOAD);
+	writel(0, base + TIMER1_MATCH1);
+	writel(0, base + TIMER1_MATCH2);
+	setup_irq(irq, &gemini_timer_irq);
+	gemini_clockevent.cpumask = cpumask_of(0);
+	clockevents_config_and_register(&gemini_clockevent, tick_rate,
+					1, 0xffffffff);
+
+	return 0;
+}
+CLOCKSOURCE_OF_DECLARE(nomadik_mtu, "cortina,gemini-timer",
+		       gemini_timer_of_init);
-- 
2.9.3
