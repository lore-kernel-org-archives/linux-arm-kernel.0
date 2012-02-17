From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri, 17 Feb 2012 17:03:45 +0800
Subject: [V1 2/3] backlight: modified power control of pm860x backlight
Message-ID: <1329469425-8209-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since several sub modules such as backlight, leds and vibrator depend
on the refernce group and internal oscillator in pm8606, so modified
the power control of backlight in pm8606 by unified interface.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/video/backlight/88pm860x_bl.c |   49 +++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
index a1376dc..b6ea65f 100644
--- a/drivers/video/backlight/88pm860x_bl.c
+++ b/drivers/video/backlight/88pm860x_bl.c
@@ -67,6 +67,28 @@ static inline int wled_idc(int port)
 	return ret;
 }
 
+static int backlight_power_set(struct pm860x_chip *chip, int port,
+		int on)
+{
+	int ret = -EINVAL;
+
+	switch (port) {
+	case PM8606_BACKLIGHT1:
+		ret = on ? pm8606_osc_enable(chip, WLED1_DUTY) :
+			pm8606_osc_disable(chip, WLED1_DUTY);
+		break;
+	case PM8606_BACKLIGHT2:
+		ret = on ? pm8606_osc_enable(chip, WLED2_DUTY) :
+			pm8606_osc_disable(chip, WLED2_DUTY);
+		break;
+	case PM8606_BACKLIGHT3:
+		ret = on ? pm8606_osc_enable(chip, WLED3_DUTY) :
+			pm8606_osc_disable(chip, WLED3_DUTY);
+		break;
+	}
+	return ret;
+}
+
 static int pm860x_backlight_set(struct backlight_device *bl, int brightness)
 {
 	struct pm860x_backlight_data *data = bl_get_data(bl);
@@ -79,6 +101,9 @@ static int pm860x_backlight_set(struct backlight_device *bl, int brightness)
 	else
 		value = brightness;
 
+	if (brightness)
+		backlight_power_set(chip, data->port, 1);
+
 	ret = pm860x_reg_write(data->i2c, wled_a(data->port), value);
 	if (ret < 0)
 		goto out;
@@ -115,6 +140,9 @@ static int pm860x_backlight_set(struct backlight_device *bl, int brightness)
 	if (ret < 0)
 		goto out;
 
+	if (brightness == 0)
+		backlight_power_set(chip, data->port, 0);
+
 	dev_dbg(chip->dev, "set brightness %d\n", value);
 	data->current_brightness = value;
 	return 0;
@@ -170,7 +198,6 @@ static int pm860x_backlight_probe(struct platform_device *pdev)
 	struct backlight_device *bl;
 	struct resource *res;
 	struct backlight_properties props;
-	unsigned char value;
 	char name[MFD_NAME_SIZE];
 	int ret;
 
@@ -218,26 +245,6 @@ static int pm860x_backlight_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bl);
 
-	/* Enable reference VSYS */
-	ret = pm860x_reg_read(data->i2c, PM8606_VSYS);
-	if (ret < 0)
-		goto out;
-	if ((ret & PM8606_VSYS_EN) == 0) {
-		value = ret | PM8606_VSYS_EN;
-		ret = pm860x_reg_write(data->i2c, PM8606_VSYS, value);
-		if (ret < 0)
-			goto out;
-	}
-	/* Enable reference OSC */
-	ret = pm860x_reg_read(data->i2c, PM8606_MISC);
-	if (ret < 0)
-		goto out;
-	if ((ret & PM8606_MISC_OSC_EN) == 0) {
-		value = ret | PM8606_MISC_OSC_EN;
-		ret = pm860x_reg_write(data->i2c, PM8606_MISC, value);
-		if (ret < 0)
-			goto out;
-	}
 	/* read current backlight */
 	ret = pm860x_backlight_get_brightness(bl);
 	if (ret < 0)
-- 
1.7.0.4
