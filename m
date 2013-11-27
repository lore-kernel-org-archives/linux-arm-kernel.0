From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 26 Nov 2013 17:04:52 -0800
Subject: [PATCH v2 5/9] clocksource/cadence_ttc: Adjust interval in clock
 notifier
In-Reply-To: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1385514296-26702-6-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clockevent has to be reprogrammed if the timer's input
clock frequency changes and the timer is in periodic mode, in order to
maintain the correct timer interval.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v2:
 - adjust the timer interval while the timer interrupt is disabled
---
 drivers/clocksource/cadence_ttc_timer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 246d018d1e63..77517675653e 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -322,6 +322,9 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
 	switch (event) {
 	case POST_RATE_CHANGE:
 	{
+		/* update cached frequency */
+		ttc->freq = ndata->new_rate;
+
 		/*
 		 * clockevents_update_freq should be called with IRQ disabled on
 		 * the CPU the timer provides events for. The timer we use is
@@ -329,12 +332,15 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
 		 * cores.
 		 */
 		disable_irq(ttcce->ce.irq);
+
 		clockevents_update_freq(&ttcce->ce,
 				ndata->new_rate / PRESCALE);
-		enable_irq(ttcce->ce.irq);
 
-		/* update cached frequency */
-		ttc->freq = ndata->new_rate;
+		if (ttcce->ce.mode == CLOCK_EVT_MODE_PERIODIC)
+			ttc_set_interval(ttc, DIV_ROUND_CLOSEST(ttc->freq,
+						PRESCALE * HZ));
+
+		enable_irq(ttcce->ce.irq);
 
 		/* fall through */
 	}
-- 
1.8.4.4
