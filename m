From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Wed, 29 Apr 2015 09:14:41 -0500
Subject: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
 independent of SoCs.
Message-ID: <1430316881-4668-1-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 4 versions of the timer hardware on Freescale MXC hardware.
--Version 0: MX1/MXL
--Version 1: MX21, MX27.
--Version 2: MX25, MX31, MX35, MX37, MX51, MX6Q
--Version 3: MX6DL, MX6SX

This patch has removed the SoC related codes, and implemented the driver
directly upon the hardware timer IP version.

The new driver can be installed via device tree or the direct function
call to mxc_timer_init in order to support imx legacy systems like MX21
and MX27.

For the device tree implementation, the driver is compatible with the current
bindings like "fsl,imx6q-gpt", but for future dts file, the string like
"fsl,imx-gpt-v2" without SoC information is recommended.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/clk-imx1.c  |   2 +-
 arch/arm/mach-imx/clk-imx21.c |   3 +-
 arch/arm/mach-imx/clk-imx27.c |   3 +-
 arch/arm/mach-imx/clk-imx31.c |   3 +-
 arch/arm/mach-imx/clk-imx35.c |   5 +-
 arch/arm/mach-imx/common.h    |   2 +-
 arch/arm/mach-imx/time.c      | 435 ++++++++++++++++++++++++++++++------------
 7 files changed, 328 insertions(+), 125 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 37c307a..57ba8d5 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -98,7 +98,7 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-fb.0");
 	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ahb", "imx1-fb.0");
 
-	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT);
+	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT, 0);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index 4b4c753..21a1061 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -153,7 +153,8 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[IMX21_CLK_I2C_GATE], NULL, "imx21-i2c.0");
 	clk_register_clkdev(clk[IMX21_CLK_OWIRE_GATE], NULL, "mxc_w1.0");
 
-	mxc_timer_init(MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR), MX21_INT_GPT1);
+	/*Timer version in MX21 is v1*/
+	mxc_timer_init(MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR), MX21_INT_GPT1, 1);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index ab6349e..0cf532c 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -229,7 +229,8 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[IMX27_CLK_EMMA_AHB_GATE], "ahb", "m2m-emmaprp.0");
 	clk_register_clkdev(clk[IMX27_CLK_EMMA_IPG_GATE], "ipg", "m2m-emmaprp.0");
 
-	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
+	/*Timer version in MX27 is v1*/
+	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1, 1);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 286ef422..c863390 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -182,7 +182,8 @@ int __init mx31_clocks_init(unsigned long fref)
 	mx31_revision();
 	clk_disable_unprepare(clk[iim_gate]);
 
-	mxc_timer_init(MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR), MX31_INT_GPT);
+	/*Timer version in MX31 is v2*/
+	mxc_timer_init(MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR), MX31_INT_GPT, 2);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index a0d2b57..532fc21 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -128,7 +128,7 @@ int __init mx35_clocks_init(void)
 	clk[esdhc3_div] = imx_clk_divider("esdhc3_div", "esdhc_sel", base + MX35_CCM_PDR3, 16, 6);
 
 	clk[spdif_sel] = imx_clk_mux("spdif_sel", base + MX35_CCM_PDR3, 22, 1, std_sel, ARRAY_SIZE(std_sel));
-	clk[spdif_div_pre] = imx_clk_divider("spdif_div_pre", "spdif_sel", base + MX35_CCM_PDR3, 29, 3); /* divide by 1 not allowed */ 
+	clk[spdif_div_pre] = imx_clk_divider("spdif_div_pre", "spdif_sel", base + MX35_CCM_PDR3, 29, 3); /* divide by 1 not allowed */
 	clk[spdif_div_post] = imx_clk_divider("spdif_div_post", "spdif_div_pre", base + MX35_CCM_PDR3, 23, 6);
 
 	clk[ssi_sel] = imx_clk_mux("ssi_sel", base + MX35_CCM_PDR2, 6, 1, std_sel, ARRAY_SIZE(std_sel));
