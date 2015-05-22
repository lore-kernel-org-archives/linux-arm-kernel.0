From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:57 +0800
Subject: [PATCH v2 10/12] ARM: imx: provide gpt device specific irq functions
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It splits irq enable/disable/acknowledge operations into device specific
functions as the hooks in imx_gpt_data, so that we can save the use of
timer_is_xxx() and cpu_is_xxx() checking in these irq functions.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 80 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index a4f12c75050f..5fb8397d8fe2 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -100,6 +100,9 @@ struct imx_gpt_data {
 	int reg_tcn;
 	int reg_tcmp;
 	void (*gpt_setup_tctl)(struct imx_timer *imxtm);
+	void (*gpt_irq_enable)(struct imx_timer *imxtm);
+	void (*gpt_irq_disable)(struct imx_timer *imxtm);
+	void (*gpt_irq_acknowledge)(struct imx_timer *imxtm);
 	int (*set_next_event)(unsigned long evt,
 			      struct clock_event_device *ced);
 };
@@ -109,40 +112,53 @@ static inline struct imx_timer *to_imx_timer(struct clock_event_device *ced)
 	return container_of(ced, struct imx_timer, ced);
 }
 
-static inline void gpt_irq_disable(struct imx_timer *imxtm)
+static void imx1_gpt_irq_disable(struct imx_timer *imxtm)
 {
 	unsigned int tmp;
 
-	if (timer_is_v2())
-		writel_relaxed(0, imxtm->base + V2_IR);
-	else {
-		tmp = readl_relaxed(imxtm->base + MXC_TCTL);
-		writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
-	}
+	tmp = readl_relaxed(imxtm->base + MXC_TCTL);
+	writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 }
+#define imx21_gpt_irq_disable imx1_gpt_irq_disable
 
