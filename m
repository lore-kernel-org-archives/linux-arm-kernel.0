From: zyw@rock-chips.com (Chris Zhong)
Date: Sun,  5 Feb 2017 15:54:59 +0800
Subject: [PATCH v17 4/7] drm/rockchip: cdn-dp: do not use
 drm_helper_hpd_irq_event
In-Reply-To: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
References: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1486281302-28200-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cdn_dp_pd_event_work is using drm_helper_hpd_irq_event to update the
connector status, this function is used to update all connectors of
drm_device. Therefore, the detect of other connector will be call, when
cdn_dp_pd_event_work is triggered, every time. It is not necessary, and
it may cause system crash. replace drm_helper_hpd_irq_event with
drm_kms_helper_hotplug_event, only update cdn-dp status.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Tested-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v17: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index a70eedc..62e02a4 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -935,6 +935,9 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
+	struct drm_connector *connector = &dp->connector;
+	enum drm_connector_status old_status;
+
 	int ret;
 	u8 sink_count;
 
@@ -997,7 +1000,11 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 
 out:
 	mutex_unlock(&dp->lock);
-	drm_helper_hpd_irq_event(dp->drm_dev);
+
+	old_status = connector->status;
+	connector->status = connector->funcs->detect(connector, false);
+	if (old_status != connector->status)
+		drm_kms_helper_hotplug_event(dp->drm_dev);
 }
 
 static int cdn_dp_pd_event(struct notifier_block *nb,
-- 
2.6.3
