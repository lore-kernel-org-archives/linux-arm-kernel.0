From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 5 Nov 2009 10:27:13 -0500
Subject: [PATCH] da903x_bl: control WLED output current in da9034
Message-ID: <mailman.40.1258455937.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update WLED output current source before changing brightness.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 drivers/video/backlight/da903x_bl.c |    7 +++++++
 include/linux/mfd/da903x.h          |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/backlight/da903x_bl.c
b/drivers/video/backlight/da903x_bl.c
index 701a108..9cbd01d 100644
--- a/drivers/video/backlight/da903x_bl.c
+++ b/drivers/video/backlight/da903x_bl.c
@@ -25,6 +25,7 @@

 #define DA9034_WLED_CONTROL1	0x3C
 #define DA9034_WLED_CONTROL2	0x3D
+#define DA9034_WLED_ISET(x)	((x) & 0x1f)

 #define DA9034_WLED_BOOST_EN	(1 << 5)

@@ -101,6 +102,7 @@ static struct backlight_ops da903x_backlight_ops = {

 static int da903x_backlight_probe(struct platform_device *pdev)
 {
+	struct da9034_backlight_pdata *pdata = pdev->dev.platform_data;
 	struct da903x_backlight_data *data;
 	struct backlight_device *bl;
 	int max_brightness;
@@ -127,6 +129,11 @@ static int da903x_backlight_probe(struct
platform_device *pdev)
 	data->da903x_dev = pdev->dev.parent;
 	data->current_brightness = 0;

+	/* adjust the WLED output current */
+	if (pdata)
+		da903x_write(dev, DA9034_WLED_CONTROL2,
+				DA9034_WLED_ISET(pdata->output_current));
+
 	bl = backlight_device_register(pdev->name, data->da903x_dev,
 			data, &da903x_backlight_ops);
 	if (IS_ERR(bl)) {
diff --git a/include/linux/mfd/da903x.h b/include/linux/mfd/da903x.h
index c63b65c..0aa3a1a 100644
--- a/include/linux/mfd/da903x.h
+++ b/include/linux/mfd/da903x.h
@@ -96,6 +96,10 @@ struct da9034_touch_pdata {
 	int	y_inverted;
 };

+struct da9034_backlight_pdata {
+	int	output_current;	/* output current of WLED, from 0-31 (in mA) */
+};
+
 /* DA9030 battery charger data */
 struct power_supply_info;

-- 
1.6.3.3