-static inline void gpt_irq_enable(struct imx_timer *imxtm)
+static void imx31_gpt_irq_disable(struct imx_timer *imxtm)
 {
-	if (timer_is_v2())
-		writel_relaxed(1<<0, imxtm->base + V2_IR);
-	else {
-		writel_relaxed(readl_relaxed(imxtm->base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
-			imxtm->base + MXC_TCTL);
-	}
+	writel_relaxed(0, imxtm->base + V2_IR);
+}
+#define imx6dl_gpt_irq_disable imx31_gpt_irq_disable
+
+static void imx1_gpt_irq_enable(struct imx_timer *imxtm)
+{
+	unsigned int tmp;
+
+	tmp = readl_relaxed(imxtm->base + MXC_TCTL);
+	writel_relaxed(tmp | MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
+}
+#define imx21_gpt_irq_enable imx1_gpt_irq_enable
+
+static void imx31_gpt_irq_enable(struct imx_timer *imxtm)
+{
+	writel_relaxed(1<<0, imxtm->base + V2_IR);
+}
+#define imx6dl_gpt_irq_enable imx31_gpt_irq_enable
+
+static void imx1_gpt_irq_acknowledge(struct imx_timer *imxtm)
+{
+	writel_relaxed(0, imxtm->base + MX1_2_TSTAT);
 }
 
-static void gpt_irq_acknowledge(struct imx_timer *imxtm)
+static void imx21_gpt_irq_acknowledge(struct imx_timer *imxtm)
 {
-	if (timer_is_v1()) {
-		if (cpu_is_mx1())
-			writel_relaxed(0, imxtm->base + MX1_2_TSTAT);
-		else
-			writel_relaxed(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
+	writel_relaxed(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
 				imxtm->base + MX1_2_TSTAT);
-	} else if (timer_is_v2())
-		writel_relaxed(V2_TSTAT_OF1, imxtm->base + V2_TSTAT);
 }
 
+static void imx31_gpt_irq_acknowledge(struct imx_timer *imxtm)
+{
+	writel_relaxed(V2_TSTAT_OF1, imxtm->base + V2_TSTAT);
+}
+#define imx6dl_gpt_irq_acknowledge imx31_gpt_irq_acknowledge
+
 static void __iomem *sched_clock_reg;
 
 static u64 notrace mxc_read_sched_clock(void)
@@ -227,7 +243,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
-	gpt_irq_disable(imxtm);
+	imxtm->gpt->gpt_irq_disable(imxtm);
 
 	if (mode != imxtm->cem) {
 		u32 tcn = readl_relaxed(imxtm->base + imxtm->gpt->reg_tcn);
@@ -235,7 +251,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 		writel_relaxed(tcn - 3, imxtm->base + imxtm->gpt->reg_tcmp);
 
 		/* Clear pending interrupt */
-		gpt_irq_acknowledge(imxtm);
+		imxtm->gpt->gpt_irq_acknowledge(imxtm);
 	}
 
 #ifdef DEBUG
@@ -261,7 +277,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	 * mode switching
 	 */
 		local_irq_save(flags);
-		gpt_irq_enable(imxtm);
+		imxtm->gpt->gpt_irq_enable(imxtm);
 		local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
@@ -283,7 +299,7 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 
 	tstat = readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
 
-	gpt_irq_acknowledge(imxtm);
+	imxtm->gpt->gpt_irq_acknowledge(imxtm);
 
 	ced->event_handler(ced);
 
@@ -357,6 +373,9 @@ static const struct imx_gpt_data imx1_gpt_data = {
 	.reg_tstat = MX1_2_TSTAT,
 	.reg_tcn = MX1_2_TCN,
 	.reg_tcmp = MX1_2_TCMP,
+	.gpt_irq_enable = imx1_gpt_irq_enable,
+	.gpt_irq_disable = imx1_gpt_irq_disable,
+	.gpt_irq_acknowledge = imx1_gpt_irq_acknowledge,
 	.gpt_setup_tctl = imx1_gpt_setup_tctl,
 	.set_next_event = mx1_2_set_next_event,
 };
@@ -365,6 +384,9 @@ static const struct imx_gpt_data imx21_gpt_data = {
 	.reg_tstat = MX1_2_TSTAT,
 	.reg_tcn = MX1_2_TCN,
 	.reg_tcmp = MX1_2_TCMP,
+	.gpt_irq_enable = imx21_gpt_irq_enable,
+	.gpt_irq_disable = imx21_gpt_irq_disable,
+	.gpt_irq_acknowledge = imx21_gpt_irq_acknowledge,
 	.gpt_setup_tctl = imx21_gpt_setup_tctl,
 	.set_next_event = mx1_2_set_next_event,
 };
@@ -373,6 +395,9 @@ static const struct imx_gpt_data imx31_gpt_data = {
 	.reg_tstat = V2_TSTAT,
 	.reg_tcn = V2_TCN,
 	.reg_tcmp = V2_TCMP,
+	.gpt_irq_enable = imx31_gpt_irq_enable,
+	.gpt_irq_disable = imx31_gpt_irq_disable,
+	.gpt_irq_acknowledge = imx31_gpt_irq_acknowledge,
 	.gpt_setup_tctl = imx31_gpt_setup_tctl,
 	.set_next_event = v2_set_next_event,
 };
@@ -381,6 +406,9 @@ static const struct imx_gpt_data imx6dl_gpt_data = {
 	.reg_tstat = V2_TSTAT,
 	.reg_tcn = V2_TCN,
 	.reg_tcmp = V2_TCMP,
+	.gpt_irq_enable = imx6dl_gpt_irq_enable,
+	.gpt_irq_disable = imx6dl_gpt_irq_disable,
+	.gpt_irq_acknowledge = imx6dl_gpt_irq_acknowledge,
 	.gpt_setup_tctl = imx6dl_gpt_setup_tctl,
 	.set_next_event = v2_set_next_event,
 };
-- 
1.9.1
