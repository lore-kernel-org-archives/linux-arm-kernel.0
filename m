From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:28:39 +0000
Subject: [PATCH RFC 34/46] imx-drm: imx-drm-core: provide common connector
 and encoder cleanup functions
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypol-0007Fn-IZ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide two helper functions to assist with cleaning up imx-drm
connectors and encoders.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   13 +++++++++++++
 drivers/staging/imx-drm/imx-drm.h      |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 1cfb8a18d905..30d516cc76bb 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -363,6 +363,19 @@ static void imx_drm_connector_unregister(
 	drm_mode_group_reinit(imxdrm->drm);
 }
 
+void imx_drm_connector_destroy(struct drm_connector *connector)
+{
+	drm_sysfs_connector_remove(connector);
+	drm_connector_cleanup(connector);
+}
+EXPORT_SYMBOL_GPL(imx_drm_connector_destroy);
+
+void imx_drm_encoder_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+}
+EXPORT_SYMBOL_GPL(imx_drm_encoder_destroy);
+
 static struct drm_mode_config_funcs imx_drm_mode_config_funcs = {
 	.fb_create = drm_fb_cma_create,
 };
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index 49d4aaf33f97..d13d518e8eb9 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -69,5 +69,7 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 
 int imx_drm_connector_mode_valid(struct drm_connector *connector,
 	struct drm_display_mode *mode);
+void imx_drm_connector_destroy(struct drm_connector *connector);
+void imx_drm_encoder_destroy(struct drm_encoder *encoder);
 
 #endif /* _IMX_DRM_H_ */
-- 
1.7.4.4
