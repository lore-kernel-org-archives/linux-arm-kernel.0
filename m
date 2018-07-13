From: yibin.gong@nxp.com (Robin Gong)
Date: Fri, 13 Jul 2018 21:08:45 +0800
Subject: [PATCH v2 1/3] dmaengine: imx-sdma: add SDMA_BD_MAX_CNT to replace
 '0xffff'
In-Reply-To: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <1531487327-21879-2-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macro SDMA_BD_MAX_CNT to replace '0xffff'.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3b622d6..e3d5e73 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -185,6 +185,7 @@
  * Mode/Count of data node descriptors - IPCv2
  */
 struct sdma_mode_count {
+#define SDMA_BD_MAX_CNT	0xffff
 	u32 count   : 16; /* size of the buffer pointed by this BD */
 	u32 status  :  8; /* E,R,I,C,W,D status bits stored here */
 	u32 command :  8; /* command mostly used for channel 0 */
@@ -1344,9 +1345,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 		count = sg_dma_len(sg);
 
-		if (count > 0xffff) {
+		if (count > SDMA_BD_MAX_CNT) {
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
-					channel, count, 0xffff);
+					channel, count, SDMA_BD_MAX_CNT);
 			goto err_bd_out;
 		}
 
@@ -1421,9 +1422,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 
-	if (period_len > 0xffff) {
+	if (period_len > SDMA_BD_MAX_CNT) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
-				channel, period_len, 0xffff);
+				channel, period_len, SDMA_BD_MAX_CNT);
 		goto err_bd_out;
 	}
 
@@ -1970,7 +1971,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
-	dma_set_max_seg_size(sdma->dma_device.dev, 65535);
+	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
 
 	platform_set_drvdata(pdev, sdma);
 
-- 
2.7.4
