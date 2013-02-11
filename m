From: csd@broadcom.com (Christian Daudt)
Date: Mon, 11 Feb 2013 15:44:39 -0800
Subject: [PATCH V4] ARM: bcm281xx: Add timer driver
Message-ID: <1360626279-26701-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the Broadcom timer, used in the following SoCs:
BCM11130, BCM11140, BCM11351, BCM28145, BCM28155

Updates from V3:
 - Migrate to 3.9 timer framework updates

Updates from V2:
 - prepend static fns + fields with kona_

Updates from V1:
 - Rename bcm_timer.c to bcm_kona_timer.c
 - Pull .h into bcm_kona_timer.c
 - Make timers static
 - Clean up comment block
 - Switched to using clockevents_config_and_register
 - Added an error to the get_timer loop if it repeats too much
 - Added to Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt
 - Added missing readl to timer_disable_and_clear

Note: bcm,kona-timer was kept as the 'compatible' field to make it
specific enough for when there are multiple bcm timers (bcm,timer is
too generic).

Signed-off-by: Christian Daudt <csd@broadcom.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: John Stultz <johnstul@us.ibm.com>
Reviewed-by: Stephen Warren <swarren@nvidia.com>

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt b/Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt
new file mode 100644
index 0000000..59fa6e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt
@@ -0,0 +1,19 @@
+Broadcom Kona Family timer
+-----------------------------------------------------
+This timer is used in the following Broadcom SoCs:
+ BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
+
+Required properties:
+- compatible : "bcm,kona-timer"
+- reg : Register range for the timer
+- interrupts : interrupt for the timer
+- clock-frequency: frequency that the clock operates
+
+Example:
+	timer at 35006000 {
+		compatible = "bcm,kona-timer";
+		reg = <0x35006000 0x1000>;
+		interrupts = <0x0 7 0x4>;
+		clock-frequency = <32768>;
+	};
+
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index ad13588..8f71f40 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -47,4 +47,12 @@
 		    cache-unified;
 		    cache-level = <2>;
 	};
+
+	timer at 35006000 {
+		compatible = "bcm,kona-timer";
+		reg = <0x35006000 0x1000>;
+		interrupts = <0x0 7 0x4>;
+		clock-frequency = <32768>;
+	};
+
 };
diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
index f0f9aba..b9d0c43 100644
--- a/arch/arm/mach-bcm/board_bcm.c
+++ b/arch/arm/mach-bcm/board_bcm.c
@@ -20,10 +20,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-static void timer_init(void)
-{
-}
 
