From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:55 +0800
Subject: [PATCH v2 08/12] ARM: imx: define gpt register offset per device type
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It defines offset of gpt registers TSTAT, TCN and TCMP per device
type in imx_gpt_data, so that these registers can be accessed in an
way without timer_is_v2() checking.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index c4692e0a944f..da1ad20d2c1d 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -96,6 +96,9 @@ struct imx_timer {
 };
 
 struct imx_gpt_data {
+	int reg_tstat;
+	int reg_tcn;
+	int reg_tcmp;
 	void (*gpt_setup_tctl)(struct imx_timer *imxtm);
 	int (*set_next_event)(unsigned long evt,
 			      struct clock_event_device *ced);
@@ -159,7 +162,7 @@ static unsigned long imx_read_current_timer(void)
 static int __init mxc_clocksource_init(struct imx_timer *imxtm)
 {
 	unsigned int c = clk_get_rate(imxtm->clk_per);
-	void __iomem *reg = imxtm->base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
+	void __iomem *reg = imxtm->base + imxtm->gpt->reg_tcn;
 
 	imx_delay_timer.read_current_timer = &imx_read_current_timer;
 	imx_delay_timer.freq = c;
@@ -227,13 +230,9 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	gpt_irq_disable();
 
 	if (mode != imxtm->cem) {
+		u32 tcn = readl_relaxed(imxtm->base + imxtm->gpt->reg_tcn);
 		/* Set event time into far-far future */
-		if (timer_is_v2())
-			writel_relaxed(readl_relaxed(timer_base + V2_TCN) - 3,
-					timer_base + V2_TCMP);
-		else
-			writel_relaxed(readl_relaxed(timer_base + MX1_2_TCN) - 3,
-					timer_base + MX1_2_TCMP);
+		writel_relaxed(tcn - 3, imxtm->base + imxtm->gpt->reg_tcmp);
 
 		/* Clear pending interrupt */
 		gpt_irq_acknowledge();
@@ -279,12 +278,10 @@ static void mxc_set_mode(enum clock_event_mode mode,
 static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *ced = dev_id;
+	struct imx_timer *imxtm = to_imx_timer(ced);
 	uint32_t tstat;
 
-	if (timer_is_v2())
-		tstat = readl_relaxed(timer_base + V2_TSTAT);
-	else
-		tstat = readl_relaxed(timer_base + MX1_2_TSTAT);
+	tstat = readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
 
 	gpt_irq_acknowledge();
 
@@ -357,21 +354,33 @@ static void imx6dl_gpt_setup_tctl(struct imx_timer *imxtm)
 }
 
 static const struct imx_gpt_data imx1_gpt_data = {
+	.reg_tstat = MX1_2_TSTAT,
+	.reg_tcn = MX1_2_TCN,
+	.reg_tcmp = MX1_2_TCMP,
 	.gpt_setup_tctl = imx1_gpt_setup_tctl,
 	.set_next_event = mx1_2_set_next_event,
 };
 
 static const struct imx_gpt_data imx21_gpt_data = {
+	.reg_tstat = MX1_2_TSTAT,
+	.reg_tcn = MX1_2_TCN,
+	.reg_tcmp = MX1_2_TCMP,
 	.gpt_setup_tctl = imx21_gpt_setup_tctl,
 	.set_next_event = mx1_2_set_next_event,
 };
 
 static const struct imx_gpt_data imx31_gpt_data = {
+	.reg_tstat = V2_TSTAT,
+	.reg_tcn = V2_TCN,
+	.reg_tcmp = V2_TCMP,
 	.gpt_setup_tctl = imx31_gpt_setup_tctl,
 	.set_next_event = v2_set_next_event,
 };
 
 static const struct imx_gpt_data imx6dl_gpt_data = {
+	.reg_tstat = V2_TSTAT,
+	.reg_tcn = V2_TCN,
+	.reg_tcmp = V2_TCMP,
 	.gpt_setup_tctl = imx6dl_gpt_setup_tctl,
 	.set_next_event = v2_set_next_event,
 };
-- 
1.9.1
