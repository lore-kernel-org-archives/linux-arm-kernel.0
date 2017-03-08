From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  8 Mar 2017 10:19:06 +0100
Subject: [PATCH 3/4] qxl: read monitors config at boot
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Message-ID: <1488964751-22763-7-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to read the client monitors config at driver load time, even without
explicit notification.  So in case that info was filled before the driver
loaded and we've missed the notifications because of that the settings
will still be used.

With that place we now have to take care to properly handle a empty client
monitors config, so we don't trip over an uninitialized client monitors
config.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 2b99496..cf99ace 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -81,6 +81,10 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 			   qdev->rom->client_monitors_config_crc);
 		return MONITORS_CONFIG_BAD_CRC;
 	}
+	if (!num_monitors) {
+		DRM_DEBUG_KMS("no client monitors configured\n");
+		return status;
+	}
 	if (num_monitors > qdev->monitors_config->max_allowed) {
 		DRM_DEBUG_KMS("client monitors list will be truncated: %d < %d\n",
 			      qdev->monitors_config->max_allowed, num_monitors);
@@ -1192,6 +1196,7 @@ int qxl_modeset_init(struct qxl_device *qdev)
 		qdev_output_init(&qdev->ddev, i);
 	}
 
+	qxl_display_read_client_monitors_config(qdev);
 	qdev->mode_info.mode_config_initialized = true;
 
 	drm_mode_config_reset(&qdev->ddev);
-- 
1.8.3.1
