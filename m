From: zyw@rock-chips.com (Chris Zhong)
Date: Sun,  5 Feb 2017 15:55:00 +0800
Subject: [PATCH v17 5/7] drm/rockchip: cdn-dp: Move mutex_init to probe
In-Reply-To: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
References: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1486281302-28200-6-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

We're trying to lock mutex when cdn-dp shutdown, so we need to make
sure the mutex is inited in cdn-dp's probe.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v17: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 62e02a4..799e826 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1041,7 +1041,6 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	dp->connected = false;
 	dp->active = false;
 
-	mutex_init(&dp->lock);
 	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
 
 	encoder = &dp->encoder;
@@ -1204,6 +1203,7 @@ static int cdn_dp_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	mutex_init(&dp->lock);
 	dev_set_drvdata(dev, dp);
 
 	return component_add(dev, &cdn_dp_component_ops);
-- 
2.6.3
