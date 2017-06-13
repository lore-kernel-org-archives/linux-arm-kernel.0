From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 13 Jun 2017 15:58:45 +0800
Subject: [PATCH V2 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <1497340725-26594-1-git-send-email-aisheng.dong@nxp.com>
References: <1497340725-26594-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1497340725-26594-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX Timer/PWM Module (TPM) supports both timer and pwm function while
this patch only adds the timer support. PWM would be added later.

The TPM counter, compare and capture registers are clocked by an
asynchronous clock that can remain enabled in low power modes.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v1->v2:
 * change to readl/writel from __raw_readl/writel according to Arnd's
   suggestion to avoid endian issue
 * add help information in Kconfig
 * add more error checking
---
 drivers/clocksource/Kconfig         |   8 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-imx-tpm.c | 227 ++++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 drivers/clocksource/timer-imx-tpm.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 545d541..33b4d31 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -603,6 +603,14 @@ config CLKSRC_IMX_GPT
 	depends on ARM && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 
+config CLKSRC_IMX_TPM
+	bool "Clocksource using i.MX TPM" if COMPILE_TEST
+	depends on ARM && CLKDEV_LOOKUP && GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	help
+	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
+	  clocksource.
+
 config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select CLKSRC_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 2b5b56a..9fdf8da0 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
+obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
new file mode 100644
index 0000000..940a4f75
--- /dev/null
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -0,0 +1,227 @@
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#define TPM_SC				0x10
+#define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
+#define TPM_SC_CMOD_DIV_DEFAULT		0x3
+#define TPM_CNT				0x14
+#define TPM_MOD				0x18
+#define TPM_STATUS			0x1c
+#define TPM_STATUS_CH0F			BIT(0)
+#define TPM_C0SC			0x20
+#define TPM_C0SC_CHIE			BIT(6)
+#define TPM_C0SC_MODE_SHIFT		2
+#define TPM_C0SC_MODE_MASK		0x3c
+#define TPM_C0SC_MODE_SW_COMPARE	0x4
+#define TPM_C0V				0x24
+
+static void __iomem *timer_base;
+static struct clock_event_device clockevent_tpm;
+
+static inline void tpm_timer_disable(void)
+{
+	unsigned int val;
+
+	/* channel disable */
+	val = readl(timer_base + TPM_C0SC);
+	val &= ~(TPM_C0SC_MODE_MASK | TPM_C0SC_CHIE);
+	writel(val, timer_base + TPM_C0SC);
+}
+
+static inline void tpm_timer_enable(void)
+{
+	unsigned int val;
+
+	/* channel enabled in sw compare mode */
+	val = readl(timer_base + TPM_C0SC);
+	val |= (TPM_C0SC_MODE_SW_COMPARE << TPM_C0SC_MODE_SHIFT) |
+	       TPM_C0SC_CHIE;
+	writel(val, timer_base + TPM_C0SC);
+}
+
+static inline void tpm_irq_acknowledge(void)
+{
+	writel(TPM_STATUS_CH0F, timer_base + TPM_STATUS);
+}
+
+static struct delay_timer tpm_delay_timer;
+
+static unsigned long tpm_read_current_timer(void)
+{
+	return readl(timer_base + TPM_CNT);
+}
+
+static u64 notrace tpm_read_sched_clock(void)
+{
+	return readl(timer_base + TPM_CNT);
+}
+
+static int __init tpm_clocksource_init(unsigned long rate)
+{
+	tpm_delay_timer.read_current_timer = &tpm_read_current_timer;
+	tpm_delay_timer.freq = rate;
+	register_current_timer_delay(&tpm_delay_timer);
+
+	sched_clock_register(tpm_read_sched_clock, 32, rate);
+
+	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
+				     rate, 200, 32, clocksource_mmio_readl_up);
+}
+
+static int tpm_set_next_event(unsigned long delta,
+				struct clock_event_device *evt)
+{
+	unsigned long next, now;
+
+	next = readl(timer_base + TPM_CNT) + delta;
+	writel(next, timer_base + TPM_C0V);
+	now = readl(timer_base + TPM_CNT);
+
+	return (int)((next - now) <= 0) ? -ETIME : 0;
+}
+
+static int tpm_set_state_oneshot(struct clock_event_device *evt)
+{
+	tpm_timer_enable();
+
+	return 0;
+}
+
+static int tpm_set_state_shutdown(struct clock_event_device *evt)
+{
+	tpm_timer_disable();
+
+	return 0;
+}
+
+static irqreturn_t tpm_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &clockevent_tpm;
+
+	tpm_irq_acknowledge();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct clock_event_device clockevent_tpm = {
+	.name			= "i.MX7ULP TPM Timer",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_oneshot	= tpm_set_state_oneshot,
+	.set_next_event		= tpm_set_next_event,
+	.set_state_shutdown	= tpm_set_state_shutdown,
+	.rating			= 200,
+};
+
+static struct irqaction tpm_timer_irq = {
+	.name		= "i.MX7ULP TPM Timer",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= tpm_timer_interrupt,
+	.dev_id		= &clockevent_tpm,
+};
+
+static int __init tpm_clockevent_init(unsigned long rate, int irq)
+{
+	setup_irq(irq, &tpm_timer_irq);
+
+	clockevent_tpm.cpumask = cpumask_of(0);
+	clockevent_tpm.irq = irq;
+	clockevents_config_and_register(&clockevent_tpm,
+					rate, 0xff, 0xfffffffe);
+
+	return 0;
+}
+
+static int __init tpm_timer_init(struct device_node *np)
+{
+	struct clk *ipg, *per;
+	int irq, ret;
+	u32 rate;
+
+	timer_base = of_iomap(np, 0);
+	if (!timer_base) {
+		pr_err("tpm: failed to get base address\n");
+		return -ENXIO;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		pr_err("tpm: failed to get irq\n");
+		ret = -ENOENT;
+		goto err_iomap;
+	}
+
+	ipg = of_clk_get_by_name(np, "ipg");
+	per = of_clk_get_by_name(np, "per");
+	if (IS_ERR(ipg) || IS_ERR(per)) {
+		pr_err("tpm: failed to get igp or per clk\n");
+		ret = -ENODEV;
+		goto err_clk_get;
+	}
+
+	/* enable clk before accessing registers */
+	ret = clk_prepare_enable(ipg);
+	if (ret) {
+		pr_err("tpm: ipg clock enable failed (%d)\n", ret);
+		goto err_ipg_clk_enable;
+	}
+
+	ret = clk_prepare_enable(per);
+	if (ret) {
+		pr_err("tpm: per clock enable failed (%d)\n", ret);
+		goto err_per_clk_enable;
+	}
+
+	/*
+	 * Initialize tpm module to a known state
+	 * 1) Counter disabled
+	 * 2) TPM counter operates in up counting mode
+	 * 3) Timer Overflow Interrupt disabled
+	 * 4) Channel0 disabled
+	 * 5) DMA transfers disabled
+	 */
+	writel(0, timer_base + TPM_SC);
+	writel(0, timer_base + TPM_CNT);
+	writel(0, timer_base + TPM_C0SC);
+
+	/* increase per cnt, div 8 by default */
+	writel(TPM_SC_CMOD_INC_PER_CNT | TPM_SC_CMOD_DIV_DEFAULT,
+		     timer_base + TPM_SC);
+
+	/* set MOD register to maximum for free running mode */
+	writel(0xffffffff, timer_base + TPM_MOD);
+
+	rate = clk_get_rate(per) / 8;
+	tpm_clocksource_init(rate);
+	tpm_clockevent_init(rate, irq);
+
+	return 0;
+
+err_per_clk_enable:
+	clk_disable_unprepare(ipg);
+err_ipg_clk_enable:
+err_clk_get:
+	clk_put(per);
+	clk_put(ipg);
+err_iomap:
+	iounmap(timer_base);
+	return ret;
+}
+CLOCKSOURCE_OF_DECLARE(imx7ulp, "fsl,imx7ulp-tpm", tpm_timer_init);
-- 
2.7.4
