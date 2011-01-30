From: jochen@scram.de (Jochen Friedrich)
Date: Sun, 30 Jan 2011 13:40:56 +0100
Subject: [PATCH] ARM:ucb1x00-ts: ucb1x00_ts - add BTN_TOUCH event
Message-ID: <1296391256-2127-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add BTN_TOUCH event reporting to ucb1x00_ts touchscreen driver.
This will make this touchscreen driver behave consistently wrt.
BTN_TOUCH.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 drivers/mfd/ucb1x00-ts.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index 92b85e2..38ffbd5 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -60,6 +60,7 @@ static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x
 	input_report_abs(idev, ABS_X, x);
 	input_report_abs(idev, ABS_Y, y);
 	input_report_abs(idev, ABS_PRESSURE, pressure);
+	input_report_key(idev, BTN_TOUCH, 1);
 	input_sync(idev);
 }
 
@@ -68,6 +69,7 @@ static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
 	struct input_dev *idev = ts->idev;
 
 	input_report_abs(idev, ABS_PRESSURE, 0);
+	input_report_key(idev, BTN_TOUCH, 0);
 	input_sync(idev);
 }
 
@@ -384,7 +386,8 @@ static int ucb1x00_ts_add(struct ucb1x00_dev *dev)
 	idev->open       = ucb1x00_ts_open;
 	idev->close      = ucb1x00_ts_close;
 
-	__set_bit(EV_ABS, idev->evbit);
+	idev->evbit[0]   = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
+	idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
 	input_set_drvdata(idev, ts);
 
-- 
1.7.2.3
