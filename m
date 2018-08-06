From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Mon, 6 Aug 2018 19:58:14 +0800
Subject: [PATCH v3 07/13] drm/mediatek: add YUYV/UYVY color format support for
 RDMA
In-Reply-To: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533556700-26525-8-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add YUYV/UYVY color format support for RDMA
and transform matrix for YUYV/UYVY.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index ba72d392dc27..91a8b6e27d39 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -33,6 +33,8 @@
 #define RDMA_ENGINE_EN					BIT(0)
 #define RDMA_MODE_MEMORY				BIT(1)
 #define DISP_REG_RDMA_SIZE_CON_0		0x0014
+#define RDMA_MATRIX_ENABLE				BIT(17)
+#define RDMA_MATRIX_INT_MTX_SEL				(7UL << 20)
 #define DISP_REG_RDMA_SIZE_CON_1		0x0018
 #define DISP_REG_RDMA_TARGET_LINE		0x001c
 #define DISP_RDMA_MEM_CON			0x0024
@@ -46,12 +48,15 @@
 #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
 #define DISP_RDMA_MEM_START_ADDR		0x0f00
 
+#define MATRIX_INT_MTX_SEL_DEFAULT		0xb00000
 #define RDMA_MEM_GMC				0x40402020
 
 #define MEM_MODE_INPUT_FORMAT_RGB565		0x0
 #define MEM_MODE_INPUT_FORMAT_RGB888		(0x001 << 4)
 #define MEM_MODE_INPUT_FORMAT_RGBA8888		(0x002 << 4)
 #define MEM_MODE_INPUT_FORMAT_ARGB8888		(0x003 << 4)
+#define MEM_MODE_INPUT_FORMAT_UYVY		(0x004 << 4)
+#define MEM_MODE_INPUT_FORMAT_YUYV		(0x005 << 4)
 
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
@@ -176,6 +181,10 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
 		return MEM_MODE_INPUT_FORMAT_RGBA8888 | MEM_MODE_INPUT_SWAP;
+	case DRM_FORMAT_UYVY:
+		return MEM_MODE_INPUT_FORMAT_UYVY;
+	case DRM_FORMAT_YUYV:
+		return MEM_MODE_INPUT_FORMAT_YUYV;
 	}
 }
 
@@ -191,6 +200,12 @@ static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 
 	con = rdma_fmt_convert(rdma, fmt);
 	writel_relaxed(con, comp->regs + DISP_RDMA_MEM_CON);
+	if (fmt == DRM_FORMAT_UYVY || fmt == DRM_FORMAT_YUYV)
+		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
+				 RDMA_MATRIX_ENABLE | RDMA_MATRIX_INT_MTX_SEL);
+	else
+		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
+				 MATRIX_INT_MTX_SEL_DEFAULT);
 
 	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
 	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
-- 
2.12.5.2.gbdf23ab
