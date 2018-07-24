From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 24 Jul 2018 16:17:10 +0800
Subject: [PATCH v1 10/15] drm/mediatek: add drm_device in RDMA for mamory mode
 to reaquest buffer
In-Reply-To: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1532420235-22268-11-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If RDMA want to request gem buffer, it need to save the drm device.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 49edbae50167..8d41f5cd485b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -72,6 +72,7 @@ struct mtk_disp_rdma {
 	struct mtk_ddp_comp		ddp_comp;
 	struct drm_crtc			*crtc;
 	const struct mtk_disp_rdma_data	*data;
+	struct drm_device *drm_dev;
 	bool rdma_memory_mode;
 };
 
@@ -240,6 +241,7 @@ static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
 {
 	struct mtk_disp_rdma *priv = dev_get_drvdata(dev);
 	struct mtk_ddp_comp *comp = &priv->ddp_comp;
+	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
 	struct drm_device *drm_dev = data;
 	int ret;
 
@@ -250,6 +252,7 @@ static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	rdma->drm_dev = drm_dev;
 
 	comp->comp_mode = &priv->rdma_memory_mode;
 
-- 
2.12.5
