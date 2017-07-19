From: maarten.lankhorst@linux.intel.com (Maarten Lankhorst)
Date: Wed, 19 Jul 2017 09:40:46 +0200
Subject: [PATCH 06/12] drm/mediatek: Handle drm_atomic_helper_swap_state
 failure
In-Reply-To: <20170719074052.2993-1-maarten.lankhorst@linux.intel.com>
References: <20170719074052.2993-1-maarten.lankhorst@linux.intel.com>
Message-ID: <20170719074052.2993-6-maarten.lankhorst@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_atomic_helper_swap_state() will be changed to interruptible waiting
in the next few commits, so all drivers have to be changed to handling
failure.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
Link: http://patchwork.freedesktop.org/patch/msgid/20170711143314.2148-7-maarten.lankhorst at linux.intel.com
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index be0741638f94..b2596f35104b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -109,7 +109,12 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	mutex_lock(&private->commit.lock);
 	flush_work(&private->commit.work);
 
-	drm_atomic_helper_swap_state(state, true);
+	ret = drm_atomic_helper_swap_state(state, true);
+	if (ret) {
+		mutex_unlock(&private->commit.lock);
+		drm_atomic_helper_cleanup_planes(drm, state);
+		return ret;
+	}
 
 	drm_atomic_state_get(state);
 	if (async)
-- 
2.11.0
