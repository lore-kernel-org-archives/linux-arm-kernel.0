From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon,  2 Apr 2018 16:26:46 +0200
Subject: [PATCH 05/15] mtd: nand: pxa3xx: remove the dmaengine compat need
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
Message-ID: <20180402142656.26815-6-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Jarzmik <robert.jarzmik@renault.com>

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mtd/nand/pxa3xx_nand.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index d1979c7dbe7e..4a56a0aef5b1 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1518,8 +1518,6 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 {
 	struct platform_device *pdev = info->pdev;
 	struct dma_slave_config	config;
-	dma_cap_mask_t mask;
-	struct pxad_param param;
 	int ret;
 
 	info->data_buff = kmalloc(info->buf_size, GFP_KERNEL);
@@ -1533,13 +1531,7 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 		return ret;
 
 	sg_init_one(&info->sg, info->data_buff, info->buf_size);
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	param.prio = PXAD_PRIO_LOWEST;
-	param.drcmr = info->drcmr_dat;
-	info->dma_chan = dma_request_slave_channel_compat(mask, pxad_filter_fn,
-							  &param, &pdev->dev,
-							  "data");
+	info->dma_chan = dma_request_slave_channel(&pdev->dev, "data");
 	if (!info->dma_chan) {
 		dev_err(&pdev->dev, "unable to request data dma channel\n");
 		return -ENODEV;
-- 
2.11.0
