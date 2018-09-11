From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 11 Sep 2018 23:03:44 +0200
Subject: [PATCH 2/3] mfd: ti-lmu: use managed resource for everything
In-Reply-To: <20180911210133.GA32497@amd>
References: <20180911210133.GA32497@amd>
Message-ID: <20180911210344.GB32497@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces all remaining unmanaged resources with device
managed ones, so that the remove function is no longer needed.
This makes the code slightly shorter and fixes two problems:
    
 1. The hardware is disabled after the child devices have
    been removed. Previously there was a potential race
    condition.
 2. The hardware is disabled when mfd_add_devices fails
    during probe.
    
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index e14cb9f..2ee09d0 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -47,8 +47,9 @@ static int ti_lmu_enable_hw(struct ti_lmu *lmu, enum ti_lmu_id id)
 	return 0;
 }
 
-static void ti_lmu_disable_hw(struct ti_lmu *lmu)
+static void ti_lmu_disable_hw(void *data)
 {
+	struct ti_lmu *lmu = data;
 	if (lmu->en_gpio)
 		gpiod_set_value(lmu->en_gpio, 0);
 }
@@ -205,6 +206,10 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, ti_lmu_disable_hw, lmu);
+	if (ret)
+		return ret;
+
 	/*
 	 * Fault circuit(open/short) can be detected by ti-lmu-fault-monitor.
 	 * After fault detection is done, some devices should re-initialize
@@ -214,17 +219,8 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 
 	i2c_set_clientdata(cl, lmu);
 
-	return mfd_add_devices(lmu->dev, 0, data->cells,
-			       data->num_cells, NULL, 0, NULL);
-}
-
-static int ti_lmu_remove(struct i2c_client *cl)
-{
-	struct ti_lmu *lmu = i2c_get_clientdata(cl);
-
-	ti_lmu_disable_hw(lmu);
-	mfd_remove_devices(lmu->dev);
-	return 0;
+	return devm_mfd_add_devices(lmu->dev, 0, data->cells,
+				    data->num_cells, NULL, 0, NULL);
 }
 
 static const struct i2c_device_id ti_lmu_ids[] = {
@@ -240,7 +236,6 @@ MODULE_DEVICE_TABLE(i2c, ti_lmu_ids);
 
 static struct i2c_driver ti_lmu_driver = {
 	.probe = ti_lmu_probe,
-	.remove = ti_lmu_remove,
 	.driver = {
 		.name = "ti-lmu",
 		.of_match_table = ti_lmu_of_match,

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180911/46051cfa/attachment-0001.sig>
