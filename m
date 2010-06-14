From: konkers@android.com (Erik Gilling)
Date: Mon, 14 Jun 2010 14:10:21 -0700
Subject: [PATCH v3 05/11] [ARM] tegra: Add timer support
In-Reply-To: <1276549827-2688-5-git-send-email-konkers@android.com>
References: <1271198563-10424-1-git-send-email-konkers@android.com>
	<1276549827-2688-1-git-send-email-konkers@android.com>
	<1276549827-2688-2-git-send-email-konkers@android.com>
	<1276549827-2688-3-git-send-email-konkers@android.com>
	<1276549827-2688-4-git-send-email-konkers@android.com>
	<1276549827-2688-5-git-send-email-konkers@android.com>
Message-ID: <1276549827-2688-6-git-send-email-konkers@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

v2: fixes from Russell King:
	- include linux/io.h instead of asm/io.h
    fixes from Gary King:
	- remove extra (and incorrect) irq definitions
	- use timer 3 instead of timer 1 for compatibility with other drivers
	- fix typo that disabled oneshot mode
v3:
	- Implement sched_clock
	- Fix checkpatch issues
    fixes from Gary King:
    	- Fix incorrect cycles calculation
	- Fix min_delta_ns assignment
    fixes from Linus Walleij:
	- use calc_mult_shift() instead of hard coding values

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/Makefile |    1 +
 arch/arm/mach-tegra/timer.c  |  187 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/timer.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index f339559..01f47fd 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -2,6 +2,7 @@ obj-y                                   += common.o
 obj-y                                   += io.o
 obj-y                                   += irq.o
 obj-y                                   += clock.o
+obj-y                                   += timer.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
new file mode 100644
index 0000000..2f42021
--- /dev/null
+++ b/arch/arm/mach-tegra/timer.c
@@ -0,0 +1,187 @@
+/*
+ * arch/arch/mach-tegra/timer.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/cnt32_to_63.h>
+
+#include <asm/mach/time.h>
+#include <asm/mach/time.h>
+#include <asm/localtimer.h>
+
+#include <mach/iomap.h>
+#include <mach/irqs.h>
+
+#include "board.h"
+#include "clock.h"
+
+#define TIMERUS_CNTR_1US 0x10
+#define TIMERUS_USEC_CFG 0x14
+#define TIMERUS_CNTR_FREEZE 0x4c
+
+#define TIMER1_BASE 0x0
+#define TIMER2_BASE 0x8
+#define TIMER3_BASE 0x50
+#define TIMER4_BASE 0x58
+
+#define TIMER_PTV 0x0
+#define TIMER_PCR 0x4
+
+struct tegra_timer;
+
+static void __iomem *timer_reg_base = IO_ADDRESS(TEGRA_TMR1_BASE);
+
+#define timer_writel(value, reg) \
+	__raw_writel(value, (u32)timer_reg_base + (reg))
+#define timer_readl(reg) \
+	__raw_readl((u32)timer_reg_base + (reg))
+
+static int tegra_timer_set_next_event(unsigned long cycles,
+					 struct clock_event_device *evt)
+{
+	u32 reg;
+
+	reg = 0x80000000 | ((cycles > 1) ? (cycles-1) : 0);
+	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
+
+	return 0;
+}
+
+static void tegra_timer_set_mode(enum clock_event_mode mode,
+				    struct clock_event_device *evt)
+{
+	u32 reg;
+
+	timer_writel(0, TIMER3_BASE + TIMER_PTV);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		reg = 0xC0000000 | ((1000000/HZ)-1);
+		timer_writel(reg, TIMER3_BASE + TIMER_PTV);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static cycle_t tegra_clocksource_read(struct clocksource *cs)
+{
+	return cnt32_to_63(timer_readl(TIMERUS_CNTR_1US));
+}
+
+static struct clock_event_device tegra_clockevent = {
+	.name		= "timer0",
+	.rating		= 300,
+	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+	.set_next_event	= tegra_timer_set_next_event,
+	.set_mode	= tegra_timer_set_mode,
+};
+
+static struct clocksource tegra_clocksource = {
+	.name	= "timer_us",
+	.rating	= 300,
+	.read	= tegra_clocksource_read,
+	.mask	= 0x7FFFFFFFFFFFFFFFULL,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+unsigned long long sched_clock(void)
+{
+	return clocksource_cyc2ns(tegra_clocksource.read(&tegra_clocksource),
+		tegra_clocksource.mult, tegra_clocksource.shift);
+}
+
+static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction tegra_timer_irq = {
+	.name		= "timer0",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_HIGH,
+	.handler	= tegra_timer_interrupt,
+	.dev_id		= &tegra_clockevent,
+	.irq		= INT_TMR3,
+};
+
+static void __init tegra_init_timer(void)
+{
+	unsigned long rate = clk_measure_input_freq();
+	int ret;
+
+#ifdef CONFIG_HAVE_ARM_TWD
+	twd_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x600);
+#endif
+
+	switch (rate) {
+	case 12000000:
+		timer_writel(0x000b, TIMERUS_USEC_CFG);
+		break;
+	case 13000000:
+		timer_writel(0x000c, TIMERUS_USEC_CFG);
+		break;
+	case 19200000:
+		timer_writel(0x045f, TIMERUS_USEC_CFG);
+		break;
+	case 26000000:
+		timer_writel(0x0019, TIMERUS_USEC_CFG);
+		break;
+	default:
+		WARN(1, "Unknown clock rate");
+	}
+
+	if (clocksource_register_hz(&tegra_clocksource, 1000000)) {
+		printk(KERN_ERR "Failed to register clocksource\n");
+		BUG();
+	}
+
+	ret = setup_irq(tegra_timer_irq.irq, &tegra_timer_irq);
+	if (ret) {
+		printk(KERN_ERR "Failed to register timer IRQ: %d\n", ret);
+		BUG();
+	}
+
+	clockevents_calc_mult_shift(&tegra_clockevent, 1000000, 5);
+	tegra_clockevent.max_delta_ns =
+		clockevent_delta2ns(0x1fffffff, &tegra_clockevent);
+	tegra_clockevent.min_delta_ns =
+		clockevent_delta2ns(0x1, &tegra_clockevent);
+	tegra_clockevent.cpumask = cpu_all_mask;
+	tegra_clockevent.irq = tegra_timer_irq.irq;
+	clockevents_register_device(&tegra_clockevent);
+
+	return;
+}
+
+struct sys_timer tegra_timer = {
+	.init = tegra_init_timer,
+};
-- 
1.6.5.6
