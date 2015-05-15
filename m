From: shawnguo@kernel.org (shawnguo at kernel.org)
Date: Fri, 15 May 2015 16:11:44 +0800
Subject: [PATCH 6/9] ARM: imx: define gpt register offset per device type
In-Reply-To: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1431677507-27420-7-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It initializes offset of gpt registers TSTAT, TCN and TCMP per device
type, so that the access to these registers can be unified.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index d79a00e24084..5908e78d9552 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -91,6 +91,9 @@ struct imx_timer {
 	int irq;
 	struct clk *clk_per;
 	struct clk *clk_ipg;
+	int reg_tstat;
+	int reg_tcn;
+	int reg_tcmp;
 	void (*gpt_setup_tctl)(void);
 };
 
@@ -147,7 +150,7 @@ static unsigned long imx_read_current_timer(void)
 static int __init mxc_clocksource_init(void)
 {
 	unsigned int c = clk_get_rate(imxtm.clk_per);
-	void __iomem *reg = imxtm.base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
+	void __iomem *reg = imxtm.base + imxtm.reg_tcn;
 
 	imx_delay_timer.read_current_timer = &imx_read_current_timer;
 	imx_delay_timer.freq = c;
@@ -214,13 +217,8 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	gpt_irq_disable();
 
 	if (mode != clockevent_mode) {
-		/* Set event time into far-far future */
-		if (timer_is_v2())
-			__raw_writel(__raw_readl(imxtm.base + V2_TCN) - 3,
-					imxtm.base + V2_TCMP);
-		else
-			__raw_writel(__raw_readl(imxtm.base + MX1_2_TCN) - 3,
-					imxtm.base + MX1_2_TCMP);
+		__raw_writel(__raw_readl(imxtm.base + imxtm.reg_tcn) - 3,
+					imxtm.base + imxtm.reg_tcmp);
 
 		/* Clear pending interrupt */
 		gpt_irq_acknowledge();
@@ -268,10 +266,7 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = &clockevent_mxc;
 	uint32_t tstat;
 
-	if (timer_is_v2())
-		tstat = __raw_readl(imxtm.base + V2_TSTAT);
-	else
-		tstat = __raw_readl(imxtm.base + MX1_2_TSTAT);
+	tstat = __raw_readl(imxtm.base + imxtm.reg_tstat);
 
 	gpt_irq_acknowledge();
 
@@ -346,18 +341,30 @@ static void __init imx_timer_data_init(void)
 {
 	switch (imxtm.type) {
 	case GPT_TYPE_IMX1:
+		imxtm.reg_tstat = MX1_2_TSTAT;
+		imxtm.reg_tcn = MX1_2_TCN;
+		imxtm.reg_tcmp = MX1_2_TCMP;
 		imxtm.gpt_setup_tctl = imx1_gpt_setup_tctl;
 		clockevent_mxc.set_next_event = mx1_2_set_next_event;
 		break;
 	case GPT_TYPE_IMX21:
+		imxtm.reg_tstat = MX1_2_TSTAT;
+		imxtm.reg_tcn = MX1_2_TCN;
+		imxtm.reg_tcmp = MX1_2_TCMP;
 		imxtm.gpt_setup_tctl = imx21_gpt_setup_tctl;
 		clockevent_mxc.set_next_event = mx1_2_set_next_event;
 		break;
 	case GPT_TYPE_IMX31:
+		imxtm.reg_tstat = V2_TSTAT;
+		imxtm.reg_tcn = V2_TCN;
+		imxtm.reg_tcmp = V2_TCMP;
 		imxtm.gpt_setup_tctl = imx31_gpt_setup_tctl;
 		clockevent_mxc.set_next_event = v2_set_next_event;
 		break;
 	case GPT_TYPE_IMX6DL:
+		imxtm.reg_tstat = V2_TSTAT;
+		imxtm.reg_tcn = V2_TCN;
+		imxtm.reg_tcmp = V2_TCMP;
 		imxtm.gpt_setup_tctl = imx6dl_gpt_setup_tctl;
 		clockevent_mxc.set_next_event = v2_set_next_event;
 		break;
-- 
1.9.1