@@ -279,7 +279,8 @@ int __init mx35_clocks_init(void)
 #ifdef CONFIG_MXC_USE_EPIT
 	epit_timer_init(MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
 #else
-	mxc_timer_init(MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);
+	/*Timer version in MX35 is v2*/
+	mxc_timer_init(MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT, 2);
 #endif
 
 	return 0;
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 0f04e30..851ae58 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -44,7 +44,7 @@ void imx27_soc_init(void);
 void imx31_soc_init(void);
 void imx35_soc_init(void);
 void epit_timer_init(void __iomem *base, int irq);
-void mxc_timer_init(void __iomem *, int);
+void mxc_timer_init(void __iomem *, int, int);
 int mx1_clocks_init(unsigned long fref);
 int mx21_clocks_init(unsigned long lref, unsigned long fref);
 int mx27_clocks_init(unsigned long fref);
diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 15d18e1..2543f8e 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/slab.h>
 
 #include <asm/mach/time.h>
 
@@ -38,9 +39,11 @@
 #include "hardware.h"
 
 /*
- * There are 2 versions of the timer hardware on Freescale MXC hardware.
- * Version 1: MX1/MXL, MX21, MX27.
- * Version 2: MX25, MX31, MX35, MX37, MX51
+ * There are 4 versions of the timer hardware on Freescale MXC hardware.
+ * Version 0: MX1/MXL
+ * Version 1: MX21, MX27.
+ * Version 2: MX25, MX31, MX35, MX37, MX51, MX6Q
+ * Version 3: MX6DL, MX6SX
  */
 
 /* defines common for all i.MX */
@@ -76,46 +79,67 @@
 
 #define V2_TIMER_RATE_OSC_DIV8	3000000
 
-#define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
-#define timer_is_v2()	(!timer_is_v1())
+#define IMX_TIMER_V0         (0)
+#define IMX_TIMER_V1         (1)
+#define IMX_TIMER_V2         (2)
+#define IMX_TIMER_V3         (3)
+
+struct imx_timer {
+	void __iomem *timer_base;
+	int version;
+	struct clock_event_device evt;
+	struct irqaction act;
+	void (*gpt_irq_enable)(struct imx_timer *);
+	void (*gpt_irq_disable)(struct imx_timer *);
+	void (*gpt_irq_acknowledge)(struct imx_timer *);
+};
+
+static void gpt_irq_disable_v0_v1(struct imx_timer *tm)
+{
+	unsigned int tmp;
 
-static struct clock_event_device clockevent_mxc;
-static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
+	tmp = __raw_readl(tm->timer_base + MXC_TCTL);
+	__raw_writel(tmp & ~MX1_2_TCTL_IRQEN, tm->timer_base + MXC_TCTL);
 
-static void __iomem *timer_base;
+}
 
-static inline void gpt_irq_disable(void)
+static void gpt_irq_disable_v2_v3(struct imx_timer *tm)
 {
-	unsigned int tmp;
+	__raw_writel(0, tm->timer_base + V2_IR);
 
-	if (timer_is_v2())
-		__raw_writel(0, timer_base + V2_IR);
-	else {
-		tmp = __raw_readl(timer_base + MXC_TCTL);
-		__raw_writel(tmp & ~MX1_2_TCTL_IRQEN, timer_base + MXC_TCTL);
-	}
 }
 
-static inline void gpt_irq_enable(void)
+static void gpt_irq_enable_v0_v1(struct imx_timer *tm)
 {
-	if (timer_is_v2())
-		__raw_writel(1<<0, timer_base + V2_IR);
-	else {
-		__raw_writel(__raw_readl(timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
-			timer_base + MXC_TCTL);
-	}
+	__raw_writel(__raw_readl(tm->timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
+			tm->timer_base + MXC_TCTL);
+}
+
+static void gpt_irq_enable_v2_v3(struct imx_timer *tm)
+{
+	__raw_writel(1, tm->timer_base + V2_IR);
+}
+
+static void gpt_irq_acknowledge_v0(struct imx_timer *tm)
+{
+	__raw_readl(tm->timer_base + MX1_2_TSTAT);
+
+	__raw_writel(0, tm->timer_base + MX1_2_TSTAT);
 }
 
-static void gpt_irq_acknowledge(void)
+static void gpt_irq_acknowledge_v1(struct imx_timer *tm)
 {
-	if (timer_is_v1()) {
-		if (cpu_is_mx1())
-			__raw_writel(0, timer_base + MX1_2_TSTAT);
-		else
-			__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
-				timer_base + MX1_2_TSTAT);
-	} else if (timer_is_v2())
-		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
+	__raw_readl(tm->timer_base + MX1_2_TSTAT);
+
+	__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
+			tm->timer_base + MX1_2_TSTAT);
+}
+
+static void gpt_irq_acknowledge_v2_v3(struct imx_timer *tm)
+{
+	__raw_readl(tm->timer_base + V2_TSTAT);
+
+	__raw_writel(V2_TSTAT_OF1, tm->timer_base + V2_TSTAT);
 }
 
 static void __iomem *sched_clock_reg;
@@ -132,10 +156,11 @@ static unsigned long imx_read_current_timer(void)
 	return __raw_readl(sched_clock_reg);
 }
 
