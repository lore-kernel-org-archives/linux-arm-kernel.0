From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 24 Jul 2018 16:17:05 +0800
Subject: [PATCH v1 05/15] drm/mediatek: add RDMA memory mode for crtc created
In-Reply-To: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1532420235-22268-6-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add RDMA memory mode for crtc created

For mt2712, the third ddp use RDMA engine to read data from dram.

Therefore, when crtc created, crtc need to decide using OVL or RDMA
by ddp to read data from dram.

If this ddp use RDMA, the crtc should set this RDMA which in the crtc
using memory mode.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 5 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 8 ++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 585943c81e1f..60851bb2dd63 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -150,6 +150,7 @@ static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
 			      void *data)
 {
 	struct mtk_disp_rdma *priv = dev_get_drvdata(dev);
+	struct mtk_ddp_comp *comp = &priv->ddp_comp;
 	struct drm_device *drm_dev = data;
 	int ret;
 
@@ -160,8 +161,10 @@ static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
-	return 0;
 
+	comp->comp_mode = &priv->rdma_memory_mode;
+
+	return 0;
 }
 
 static void mtk_disp_rdma_unbind(struct device *dev, struct device *master,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 2d6aa150a9ff..4bf636e466f2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -578,6 +578,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		enum mtk_ddp_comp_id comp_id = path[i];
 		struct mtk_ddp_comp *comp;
 		struct device_node *node;
+		bool *rdma_memory_mode;
 
 		node = priv->comp_node[comp_id];
 		comp = priv->ddp_comp[comp_id];
@@ -595,6 +596,13 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 			goto unprepare;
 		}
 
+		if (i == 0 && (comp_id == DDP_COMPONENT_RDMA0 ||
+			       comp_id == DDP_COMPONENT_RDMA1 ||
+			       comp_id == DDP_COMPONENT_RDMA2)) {
+			rdma_memory_mode = comp->comp_mode;
+			*rdma_memory_mode = true;
+		}
+
 		mtk_crtc->ddp_comp[i] = comp;
 	}
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 7413ffeb3c9d..a1988ce15141 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -93,6 +93,7 @@ struct mtk_ddp_comp {
 	struct device *larb_dev;
 	enum mtk_ddp_comp_id id;
 	const struct mtk_ddp_comp_funcs *funcs;
+	void *comp_mode;
 };
 
 static inline void mtk_ddp_comp_config(struct mtk_ddp_comp *comp,
-- 
2.12.5
