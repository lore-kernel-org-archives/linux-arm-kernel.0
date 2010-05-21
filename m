From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 May 2010 09:15:22 +0200
Subject: [PATCH 2/2] mx2_camera: pass physical address to DMA engine
Message-ID: <mailman.467.1274426389.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/media/video/mx2_camera.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/mx2_camera.c b/drivers/media/video/mx2_camera.c
index 5d6fb08..6436968 100644
--- a/drivers/media/video/mx2_camera.c
+++ b/drivers/media/video/mx2_camera.c
@@ -216,6 +216,7 @@ struct mx2_camera_dev {
 
 	unsigned int		irq_csi, irq_emma;
 	void __iomem		*base_csi, *base_emma;
+	unsigned long		base_dma;
 
 	struct mx2_camera_platform_data *pdata;
 	struct resource		*res_csi, *res_emma;
@@ -550,7 +551,7 @@ static void mx2_videobuf_queue(struct videobuf_queue *vq,
 		if (!pcdev->active) {
 			ret = imx_dma_setup_single(pcdev->dma,
 					videobuf_to_dma_contig(vb), vb->size,
-					(u32)pcdev->base_csi + 0x10,
+					(u32)pcdev->base_dma + 0x10,
 					DMA_MODE_READ);
 			if (ret) {
 				vb->state = VIDEOBUF_ERROR;
@@ -976,7 +977,8 @@ static void mx27_camera_frame_done(struct mx2_camera_dev *pcdev, int state)
 	vb->state = VIDEOBUF_ACTIVE;
 
 	ret = imx_dma_setup_single(pcdev->dma, videobuf_to_dma_contig(vb),
-			vb->size, (u32)pcdev->base_csi + 0x10, DMA_MODE_READ);
+			vb->size, (u32)pcdev->base_dma + 0x10, DMA_MODE_READ);
+
 	if (ret) {
 		vb->state = VIDEOBUF_ERROR;
 		wake_up(&vb->done);
@@ -1273,6 +1275,7 @@ static int mx2_camera_probe(struct platform_device *pdev)
 	}
 	pcdev->irq_csi = irq_csi;
 	pcdev->base_csi = base_csi;
+	pcdev->base_dma = res_csi->start;
 	pcdev->dev = &pdev->dev;
 
 	err = request_irq(pcdev->irq_csi, mx2_cam_irq_handler, 0,
-- 
1.7.0

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
