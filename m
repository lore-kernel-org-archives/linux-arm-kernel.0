From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 30 Apr 2014 16:02:53 +0200
Subject: [RFC PATCH 3/4] drm/exynos/dpi: add interface tracker support
In-Reply-To: <1398866574-27001-1-git-send-email-a.hajda@samsung.com>
References: <1398866574-27001-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1398866574-27001-4-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos_dpi uses connector polling for tracking panel presence,
this solution introduces unnecessary 10s delay before panel activation.
Moreover it is unsafe, module unloading or driver unbinding can
cause system crash. interface_tracker support solves both problems.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dpi.c | 58 ++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 2b09c7c..4c6682f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -14,6 +14,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_panel.h>
 
+#include <linux/interface_tracker.h>
 #include <linux/regulator/consumer.h>
 
 #include <video/of_videomode.h>
@@ -21,6 +22,8 @@
 
 #include "exynos_drm_drv.h"
 
+static void exynos_dpi_dpms(struct exynos_drm_display *display, int mode);
+
 struct exynos_dpi {
 	struct device *dev;
 	struct device_node *panel_node;
@@ -28,6 +31,7 @@ struct exynos_dpi {
 	struct drm_panel *panel;
 	struct drm_connector connector;
 	struct drm_encoder *encoder;
+	struct interface_tracker_block itb;
 
 	struct videomode *vm;
 	int dpms_mode;
@@ -41,15 +45,9 @@ exynos_dpi_detect(struct drm_connector *connector, bool force)
 	struct exynos_dpi *ctx = connector_to_dpi(connector);
 
 	/* panels supported only by boot-loader are always connected */
-	if (!ctx->panel_node)
+	if (ctx->vm)
 		return connector_status_connected;
 
-	if (!ctx->panel) {
-		ctx->panel = of_drm_find_panel(ctx->panel_node);
-		if (ctx->panel)
-			drm_panel_attach(ctx->panel, &ctx->connector);
-	}
-
 	if (ctx->panel)
 		return connector_status_connected;
 
@@ -114,6 +112,28 @@ static struct drm_connector_helper_funcs exynos_dpi_connector_helper_funcs = {
 	.best_encoder = exynos_dpi_best_encoder,
 };
 
+void exynos_dpi_notifier(struct interface_tracker_block *itb,
+			 const void *object, unsigned long type, bool on,
+			 void *data)
+{
+	struct exynos_dpi *ctx = container_of(itb, struct exynos_dpi, itb);
+
+	mutex_lock(&ctx->connector.dev->mode_config.mutex);
+	if (on) {
+		ctx->panel = data;
+		drm_panel_attach(ctx->panel, &ctx->connector);
+	} else {
+		struct exynos_drm_display *display;
+
+		display = platform_get_drvdata(to_platform_device(ctx->dev));
+		exynos_dpi_dpms(display, DRM_MODE_DPMS_OFF);
+		drm_panel_detach(ctx->panel);
+		ctx->panel = NULL;
+	}
+	mutex_unlock(&ctx->connector.dev->mode_config.mutex);
+	drm_helper_hpd_irq_event(ctx->connector.dev);
+}
+
 static int exynos_dpi_create_connector(struct exynos_drm_display *display,
 				       struct drm_encoder *encoder)
 {
@@ -123,10 +143,7 @@ static int exynos_dpi_create_connector(struct exynos_drm_display *display,
 
 	ctx->encoder = encoder;
 
-	if (ctx->panel_node)
-		connector->polled = DRM_CONNECTOR_POLL_CONNECT;
-	else
-		connector->polled = DRM_CONNECTOR_POLL_HPD;
+	connector->polled = DRM_CONNECTOR_POLL_HPD;
 
 	ret = drm_connector_init(encoder->dev, connector,
 				 &exynos_dpi_connector_funcs,
@@ -140,9 +157,27 @@ static int exynos_dpi_create_connector(struct exynos_drm_display *display,
 	drm_sysfs_connector_add(connector);
 	drm_mode_connector_attach_encoder(connector, encoder);
 
+	if (ctx->panel_node) {
+		ctx->itb.callback = exynos_dpi_notifier;
+		interface_tracker_register(ctx->panel_node,
+					   INTERFACE_TRACKER_TYPE_DRM_PANEL,
+					   &ctx->itb);
+	}
+
 	return 0;
 }
 
+static void exynos_dpi_display_remove(struct exynos_drm_display *display)
+{
+	struct exynos_dpi *ctx = display->ctx;
+
+	if (ctx->panel_node) {
+		interface_tracker_unregister(ctx->panel_node,
+					     INTERFACE_TRACKER_TYPE_DRM_PANEL,
+					     &ctx->itb);
+	}
+}
+
 static void exynos_dpi_poweron(struct exynos_dpi *ctx)
 {
 	if (ctx->panel)
@@ -178,6 +213,7 @@ static void exynos_dpi_dpms(struct exynos_drm_display *display, int mode)
 
 static struct exynos_drm_display_ops exynos_dpi_display_ops = {
 	.create_connector = exynos_dpi_create_connector,
+	.remove = exynos_dpi_display_remove,
 	.dpms = exynos_dpi_dpms
 };
 
-- 
1.8.3.2
