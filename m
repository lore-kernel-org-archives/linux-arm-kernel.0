From: zyw@rock-chips.com (Chris Zhong)
Date: Sun,  5 Feb 2017 15:54:57 +0800
Subject: [PATCH v17 2/7] drm/rockchip: cdn-dp: Load firmware if no monitor
 connected
In-Reply-To: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
References: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1486281302-28200-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guenter Roeck <groeck@chromium.org>

If no monitor is connected, suspend/resume cycles result in firmware
load errors because the driver attempts to load the firmware while
the system is in suspend state. This results in a kernel warning and
traceback.

Loading the firmware during boot fixes the problem. Note that we can not
just call schedule_work conditionally in cdn_dp_pd_event() if the insertion
status changed. The problem would still be seen if a monitor is connected
for the first time during suspend.

Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v17: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 7db2508..b8d0dd7 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1021,7 +1021,6 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	struct cdn_dp_port *port;
 	struct drm_device *drm_dev = data;
 	int ret, i;
-	bool schedule_event = false;
 
 	ret = cdn_dp_parse_dt(dp);
 	if (ret < 0)
@@ -1083,15 +1082,11 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 				      "register EXTCON_DISP_DP notifier err\n");
 			goto err_free_connector;
 		}
-
-		if (extcon_get_state(port->extcon, EXTCON_DISP_DP))
-			schedule_event = true;
 	}
 
 	pm_runtime_enable(dev);
 
-	if (schedule_event)
-		schedule_work(&dp->event_work);
+	schedule_work(&dp->event_work);
 
 	return 0;
 
-- 
2.6.3
