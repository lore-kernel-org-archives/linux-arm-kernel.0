From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 11 Jan 2017 14:51:05 +0800
Subject: [PATCH v11 04/12] drm/mediatek: add shadow register support
In-Reply-To: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484117473-46644-5-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to acquire mutex before using the resources,
and need to release it after finished.
So we don't need to write registers in the blanking period.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 75 ++++++++++++++++++++-------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 25 +++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  1 +
 4 files changed, 74 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 01a21dd..b9b82e5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -329,6 +329,42 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
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
+				    state->pending_vrefresh, 0);
+
+		state->pending_config = false;
+	}
+
+	if (mtk_crtc->pending_planes) {
+		for (i = 0; i < OVL_LAYER_NR; i++) {
+			struct drm_plane *plane = &mtk_crtc->planes[i];
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
@@ -405,6 +441,7 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 				      struct drm_crtc_state *old_crtc_state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_drm_private *priv = crtc->dev->dev_private;
 	unsigned int pending_planes = 0;
 	int i;
 
@@ -426,6 +463,12 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	if (crtc->state->color_mgmt_changed)
 		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
 			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
+
+	if (priv->data->shadow_register) {
+		mtk_disp_mutex_acquire(mtk_crtc->mutex);
+		mtk_crtc_ddp_config(crtc);
+		mtk_disp_mutex_release(mtk_crtc->mutex);
+	}
 }
 
 static const struct drm_crtc_funcs mtk_crtc_funcs = {
@@ -471,36 +514,10 @@ static int mtk_drm_crtc_init(struct drm_device *drm,
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
-				    state->pending_vrefresh, 0);
-
-		state->pending_config = false;
-	}
-
-	if (mtk_crtc->pending_planes) {
-		for (i = 0; i < OVL_LAYER_NR; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i];
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
index 8030769..b77d456 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -32,10 +33,13 @@
 #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
 
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
+#define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
 #define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
 
+#define INT_MUTEX				BIT(1)
+
 #define MT8173_MUTEX_MOD_DISP_OVL0		BIT(11)
 #define MT8173_MUTEX_MOD_DISP_OVL1		BIT(12)
 #define MT8173_MUTEX_MOD_DISP_RDMA0		BIT(13)
@@ -300,6 +304,27 @@ void mtk_disp_mutex_disable(struct mtk_disp_mutex *mutex)
 	writel(0, ddp->regs + DISP_REG_MUTEX_EN(mutex->id));
 }
 
+void mtk_disp_mutex_acquire(struct mtk_disp_mutex *mutex)
+{
+	struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
+					   mutex[mutex->id]);
+	u32 tmp;
+
+	writel(1, ddp->regs + DISP_REG_MUTEX_EN(mutex->id));
+	writel(1, ddp->regs + DISP_REG_MUTEX(mutex->id));
+	if (readl_poll_timeout_atomic(ddp->regs + DISP_REG_MUTEX(mutex->id),
+				      tmp, tmp & INT_MUTEX, 1, 10000))
+		pr_err("could not acquire mutex %d\n", mutex->id);
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
 static int mtk_ddp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
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
1.9.1
