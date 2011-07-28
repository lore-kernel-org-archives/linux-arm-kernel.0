From: nm@ti.com (Nishanth Menon)
Date: Thu, 28 Jul 2011 17:07:28 -0500
Subject: [PATCH 2/2] OMAP: PM: omap_device: add few quick access functions
Message-ID: <mailman.41.1311947385.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a quick set of access functions:
a) Convert omap_device to platform_device - This is the flip of
   to_omap_device for equivalent usage
b) Convert omap_device to device pointer - This is useful for
   most devices that need to go through standard linux functions that
   take device pointer.
c) Convert hwmod to device pointer - This wrapper provides ability for
   drivers to convert directly from hwmod name back to device pointer
   without having to handle this on a driver by driver basis

Change-Id: I0fe16eeb41c32d5b166d5cb3f78af4fda140d398
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 7a3c046..11cb471 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -150,5 +150,18 @@ struct omap_device_pm_latency {
 
 /* Get omap_device pointer from platform_device pointer */
 #define to_omap_device(x) container_of((x), struct omap_device, pdev)
+/* Convert omap_device to platform device pointer */
+#define omap_device_get_pdev(x) (&(x)->pdev)
+/* Convert omap_device to device pointer */
+#define omap_device_get_dev(x) (&omap_device_get_pdev(x)->dev)
+/* Convert omap_hwmod name to device pointer */
+static inline struct device *omap_hwmod_name_get_dev(const char *oh_name)
+{
+	struct omap_device *od;
+	od = omap_hwmod_name_get_dev(oh_name);
+	if (IS_ERR_OR_NULL(od))
+		return ERR_PTR(od ? PTR_ERR(od) : -ENODEV);
+	return omap_device_get_dev(od);
+}
 
 #endif
-- 
1.7.4.1
