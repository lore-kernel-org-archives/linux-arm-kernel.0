From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 11 Sep 2013 18:32:34 +0300
Subject: [PATCH v2 3/9] Input: misc - convert existing I2C client drivers to
 use I2C core runtime PM
In-Reply-To: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <1378913560-2752-4-git-send-email-mika.westerberg@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C core now prepares runtime PM on behalf of the I2C client device, so
only thing the driver needs to do is to call pm_runtime_put() at the end of
->probe().

This patch converts bma150 and mpu3050 input drivers to use this model.

While we are there remove call to pm_runtime_set_autosuspend_delay() in
mpu3050 driver because the driver doesn't seem to use autosuspend anyway.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/input/misc/bma150.c  |  4 ++--
 drivers/input/misc/mpu3050.c | 16 ++++------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 865c2f9..f1bf5e9 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -592,7 +592,7 @@ static int bma150_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, bma150);
 
-	pm_runtime_enable(&client->dev);
+	pm_runtime_put(&client->dev);
 
 	return 0;
 
@@ -605,7 +605,7 @@ static int bma150_remove(struct i2c_client *client)
 {
 	struct bma150_data *bma150 = i2c_get_clientdata(client);
 
-	pm_runtime_disable(&client->dev);
+	pm_runtime_get(&client->dev);
 
 	if (client->irq > 0) {
 		free_irq(client->irq, bma150);
diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index dce0d95..9f2ead5 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -43,8 +43,6 @@
 
 #define MPU3050_CHIP_ID		0x69
 
-#define MPU3050_AUTO_DELAY	1000
-
 #define MPU3050_MIN_VALUE	-32768
 #define MPU3050_MAX_VALUE	32767
 
@@ -359,11 +357,9 @@ static int mpu3050_probe(struct i2c_client *client,
 
 	input_set_drvdata(idev, sensor);
 
-	pm_runtime_set_active(&client->dev);
-
 	error = mpu3050_hw_init(sensor);
 	if (error)
-		goto err_pm_set_suspended;
+		goto err_free_mem;
 
 	error = request_threaded_irq(client->irq,
 				     NULL, mpu3050_interrupt_thread,
@@ -372,7 +368,7 @@ static int mpu3050_probe(struct i2c_client *client,
 	if (error) {
 		dev_err(&client->dev,
 			"can't get IRQ %d, error %d\n", client->irq, error);
-		goto err_pm_set_suspended;
+		goto err_free_mem;
 	}
 
 	error = input_register_device(idev);
@@ -381,15 +377,12 @@ static int mpu3050_probe(struct i2c_client *client,
 		goto err_free_irq;
 	}
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev, MPU3050_AUTO_DELAY);
+	pm_runtime_put(&client->dev);
 
 	return 0;
 
 err_free_irq:
 	free_irq(client->irq, sensor);
-err_pm_set_suspended:
-	pm_runtime_set_suspended(&client->dev);
 err_free_mem:
 	input_free_device(idev);
 	kfree(sensor);
@@ -406,8 +399,7 @@ static int mpu3050_remove(struct i2c_client *client)
 {
 	struct mpu3050_sensor *sensor = i2c_get_clientdata(client);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_get(&client->dev);
 
 	free_irq(client->irq, sensor);
 	input_unregister_device(sensor->idev);
-- 
1.8.4.rc3
