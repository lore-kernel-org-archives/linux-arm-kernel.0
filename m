From: khilman@ti.com (Kevin Hilman)
Date: Tue, 10 Jul 2012 16:02:02 -0700
Subject: [PATCH 1/3] ARM: OMAP: omap_device: keep track of driver bound status
Message-ID: <1341961324-19657-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the bus notifier to keep track of driver bound status by adding a
new internal field to struct omap_device: _driver_staus.

This will be useful for follow-up patches which need to know whether
or not a driver is bound in order to make intelligent omap_device
enable/idle decisions.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
 arch/arm/plat-omap/omap_device.c              |   14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 4327b2c..e0486cb 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -60,6 +60,7 @@ extern struct dev_pm_domain omap_device_pm_domain;
  * @_dev_wakeup_lat_limit: dev wakeup latency limit in nsec - set by OMAP PM
  * @_state: one of OMAP_DEVICE_STATE_* (see above)
  * @flags: device flags
+ * @_driver_status: one of BUS_NOTIFY_*_DRIVER from <linux/device.h>
  *
  * Integrates omap_hwmod data into Linux platform_device.
  *
@@ -78,6 +79,7 @@ struct omap_device {
 	u8				hwmods_cnt;
 	u8				_state;
 	u8                              flags;
+	u8				_driver_status;
 };
 
 /* Device driver interface (call via platform_data fn ptrs) */
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index c490240..1d1b5ff 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -385,17 +385,21 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 				      unsigned long event, void *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od;
 
 	switch (event) {
-	case BUS_NOTIFY_ADD_DEVICE:
-		if (pdev->dev.of_node)
-			omap_device_build_from_dt(pdev);
-		break;
-
 	case BUS_NOTIFY_DEL_DEVICE:
 		if (pdev->archdata.od)
 			omap_device_delete(pdev->archdata.od);
 		break;
+	case BUS_NOTIFY_ADD_DEVICE:
+		if (pdev->dev.of_node)
+			omap_device_build_from_dt(pdev);
+		/* fall through */
+	default:
+		od = to_omap_device(pdev);
+		if (od)
+			od->_driver_status = event;
 	}
 
 	return NOTIFY_DONE;
-- 
1.7.9.2
