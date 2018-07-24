From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 24 Jul 2018 16:17:07 +0800
Subject: [PATCH v1 07/15] drm/mediatek: add layer config to set RDMA for plane
 setting
In-Reply-To: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1532420235-22268-8-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add layer config to set RDMA for plane setting

Layer config set the data address and pitch to RDMA from plane setting.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 78a1a0057aff..4ad0715c8341 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -36,13 +36,17 @@
 #define DISP_REG_RDMA_SIZE_CON_0		0x0014
 #define DISP_REG_RDMA_SIZE_CON_1		0x0018
 #define DISP_REG_RDMA_TARGET_LINE		0x001c
+#define DISP_RDMA_MEM_SRC_PITCH			0x002c
+#define DISP_RDMA_MEM_GMC_SETTING_0		0x0030
 #define DISP_REG_RDMA_FIFO_CON			0x0040
 #define RDMA_FIFO_UNDERFLOW_EN				BIT(31)
 #define RDMA_FIFO_PSEUDO_SIZE(bytes)			(((bytes) / 16) << 16)
 #define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes)		((bytes) / 16)
 #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
+#define DISP_RDMA_MEM_START_ADDR		0x0f00
 
 #define MATRIX_INT_MTX_SEL_DEFAULT		0xb00000
+#define RDMA_MEM_GMC				0x40402020
 
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
@@ -152,12 +156,28 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
 }
 
+static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
+				  struct mtk_plane_state *state)
+{
+	struct mtk_plane_pending_state *pending = &state->pending;
+	unsigned int addr = pending->addr;
+	unsigned int pitch = pending->pitch & 0xffff;
+
+	if (pending->height == 0u || pending->width == 0u)
+		return;
+
+	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
+	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
+	writel(RDMA_MEM_GMC, comp->regs + DISP_RDMA_MEM_GMC_SETTING_0);
+}
+
 static const struct mtk_ddp_comp_funcs mtk_disp_rdma_funcs = {
 	.config = mtk_rdma_config,
 	.start = mtk_rdma_start,
 	.stop = mtk_rdma_stop,
 	.enable_vblank = mtk_rdma_enable_vblank,
 	.disable_vblank = mtk_rdma_disable_vblank,
+	.layer_config = mtk_rdma_layer_config,
 };
 
 static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
-- 
2.12.5
