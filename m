From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Mon,  5 Nov 2018 15:15:11 +0100
Subject: [PATCH] clocksource: imx-gpt: remove unnecessary irq protection
Message-ID: <20181105141511.30657-1-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

shutdown and oneshot are already protected against irq interruptions

Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
---
 drivers/clocksource/timer-imx-gpt.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 165fbbb1c9a0..48e025e8dc82 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -198,15 +198,8 @@ static int v2_set_next_event(unsigned long evt,
 static int mxc_shutdown(struct clock_event_device *ced)
 {
 	struct imx_timer *imxtm = to_imx_timer(ced);
-	unsigned long flags;
 	u32 tcn;
 
-	/*
-	 * The timer interrupt generation is disabled at least
-	 * for enough time to call mxc_set_next_event()
-	 */
-	local_irq_save(flags);
-
 	/* Disable interrupt in GPT module */
 	imxtm->gpt->gpt_irq_disable(imxtm);
 
@@ -221,21 +214,12 @@ static int mxc_shutdown(struct clock_event_device *ced)
 	printk(KERN_INFO "%s: changing mode\n", __func__);
 #endif /* DEBUG */
 
-	local_irq_restore(flags);
-
 	return 0;
 }
 
 static int mxc_set_oneshot(struct clock_event_device *ced)
 {
 	struct imx_timer *imxtm = to_imx_timer(ced);
-	unsigned long flags;
-
-	/*
-	 * The timer interrupt generation is disabled at least
-	 * for enough time to call mxc_set_next_event()
-	 */
-	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
 	imxtm->gpt->gpt_irq_disable(imxtm);
@@ -260,7 +244,6 @@ static int mxc_set_oneshot(struct clock_event_device *ced)
 	 * mode switching
 	 */
 	imxtm->gpt->gpt_irq_enable(imxtm);
-	local_irq_restore(flags);
 
 	return 0;
 }
-- 
2.19.1
