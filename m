From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 24 May 2018 09:06:55 +0200
Subject: [PATCH v2 05/13] mtd: rawnand: marvell: remove the dmaengine compat
 need
In-Reply-To: <20180524070703.11901-1-robert.jarzmik@free.fr>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
Message-ID: <20180524070703.11901-6-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mtd/nand/raw/marvell_nand.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 10e953218948..f9763be078ef 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2613,8 +2613,6 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 						    dev);
 	struct dma_slave_config config = {};
 	struct resource *r;
-	dma_cap_mask_t mask;
-	struct pxad_param param;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_PXA_DMA)) {
@@ -2627,20 +2625,7 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 	if (ret)
 		return ret;
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r) {
-		dev_err(nfc->dev, "No resource defined for data DMA\n");
-		return -ENXIO;
-	}
-
-	param.drcmr = r->start;
-	param.prio = PXAD_PRIO_LOWEST;
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	nfc->dma_chan =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &param, nfc->dev,
-						 "data");
+	nfc->dma_chan =	dma_request_slave_channel(&nfc->dev, "data");
 	if (!nfc->dma_chan) {
 		dev_err(nfc->dev,
 			"Unable to request data DMA channel\n");
-- 
2.11.0
