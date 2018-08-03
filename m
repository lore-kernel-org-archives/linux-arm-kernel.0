From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Fri, 3 Aug 2018 11:11:05 +0800
Subject: [PATCH v2 12/15] drm/mediatek: add callback function to return RDMA
 layer number
In-Reply-To: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533265868-28110-13-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add callback function to return RDMA layer number

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index b728f0f42611..8c145a87c9e5 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -60,6 +60,7 @@
 
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
+	unsigned int layer_nr;
 };
 
 /**
@@ -194,6 +195,13 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
 	}
 }
 
+static unsigned int mtk_rdma_layer_nr(struct mtk_ddp_comp *comp)
+{
+	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
+
+	return rdma->data->layer_nr;
+}
+
 static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 				  struct mtk_plane_state *state)
 {
@@ -227,6 +235,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_rdma_funcs = {
 	.stop = mtk_rdma_stop,
 	.enable_vblank = mtk_rdma_enable_vblank,
 	.disable_vblank = mtk_rdma_disable_vblank,
+	.layer_nr = mtk_rdma_layer_nr,
 	.layer_config = mtk_rdma_layer_config,
 };
 
@@ -329,6 +338,7 @@ static const struct mtk_disp_rdma_data mt2701_rdma_driver_data = {
 
 static const struct mtk_disp_rdma_data mt8173_rdma_driver_data = {
 	.fifo_size = SZ_8K,
+	.layer_nr = 1,
 };
 
 static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
-- 
2.12.5.2.gbdf23ab
