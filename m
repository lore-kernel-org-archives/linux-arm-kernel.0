From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed,  8 Sep 2010 09:44:35 -0400
Subject: [PATCH 4/5] input: monitor both onkey up and down event
In-Reply-To: <1283953476-2395-3-git-send-email-haojian.zhuang@marvell.com>
References: <1283953476-2395-1-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-2-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1283953476-2395-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove original 3-second ONKEY event. Detect ONKEY changing event directly.
So both UP and DOWN event of ONKEY in max8925 are monitered.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Samuel Ortiz <sameo@openedhand.com>
---
 drivers/input/misc/max8925_onkey.c |   72 +++++++++++++++++++++++++++---------
 drivers/mfd/max8925-core.c         |   11 ++++-
 2 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
index 80af446..7de0ded 100644
--- a/drivers/input/misc/max8925_onkey.c
+++ b/drivers/input/misc/max8925_onkey.c
@@ -27,27 +27,37 @@
 #include <linux/mfd/max8925.h>
 #include <linux/slab.h>
 
+#define SW_INPUT		(1 << 7)	/* 0/1 -- up/down */
 #define HARDRESET_EN		(1 << 7)
 #define PWREN_EN		(1 << 7)
 
 struct max8925_onkey_info {
 	struct input_dev	*idev;
 	struct i2c_client	*i2c;
-	int			irq;
+	struct device		*dev;
+	int			irq[2];
 };
 
 /*
- * MAX8925 gives us an interrupt when ONKEY is held for 3 seconds.
+ * MAX8925 gives us an interrupt when ONKEY is pressed or released.
  * max8925_set_bits() operates I2C bus and may sleep. So implement
  * it in thread IRQ handler.
  */
 static irqreturn_t max8925_onkey_handler(int irq, void *data)
 {
 	struct max8925_onkey_info *info = data;
-
-	input_report_key(info->idev, KEY_POWER, 1);
+	int ret, event;
+
+	ret = max8925_reg_read(info->i2c, MAX8925_ON_OFF_STATUS);
+	if (ret & SW_INPUT)
+		event = 1;
+	else
+		event = 0;
+	input_report_key(info->idev, KEY_POWER, event);
 	input_sync(info->idev);
 
+	dev_dbg(info->dev, "onkey event:%d\n", event);
+
 	/* Enable hardreset to halt if system isn't shutdown on time */
 	max8925_set_bits(info->i2c, MAX8925_SYSENSEL,
 			 HARDRESET_EN, HARDRESET_EN);
@@ -59,14 +69,42 @@ static int __devinit max8925_onkey_probe(struct platform_device *pdev)
 {
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct max8925_onkey_info *info;
-	int error;
+	int irq[2], error;
+
+	irq[0] = platform_get_irq(pdev, 0);
+	if (irq[0] < 0) {
+		dev_err(&pdev->dev, "No IRQ resource!\n");
+		return -EINVAL;
+	}
+	irq[1] = platform_get_irq(pdev, 1);
+	if (irq[1] < 0) {
+		dev_err(&pdev->dev, "No IRQ resource!\n");
+		return -EINVAL;
+	}
 
 	info = kzalloc(sizeof(struct max8925_onkey_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
 	info->i2c = chip->i2c;
-	info->irq = chip->irq_base + MAX8925_IRQ_GPM_SW_3SEC;
+	info->dev = &pdev->dev;
+	irq[0] += chip->irq_base;
+	irq[1] += chip->irq_base;
+
+	error = request_threaded_irq(irq[0], NULL, max8925_onkey_handler,
+				     IRQF_ONESHOT, "onkey-down", info);
+	if (error < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			irq[0], error);
+		goto out;
+	}
+	error = request_threaded_irq(irq[1], NULL, max8925_onkey_handler,
+				     IRQF_ONESHOT, "onkey-up", info);
+	if (error < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			irq[1], error);
+		goto out_irq;
+	}
 
 	info->idev = input_allocate_device();
 	if (!info->idev) {
@@ -79,32 +117,29 @@ static int __devinit max8925_onkey_probe(struct platform_device *pdev)
 	info->idev->phys = "max8925_on/input0";
 	info->idev->id.bustype = BUS_I2C;
 	info->idev->dev.parent = &pdev->dev;
+	info->irq[0] = irq[0];
+	info->irq[1] = irq[1];
 	info->idev->evbit[0] = BIT_MASK(EV_KEY);
 	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
 
-	error = request_threaded_irq(info->irq, NULL, max8925_onkey_handler,
-				     IRQF_ONESHOT, "onkey", info);
-	if (error < 0) {
-		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
-			info->irq, error);
-		goto out_irq;
-	}
 
 	error = input_register_device(info->idev);
 	if (error) {
 		dev_err(chip->dev, "Can't register input device: %d\n", error);
-		goto out;
+		goto out_reg;
 	}
 
 	platform_set_drvdata(pdev, info);
 
 	return 0;
 
-out:
-	free_irq(info->irq, info);
-out_irq:
+out_reg:
 	input_free_device(info->idev);
 out_input:
+	free_irq(info->irq[1], info);
+out_irq:
+	free_irq(info->irq[0], info);
+out:
 	kfree(info);
 	return error;
 }
@@ -113,7 +148,8 @@ static int __devexit max8925_onkey_remove(struct platform_device *pdev)
 {
 	struct max8925_onkey_info *info = platform_get_drvdata(pdev);
 
-	free_irq(info->irq, info);
+	free_irq(info->irq[0], info);
+	free_irq(info->irq[1], info);
 	input_unregister_device(info->idev);
 	kfree(info);
 
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 04028a9..f9cdfbe 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -93,8 +93,13 @@ static struct mfd_cell rtc_devs[] = {
 static struct resource onkey_resources[] = {
 	{
 		.name	= "max8925-onkey",
-		.start	= MAX8925_IRQ_GPM_SW_3SEC,
-		.end	= MAX8925_IRQ_GPM_SW_3SEC,
+		.start	= MAX8925_IRQ_GPM_SW_R,
+		.end	= MAX8925_IRQ_GPM_SW_R,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.name	= "max8925-onkey",
+		.start	= MAX8925_IRQ_GPM_SW_F,
+		.end	= MAX8925_IRQ_GPM_SW_F,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -102,7 +107,7 @@ static struct resource onkey_resources[] = {
 static struct mfd_cell onkey_devs[] = {
 	{
 		.name		= "max8925-onkey",
-		.num_resources	= 1,
+		.num_resources	= 2,
 		.resources	= &onkey_resources[0],
 		.id		= -1,
 	},
-- 
1.5.6.5
