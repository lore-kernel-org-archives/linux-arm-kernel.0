From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:25 -0500
Subject: [PATCH 10/18] ARM: imx: Removed the SoC relating codes in mxc_set_mode
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-11-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabled the use of parameter *evt, and removed the SoC relating
codes in mxc_set_mode.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index e41bad9..ddbb3e7 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -258,6 +258,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
 	unsigned long flags;
+	struct imx_timer *tm = container_of(evt, struct imx_timer, evt);
 
 	/*
 	 * The timer interrupt generation is disabled at least
@@ -266,19 +267,14 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
-	gpt_irq_disable();
+	tm->gpt_irq_disable(tm);
 
 	if (mode != clockevent_mode) {
 		/* Set event time into far-far future */
-		if (timer_is_v2())
-			__raw_writel(__raw_readl(timer_base + V2_TCN) - 3,
-					timer_base + V2_TCMP);
-		else
-			__raw_writel(__raw_readl(timer_base + MX1_2_TCN) - 3,
-					timer_base + MX1_2_TCMP);
+		evt->set_next_event(-3, evt);
 
 		/* Clear pending interrupt */
-		gpt_irq_acknowledge();
+		tm->gpt_irq_acknowledge(tm);
 	}
 
 #ifdef DEBUG
@@ -304,7 +300,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	 * mode switching
 	 */
 		local_irq_save(flags);
-		gpt_irq_enable();
+		tm->gpt_irq_enable(tm);
 		local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
-- 
1.9.1
