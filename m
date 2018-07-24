From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 24 Jul 2018 16:17:09 +0800
Subject: [PATCH v1 09/15] drm/mediatek: add YUYV/UYVY color format support for
 RDMA
In-Reply-To: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1532420235-22268-10-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add YUYV/UYVY color format support for RDMA
and transform matrix for YUYV/UYVY.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 5b7dadc21016..49edbae50167 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -34,6 +34,8 @@
 #define RDMA_SOFT_RESET					BIT(4)
 #define RDMA_MODE_MEMORY				BIT(1)
 #define DISP_REG_RDMA_SIZE_CON_0		0x0014
+#define RDMA_MATRIX_ENABLE				BIT(17)
+#define RDMA_MATRIX_INT_MTX_SEL				(7UL << 20)
 #define DISP_REG_RDMA_SIZE_CON_1		0x0018
 #define DISP_REG_RDMA_TARGET_LINE		0x001c
 #define DISP_RDMA_MEM_CON			0x0024
@@ -54,6 +56,8 @@
 #define MEM_MODE_INPUT_FORMAT_RGB888		(0x001 << 4)
 #define MEM_MODE_INPUT_FORMAT_RGBA8888		(0x002 << 4)
 #define MEM_MODE_INPUT_FORMAT_ARGB8888		(0x003 << 4)
+#define MEM_MODE_INPUT_FORMAT_UYVY		(0x004 << 4)
+#define MEM_MODE_INPUT_FORMAT_YUYV		(0x005 << 4)
 
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
@@ -188,6 +192,10 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
 		return MEM_MODE_INPUT_FORMAT_RGBA8888 | MEM_MODE_INPUT_SWAP;
+	case DRM_FORMAT_UYVY:
+		return MEM_MODE_INPUT_FORMAT_UYVY;
+	case DRM_FORMAT_YUYV:
+		return MEM_MODE_INPUT_FORMAT_YUYV;
 	}
 }
 
@@ -206,6 +214,12 @@ static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 
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
2.12.5
