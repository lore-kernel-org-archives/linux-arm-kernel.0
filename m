From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:23 -0500
Subject: [PATCH 08/18] ARM: imx: Reimplemented the _mxc_timer_init based on IP
 version
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-9-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reimplemented the function of _mxc_timer_init just based on the
version of timer IP block.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 75 +++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 451f761..cf07401 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -486,53 +486,44 @@ static void __init _mxc_timer_init_v3(int irq, struct clk *clk_per,
 	setup_irq(irq, &tm->act);
 }
 
-static void __init _mxc_timer_init(int irq,
-				   struct clk *clk_per, struct clk *clk_ipg)
+static void __init _mxc_timer_init(int irq, struct clk *clk_per,
+		struct clk *clk_ipg, struct imx_timer *tm)
 {
-	uint32_t tctl_val;
-
-	if (IS_ERR(clk_per)) {
-		pr_err("i.MX timer: unable to get clk\n");
-		return;
-	}
 
-	if (!IS_ERR(clk_ipg))
-		clk_prepare_enable(clk_ipg);
-
-	clk_prepare_enable(clk_per);
+	switch (tm->version) {
+	case IMX_TIMER_V0:
+		tm->gpt_irq_enable = gpt_irq_enable_v0_v1;
+		tm->gpt_irq_disable = gpt_irq_disable_v0_v1;
+		tm->gpt_irq_acknowledge = gpt_irq_acknowledge_v0;
+		_mxc_timer_init_v0_v1(irq, clk_per, clk_ipg, tm);
+		break;
 
-	/*
-	 * Initialise to a known state (all timers off, and timing reset)
-	 */
+	case IMX_TIMER_V1:
+		tm->gpt_irq_enable = gpt_irq_enable_v0_v1;
+		tm->gpt_irq_disable = gpt_irq_disable_v0_v1;
+		tm->gpt_irq_acknowledge = gpt_irq_acknowledge_v1;
+		_mxc_timer_init_v0_v1(irq, clk_per, clk_ipg, tm);
+		break;
 
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
-	} else {
-		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
-	}
+	case IMX_TIMER_V2:
+		tm->gpt_irq_enable = gpt_irq_enable_v2_v3;
+		tm->gpt_irq_disable = gpt_irq_disable_v2_v3;
+		tm->gpt_irq_acknowledge = gpt_irq_acknowledge_v2_v3;
+		_mxc_timer_init_v2(irq, clk_per, clk_ipg, tm);
+		break;
 
-	__raw_writel(tctl_val, timer_base + MXC_TCTL);
+	case IMX_TIMER_V3:
+		tm->gpt_irq_enable = gpt_irq_enable_v2_v3;
+		tm->gpt_irq_disable = gpt_irq_disable_v2_v3;
+		tm->gpt_irq_acknowledge = gpt_irq_acknowledge_v2_v3;
+		_mxc_timer_init_v3(irq, clk_per, clk_ipg, tm);
+		break;
 
-	/* init and register the timer to the framework */
-	mxc_clocksource_init(clk_per, 0);
-	mxc_clockevent_init(clk_per, 0);
+	default:
+		pr_err("<%s> timer device node is not supported\r\n", __func__);
+		break;
 
-	/* Make irqs happen */
-	setup_irq(irq, &mxc_timer_irq);
+	}
 }
 
 void __init mxc_timer_init(unsigned long pbase, int irq, int ver)
@@ -560,7 +551,7 @@ void __init mxc_timer_init(unsigned long pbase, int irq, int ver)
 	timer->act.dev_id = timer;
 	timer->act.handler = mxc_timer_interrupt;
 
-	_mxc_timer_init(irq, clk_per, clk_ipg);
+	_mxc_timer_init(irq, clk_per, clk_ipg, timer);
 }
 
 struct imx_timer_ip_combo {
@@ -633,7 +624,7 @@ static void __init mxc_timer_init_dt(struct device_node *np)
 	timer->act.dev_id = timer;
 	timer->act.handler = mxc_timer_interrupt;
 
-	_mxc_timer_init(irq, clk_per, clk_ipg);
+	_mxc_timer_init(irq, clk_per, clk_ipg, timer);
 }
 
 CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
-- 
1.9.1
