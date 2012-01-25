From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:32:27 +0000
Subject: [PATCH 07/33] MFD: ucb1x00-ts: fix resume failure
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3tj-0000Y6-H2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the ucb1x00 touchscreen is resumed while the touchscreen is being
touched, the main thread stops responding.  This occurs because two
things happen:

1. When we suspended, we were woken up, and executed the loop.
   Finding that the touchscreen was not pressed, we prepare to
   schedule for a maximum timeout, before being stopped in
   try_to_freeze().

2. an irq occurs, we disable the irq, and mark it as disabled,
   and wake the thread.  This wake occurs while the thread is
   still within __refrigerator()

3. The thread is unfrozen, and __refrigerator() sets the threads
   state back to INTERRUPTIBLE.

We then drop into schedule_timeout() with an infinite timeout and the
IRQ disabled.  This prevents any further screen touches activating
the thread.

Fix this by using kthread_freezable_should_stop() which handles the
freezing issues for us outside of the hotspot where the task state
matters.  Include a flag to ignore the touchscreen until it is
released to avoid sending unintended data to the application.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-ts.c |   32 +++++---------------------------
 1 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index 38ffbd5..63a3cbd 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -47,7 +47,6 @@ struct ucb1x00_ts {
 	u16			x_res;
 	u16			y_res;
 
-	unsigned int		restart:1;
 	unsigned int		adcsync:1;
 };
 
@@ -207,15 +206,17 @@ static int ucb1x00_thread(void *_ts)
 {
 	struct ucb1x00_ts *ts = _ts;
 	DECLARE_WAITQUEUE(wait, current);
+	bool frozen, ignore = false;
 	int valid = 0;
 
 	set_freezable();
 	add_wait_queue(&ts->irq_wait, &wait);
-	while (!kthread_should_stop()) {
+	while (!kthread_freezable_should_stop(&frozen)) {
 		unsigned int x, y, p;
 		signed long timeout;
 
-		ts->restart = 0;
+		if (frozen)
+			ignore = true;
 
 		ucb1x00_adc_enable(ts->ucb);
 
@@ -258,7 +259,7 @@ static int ucb1x00_thread(void *_ts)
 			 * space.  We therefore leave it to user space
 			 * to do any filtering they please.
 			 */
-			if (!ts->restart) {
+			if (!ignore) {
 				ucb1x00_ts_evt_add(ts, p, x, y);
 				valid = 1;
 			}
@@ -267,8 +268,6 @@ static int ucb1x00_thread(void *_ts)
 			timeout = HZ / 100;
 		}
 
-		try_to_freeze();
-
 		schedule_timeout(timeout);
 	}
 
@@ -340,26 +339,6 @@ static void ucb1x00_ts_close(struct input_dev *idev)
 	ucb1x00_disable(ts->ucb);
 }
 
-#ifdef CONFIG_PM
-static int ucb1x00_ts_resume(struct ucb1x00_dev *dev)
-{
-	struct ucb1x00_ts *ts = dev->priv;
-
-	if (ts->rtask != NULL) {
-		/*
-		 * Restart the TS thread to ensure the
-		 * TS interrupt mode is set up again
-		 * after sleep.
-		 */
-		ts->restart = 1;
-		wake_up(&ts->irq_wait);
-	}
-	return 0;
-}
-#else
-#define ucb1x00_ts_resume NULL
-#endif
-
 
 /*
  * Initialisation.
@@ -425,7 +404,6 @@ static void ucb1x00_ts_remove(struct ucb1x00_dev *dev)
 static struct ucb1x00_driver ucb1x00_ts_driver = {
 	.add		= ucb1x00_ts_add,
 	.remove		= ucb1x00_ts_remove,
-	.resume		= ucb1x00_ts_resume,
 };
 
 static int __init ucb1x00_ts_init(void)
-- 
1.7.4.4
