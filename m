From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 22 Aug 2011 17:19:02 +0200
Subject: [PATCH 2/7] OMAP: PM: omap_device: add few quick access functions
In-Reply-To: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314026347-21623-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Provide a quick set of access functions:
a) Convert omap_device to platform_device - This is the flip of
   to_omap_device for equivalent usage
b) Convert omap_device to device pointer - This is useful for
   most devices that need to go through standard linux functions that
   take device pointer.
c) Convert hwmod to device pointer - This wrapper provides ability for
   drivers to convert directly from hwmod name back to device pointer
   without having to handle this on a driver by driver basis

Signed-off-by: Nishanth Menon <nm@ti.com>
[b-cousson at ti.com: Adapt it to the new pdev pointer inside od]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index bdc2804..903f329 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -152,6 +152,21 @@ static inline struct omap_device *to_omap_device(struct platform_device *pdev)
 	return pdev ? pdev->archdata.od : NULL;
 }
 
+/* Convert omap_device to platform device pointer */
+#define omap_device_get_pdev(x) ((x)->pdev)
+/* Convert omap_device to device pointer */
+#define omap_device_get_dev(x) (&omap_device_get_pdev(x)->dev)
+
+/* Convert omap_hwmod name to device pointer */
+static inline struct device *omap_hwmod_name_get_dev(const char *oh_name)
+{
+	struct omap_device *od;
+	od = omap_hwmod_name_get_odev(oh_name);
+	if (IS_ERR_OR_NULL(od))
+		return ERR_PTR(od ? PTR_ERR(od) : -ENODEV);
+	return omap_device_get_dev(od);
+}
+
 static inline
 void omap_device_disable_idle_on_suspend(struct platform_device *pdev)
 {
-- 
1.7.0.4
