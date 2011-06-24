From: wdgvip@gmail.com (Wu DaoGuang)
Date: Fri, 24 Jun 2011 10:15:38 +0800
Subject: [PATCH] INPUT:Add ABS_PRESSURE input event support for touchscreen
	driver
Message-ID: <1308881738-6392-1-git-send-email-wdgvip@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The touchscreen driver s3c2410_ts.c doesn't work well when using
the tslib, an abstraction layer for touchscreen panel events.
Tslib needs ABS_X ABS_Y and ABS_PRESSURE events to report, but only
the former two the driver can provide.

So this patch fixes the problem.

Signed-off-by: Wu DaoGuang <wdgvip@gmail.com>
---
 drivers/input/touchscreen/s3c2410_ts.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 8feb7f3..0cf4f12 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -126,6 +126,7 @@ static void touch_timer_fire(unsigned long data)
 			input_report_abs(ts.input, ABS_Y, ts.yp);
 
 			input_report_key(ts.input, BTN_TOUCH, 1);
+			input_report_abs(ts.input, ABS_PRESSURE, 1);
 			input_sync(ts.input);
 
 			ts.xp = 0;
@@ -140,6 +141,7 @@ static void touch_timer_fire(unsigned long data)
 		ts.count = 0;
 
 		input_report_key(ts.input, BTN_TOUCH, 0);
+		input_report_abs(ts.input, ABS_PRESSURE, 0);
 		input_sync(ts.input);
 
 		writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
@@ -318,7 +320,7 @@ static int __devinit s3c2410ts_probe(struct platform_device *pdev)
 	ts.input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 	input_set_abs_params(ts.input, ABS_X, 0, 0x3FF, 0, 0);
 	input_set_abs_params(ts.input, ABS_Y, 0, 0x3FF, 0, 0);
-
+	input_set_abs_params(ts.input, ABS_PRESSURE, 0, 1, 0, 0);
 	ts.input->name = "S3C24XX TouchScreen";
 	ts.input->id.bustype = BUS_HOST;
 	ts.input->id.vendor = 0xDEAD;
-- 
1.7.1
