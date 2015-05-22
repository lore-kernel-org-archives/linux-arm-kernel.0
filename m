From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:56 +0800
Subject: [PATCH v2 09/12] ARM: imx: get rid of variable timer_base
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have pointer to imx_timer structure available where timer base
address is needed, so we can just kill global timer_base by using
imxtm->base instead.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 55 +++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index da1ad20d2c1d..a4f12c75050f 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -104,45 +104,43 @@ struct imx_gpt_data {
 			      struct clock_event_device *ced);
 };
 
-static void __iomem *timer_base;
-
 static inline struct imx_timer *to_imx_timer(struct clock_event_device *ced)
 {
 	return container_of(ced, struct imx_timer, ced);
 }
 
-static inline void gpt_irq_disable(void)
+static inline void gpt_irq_disable(struct imx_timer *imxtm)
 {
 	unsigned int tmp;
 
 	if (timer_is_v2())
-		writel_relaxed(0, timer_base + V2_IR);
+		writel_relaxed(0, imxtm->base + V2_IR);
 	else {
-		tmp = readl_relaxed(timer_base + MXC_TCTL);
-		writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, timer_base + MXC_TCTL);
+		tmp = readl_relaxed(imxtm->base + MXC_TCTL);
+		writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 	}
 }
 
-static inline void gpt_irq_enable(void)
+static inline void gpt_irq_enable(struct imx_timer *imxtm)
 {
 	if (timer_is_v2())
-		writel_relaxed(1<<0, timer_base + V2_IR);
+		writel_relaxed(1<<0, imxtm->base + V2_IR);
 	else {
-		writel_relaxed(readl_relaxed(timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
-			timer_base + MXC_TCTL);
+		writel_relaxed(readl_relaxed(imxtm->base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
+			imxtm->base + MXC_TCTL);
 	}
 }
 
-static void gpt_irq_acknowledge(void)
+static void gpt_irq_acknowledge(struct imx_timer *imxtm)
 {
 	if (timer_is_v1()) {
 		if (cpu_is_mx1())
-			writel_relaxed(0, timer_base + MX1_2_TSTAT);
+			writel_relaxed(0, imxtm->base + MX1_2_TSTAT);
 		else
 			writel_relaxed(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
-				timer_base + MX1_2_TSTAT);
+				imxtm->base + MX1_2_TSTAT);
 	} else if (timer_is_v2())
-		writel_relaxed(V2_TSTAT_OF1, timer_base + V2_TSTAT);
+		writel_relaxed(V2_TSTAT_OF1, imxtm->base + V2_TSTAT);
 }
 
 static void __iomem *sched_clock_reg;
@@ -178,29 +176,31 @@ static int __init mxc_clocksource_init(struct imx_timer *imxtm)
 /* clock event */
 
 static int mx1_2_set_next_event(unsigned long evt,
-			      struct clock_event_device *unused)
+			      struct clock_event_device *ced)
 {
+	struct imx_timer *imxtm = to_imx_timer(ced);
 	unsigned long tcmp;
 
-	tcmp = readl_relaxed(timer_base + MX1_2_TCN) + evt;
+	tcmp = readl_relaxed(imxtm->base + MX1_2_TCN) + evt;
 
-	writel_relaxed(tcmp, timer_base + MX1_2_TCMP);
+	writel_relaxed(tcmp, imxtm->base + MX1_2_TCMP);
 
-	return (int)(tcmp - readl_relaxed(timer_base + MX1_2_TCN)) < 0 ?
+	return (int)(tcmp - readl_relaxed(imxtm->base + MX1_2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
 static int v2_set_next_event(unsigned long evt,
-			      struct clock_event_device *unused)
+			      struct clock_event_device *ced)
 {
+	struct imx_timer *imxtm = to_imx_timer(ced);
 	unsigned long tcmp;
 
-	tcmp = readl_relaxed(timer_base + V2_TCN) + evt;
+	tcmp = readl_relaxed(imxtm->base + V2_TCN) + evt;
 
-	writel_relaxed(tcmp, timer_base + V2_TCMP);
+	writel_relaxed(tcmp, imxtm->base + V2_TCMP);
 
 	return evt < 0x7fffffff &&
-		(int)(tcmp - readl_relaxed(timer_base + V2_TCN)) < 0 ?
+		(int)(tcmp - readl_relaxed(imxtm->base + V2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
@@ -227,7 +227,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
-	gpt_irq_disable();
+	gpt_irq_disable(imxtm);
 
 	if (mode != imxtm->cem) {
 		u32 tcn = readl_relaxed(imxtm->base + imxtm->gpt->reg_tcn);
@@ -235,7 +235,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 		writel_relaxed(tcn - 3, imxtm->base + imxtm->gpt->reg_tcmp);
 
 		/* Clear pending interrupt */
-		gpt_irq_acknowledge();
+		gpt_irq_acknowledge(imxtm);
 	}
 
 #ifdef DEBUG
@@ -261,7 +261,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	 * mode switching
 	 */
 		local_irq_save(flags);
-		gpt_irq_enable();
+		gpt_irq_enable(imxtm);
 		local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
@@ -283,7 +283,7 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 
 	tstat = readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
 
-	gpt_irq_acknowledge();
+	gpt_irq_acknowledge(imxtm);
 
 	ced->event_handler(ced);
 
@@ -387,9 +387,6 @@ static const struct imx_gpt_data imx6dl_gpt_data = {
 
 static void __init _mxc_timer_init(struct imx_timer *imxtm)
 {
-	/* Temporary */
-	timer_base = imxtm->base;
-
 	switch (imxtm->type) {
 	case GPT_TYPE_IMX1:
 		imxtm->gpt = &imx1_gpt_data;
-- 
1.9.1
