From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 12 Sep 2018 17:27:02 +0200
Subject: [PATCH] soc: imx: gpc: set DMA mask for PD platform devices
Message-ID: <20180912152702.14640-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PD platform devices aren't DMA capable (as is correctly reflected
in with a zero mask coherent_dma_mask). As they have a of_node attached
they will go through of_dma_configure, which will warn if it finds an
uninitialized DMA mask. Let the driver core know that this isn't a
missing configuration, but a non DMA capable device by pointing the
dma_mask to the coherent_dma_mask.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
Since the warning that is triggered with the incomplete configuration
has been introduced in the v4.19 cycle, it would nice to get this in
as a fix.
---
 drivers/soc/imx/gpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index f301fcd96c07..a897c851f305 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -493,6 +493,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 
 			pd_pdev->dev.parent = &pdev->dev;
 			pd_pdev->dev.of_node = np;
+			pd_pdev->dev.dma_mask = &pd_pdev->dev.coherent_dma_mask;
 
 			ret = platform_device_add(pd_pdev);
 			if (ret) {
-- 
2.18.0
