From: vw@iommu.org (Wan Zongshun)
Date: Sun, 10 Jul 2016 15:27:23 +0800
Subject: [PATCH v2 03/10] Clocksource: add nuc970 clocksource driver
In-Reply-To: <1468135649-19980-1-git-send-email-vw@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
Message-ID: <1468135649-19980-4-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add nuc970 clocksource driver support.

NUC970 general timer controller includes five channels, TIMER0, TIMER1,
TIMER2, TIMER3, and TIMER4, which allow user to easily implement a
counting scheme or timing control for applications.The timer possesses
features such as adjustable resolution, and programmable counting period.
The timer can generate an interrupt signal upon timeout, or provide the
current value of count during operation.

Currently, we are using TIMER0 and TIMER1 for clocksource and clockevent
device driver support.

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 drivers/clocksource/Kconfig        |   8 +
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-nuc900.c | 305 +++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)
 create mode 100644 drivers/clocksource/timer-nuc900.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 47352d2..441c5ee 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -427,4 +427,12 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
+config NUC900_TIMER
+        bool "Clocksource timer for nuc900 platform" if COMPILE_TEST
+        depends on ARM
+        select CLKSRC_OF if OF
+        select CLKSRC_MMIO
+        help
+          Enables the clocksource for the NUC900 platform.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 473974f..c74e252 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
+obj-$(CONFIG_NUC900_TIMER)		+= timer-nuc900.o
diff --git a/drivers/clocksource/timer-nuc900.c b/drivers/clocksource/timer-nuc900.c
new file mode 100644
index 0000000..28ccbcf
--- /dev/null
+++ b/drivers/clocksource/timer-nuc900.c
@@ -0,0 +1,305 @@
+/*
+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/clockchips.h>
+#include <linux/types.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+
+#include <linux/io.h>
+#include <asm/mach/time.h>
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define TMR_TCSR0	0x00
+#define TMR_TICR0	0x04
+#define TMR_TDR0	0x08
+#define TMR_TCSR1	0x10
+#define TMR_TICR1	0x14
+#define TMR_TDR1	0x18
+#define TMR_TISR	0x60
+
+#define RESETINT	0x1f
+#define PERIODIC	(0x01 << 27)
+#define ONESHOT		(0x00 << 27)
+#define COUNTEN		(0x01 << 30)
+#define INTEN		(0x01 << 29)
+
+#define TICKS_PER_SEC	100
+/* Divider = prescale + 1 */
+#define PRESCALE	0x63
+
+#define	TDR_SHIFT	24
+#define	TDR_MASK	((1 << TDR_SHIFT) - 1)
+#define OPMODE_MASK	~(0x03 << 27)
+
+struct nuc970_clockevents {
+	struct clock_event_device clkevt;
+	unsigned int timer0_load;
+	void __iomem *base;
+};
+
+struct nuc970_clockevents *clkevt_to_nuc970(struct clock_event_device *clk)
+{
+	return container_of(clk, struct nuc970_clockevents, clkevt);
+}
+
+static int nuc970_clockevent_set(bool periodic, struct clock_event_device *clk)
+{
+	struct nuc970_clockevents *evt = clkevt_to_nuc970(clk);
+	unsigned int val;
+
+	val = readl(evt->base + TMR_TCSR0);
+	val &= OPMODE_MASK;
+
+	writel(evt->timer0_load, evt->base + TMR_TICR0);
+
+	val |= periodic ? PERIODIC:ONESHOT;
+	val |= (COUNTEN | INTEN | PRESCALE);
+
+	writel(val, evt->base + TMR_TCSR0);
+
+	return 0;
+}
+
+
+static int nuc970_clockevent_set_oneshot(struct clock_event_device *clk)
+{
+	nuc970_clockevent_set(0, clk);
+	return 0;
+}
+
+static int nuc970_clockevent_set_periodic(struct clock_event_device *clk)
+{
+	nuc970_clockevent_set(1, clk);
+	return 0;
+}
+
+static int nuc970_clockevent_setnextevent(unsigned long evtval,
+					  struct clock_event_device *clk)
+{
+	struct nuc970_clockevents *evt = clkevt_to_nuc970(clk);
+	unsigned int tcsr, tdelta;
+
+	tcsr = readl(evt->base + TMR_TCSR0);
+	tdelta = readl(evt->base + TMR_TICR0) - readl(evt->base + TMR_TDR0);
+
+	writel(evtval, evt->base + TMR_TICR0);
+
+	if (!(tcsr & COUNTEN) && ((tdelta > 2) || (tdelta == 0)))
+		writel(readl(evt->base + TMR_TCSR0) | COUNTEN,
+			     evt->base + TMR_TCSR0);
+
+	return 0;
+}
+
+static int nuc970_clockevent_shutdown(struct clock_event_device *clk)
+{
+	struct nuc970_clockevents *evt = clkevt_to_nuc970(clk);
+	unsigned int val = readl(evt->base + TMR_TCSR0) & ~(0x03 << 27);
+
+	writel(val, evt->base + TMR_TCSR0);
+
+	return 0;
+}
+
+/*IRQ handler for the timer*/
+static irqreturn_t nuc970_timer0_interrupt(int irq, void *dev_id)
+{
+	struct nuc970_clockevents *evt = dev_id;
+	struct clock_event_device *clk = &(evt->clkevt);
+
+	writel(0x01, evt->base + TMR_TISR);
+
+	clk->event_handler(clk);
+
+	return IRQ_HANDLED;
+}
+
+static int clock_event_device_init(struct clock_event_device *clk,
+				   unsigned int rate)
+{
+	clk->name = "nuc970-timer0";
+	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	clk->set_state_shutdown = nuc970_clockevent_shutdown;
+	clk->set_state_periodic = nuc970_clockevent_set_periodic;
+	clk->set_state_oneshot = nuc970_clockevent_set_oneshot;
+	clk->set_state_oneshot_stopped = nuc970_clockevent_shutdown;
+	clk->set_next_event = nuc970_clockevent_setnextevent;
+	clk->cpumask = cpumask_of(0);
+	clk->rating = 300;
+
+	clockevents_config_and_register(clk, rate, 0xf, 0xffffffff);
+	return 0;
+}
+
+static int __init nuc970_clkevt_init(struct nuc970_clockevents *evt,
+				     int irq, struct clk *clk_timer0)
+{
+	unsigned int rate = 0;
+	int ret;
+
+	/*Clockevents init*/
+	ret = clk_prepare_enable(clk_timer0);
+	if (ret) {
+		pr_err("Failed to enable clk_timer0 clock :%d.\n", ret);
+		goto err_clk_prepare_enable;
+	}
+
+	writel(0x00, evt->base + TMR_TCSR0);
+
+	rate = clk_get_rate(clk_timer0);
+	if (!rate) {
+		pr_err("Failed to get clk_timer0 rate :%d.\n", rate);
+		ret = -EINVAL;
+		goto err_clk_get_rate;
+	}
+
+	rate /= (PRESCALE + 1);
+
+	evt->timer0_load = (rate / TICKS_PER_SEC);
+
+	writel(RESETINT, evt->base + TMR_TISR);
+
+	clock_event_device_init(&(evt->clkevt), rate);
+
+	ret = request_irq(irq, nuc970_timer0_interrupt,
+			  IRQF_TIMER | IRQF_IRQPOLL, "nuc970-timer0", evt);
+	if (ret) {
+		pr_err("Failed to request irq :%d, return: %d.\n", irq, ret);
+		goto err_clk_get_rate;
+	}
+
+	return 0;
+
+err_clk_get_rate:
+	clk_disable_unprepare(clk_timer0);
+err_clk_prepare_enable:
+	return ret;
+}
+
+static int __init nuc970_clksrc_init(struct nuc970_clockevents *evt,
+				     struct clk *clk_timer1)
+{
+	unsigned int val, rate = 0;
+	int ret;
+
+	/*Clocksource init*/
+	ret = clk_prepare_enable(clk_timer1);
+	if (ret) {
+		pr_err("Failed to enable clk_timer1 clock :%d.\n", ret);
+		goto err_clk_prepare_enable;
+	}
+
+	writel(0x00, evt->base + TMR_TCSR1);
+
+	rate = clk_get_rate(clk_timer1);
+	if (!rate) {
+		pr_err("Failed to get clk_timer1 rate :%d.\n", rate);
+		ret = -EINVAL;
+		goto err_clk_get_rate;
+	}
+
+	rate /= (PRESCALE + 1);
+
+	writel(0xffffffff, evt->base + TMR_TICR1);
+
+	val = readl(evt->base + TMR_TCSR1);
+	val |= (COUNTEN | PERIODIC  | PRESCALE);
+	writel(val, evt->base + TMR_TCSR1);
+
+	ret = clocksource_mmio_init(evt->base + TMR_TDR1, "nuc970-timer1",
+			      rate, 200, TDR_SHIFT,
+			      clocksource_mmio_readl_down);
+	if (ret) {
+		pr_err("nuc970-timer1: can't register clocksource\n");
+		goto err_clk_get_rate;
+	}
+
+	return 0;
+
+err_clk_get_rate:
+	clk_disable_unprepare(clk_timer1);
+err_clk_prepare_enable:
+	return ret;
+
+}
+
+static void __init nuc970_timer_of_init(struct device_node *node)
+{
+	struct nuc970_clockevents *nuc970_evt;
+	struct clk *clk_timer0, *clk_timer1;
+	int irq, ret;
+
+	nuc970_evt = kzalloc(sizeof(struct nuc970_clockevents), GFP_KERNEL);
+	if (!nuc970_evt) {
+		ret = -ENOMEM;
+		pr_err("%s: Failed to kzalloc memory\n", node->full_name);
+		goto err_alloc_mem;
+	}
+
+	nuc970_evt->base = of_iomap(node, 0);
+	if (!nuc970_evt->base) {
+		ret = -ENOMEM;
+		pr_err("%s: Unable to map timer base\n", node->full_name);
+		goto err_iomap;
+	}
+
+	clk_timer0 = of_clk_get_by_name(node, "timer0");
+	if (IS_ERR(clk_timer0)) {
+		ret = PTR_ERR(clk_timer0);
+		pr_err("%s: Unable to get clk_timer0\n", node->full_name);
+		goto err_get_clk;
+	}
+
+	clk_timer1 = of_clk_get_by_name(node, "timer1");
+	if (IS_ERR(clk_timer1)) {
+		ret = PTR_ERR(clk_timer1);
+		pr_err("%s: Unable to get clk_timer1\n", node->full_name);
+		goto err_get_clk;
+	}
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq <= 0) {
+		ret = irq;
+		pr_err("%s: Unable to get irq\n", node->full_name);
+		goto err_get_clk;
+	}
+
+	ret = nuc970_clksrc_init(nuc970_evt, clk_timer1);
+	if (ret) {
+		pr_err("Failed to init clock source :%d.\n", ret);
+		goto err_get_clk;
+	}
+
+	nuc970_clkevt_init(nuc970_evt, irq, clk_timer0);
+	if (ret) {
+		pr_err("Failed to init clock event device :%d.\n", ret);
+		goto err_get_clk;
+	}
+
+	return;
+
+err_get_clk:
+	iounmap(nuc970_evt->base);
+err_iomap:
+	kfree(nuc970_evt);
+err_alloc_mem:
+	return;
+}
+
+CLOCKSOURCE_OF_DECLARE(nuc970, "nuvoton,nuc970-tmr", nuc970_timer_of_init);
-- 
2.7.4
