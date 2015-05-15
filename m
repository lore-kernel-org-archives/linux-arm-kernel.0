From: shawnguo@kernel.org (shawnguo at kernel.org)
Date: Fri, 15 May 2015 16:11:42 +0800
Subject: [PATCH 4/9] ARM: imx: setup tctl register in device specific function
In-Reply-To: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1431677507-27420-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It creates device speicific function hook gpt_setup_tctl to set up gpt
TCTL register.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 81 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index ed01813cfc76..c86e25922eb4 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -91,6 +91,7 @@ struct imx_timer {
 	int irq;
 	struct clk *clk_per;
 	struct clk *clk_ipg;
+	void (*gpt_setup_tctl)(void);
 };
 
 static struct imx_timer imxtm;
@@ -306,9 +307,68 @@ static int __init mxc_clockevent_init(void)
 	return 0;
 }
 
+static void imx1_gpt_setup_tctl(void)
+{
+	u32 tctl_val;
+
+	tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
+	__raw_writel(tctl_val, imxtm.base + MXC_TCTL);
+}
+#define imx21_gpt_setup_tctl imx1_gpt_setup_tctl
+
+static void imx31_gpt_setup_tctl(void)
+{
+	u32 tctl_val;
+
+	tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+	if (clk_get_rate(imxtm.clk_per) == V2_TIMER_RATE_OSC_DIV8)
+		tctl_val |= V2_TCTL_CLK_OSC_DIV8;
+	else
+		tctl_val |= V2_TCTL_CLK_PER;
+
+	__raw_writel(tctl_val, imxtm.base + MXC_TCTL);
+}
+
+static void imx6dl_gpt_setup_tctl(void)
+{
+	u32 tctl_val;
+
+	tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+	if (clk_get_rate(imxtm.clk_per) == V2_TIMER_RATE_OSC_DIV8) {
+		tctl_val |= V2_TCTL_CLK_OSC_DIV8;
+		/* 24 / 8 = 3 MHz */
+		__raw_writel(7 << V2_TPRER_PRE24M, imxtm.base + MXC_TPRER);
+		tctl_val |= V2_TCTL_24MEN;
+	} else {
+		tctl_val |= V2_TCTL_CLK_PER;
+	}
+
+	__raw_writel(tctl_val, imxtm.base + MXC_TCTL);
+}
+
+static void __init imx_timer_data_init(void)
+{
+	switch (imxtm.type) {
+	case GPT_TYPE_IMX1:
+		imxtm.gpt_setup_tctl = imx1_gpt_setup_tctl;
+		break;
+	case GPT_TYPE_IMX21:
+		imxtm.gpt_setup_tctl = imx21_gpt_setup_tctl;
+		break;
+	case GPT_TYPE_IMX31:
+		imxtm.gpt_setup_tctl = imx31_gpt_setup_tctl;
+		break;
+	case GPT_TYPE_IMX6DL:
+		imxtm.gpt_setup_tctl = imx6dl_gpt_setup_tctl;
+		break;
+	default:
+		BUG();
+	}
+}
+
 static void __init _mxc_timer_init(void)
 {
-	uint32_t tctl_val;
+	imx_timer_data_init();
 
 	if (IS_ERR(imxtm.clk_per)) {
 		pr_err("i.MX timer: unable to get clk\n");
@@ -327,24 +387,7 @@ static void __init _mxc_timer_init(void)
 	__raw_writel(0, imxtm.base + MXC_TCTL);
 	__raw_writel(0, imxtm.base + MXC_TPRER); /* see datasheet note */
 
-	if (timer_is_v2()) {
-		tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
-		if (clk_get_rate(imxtm.clk_per) == V2_TIMER_RATE_OSC_DIV8) {
-			tctl_val |= V2_TCTL_CLK_OSC_DIV8;
-			if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
-				/* 24 / 8 = 3 MHz */
-				__raw_writel(7 << V2_TPRER_PRE24M,
-					imxtm.base + MXC_TPRER);
-				tctl_val |= V2_TCTL_24MEN;
-			}
-		} else {
-			tctl_val |= V2_TCTL_CLK_PER;
-		}
-	} else {
-		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
-	}
-
-	__raw_writel(tctl_val, imxtm.base + MXC_TCTL);
+	imxtm.gpt_setup_tctl();
 
 	/* init and register the timer to the framework */
 	mxc_clocksource_init();
-- 
1.9.1
