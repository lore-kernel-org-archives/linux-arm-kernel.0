From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 3 Feb 2010 15:39:54 -0500
Subject: [PATCH] input: update 88pm860x driver
Message-ID: <mailman.186.1265202242.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update 88pm860x driver since genirq is used. The IRQ interface should be
updated.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/input/touchscreen/88pm860x-ts.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/88pm860x-ts.c
b/drivers/input/touchscreen/88pm860x-ts.c
index 56254d2..286bb49 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -54,7 +54,6 @@ static irqreturn_t pm860x_touch_handler(int irq, void *data)
 	int z1, z2, rt = 0;
 	int ret;

-	pm860x_mask_irq(chip, irq);
 	ret = pm860x_bulk_read(touch->i2c, MEAS_TSIX_1, MEAS_LEN, buf);
 	if (ret < 0)
 		goto out;
@@ -83,7 +82,6 @@ static irqreturn_t pm860x_touch_handler(int irq, void *data)
 		dev_dbg(chip->dev, "pen release\n");
 	}
 	input_sync(touch->idev);
-	pm860x_unmask_irq(chip, irq);

 out:
 	return IRQ_HANDLED;
@@ -92,7 +90,6 @@ out:
 static int pm860x_touch_open(struct input_dev *dev)
 {
 	struct pm860x_touch *touch = input_get_drvdata(dev);
-	struct pm860x_chip *chip = touch->chip;
 	int data, ret;

 	data = MEAS_PD_EN | MEAS_TSIX_EN | MEAS_TSIY_EN
@@ -100,7 +97,6 @@ static int pm860x_touch_open(struct input_dev *dev)
 	ret = pm860x_set_bits(touch->i2c, MEAS_EN3, data, data);
 	if (ret < 0)
 		goto out;
-	pm860x_unmask_irq(chip, touch->irq);
 	return 0;
 out:
 	return ret;
@@ -109,13 +105,11 @@ out:
 static void pm860x_touch_close(struct input_dev *dev)
 {
 	struct pm860x_touch *touch = input_get_drvdata(dev);
-	struct pm860x_chip *chip = touch->chip;
 	int data;

 	data = MEAS_PD_EN | MEAS_TSIX_EN | MEAS_TSIY_EN
 		| MEAS_TSIZ1_EN | MEAS_TSIZ2_EN;
 	pm860x_set_bits(touch->i2c, MEAS_EN3, data, 0);
-	pm860x_mask_irq(chip, touch->irq);
 }

 static int __devinit pm860x_touch_probe(struct platform_device *pdev)
@@ -164,11 +158,12 @@ static int __devinit pm860x_touch_probe(struct
platform_device *pdev)
 	touch->idev->close = pm860x_touch_close;
 	touch->chip = chip;
 	touch->i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
-	touch->irq = irq;
+	touch->irq = irq + chip->irq_base;
 	touch->res_x = pdata->res_x;
 	input_set_drvdata(touch->idev, touch);

-	ret = pm860x_request_irq(chip, irq, pm860x_touch_handler, touch);
+	ret = request_threaded_irq(touch->irq, NULL, pm860x_touch_handler,
+				   IRQF_ONESHOT, "touch", touch);
 	if (ret < 0)
 		goto out_irq;

@@ -194,7 +189,7 @@ static int __devinit pm860x_touch_probe(struct
platform_device *pdev)
 	platform_set_drvdata(pdev, touch);
 	return 0;
 out_rg:
-	pm860x_free_irq(chip, irq);
+	free_irq(touch->irq, touch);
 out_irq:
 	input_free_device(touch->idev);
 out:
@@ -207,7 +202,7 @@ static int __devexit pm860x_touch_remove(struct
platform_device *pdev)
 	struct pm860x_touch *touch = platform_get_drvdata(pdev);

 	input_unregister_device(touch->idev);
-	pm860x_free_irq(touch->chip, touch->irq);
+	free_irq(touch->irq, touch);
 	platform_set_drvdata(pdev, NULL);
 	kfree(touch);
 	return 0;
-- 
1.5.6.5
