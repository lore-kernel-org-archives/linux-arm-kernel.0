From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 24 Jul 2018 16:17:06 +0800
Subject: [PATCH v1 06/15] drm/mediatek: add memory mode for RDMA
In-Reply-To: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1532420235-22268-7-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add memory mode for RDMA

If use RDMA to read data from memory, it should set memory mode to RDMA

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 60851bb2dd63..78a1a0057aff 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -31,6 +31,8 @@
 #define RDMA_REG_UPDATE_INT				BIT(0)
 #define DISP_REG_RDMA_GLOBAL_CON		0x0010
 #define RDMA_ENGINE_EN					BIT(0)
+#define RDMA_SOFT_RESET					BIT(4)
+#define RDMA_MODE_MEMORY				BIT(1)
 #define DISP_REG_RDMA_SIZE_CON_0		0x0014
 #define DISP_REG_RDMA_SIZE_CON_1		0x0018
 #define DISP_REG_RDMA_TARGET_LINE		0x001c
@@ -40,6 +42,8 @@
 #define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes)		((bytes) / 16)
 #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
 
+#define MATRIX_INT_MTX_SEL_DEFAULT		0xb00000
+
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
 };
@@ -53,6 +57,7 @@ struct mtk_disp_rdma {
 	struct mtk_ddp_comp		ddp_comp;
 	struct drm_crtc			*crtc;
 	const struct mtk_disp_rdma_data	*data;
+	bool rdma_memory_mode;
 };
 
 static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *comp)
@@ -111,7 +116,8 @@ static void mtk_rdma_start(struct mtk_ddp_comp *comp)
 
 static void mtk_rdma_stop(struct mtk_ddp_comp *comp)
 {
-	rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON, RDMA_ENGINE_EN, 0);
+	writel(RDMA_SOFT_RESET, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
+	writel(0, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
 }
 
 static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
@@ -121,10 +127,18 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	unsigned int threshold;
 	unsigned int reg;
 	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
+	bool *rdma_memory_mode = comp->comp_mode;
 
 	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
 	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
 
+	if (*rdma_memory_mode == true) {
+		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
+				 MATRIX_INT_MTX_SEL_DEFAULT);
+		rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON,
+				 RDMA_MODE_MEMORY, RDMA_MODE_MEMORY);
+	}
+
 	/*
 	 * Enable FIFO underflow since DSI and DPI can't be blocked.
 	 * Keep the FIFO pseudo size reset default of 8 KiB. Set the
-- 
2.12.5
