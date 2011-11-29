From: jhbird.choi@samsung.com (jhbird.choi at samsung.com)
Date: Tue, 29 Nov 2011 17:17:51 +0900
Subject: [PATCH] mfd: max8998: Use standard device wakeup for handling wakeup
 device
Message-ID: <1322554671-16312-1-git-send-email-jhbird.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Use device_init_wakeup & device_may_wakeup to init wakeup

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/mfd/max8998.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index de4096a..6ef56d2 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -176,6 +176,8 @@ static int max8998_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		goto err;
 
+	device_init_wakeup(max8998->dev, max8998->wakeup);
+
 	return ret;
 
 err:
@@ -210,7 +212,7 @@ static int max8998_suspend(struct device *dev)
 	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
 	struct max8998_dev *max8998 = i2c_get_clientdata(i2c);
 
-	if (max8998->wakeup)
+	if (device_may_wakeup(dev))
 		irq_set_irq_wake(max8998->irq, 1);
 	return 0;
 }
@@ -220,7 +222,7 @@ static int max8998_resume(struct device *dev)
 	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
 	struct max8998_dev *max8998 = i2c_get_clientdata(i2c);
 
-	if (max8998->wakeup)
+	if (device_may_wakeup(dev))
 		irq_set_irq_wake(max8998->irq, 0);
 	/*
 	 * In LP3974, if IRQ registers are not "read & clear"
-- 
1.7.1
