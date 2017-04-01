From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Sat,  1 Apr 2017 18:43:57 +0800
Subject: [PATCH 4/9] drm/rockchip: cdn-dp: Don't try to release firmware when
 not loaded
In-Reply-To: <1491043442-20626-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1491043442-20626-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1491043442-20626-5-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index fd79a70..a97f3f4 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1052,6 +1052,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	dp->connected = false;
 	dp->active = false;
 	dp->active_port = -1;
+	dp->fw_loaded = false;
 
 	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
 
@@ -1132,7 +1133,8 @@ static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
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
