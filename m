From: khilman@ti.com (Kevin Hilman)
Date: Wed,  6 Jul 2011 12:26:17 -0700
Subject: [PATCH] OMAP: omap_device: replace _find_by_pdev() with
	to_omap_device()
Message-ID: <1309980377-5964-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap_device layer currently has two ways of getting an omap_device
pointer from a platform_device pointer.

Replace current usage of _find_by_pdev() with to_omap_device() since
to_omap_device() is more familiar to the existing to_platform_device()
used when getting a platform_device pointer from a struct device pointer.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Paul, please consider this minor cleanup for the v3.1 merge window.
Applies to v3.0-c6.

 arch/arm/plat-omap/omap_device.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 49fc0df..c8b9cd1 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -236,11 +236,6 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 	return 0;
 }
 
-static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
-{
-	return container_of(pdev, struct omap_device, pdev);
-}
-
 /**
  * _add_optional_clock_clkdev - Add clkdev entry for hwmod optional clocks
  * @od: struct omap_device *od
@@ -316,7 +311,7 @@ u32 omap_device_get_context_loss_count(struct platform_device *pdev)
 	struct omap_device *od;
 	u32 ret = 0;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (od->hwmods_cnt)
 		ret = omap_hwmod_get_context_loss_count(od->hwmods[0]);
@@ -611,7 +606,7 @@ int omap_device_enable(struct platform_device *pdev)
 	int ret;
 	struct omap_device *od;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
 		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
@@ -650,7 +645,7 @@ int omap_device_idle(struct platform_device *pdev)
 	int ret;
 	struct omap_device *od;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
 		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
@@ -681,7 +676,7 @@ int omap_device_shutdown(struct platform_device *pdev)
 	int ret, i;
 	struct omap_device *od;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED &&
 	    od->_state != OMAP_DEVICE_STATE_IDLE) {
@@ -722,7 +717,7 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
 	int ret = -EINVAL;
 	struct omap_device *od;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (new_wakeup_lat_limit == od->dev_wakeup_lat)
 		return 0;
-- 
1.7.6