-static int __init mxc_clocksource_init(struct clk *timer_clk)
+static int __init mxc_clocksource_init(struct clk *timer_clk, void __iomem *reg)
 {
 	unsigned int c = clk_get_rate(timer_clk);
-	void __iomem *reg = timer_base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
+
+	BUG_ON(!reg);
 
 	imx_delay_timer.read_current_timer = &imx_read_current_timer;
 	imx_delay_timer.freq = c;
@@ -150,30 +175,32 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 
 /* clock event */
 
-static int mx1_2_set_next_event(unsigned long evt,
-			      struct clock_event_device *unused)
+static int mx1_2_set_next_event(unsigned long event,
+			      struct clock_event_device *evt_dev)
 {
 	unsigned long tcmp;
+	struct imx_timer *tm = container_of(evt_dev, struct imx_timer, evt);
 
-	tcmp = __raw_readl(timer_base + MX1_2_TCN) + evt;
+	tcmp = __raw_readl(tm->timer_base + MX1_2_TCN) + event;
 
-	__raw_writel(tcmp, timer_base + MX1_2_TCMP);
+	__raw_writel(tcmp, tm->timer_base + MX1_2_TCMP);
 
-	return (int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
+	return (int)(tcmp - __raw_readl(tm->timer_base + MX1_2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
-static int v2_set_next_event(unsigned long evt,
-			      struct clock_event_device *unused)
+static int v2_set_next_event(unsigned long event,
+			      struct clock_event_device *evt_dev)
 {
 	unsigned long tcmp;
+	struct imx_timer *tm = container_of(evt_dev, struct imx_timer, evt);
 
-	tcmp = __raw_readl(timer_base + V2_TCN) + evt;
+	tcmp = __raw_readl(tm->timer_base + V2_TCN) + event;
 
-	__raw_writel(tcmp, timer_base + V2_TCMP);
+	__raw_writel(tcmp, tm->timer_base + V2_TCMP);
 
-	return evt < 0x7fffffff &&
-		(int)(tcmp - __raw_readl(timer_base + V2_TCN)) < 0 ?
+	return event < 0x7fffffff &&
+		(int)(tcmp - __raw_readl(tm->timer_base + V2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
@@ -188,9 +215,11 @@ static const char *clock_event_mode_label[] = {
 #endif /* DEBUG */
 
 static void mxc_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
+				struct clock_event_device *evt_dev)
 {
 	unsigned long flags;
+	static enum clock_event_mode last_mode = CLOCK_EVT_MODE_UNUSED;
+	struct imx_timer *tm = container_of(evt_dev, struct imx_timer, evt);
 
 	/*
 	 * The timer interrupt generation is disabled@least
@@ -199,29 +228,24 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
-	gpt_irq_disable();
+	tm->gpt_irq_disable(tm);
 
-	if (mode != clockevent_mode) {
+	if (mode != last_mode) {
 		/* Set event time into far-far future */
-		if (timer_is_v2())
-			__raw_writel(__raw_readl(timer_base + V2_TCN) - 3,
-					timer_base + V2_TCMP);
-		else
-			__raw_writel(__raw_readl(timer_base + MX1_2_TCN) - 3,
-					timer_base + MX1_2_TCMP);
+		evt_dev->set_next_event(-3, evt_dev);
 
 		/* Clear pending interrupt */
-		gpt_irq_acknowledge();
+		tm->gpt_irq_acknowledge(tm);
 	}
 
 #ifdef DEBUG
 	printk(KERN_INFO "mxc_set_mode: changing mode from %s to %s\n",
-		clock_event_mode_label[clockevent_mode],
+		clock_event_mode_label[last_mode],
 		clock_event_mode_label[mode]);
 #endif /* DEBUG */
 
 	/* Remember timer mode */
-	clockevent_mode = mode;
+	last_mode = mode;
 	local_irq_restore(flags);
 
 	switch (mode) {
@@ -237,7 +261,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	 * mode switching
 	 */
 		local_irq_save(flags);
-		gpt_irq_enable();
+		tm->gpt_irq_enable(tm);
 		local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
@@ -253,50 +277,33 @@ static void mxc_set_mode(enum clock_event_mode mode,
  */
 static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = &clockevent_mxc;
-	uint32_t tstat;
+	struct imx_timer *tm = dev_id;
+	void (*event_handler)(struct clock_event_device *);
 
-	if (timer_is_v2())
-		tstat = __raw_readl(timer_base + V2_TSTAT);
-	else
-		tstat = __raw_readl(timer_base + MX1_2_TSTAT);
+	BUG_ON(!tm);
 
-	gpt_irq_acknowledge();
+	tm->gpt_irq_acknowledge(tm);
 
-	evt->event_handler(evt);
+	event_handler = ACCESS_ONCE(tm->evt.event_handler);
+	if (event_handler)
+		event_handler(&tm->evt);
 
 	return IRQ_HANDLED;
 }
 
-static struct irqaction mxc_timer_irq = {
-	.name		= "i.MX Timer Tick",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= mxc_timer_interrupt,
-};
-
-static struct clock_event_device clockevent_mxc = {
-	.name		= "mxc_timer1",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= mxc_set_mode,
-	.set_next_event	= mx1_2_set_next_event,
-	.rating		= 200,
-};
-
-static int __init mxc_clockevent_init(struct clk *timer_clk)
+static int __init mxc_clockevent_init(struct clk *timer_clk,
+		struct imx_timer *tm)
 {
-	if (timer_is_v2())
-		clockevent_mxc.set_next_event = v2_set_next_event;
-
-	clockevent_mxc.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&clockevent_mxc,
+	tm->evt.cpumask = cpumask_of(0);
+	clockevents_config_and_register(&tm->evt,
 					clk_get_rate(timer_clk),
 					0xff, 0xfffffffe);
 
 	return 0;
 }
 
-static void __init _mxc_timer_init(int irq,
-				   struct clk *clk_per, struct clk *clk_ipg)
+static void __init _mxc_timer_init_v0_v1(int irq, struct clk *clk_per,
+		struct clk *clk_ipg, struct imx_timer *tm)
 {
 	uint32_t tctl_val;
 
@@ -314,56 +321,231 @@ static void __init _mxc_timer_init(int irq,
 	 * Initialise to a known state (all timers off, and timing reset)
 	 */
 
-	__raw_writel(0, timer_base + MXC_TCTL);
-	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
-
-	if (timer_is_v2()) {
-		tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
-		if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8) {
-			tctl_val |= V2_TCTL_CLK_OSC_DIV8;
-			if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
-				/* 24 / 8 = 3 MHz */
-				__raw_writel(7 << V2_TPRER_PRE24M,
-					timer_base + MXC_TPRER);
-				tctl_val |= V2_TCTL_24MEN;
-			}
-		} else {
-			tctl_val |= V2_TCTL_CLK_PER;
-		}
+	__raw_writel(0, tm->timer_base + MXC_TCTL);
+	__raw_writel(0, tm->timer_base + MXC_TPRER); /* see datasheet note */
+
+	tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
+
+	__raw_writel(tctl_val, tm->timer_base + MXC_TCTL);
+
+	/* init and register the timer to the framework */
+	mxc_clocksource_init(clk_per, tm->timer_base + MX1_2_TCN);
+
+	tm->evt.set_next_event = mx1_2_set_next_event;
+	mxc_clockevent_init(clk_per, tm);
+
+	/* Make irqs happen */
+	setup_irq(irq, &tm->act);
+}
+
+static void __init _mxc_timer_init_v2(int irq, struct clk *clk_per,
+		struct clk *clk_ipg, struct imx_timer *tm)
+{
+	uint32_t tctl_val;
+
+	if (IS_ERR(clk_per)) {
+		pr_err("i.MX timer: unable to get clk\n");
+		return;
+	}
+
+	if (!IS_ERR(clk_ipg))
+		clk_prepare_enable(clk_ipg);
+
+	clk_prepare_enable(clk_per);
+
+	/*
+	 * Initialise to a known state (all timers off, and timing reset)
+	 */
+
+	__raw_writel(0, tm->timer_base + MXC_TCTL);
+	__raw_writel(0, tm->timer_base + MXC_TPRER); /* see datasheet note */
+
+	tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+
+	if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8)
+		tctl_val |= V2_TCTL_CLK_OSC_DIV8;
+	else
+		tctl_val |= V2_TCTL_CLK_PER;
+
+	__raw_writel(tctl_val, tm->timer_base + MXC_TCTL);
+
+	/* init and register the timer to the framework */
+	mxc_clocksource_init(clk_per, tm->timer_base + V2_TCN);
+
+	tm->evt.set_next_event = v2_set_next_event;
+	mxc_clockevent_init(clk_per, tm);
+
+	/* Make irqs happen */
+	setup_irq(irq, &tm->act);
+}
+
+static void __init _mxc_timer_init_v3(int irq, struct clk *clk_per,
+		struct clk *clk_ipg, struct imx_timer *tm)
+{
+	uint32_t tctl_val;
+
+	if (IS_ERR(clk_per)) {
+		pr_err("i.MX timer: unable to get clk\n");
+		return;
+	}
+
+	if (!IS_ERR(clk_ipg))
+		clk_prepare_enable(clk_ipg);
+
+	clk_prepare_enable(clk_per);
+
+	/*
+	 * Initialise to a known state (all timers off, and timing reset)
+	 */
+
+	__raw_writel(0, tm->timer_base + MXC_TCTL);
+	__raw_writel(0, tm->timer_base + MXC_TPRER); /* see datasheet note */
+
+	tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+
+	if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8) {
+		tctl_val |= V2_TCTL_CLK_OSC_DIV8;
+		/* 24 / 8 = 3 MHz */
+		__raw_writel(7 << V2_TPRER_PRE24M,
+					tm->timer_base + MXC_TPRER);
+		tctl_val |= V2_TCTL_24MEN;
 	} else {
-		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
+		tctl_val |= V2_TCTL_CLK_PER;
 	}
 
-	__raw_writel(tctl_val, timer_base + MXC_TCTL);
+	__raw_writel(tctl_val, tm->timer_base + MXC_TCTL);
 
 	/* init and register the timer to the framework */
-	mxc_clocksource_init(clk_per);
-	mxc_clockevent_init(clk_per);
+	mxc_clocksource_init(clk_per, tm->timer_base + V2_TCN);
+
+	tm->evt.set_next_event = v2_set_next_event;
+	mxc_clockevent_init(clk_per, tm);
 
 	/* Make irqs happen */
-	setup_irq(irq, &mxc_timer_irq);
+	setup_irq(irq, &tm->act);
 }
 
-void __init mxc_timer_init(void __iomem *base, int irq)
+static void __init _mxc_timer_init(int irq, struct clk *clk_per,
+		struct clk *clk_ipg, struct imx_timer *tm)
 {
+
+	switch (tm->version) {
+	case IMX_TIMER_V0:
+		tm->gpt_irq_enable = gpt_irq_enable_v0_v1;
+		tm->gpt_irq_disable = gpt_irq_disable_v0_v1;
+		tm->gpt_irq_acknowledge = gpt_irq_acknowledge_v0;
+		_mxc_timer_init_v0_v1(irq, clk_per, clk_ipg, tm);
+		break;
+
+	case IMX_TIMER_V1:
+		tm->gpt_irq_enable = gpt_irq_enable_v0_v1;
+		tm->gpt_irq_disable = gpt_irq_disable_v0_v1;
+		tm->gpt_irq_acknowledge = gpt_irq_acknowledge_v1;
+		_mxc_timer_init_v0_v1(irq, clk_per, clk_ipg, tm);
+		break;
+
+	case IMX_TIMER_V2:
+		tm->gpt_irq_enable = gpt_irq_enable_v2_v3;
+		tm->gpt_irq_disable = gpt_irq_disable_v2_v3;
+		tm->gpt_irq_acknowledge = gpt_irq_acknowledge_v2_v3;
+		_mxc_timer_init_v2(irq, clk_per, clk_ipg, tm);
+		break;
+
+	case IMX_TIMER_V3:
+		tm->gpt_irq_enable = gpt_irq_enable_v2_v3;
+		tm->gpt_irq_disable = gpt_irq_disable_v2_v3;
+		tm->gpt_irq_acknowledge = gpt_irq_acknowledge_v2_v3;
+		_mxc_timer_init_v3(irq, clk_per, clk_ipg, tm);
+		break;
+
+	default:
+		pr_err("<%s> timer device node is not supported\r\n", __func__);
+		break;
+
+	}
+}
+
+void __init mxc_timer_init(void __iomem *base, int irq, int ver)
+{
+	struct imx_timer *timer;
 	struct clk *clk_per = clk_get_sys("imx-gpt.0", "per");
 	struct clk *clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
 
-	timer_base = base;
-
-	_mxc_timer_init(irq, clk_per, clk_ipg);
+	timer = kzalloc(sizeof(struct imx_timer), GFP_KERNEL);
+	if (!timer)
+		panic("Can't allocate timer struct\n");
+
+	timer->timer_base = base;
+	timer->version = ver;
+	timer->evt.name = "mxc_timer1";
+	timer->evt.rating = 200;
+	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
+	timer->evt.set_mode = mxc_set_mode;
+	timer->evt.set_next_event = v2_set_next_event;
+	timer->act.name = "i.MX Timer Tick";
+	timer->act.flags = IRQF_TIMER | IRQF_IRQPOLL;
+	timer->act.dev_id = timer;
+	timer->act.handler = mxc_timer_interrupt;
+
+	_mxc_timer_init(irq, clk_per, clk_ipg, timer);
 }
 
+
+struct imx_timer_ip_combo {
+	const char	*compat;
+	int		version;
+};
+
+static struct imx_timer_ip_combo imx_timer_tables[] = {
+	{"fsl,imx-gpt-v0",	IMX_TIMER_V0},
+	{"fsl,imx-gpt-v1",	IMX_TIMER_V1},
+	{"fsl,imx-gpt-v2",	IMX_TIMER_V2},
+	{"fsl,imx-gpt-v3",	IMX_TIMER_V3},
+	{"fsl,imx1-gpt",	IMX_TIMER_V0},
+	{"fsl,imx25-gpt",	IMX_TIMER_V2},
+	{"fsl,imx25-gpt",	IMX_TIMER_V2},
+	{"fsl,imx50-gpt",	IMX_TIMER_V2},
+	{"fsl,imx51-gpt",	IMX_TIMER_V2},
+	{"fsl,imx53-gpt",	IMX_TIMER_V2},
+	{"fsl,imx6q-gpt",	IMX_TIMER_V2},
+	{"fsl,imx6sl-gpt",	IMX_TIMER_V3},
+	{"fsl,imx6sx-gpt",	IMX_TIMER_V3},
+};
+
+
+
 static void __init mxc_timer_init_dt(struct device_node *np)
 {
 	struct clk *clk_per, *clk_ipg;
-	int irq;
+	int irq, i, ret, ver;
+	struct imx_timer *timer;
+
+	if (sched_clock_reg)
+		return;
+
+	for (i =  0; i < sizeof(imx_timer_tables) /
+			sizeof(struct imx_timer_ip_combo); i++) {
+		ret = of_device_is_compatible(np, imx_timer_tables[i].compat);
+		if (ret) {
+			ver = imx_timer_tables[i].version;
+			pr_err("<%s> compatible=%s timer_version=%d\r\n",
+				__func__, imx_timer_tables[i].compat, ver);
+			break;
+		}
+	}
 
-	if (timer_base)
+	if (!ret) {
+		pr_err("<%s> timer device node is not supported\r\n", __func__);
 		return;
+	}
+
+	timer = kzalloc(sizeof(struct imx_timer), GFP_KERNEL);
+	if (!timer)
+		panic("Can't allocate timer struct\n");
+
+	timer->timer_base = of_iomap(np, 0);
+	WARN_ON(!timer->timer_base || !ret);
 
-	timer_base = of_iomap(np, 0);
-	WARN_ON(!timer_base);
 	irq = irq_of_parse_and_map(np, 0);
 
 	clk_ipg = of_clk_get_by_name(np, "ipg");
@@ -373,8 +555,25 @@ static void __init mxc_timer_init_dt(struct device_node *np)
 	if (IS_ERR(clk_per))
 		clk_per = of_clk_get_by_name(np, "per");
 
-	_mxc_timer_init(irq, clk_per, clk_ipg);
+
+	timer->version = ver;
+	timer->evt.name = np->name;
+	timer->evt.rating = 200;
+	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
+	timer->evt.set_mode = mxc_set_mode;
+	timer->evt.set_next_event = v2_set_next_event;
+	timer->act.name = np->name;
+	timer->act.flags = IRQF_TIMER | IRQF_IRQPOLL;
+	timer->act.dev_id = timer;
+	timer->act.handler = mxc_timer_interrupt;
+
+	_mxc_timer_init(irq, clk_per, clk_ipg, timer);
 }
+
+CLOCKSOURCE_OF_DECLARE(mx_timer_v0, "fsl,imx-gpt-v0", mxc_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(mx_timer_v1, "fsl,imx-gpt-v1", mxc_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(mx_timer_v2, "fsl,imx-gpt-v2", mxc_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(mx_timer_v3, "fsl,imx-gpt-v3", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx25_timer, "fsl,imx25-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx50_timer, "fsl,imx50-gpt", mxc_timer_init_dt);
-- 
1.9.1
