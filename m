From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:17 -0500
Subject: [PATCH 02/41] drm/rockchip: Get rid of some unnecessary code
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-3-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <tfiga@chromium.org>

Current code implements prepare_fb and cleanup_fb callbacks only to
grab/release fb references, which is already done by atomic framework
when creating/destryoing plane state. Also there are some unused fields
vop and vop_win structs. Let's remove these unused bits.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 2151e1cee4b4..0539afb6b7c8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -108,9 +108,6 @@ struct vop {
 	struct drm_device *drm_dev;
 	bool is_enabled;
 
-	/* mutex vsync_ work */
-	struct mutex vsync_mutex;
-	bool vsync_work_pending;
 	struct completion dsp_hold_completion;
 
 	/* protected by dev->event_lock */
@@ -1592,8 +1589,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	spin_lock_init(&vop->reg_lock);
 	spin_lock_init(&vop->irq_lock);
 
-	mutex_init(&vop->vsync_mutex);
-
 	ret = devm_request_irq(dev, vop->irq, vop_isr,
 			       IRQF_SHARED, dev_name(dev), vop);
 	if (ret)
-- 
2.12.0.246.ga2ecc84866-goog
