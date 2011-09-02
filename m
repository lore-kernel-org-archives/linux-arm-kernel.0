From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 2 Sep 2011 16:25:19 +0200
Subject: [PATCH v2 5/6] OMAP: omap_device: Create a default
	omap_device_pm_latency
In-Reply-To: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
References: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314973520-3585-6-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most devices are using the same default omap_device_pm_latency structure
during device built. In order to avoid the duplication of the same
structure everywhere, add a default structure that will be used if
the device does not have an explicit one.

Next patches will clean the duplicated structures.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 320b1f4..272dbab 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -97,6 +97,14 @@
 static int omap_device_register(struct platform_device *pdev);
 static int omap_early_device_register(struct platform_device *pdev);
 
+static struct omap_device_pm_latency omap_default_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	}
+};
+
 /* Private functions */
 
 /**
@@ -510,8 +518,13 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	if (ret)
 		goto odbs_exit3;
 
-	od->pm_lats = pm_lats;
-	od->pm_lats_cnt = pm_lats_cnt;
+	if (pm_lats) {
+		od->pm_lats = pm_lats;
+		od->pm_lats_cnt = pm_lats_cnt;
+	} else {
+		od->pm_lats = omap_default_latency;
+		od->pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
+	}
 
 	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
-- 
1.7.0.4
