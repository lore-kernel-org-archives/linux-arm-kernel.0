From: yt.shen@mediatek.com (yt.shen at mediatek.com)
Date: Fri, 20 May 2016 23:05:35 +0800
Subject: [RFC v2 4/5] drm/mediatek: add shadow register support
In-Reply-To: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1463756736-46573-5-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YT Shen <yt.shen@mediatek.com>

We need to acquire mutex before using the resources,
and need to release it after finished.
So we don't need to write registers in the blanking period.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c |   75 +++++++++++++++++++------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c  |   26 +++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  |    1 +
 5 files changed, 77 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 3095fc1..5f1eea1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -315,6 +315,42 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 	pm_runtime_put(drm->dev);
 }
 
+static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
+{
+	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
+	struct mtk_ddp_comp *ovl = mtk_crtc->ddp_comp[0];
+	unsigned int i;
+
+	/*
+	 * TODO: instead of updating the registers here, we should prepare
+	 * working registers in atomic_commit and let the hardware command
+	 * queue update module registers on vblank.
+	 */
+	if (state->pending_config) {
+		mtk_ddp_comp_config(ovl, state->pending_width,
+				    state->pending_height,
+				    state->pending_vrefresh);
+
+		state->pending_config = false;
+	}
+
+	if (mtk_crtc->pending_planes) {
+		for (i = 0; i < OVL_LAYER_NR; i++) {
+			struct drm_plane *plane = &mtk_crtc->planes[i].base;
+			struct mtk_plane_state *plane_state;
+
+			plane_state = to_mtk_plane_state(plane->state);
+
+			if (plane_state->pending.config) {
+				mtk_ddp_comp_layer_config(ovl, i, plane_state);
+				plane_state->pending.config = false;
+			}
+		}
+		mtk_crtc->pending_planes = false;
+	}
+}
+
 static void mtk_drm_crtc_enable(struct drm_crtc *crtc)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
@@ -391,6 +427,7 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 				      struct drm_crtc_state *old_crtc_state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_drm_private *priv = crtc->dev->dev_private;
 	unsigned int pending_planes = 0;
 	int i;
 
@@ -409,6 +446,12 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 	if (pending_planes)
 		mtk_crtc->pending_planes = true;
+
+	if (priv->data->shadow_register) {
+		mtk_disp_mutex_acquire(mtk_crtc->mutex);
+		mtk_crtc_ddp_config(crtc);
+		mtk_disp_mutex_release(mtk_crtc->mutex);
+	}
 }
 
 static const struct drm_crtc_funcs mtk_crtc_funcs = {
@@ -453,36 +496,10 @@ err_cleanup_crtc:
 void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *ovl)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
-	unsigned int i;
+	struct mtk_drm_private *priv = crtc->dev->dev_private;
 
-	/*
-	 * TODO: instead of updating the registers here, we should prepare
-	 * working registers in atomic_commit and let the hardware command
-	 * queue update module registers on vblank.
-	 */
-	if (state->pending_config) {
-		mtk_ddp_comp_config(ovl, state->pending_width,
-				    state->pending_height,
-				    state->pending_vrefresh);
-
-		state->pending_config = false;
-	}
-
-	if (mtk_crtc->pending_planes) {
-		for (i = 0; i < OVL_LAYER_NR; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i].base;
-			struct mtk_plane_state *plane_state;
-
-			plane_state = to_mtk_plane_state(plane->state);
-
-			if (plane_state->pending.config) {
-				mtk_ddp_comp_layer_config(ovl, i, plane_state);
-				plane_state->pending.config = false;
-			}
-		}
-		mtk_crtc->pending_planes = false;
-	}
+	if (!priv->data->shadow_register)
+		mtk_crtc_ddp_config(crtc);
 
 	mtk_drm_finish_page_flip(mtk_crtc);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 529569d..f09a414 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -36,6 +37,7 @@
 #define DISP_REG_CONFIG_DSI_SEL			0x050
 
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
+#define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
 #define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
@@ -341,6 +343,30 @@ void mtk_disp_mutex_disable(struct mtk_disp_mutex *mutex)
 	writel(0, ddp->regs + DISP_REG_MUTEX_EN(mutex->id));
 }
 
+void mtk_disp_mutex_acquire(struct mtk_disp_mutex *mutex)
+{
+	struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
+					   mutex[mutex->id]);
+
+	unsigned int cnt = 0;
+
+	writel(1, ddp->regs + DISP_REG_MUTEX_EN(mutex->id));
+	writel(1, ddp->regs + DISP_REG_MUTEX(mutex->id));
+	while (!(readl(ddp->regs + DISP_REG_MUTEX(mutex->id)) & 0x2)) {
+		if (cnt++ > 10000)
+			break;
+		udelay(1);
+	}
+}
+
+void mtk_disp_mutex_release(struct mtk_disp_mutex *mutex)
+{
+	struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
+					   mutex[mutex->id]);
+
+	writel(0, ddp->regs + DISP_REG_MUTEX(mutex->id));
+}
+
 static const struct of_device_id ddp_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mutex_mod_mt2701},
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mutex_mod_mt8173},
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
index 92c1175..f9a7991 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
@@ -37,5 +37,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 				enum mtk_ddp_comp_id id);
 void mtk_disp_mutex_unprepare(struct mtk_disp_mutex *mutex);
 void mtk_disp_mutex_put(struct mtk_disp_mutex *mutex);
+void mtk_disp_mutex_acquire(struct mtk_disp_mutex *mutex);
+void mtk_disp_mutex_release(struct mtk_disp_mutex *mutex);
 
 #endif /* MTK_DRM_DDP_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 8b562ab..8f9fb7e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -146,6 +146,7 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.main_len = ARRAY_SIZE(mtk_ddp_main_2701),
 	.ext_path = mtk_ddp_ext_2701,
 	.ext_len = ARRAY_SIZE(mtk_ddp_ext_2701),
+	.shadow_register = true,
 };
 
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
@@ -153,6 +154,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.main_len = ARRAY_SIZE(mtk_ddp_main_8173),
 	.ext_path = mtk_ddp_ext_8173,
 	.ext_len = ARRAY_SIZE(mtk_ddp_ext_8173),
+	.shadow_register = false,
 };
 
 static int mtk_drm_kms_init(struct drm_device *drm)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index fa0b106..94f8b66 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -33,6 +33,7 @@ struct mtk_mmsys_driver_data {
 	unsigned int main_len;
 	const enum mtk_ddp_comp_id *ext_path;
 	unsigned int ext_len;
+	bool shadow_register;
 };
 
 struct mtk_drm_private {
-- 
1.7.9.5
