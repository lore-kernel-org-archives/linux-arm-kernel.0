From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:52 +0800
Subject: [PATCH v2 05/12] ARM: imx: setup tctl register in device specific
 function
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It creates a gpt device speicific data structure and adds function hook
gpt_setup_tctl in there to set up gpt TCTL register.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 98 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index cf88355654dd..2fbc3022ce3f 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -92,6 +92,11 @@ struct imx_timer {
 	int irq;
 	struct clk *clk_per;
 	struct clk *clk_ipg;
+	const struct imx_gpt_data *gpt;
+};
+
+struct imx_gpt_data {
+	void (*gpt_setup_tctl)(struct imx_timer *imxtm);
 };
 
 static void __iomem *timer_base;
@@ -307,13 +312,83 @@ static int __init mxc_clockevent_init(struct imx_timer *imxtm)
 	return 0;
 }
 
-static void __init _mxc_timer_init(struct imx_timer *imxtm)
+static void imx1_gpt_setup_tctl(struct imx_timer *imxtm)
+{
+	u32 tctl_val;
+
+	tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
+	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
+}
+#define imx21_gpt_setup_tctl imx1_gpt_setup_tctl
+
+static void imx31_gpt_setup_tctl(struct imx_timer *imxtm)
+{
+	u32 tctl_val;
+
+	tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+	if (clk_get_rate(imxtm->clk_per) == V2_TIMER_RATE_OSC_DIV8)
+		tctl_val |= V2_TCTL_CLK_OSC_DIV8;
+	else
+		tctl_val |= V2_TCTL_CLK_PER;
+
+	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
+}
+
+static void imx6dl_gpt_setup_tctl(struct imx_timer *imxtm)
 {
-	uint32_t tctl_val;
+	u32 tctl_val;
+
+	tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+	if (clk_get_rate(imxtm->clk_per) == V2_TIMER_RATE_OSC_DIV8) {
+		tctl_val |= V2_TCTL_CLK_OSC_DIV8;
+		/* 24 / 8 = 3 MHz */
+		writel_relaxed(7 << V2_TPRER_PRE24M, imxtm->base + MXC_TPRER);
+		tctl_val |= V2_TCTL_24MEN;
+	} else {
+		tctl_val |= V2_TCTL_CLK_PER;
+	}
+
+	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
+}
 
+static const struct imx_gpt_data imx1_gpt_data = {
+	.gpt_setup_tctl = imx1_gpt_setup_tctl,
+};
+
+static const struct imx_gpt_data imx21_gpt_data = {
+	.gpt_setup_tctl = imx21_gpt_setup_tctl,
+};
+
+static const struct imx_gpt_data imx31_gpt_data = {
+	.gpt_setup_tctl = imx31_gpt_setup_tctl,
+};
+
+static const struct imx_gpt_data imx6dl_gpt_data = {
+	.gpt_setup_tctl = imx6dl_gpt_setup_tctl,
+};
+
+static void __init _mxc_timer_init(struct imx_timer *imxtm)
+{
 	/* Temporary */
 	timer_base = imxtm->base;
 
+	switch (imxtm->type) {
+	case GPT_TYPE_IMX1:
+		imxtm->gpt = &imx1_gpt_data;
+		break;
+	case GPT_TYPE_IMX21:
+		imxtm->gpt = &imx21_gpt_data;
+		break;
+	case GPT_TYPE_IMX31:
+		imxtm->gpt = &imx31_gpt_data;
+		break;
+	case GPT_TYPE_IMX6DL:
+		imxtm->gpt = &imx6dl_gpt_data;
+		break;
+	default:
+		BUG();
+	}
+
 	if (IS_ERR(imxtm->clk_per)) {
 		pr_err("i.MX timer: unable to get clk\n");
 		return;
@@ -331,24 +406,7 @@ static void __init _mxc_timer_init(struct imx_timer *imxtm)
 	writel_relaxed(0, imxtm->base + MXC_TCTL);
 	writel_relaxed(0, imxtm->base + MXC_TPRER); /* see datasheet note */
 
-	if (timer_is_v2()) {
-		tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
-		if (clk_get_rate(imxtm->clk_per) == V2_TIMER_RATE_OSC_DIV8) {
-			tctl_val |= V2_TCTL_CLK_OSC_DIV8;
-			if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
-				/* 24 / 8 = 3 MHz */
-				writel_relaxed(7 << V2_TPRER_PRE24M,
-					imxtm->base + MXC_TPRER);
-				tctl_val |= V2_TCTL_24MEN;
-			}
-		} else {
-			tctl_val |= V2_TCTL_CLK_PER;
-		}
-	} else {
-		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
-	}
-
-	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
+	imxtm->gpt->gpt_setup_tctl(imxtm);
 
 	/* init and register the timer to the framework */
 	mxc_clocksource_init(imxtm);
-- 
1.9.1
