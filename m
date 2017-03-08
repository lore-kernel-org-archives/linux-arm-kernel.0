From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  8 Mar 2017 10:19:08 +0100
Subject: [PATCH 4/4] qxl: fix qxl_conn_get_modes
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Message-ID: <1488964751-22763-9-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call qxl_add_monitors_config_modes() unconditionally.  Do all sanity
checks in that function.

Fix sanity checks.  monitors_config is the current monitor
configuration, whereas client_monitors_config is the configuration
requested by the spice client.  So when filling the mode list, based on
the spice client request, we need to look at
client_monitors_config->count not monitors_config->count.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index cf99ace..9548bb5 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -202,9 +202,17 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector,
 	struct drm_display_mode *mode = NULL;
 	struct qxl_head *head;
 
+	if (!qdev->monitors_config)
+		return 0;
+	if (h >= qdev->monitors_config->max_allowed)
+		return 0;
 	if (!qdev->client_monitors_config)
 		return 0;
+	if (h >= qdev->client_monitors_config->count)
+		return 0;
+
 	head = &qdev->client_monitors_config->heads[h];
+	DRM_DEBUG_KMS("head %d is %dx%d\n", h, head->width, head->height);
 
 	mode = drm_cvt_mode(dev, head->width, head->height, 60, false, false,
 			    false);
@@ -911,19 +919,13 @@ static void qxl_enc_mode_set(struct drm_encoder *encoder,
 
 static int qxl_conn_get_modes(struct drm_connector *connector)
 {
-	int ret = 0;
-	struct qxl_device *qdev = connector->dev->dev_private;
 	unsigned pwidth = 1024;
 	unsigned pheight = 768;
+	int ret = 0;
 
-	DRM_DEBUG_KMS("monitors_config=%p\n", qdev->monitors_config);
-	/* TODO: what should we do here? only show the configured modes for the
-	 * device, or allow the full list, or both? */
-	if (qdev->monitors_config && qdev->monitors_config->count) {
-		ret = qxl_add_monitors_config_modes(connector, &pwidth, &pheight);
-		if (ret < 0)
-			return ret;
-	}
+	ret = qxl_add_monitors_config_modes(connector, &pwidth, &pheight);
+	if (ret < 0)
+		return ret;
 	ret += qxl_add_common_modes(connector, pwidth, pheight);
 	return ret;
 }
-- 
1.8.3.1
