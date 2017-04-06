From: you@example.com (Your Name)
Date: Thu,  6 Apr 2017 20:22:16 +0800
Subject: [PATCH v4 05/12] drm/rockchip: cdn-dp: Don't try to release firmware
 when not loaded
In-Reply-To: <1491481343-11025-1-git-send-email-you@example.com>
References: <1491481343-11025-1-git-send-email-you@example.com>
Message-ID: <1491481343-11025-6-git-send-email-you@example.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Your Name <you@example.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 4e55d63..ee4195d 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1053,6 +1053,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	dp->connected = false;
 	dp->active = false;
 	dp->active_port = -1;
+	dp->fw_loaded = false;
 
 	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
 
@@ -1133,7 +1134,8 @@ static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
 	connector->funcs->destroy(connector);
 
 	pm_runtime_disable(dev);
-	release_firmware(dp->fw);
+	if (dp->fw_loaded)
+		release_firmware(dp->fw);
 	kfree(dp->edid);
 	dp->edid = NULL;
 }
-- 
2.1.4
