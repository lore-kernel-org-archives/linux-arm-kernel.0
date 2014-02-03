From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  3 Feb 2014 14:34:33 -0800
Subject: [PATCH v3 3/7] clocksource/cadence_ttc: Call
 clockevents_update_freq() with IRQs enabled
In-Reply-To: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1391466877-28908-4-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer core takes care of serialization and IRQs. Hence the driver is
no longer required to disable interrupts when calling
clockevents_update_freq().

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clocksource/cadence_ttc_timer.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 63f176de0d02..f05b9fdc7425 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -321,25 +321,12 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
 
 	switch (event) {
 	case POST_RATE_CHANGE:
-	{
-		unsigned long flags;
-
-		/*
-		 * clockevents_update_freq should be called with IRQ disabled on
-		 * the CPU the timer provides events for. The timer we use is
-		 * common to both CPUs, not sure if we need to run on both
-		 * cores.
-		 */
-		local_irq_save(flags);
-		clockevents_update_freq(&ttcce->ce,
-				ndata->new_rate / PRESCALE);
-		local_irq_restore(flags);
-
 		/* update cached frequency */
 		ttc->freq = ndata->new_rate;
 
+		clockevents_update_freq(&ttcce->ce, ndata->new_rate / PRESCALE);
+
 		/* fall through */
-	}
 	case PRE_RATE_CHANGE:
 	case ABORT_RATE_CHANGE:
 	default:
-- 
1.8.5.3
