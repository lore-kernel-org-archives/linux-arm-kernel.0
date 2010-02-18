From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 18 Feb 2010 18:32:28 +0200
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1266510750-9846-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, driver reports touches when it gots (1 << ts.shift)
samples, even if stylus is up. This behavior looks wrong to me.
Patch makes driver to report touches only when stylus is down.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/input/touchscreen/s3c2410_ts.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 6386b44..e2fe2ed 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -128,25 +128,25 @@ static void touch_timer_fire(unsigned long data)
 
 	down = get_down(data0, data1);
 
-	if (ts.count == (1 << ts.shift)) {
-		ts.xp >>= ts.shift;
-		ts.yp >>= ts.shift;
+	if (down) {
+		if (ts.count == (1 << ts.shift)) {
+			ts.xp >>= ts.shift;
+			ts.yp >>= ts.shift;
 
-		dev_dbg(ts.dev, "%s: X=%lu, Y=%lu, count=%d\n",
-			__func__, ts.xp, ts.yp, ts.count);
+			dev_dbg(ts.dev, "%s: X=%lu, Y=%lu, count=%d\n",
+				__func__, ts.xp, ts.yp, ts.count);
 
-		input_report_abs(ts.input, ABS_X, ts.xp);
-		input_report_abs(ts.input, ABS_Y, ts.yp);
+			input_report_abs(ts.input, ABS_X, ts.xp);
+			input_report_abs(ts.input, ABS_Y, ts.yp);
 
-		input_report_key(ts.input, BTN_TOUCH, 1);
-		input_sync(ts.input);
+			input_report_key(ts.input, BTN_TOUCH, 1);
+			input_sync(ts.input);
 
+		}
 		ts.xp = 0;
 		ts.yp = 0;
 		ts.count = 0;
-	}
 
-	if (down) {
 		s3c_adc_start(ts.client, 0, 1 << ts.shift);
 	} else {
 		ts.count = 0;
-- 
1.7.0
