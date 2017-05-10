From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 10 May 2017 11:35:48 +0800
Subject: [PATCH] drm: mediatek: change the variable type of rdma threshold
Message-ID: <1494387348-41170-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some greater resolution, the rdma threshold
variable will overflow.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 0df05f9..2718413 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -109,7 +109,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 			    unsigned int height, unsigned int vrefresh,
 			    unsigned int bpc)
 {
-	unsigned int threshold;
+	unsigned long long threshold;
 	unsigned int reg;
 
 	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
@@ -121,10 +121,11 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	 * output threshold to 6 microseconds with 7/6 overhead to
 	 * account for blanking, and with a pixel depth of 4 bytes:
 	 */
-	threshold = width * height * vrefresh * 4 * 7 / 1000000;
+	threshold = (unsigned long long)width * height * vrefresh *
+		    4 * 7 / 1000000;
 	reg = RDMA_FIFO_UNDERFLOW_EN |
 	      RDMA_FIFO_PSEUDO_SIZE(SZ_8K) |
-	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
+	      (unsigned int)RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
 	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
 }
 
-- 
1.9.1
