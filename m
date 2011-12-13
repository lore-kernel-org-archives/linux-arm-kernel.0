From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 13 Dec 2011 16:25:55 +0530
Subject: [PATCHv8 2/5] OMAP: hwmod/device : add omap_device_reset to reset all
 the hwmods in the device
In-Reply-To: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1323773758-6375-3-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Add a function omap_device_reset() to reset all the hwmods in the hwmod device.
    This is intended to be used by device drivers to reset all the hwmods in the
    device. This is needed to support some ips like i2c which  may have to do reset
    in error paths or in errata.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 51423d2..663ef55 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -116,6 +116,7 @@ int omap_device_enable_hwmods(struct omap_device *od);
 
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
+int omap_device_reset(struct device *dev);
 
 /*
  * Entries should be kept in latency order ascending
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index e8d9869..e80e8c4 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -1129,6 +1129,28 @@ int omap_device_enable_clocks(struct omap_device *od)
 	/* XXX pass along return value here? */
 	return 0;
 }
+/**
+ * omap_device_reset - reset the module.
+ * @dev: struct device*
+ *
+ * Reset all the hwmods associated with the device
+ */
+
+int omap_device_reset(struct device *dev)
+{
+	int r = 0;
+	int i;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	struct omap_hwmod *oh;
+
+	for (i = 0; i < odev->hwmods_cnt; i++) {
+		oh = odev->hwmods[i];
+		r |= omap_hwmod_reset(oh);
+	}
+	return r;
+}
+
 
 struct device omap_device_parent = {
 	.init_name	= "omap",
-- 
1.7.1