+extern void kona_timer_init(void);
 
 static void __init board_init(void)
 {
@@ -35,7 +33,7 @@ static const char * const bcm11351_dt_compat[] = { "bcm,bcm11351", NULL, };
 
 DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
 	.init_irq = irqchip_init,
-	.init_time = timer_init,
+	.init_time = kona_timer_init,
 	.init_machine = board_init,
 	.dt_compat = bcm11351_dt_compat,
 MACHINE_END
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 596c45c..b681d67 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -19,5 +19,6 @@ obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
 obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
+obj-$(CONFIG_ARCH_BCM)		+= bcm_kona_timer.o
 
 obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
new file mode 100644
index 0000000..a12754b
--- /dev/null
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -0,0 +1,208 @@
+/*
+ * Copyright (C) 2012 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/clockchips.h>
+#include <linux/types.h>
+
+#include <linux/io.h>
+#include <asm/mach/time.h>
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+
+#define KONA_GPTIMER_STCS_OFFSET			0x00000000
+#define KONA_GPTIMER_STCLO_OFFSET			0x00000004
+#define KONA_GPTIMER_STCHI_OFFSET			0x00000008
+#define KONA_GPTIMER_STCM0_OFFSET			0x0000000C
+
+#define KONA_GPTIMER_STCS_TIMER_MATCH_SHIFT		0
+#define KONA_GPTIMER_STCS_COMPARE_ENABLE_SHIFT		4
+
+struct kona_bcm_timers {
+	int tmr_irq;
+	void __iomem *tmr_regs;
+};
+
+static struct kona_bcm_timers timers;
+
+static u32 arch_timer_rate;
+
+/*
+ * We use the peripheral timers for system tick, the cpu global timer for
+ * profile tick
+ */
+static void kona_timer_disable_and_clear(void __iomem *base)
+{
+	uint32_t reg;
+
+	/*
+	 * clear and disable interrupts
+	 * We are using compare/match register 0 for our system interrupts
+	 */
+	reg = readl(base + KONA_GPTIMER_STCS_OFFSET);
+
+	/* Clear compare (0) interrupt */
+	reg |= 1 << KONA_GPTIMER_STCS_TIMER_MATCH_SHIFT;
+	/* disable compare */
+	reg &= ~(1 << KONA_GPTIMER_STCS_COMPARE_ENABLE_SHIFT);
+
+	writel(reg, base + KONA_GPTIMER_STCS_OFFSET);
+
+}
+
+static void
+kona_timer_get_counter(void *timer_base, uint32_t *msw, uint32_t *lsw)
+{
+	void __iomem *base = IOMEM(timer_base);
+	int loop_limit = 4;
+
+	/*
+	 * Read 64-bit free running counter
+	 * 1. Read hi-word
+	 * 2. Read low-word
+	 * 3. Read hi-word again
+	 * 4.1
+	 *      if new hi-word is not equal to previously read hi-word, then
+	 *      start from #1
+	 * 4.2
+	 *      if new hi-word is equal to previously read hi-word then stop.
+	 */
+
+	while (--loop_limit) {
+		*msw = readl(base + KONA_GPTIMER_STCHI_OFFSET);
+		*lsw = readl(base + KONA_GPTIMER_STCLO_OFFSET);
+		if (*msw == readl(base + KONA_GPTIMER_STCHI_OFFSET))
+			break;
+	}
+	if (!loop_limit) {
+		pr_err("bcm_kona_timer: getting counter failed.\n");
+		pr_err(" Timer will be impacted\n");
+	}
+
+	return;
+}
+
+static const struct of_device_id bcm_timer_ids[] __initconst = {
+	{.compatible = "bcm,kona-timer"},
+	{},
+};
+
+static void __init kona_timers_init(void)
+{
+	struct device_node *node;
+	u32 freq;
+
+	node = of_find_matching_node(NULL, bcm_timer_ids);
+
+	if (!node)
+		panic("No timer");
+
+	if (!of_property_read_u32(node, "clock-frequency", &freq))
+		arch_timer_rate = freq;
+	else
+		panic("clock-frequency not set in the .dts file");
+
+	/* Setup IRQ numbers */
+	timers.tmr_irq = irq_of_parse_and_map(node, 0);
+
+	/* Setup IO addresses */
+	timers.tmr_regs = of_iomap(node, 0);
+
+	kona_timer_disable_and_clear(timers.tmr_regs);
+}
+
+static int kona_timer_set_next_event(unsigned long clc,
+				  struct clock_event_device *unused)
+{
+	/*
+	 * timer (0) is disabled by the timer interrupt already
+	 * so, here we reload the next event value and re-enable
+	 * the timer.
+	 *
+	 * This way, we are potentially losing the time between
+	 * timer-interrupt->set_next_event. CPU local timers, when
+	 * they come in should get rid of skew.
+	 */
+
+	uint32_t lsw, msw;
+	uint32_t reg;
+
+	kona_timer_get_counter(timers.tmr_regs, &msw, &lsw);
+
+	/* Load the "next" event tick value */
+	writel(lsw + clc, timers.tmr_regs + KONA_GPTIMER_STCM0_OFFSET);
+
+	/* Enable compare */
+	reg = readl(timers.tmr_regs + KONA_GPTIMER_STCS_OFFSET);
+	reg |= (1 << KONA_GPTIMER_STCS_COMPARE_ENABLE_SHIFT);
+	writel(reg, timers.tmr_regs + KONA_GPTIMER_STCS_OFFSET);
+
+	return 0;
+}
+
+static void kona_timer_set_mode(enum clock_event_mode mode,
+			     struct clock_event_device *unused)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* by default mode is one shot don't do any thing */
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		kona_timer_disable_and_clear(timers.tmr_regs);
+	}
+}
+
+static struct clock_event_device kona_clockevent_timer = {
+	.name = "timer 1",
+	.features = CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event = kona_timer_set_next_event,
+	.set_mode = kona_timer_set_mode
+};
+
+static void __init kona_timer_clockevents_init(void)
+{
+	kona_clockevent_timer.cpumask = cpumask_of(0);
+	clockevents_config_and_register(&kona_clockevent_timer,
+		arch_timer_rate, 6, 0xffffffff);
+}
+
+static irqreturn_t kona_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &kona_clockevent_timer;
+
+	kona_timer_disable_and_clear(timers.tmr_regs);
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction kona_timer_irq = {
+	.name = "Kona Timer Tick",
+	.flags = IRQF_TIMER,
+	.handler = kona_timer_interrupt,
+};
+
+void __init kona_timer_init(void)
+{
+	kona_timers_init();
+	kona_timer_clockevents_init();
+	setup_irq(timers.tmr_irq, &kona_timer_irq);
+	kona_timer_set_next_event((arch_timer_rate / HZ), NULL);
+}
-- 
1.7.1
