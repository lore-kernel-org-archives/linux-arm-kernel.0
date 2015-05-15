From: shawnguo@kernel.org (shawnguo at kernel.org)
Date: Fri, 15 May 2015 16:11:45 +0800
Subject: [PATCH 7/9] ARM: imx: provide gpt device specific irq functions
In-Reply-To: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1431677507-27420-8-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It splits irq enable/disable/acknowledge operations into device specific
functions to get proper hook called in the correct context.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 76 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 5908e78d9552..174c553a3bb7 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -95,44 +95,58 @@ struct imx_timer {
 	int reg_tcn;
 	int reg_tcmp;
 	void (*gpt_setup_tctl)(void);
+	void (*gpt_irq_enable)(void);
+	void (*gpt_irq_disable)(void);
+	void (*gpt_irq_acknowledge)(void);
 };
 
 static struct imx_timer imxtm;
 
-static inline void gpt_irq_disable(void)
+static void imx1_gpt_irq_disable(void)
 {
 	unsigned int tmp;
 
-	if (timer_is_v2())
-		__raw_writel(0, imxtm.base + V2_IR);
-	else {
-		tmp = __raw_readl(imxtm.base + MXC_TCTL);
-		__raw_writel(tmp & ~MX1_2_TCTL_IRQEN, imxtm.base + MXC_TCTL);
-	}
+	tmp = __raw_readl(imxtm.base + MXC_TCTL);
+	__raw_writel(tmp & ~MX1_2_TCTL_IRQEN, imxtm.base + MXC_TCTL);
+}
+#define imx21_gpt_irq_disable imx1_gpt_irq_disable
+
+static void imx31_gpt_irq_disable(void)
+{
+	__raw_writel(0, imxtm.base + V2_IR);
 }
+#define imx6dl_gpt_irq_disable imx31_gpt_irq_disable
 
-static inline void gpt_irq_enable(void)
+static void imx1_gpt_irq_enable(void)
 {
-	if (timer_is_v2())
-		__raw_writel(1<<0, imxtm.base + V2_IR);
-	else {
-		__raw_writel(__raw_readl(imxtm.base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
+	__raw_writel(__raw_readl(imxtm.base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
 			imxtm.base + MXC_TCTL);
-	}
+}
+#define imx21_gpt_irq_enable imx1_gpt_irq_enable
+
+static void imx31_gpt_irq_enable(void)
+{
+	__raw_writel(1<<0, imxtm.base + V2_IR);
+}
+#define imx6dl_gpt_irq_enable imx31_gpt_irq_enable
+
+static void imx1_gpt_irq_acknowledge(void)
+{
+	__raw_writel(0, imxtm.base + MX1_2_TSTAT);
 }
 
-static void gpt_irq_acknowledge(void)
+static void imx21_gpt_irq_acknowledge(void)
 {
-	if (timer_is_v1()) {
-		if (cpu_is_mx1())
-			__raw_writel(0, imxtm.base + MX1_2_TSTAT);
-		else
-			__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
+	__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
 				imxtm.base + MX1_2_TSTAT);
-	} else if (timer_is_v2())
-		__raw_writel(V2_TSTAT_OF1, imxtm.base + V2_TSTAT);
 }
 
+static void imx31_gpt_irq_acknowledge(void)
+{
+	__raw_writel(V2_TSTAT_OF1, imxtm.base + V2_TSTAT);
+}
+#define imx6dl_gpt_irq_acknowledge imx31_gpt_irq_acknowledge
+
 static void __iomem *sched_clock_reg;
 
 static u64 notrace mxc_read_sched_clock(void)
@@ -214,14 +228,14 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
-	gpt_irq_disable();
+	imxtm.gpt_irq_disable();
 
 	if (mode != clockevent_mode) {
 		__raw_writel(__raw_readl(imxtm.base + imxtm.reg_tcn) - 3,
 					imxtm.base + imxtm.reg_tcmp);
 
 		/* Clear pending interrupt */
-		gpt_irq_acknowledge();
+		imxtm.gpt_irq_acknowledge();
 	}
 
 #ifdef DEBUG
@@ -247,7 +261,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	 * mode switching
 	 */
 		local_irq_save(flags);
-		gpt_irq_enable();
+		imxtm.gpt_irq_enable();
 		local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
@@ -268,7 +282,7 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 
 	tstat = __raw_readl(imxtm.base + imxtm.reg_tstat);
 
-	gpt_irq_acknowledge();
+	imxtm.gpt_irq_acknowledge();
 
 	evt->event_handler(evt);
 
@@ -345,6 +359,9 @@ static void __init imx_timer_data_init(void)
 		imxtm.reg_tcn = MX1_2_TCN;
 		imxtm.reg_tcmp = MX1_2_TCMP;
 		imxtm.gpt_setup_tctl = imx1_gpt_setup_tctl;
+		imxtm.gpt_irq_enable = imx1_gpt_irq_enable;
+		imxtm.gpt_irq_disable = imx1_gpt_irq_disable;
+		imxtm.gpt_irq_acknowledge = imx1_gpt_irq_acknowledge;
 		clockevent_mxc.set_next_event = mx1_2_set_next_event;
 		break;
 	case GPT_TYPE_IMX21:
@@ -352,6 +369,9 @@ static void __init imx_timer_data_init(void)
 		imxtm.reg_tcn = MX1_2_TCN;
 		imxtm.reg_tcmp = MX1_2_TCMP;
 		imxtm.gpt_setup_tctl = imx21_gpt_setup_tctl;
+		imxtm.gpt_irq_enable = imx21_gpt_irq_enable;
+		imxtm.gpt_irq_disable = imx21_gpt_irq_disable;
+		imxtm.gpt_irq_acknowledge = imx21_gpt_irq_acknowledge;
 		clockevent_mxc.set_next_event = mx1_2_set_next_event;
 		break;
 	case GPT_TYPE_IMX31:
@@ -359,6 +379,9 @@ static void __init imx_timer_data_init(void)
 		imxtm.reg_tcn = V2_TCN;
 		imxtm.reg_tcmp = V2_TCMP;
 		imxtm.gpt_setup_tctl = imx31_gpt_setup_tctl;
+		imxtm.gpt_irq_enable = imx31_gpt_irq_enable;
+		imxtm.gpt_irq_disable = imx31_gpt_irq_disable;
+		imxtm.gpt_irq_acknowledge = imx31_gpt_irq_acknowledge;
 		clockevent_mxc.set_next_event = v2_set_next_event;
 		break;
 	case GPT_TYPE_IMX6DL:
@@ -366,6 +389,9 @@ static void __init imx_timer_data_init(void)
 		imxtm.reg_tcn = V2_TCN;
 		imxtm.reg_tcmp = V2_TCMP;
 		imxtm.gpt_setup_tctl = imx6dl_gpt_setup_tctl;
+		imxtm.gpt_irq_enable = imx6dl_gpt_irq_enable;
+		imxtm.gpt_irq_disable = imx6dl_gpt_irq_disable;
+		imxtm.gpt_irq_acknowledge = imx6dl_gpt_irq_acknowledge;
 		clockevent_mxc.set_next_event = v2_set_next_event;
 		break;
 	default:
-- 
1.9.1
