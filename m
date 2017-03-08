From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  8 Mar 2017 10:19:04 +0100
Subject: [PATCH 2/4] qxl: limit monitor config read retries
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Message-ID: <1488964751-22763-5-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When reading the monitor config fails, don't retry forever.  If it fails
ten times in a row just give up to avoid the driver hangs.  Also add a
small delay after each attempt, so the host has a chance to complete a
partial update.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 2cd14be..2b99496 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -157,19 +157,23 @@ static void qxl_update_offset_props(struct qxl_device *qdev)
 
 void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
 {
-
 	struct drm_device *dev = &qdev->ddev;
-	int status;
+	int status, retries;
 
-	status = qxl_display_copy_rom_client_monitors_config(qdev);
-	while (status == MONITORS_CONFIG_BAD_CRC) {
-		qxl_io_log(qdev, "failed crc check for client_monitors_config,"
-				 " retrying\n");
+	for (retries = 0; retries < 10; retries++) {
 		status = qxl_display_copy_rom_client_monitors_config(qdev);
+		if (status != MONITORS_CONFIG_BAD_CRC)
+			break;
+		udelay(5);
+	}
+	if (status == MONITORS_CONFIG_BAD_CRC) {
+		qxl_io_log(qdev, "config: bad crc\n");
+		DRM_DEBUG_KMS("ignoring client monitors config: bad crc");
+		return;
 	}
 	if (status == MONITORS_CONFIG_UNCHANGED) {
-		qxl_io_log(qdev, "config unchanged\n");
-		DRM_DEBUG("ignoring unchanged client monitors config");
+		qxl_io_log(qdev, "config: unchanged\n");
+		DRM_DEBUG_KMS("ignoring client monitors config: unchanged");
 		return;
 	}
 
-- 
1.8.3.1
