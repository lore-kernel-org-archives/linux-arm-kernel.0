From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  8 Mar 2015 21:53:41 +0100
Subject: [PATCH 2/3] touchscreen: sun4i-ts: Do not report -EAGAIN from
 tempzone callback
In-Reply-To: <1425848022-18001-1-git-send-email-hdegoede@redhat.com>
References: <1425848022-18001-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425848022-18001-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Returning -EAGAIN while waiting for the first temperature ready interrupt,
causes the tempzone core to log the following errors:

[    1.219353] thermal thermal_zone0: failed to read out thermal zone 0
[    2.015433] thermal thermal_zone0: failed to read out thermal zone 0
[    2.416737] thermal thermal_zone0: failed to read out thermal zone 0

So instead of returning -EAGAIN, return an intial temperature estimate of
40 degrees, and a success status.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/sun4i-ts.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 66ccd5a..d641b12 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -189,12 +189,7 @@ static void sun4i_ts_close(struct input_dev *dev)
 
 static int sun4i_get_temp(const struct sun4i_ts_data *ts, long *temp)
 {
-	/* No temp_data until the first irq */
-	if (ts->temp_data == -1)
-		return -EAGAIN;
-
 	*temp = (ts->temp_data - ts->temp_offset) * ts->temp_step;
-
 	return 0;
 }
 
@@ -212,11 +207,8 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
 {
 	struct sun4i_ts_data *ts = dev_get_drvdata(dev);
 	long temp;
-	int error;
 
-	error = sun4i_get_temp(ts, &temp);
-	if (error)
-		return error;
+	sun4i_get_temp(ts, &temp);
 
 	return sprintf(buf, "%ld\n", temp);
 }
@@ -253,7 +245,7 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 
 	ts->dev = dev;
 	ts->ignore_fifo_data = true;
-	ts->temp_data = -1;
+
 	if (of_device_is_compatible(np, "allwinner,sun6i-a31-ts")) {
 		/* Allwinner SDK has temperature = -271 + (value / 6) (C) */
 		ts->temp_offset = 1626;
@@ -283,6 +275,13 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 		ts->temp_step = 100;
 	}
 
+	/*
+	 * Start by reporting 40 degrees as temperature, this avoids
+	 * "thermal_zone: failed to read out thermal zone" errors while
+	 * waiting for the first temp ready irq.
+	 */
+	ts->temp_data = ts->temp_offset + 40000 / ts->temp_step;
+
 	ts_attached = of_property_read_bool(np, "allwinner,ts-attached");
 	if (ts_attached) {
 		ts->input = devm_input_allocate_device(dev);
-- 
2.3.1
