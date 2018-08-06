From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Mon, 6 Aug 2018 19:58:12 +0800
Subject: [PATCH v3 05/13] drm/mediatek: add memory mode and layer_config for
 RDMA
In-Reply-To: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533556700-26525-6-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add memory mode for RDMA and layer_config for RDMA

If use RDMA to read data from memory, it should set memory mode to RDMA

Layer config set the data address and pitch to RDMA from plane setting.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 585943c81e1f..08866550740f 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -31,14 +31,20 @@
 #define RDMA_REG_UPDATE_INT				BIT(0)
 #define DISP_REG_RDMA_GLOBAL_CON		0x0010
 #define RDMA_ENGINE_EN					BIT(0)
+#define RDMA_MODE_MEMORY				BIT(1)
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
+
+#define RDMA_MEM_GMC				0x40402020
 
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
@@ -138,12 +144,27 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
 }
 
+static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
+				  struct mtk_plane_state *state)
+{
+	struct mtk_plane_pending_state *pending = &state->pending;
+	unsigned int addr = pending->addr;
+	unsigned int pitch = pending->pitch & 0xffff;
+
+	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
+	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
+	writel(RDMA_MEM_GMC, comp->regs + DISP_RDMA_MEM_GMC_SETTING_0);
+	rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON,
+			 RDMA_MODE_MEMORY, RDMA_MODE_MEMORY);
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
2.12.5.2.gbdf23ab
