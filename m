From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  3 Feb 2014 14:34:32 -0800
Subject: [PATCH v3 2/7] time: clockevents: Adjust timer interval when
 frequency changes
In-Reply-To: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1391466877-28908-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To adjust the timer's interval in periodic mode, the clockevent device
is put into periodic mode during clockevents_update_freq() in case the
timer is in periodic mode.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
It is assumed that simply calling the timer's 'set_mode()' API takes care of
programming an appropriate interval based on the current timer frequency.
If that doesn't work for all timers, I guess it might require a new API
call.
---
 kernel/time/clockevents.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 641d91003a45..f85e5fda9c66 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -443,10 +443,13 @@ int __clockevents_update_freq(struct clock_event_device *dev, u32 freq)
 {
 	clockevents_config(dev, freq);
 
-	if (dev->mode != CLOCK_EVT_MODE_ONESHOT)
-		return 0;
+	if (dev->mode == CLOCK_EVT_MODE_ONESHOT)
+		return clockevents_program_event(dev, dev->next_event, false);
+
+	if (dev->mode == CLOCK_EVT_MODE_PERIODIC)
+		dev->set_mode(CLOCK_EVT_MODE_PERIODIC, dev);
 
-	return clockevents_program_event(dev, dev->next_event, false);
+	return 0;
 }
 
 /**
-- 
1.8.5.3
