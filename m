From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:54 +0800
Subject: [PATCH v2 07/12] ARM: imx: move clock event variables into imx_timer
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we now have imx_timer structure, it makes more sense to move those
clock event related variables into the structure, so that we can save
some global variables.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 64 +++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index ceba782a1f1d..c4692e0a944f 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -83,9 +83,6 @@
 #define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
 #define timer_is_v2()	(!timer_is_v1())
 
-static struct clock_event_device clockevent_mxc;
-static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
-
 struct imx_timer {
 	enum imx_gpt_type type;
 	void __iomem *base;
@@ -93,6 +90,9 @@ struct imx_timer {
 	struct clk *clk_per;
 	struct clk *clk_ipg;
 	const struct imx_gpt_data *gpt;
+	struct clock_event_device ced;
+	enum clock_event_mode cem;
+	struct irqaction act;
 };
 
 struct imx_gpt_data {
@@ -103,6 +103,11 @@ struct imx_gpt_data {
 
 static void __iomem *timer_base;
 
+static inline struct imx_timer *to_imx_timer(struct clock_event_device *ced)
+{
+	return container_of(ced, struct imx_timer, ced);
+}
+
 static inline void gpt_irq_disable(void)
 {
 	unsigned int tmp;
@@ -207,8 +212,9 @@ static const char *clock_event_mode_label[] = {
 #endif /* DEBUG */
 
 static void mxc_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
+				struct clock_event_device *ced)
 {
+	struct imx_timer *imxtm = to_imx_timer(ced);
 	unsigned long flags;
 
 	/*
@@ -220,7 +226,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	/* Disable interrupt in GPT module */
 	gpt_irq_disable();
 
-	if (mode != clockevent_mode) {
+	if (mode != imxtm->cem) {
 		/* Set event time into far-far future */
 		if (timer_is_v2())
 			writel_relaxed(readl_relaxed(timer_base + V2_TCN) - 3,
@@ -235,12 +241,12 @@ static void mxc_set_mode(enum clock_event_mode mode,
 
 #ifdef DEBUG
 	printk(KERN_INFO "mxc_set_mode: changing mode from %s to %s\n",
-		clock_event_mode_label[clockevent_mode],
+		clock_event_mode_label[imxtm->cem],
 		clock_event_mode_label[mode]);
 #endif /* DEBUG */
 
 	/* Remember timer mode */
-	clockevent_mode = mode;
+	imxtm->cem = mode;
 	local_irq_restore(flags);
 
 	switch (mode) {
@@ -272,7 +278,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
  */
 static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = &clockevent_mxc;
+	struct clock_event_device *ced = dev_id;
 	uint32_t tstat;
 
 	if (timer_is_v2())
@@ -282,34 +288,33 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 
 	gpt_irq_acknowledge();
 
-	evt->event_handler(evt);
+	ced->event_handler(ced);
 
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
 static int __init mxc_clockevent_init(struct imx_timer *imxtm)
 {
-	clockevent_mxc.set_next_event = imxtm->gpt->set_next_event;
-	clockevent_mxc.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&clockevent_mxc,
-					clk_get_rate(imxtm->clk_per),
+	struct clock_event_device *ced = &imxtm->ced;
+	struct irqaction *act = &imxtm->act;
+
+	imxtm->cem = CLOCK_EVT_MODE_UNUSED;
+
+	ced->name = "mxc_timer1";
+	ced->features = CLOCK_EVT_FEAT_ONESHOT;
+	ced->set_mode = mxc_set_mode;
+	ced->set_next_event = imxtm->gpt->set_next_event;
+	ced->rating = 200;
+	ced->cpumask = cpumask_of(0);
+	clockevents_config_and_register(ced, clk_get_rate(imxtm->clk_per),
 					0xff, 0xfffffffe);
 
-	return 0;
+	act->name = "i.MX Timer Tick";
+	act->flags = IRQF_TIMER | IRQF_IRQPOLL;
+	act->handler = mxc_timer_interrupt;
+	act->dev_id = ced;
+
+	return setup_irq(imxtm->irq, act);
 }
 
 static void imx1_gpt_setup_tctl(struct imx_timer *imxtm)
@@ -415,9 +420,6 @@ static void __init _mxc_timer_init(struct imx_timer *imxtm)
 	/* init and register the timer to the framework */
 	mxc_clocksource_init(imxtm);
 	mxc_clockevent_init(imxtm);
-
-	/* Make irqs happen */
-	setup_irq(imxtm->irq, &mxc_timer_irq);
 }
 
 void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type)
-- 
1.9.1
