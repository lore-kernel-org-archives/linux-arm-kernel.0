From: zyw@rock-chips.com (Chris Zhong)
Date: Sun,  5 Feb 2017 15:54:58 +0800
Subject: [PATCH v17 3/7] drm/rockchip: cdn-dp: Do not run worker while
 suspended
In-Reply-To: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
References: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1486281302-28200-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guenter Roeck <groeck@chromium.org>

If the driver is in suspended mode, the dp block may be disabled, and
chip registers may not be accessible. Yet, the worker may be triggered
in this situation by an extcon event. If that happens, the following crash
will be seen.

cdn-dp fec00000.dp: [drm:cdn_dp_pd_event_work] *ERROR* Enable dp failed -19
cdn-dp fec00000.dp: [drm:cdn_dp_pd_event_work] Connected, not enabled. Enabling cdn
Bad mode in Error handler detected, code 0xbf000002 -- SError
CPU: 1 PID: 10357 Comm: kworker/1:2 Not tainted 4.4.21-05903-ge0514ea #1
Hardware name: Google Kevin (DT)
Workqueue: events cdn_dp_pd_event_work
task: ffffffc0cda67080 ti: ffffffc0b9b80000 task.ti: ffffffc0b9b80000
PC is at cdn_dp_clock_reset+0x30/0xa8
LR is at cdn_dp_enable+0x1e0/0x69c
...
Call trace:
[<ffffffc0005a7e24>] cdn_dp_pd_event_work+0x58/0x3f4
[<ffffffc0002397f0>] process_one_work+0x240/0x424
[<ffffffc00023a28c>] worker_thread+0x2fc/0x424
[<ffffffc00023f5fc>] kthread+0x10c/0x114
[<ffffffc000203dd0>] ret_from_fork+0x10/0x40

Problem is two-fold: The worker should not run while suspended, and the
suspend function should not call cdn_dp_disable() while the worker is
running.

Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v17: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 15 +++++++++++++--
 drivers/gpu/drm/rockchip/cdn-dp-core.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index b8d0dd7..a70eedc 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -939,6 +939,10 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 	u8 sink_count;
 
 	mutex_lock(&dp->lock);
+
+	if (dp->suspended)
+		goto out;
+
 	ret = cdn_dp_request_firmware(dp);
 	if (ret)
 		goto out;
@@ -1123,19 +1127,26 @@ static const struct component_ops cdn_dp_component_ops = {
 int cdn_dp_suspend(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
+	int ret = 0;
 
+	mutex_lock(&dp->lock);
 	if (dp->active)
-		return cdn_dp_disable(dp);
+		ret = cdn_dp_disable(dp);
+	dp->suspended = true;
+	mutex_unlock(&dp->lock);
 
-	return 0;
+	return ret;
 }
 
 int cdn_dp_resume(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 
+	mutex_lock(&dp->lock);
+	dp->suspended = false;
 	if (dp->fw_loaded)
 		schedule_work(&dp->event_work);
+	mutex_unlock(&dp->lock);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index 3bea4b8..7d48661 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -82,6 +82,7 @@ struct cdn_dp_device {
 	struct mutex lock;
 	bool connected;
 	bool active;
+	bool suspended;
 
 	const struct firmware *fw;	/* cdn dp firmware */
 	unsigned int fw_version;	/* cdn fw version */
-- 
2.6.3
