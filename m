From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:28:14 +0000
Subject: [PATCH RFC 29/46] imx-drm: delay publishing sysfs connector entries
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VypoM-0007FS-1L@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delay publishing sysfs connector entries until all components have
initialised.  This reduces the probability of generating false hotplug
events when we're uncertain whether the driver can fully initialise.
This also pulls that code out of the individual imx-drm connector
drivers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 8ece15944569..d5bf4a4646a3 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -355,7 +355,7 @@ static int imx_drm_connector_register(
 			imx_drm_connector->connector->connector_type);
 	drm_mode_group_reinit(imxdrm->drm);
 
-	return drm_sysfs_connector_add(imx_drm_connector->connector);
+	return 0;
 }
 
 /*
@@ -379,6 +379,7 @@ static void imx_drm_connector_unregister(
 static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 {
 	struct imx_drm_device *imxdrm = __imx_drm_device();
+	struct drm_connector *connector;
 	int ret;
 
 	imxdrm->drm = drm;
@@ -431,8 +432,27 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 	ret = component_bind_all(drm->dev, drm);
 	if (ret)
 		goto err_relock;
+
+	/*
+	 * All components are now added, we can publish the connector sysfs
+	 * entries to userspace.  This will generate hotplug events and so
+	 * userspace will expect to be able to access DRM at this point.
+	 */
+	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
+		ret = drm_sysfs_connector_add(connector);
+		if (ret) {
+			dev_err(drm->dev,
+				"[CONNECTOR:%d:%s] drm_sysfs_connector_add failed: %d\n",
+				connector->base.id,
+				drm_get_connector_name(connector), ret);
+			goto err_unbind;
+		}
+	}
+
 	return 0;
 
+err_unbind:
+	component_unbind_all(drm->dev, drm);
 err_relock:
 	mutex_lock(&imxdrm->mutex);
 err_vblank:
-- 
1.7.4.4
