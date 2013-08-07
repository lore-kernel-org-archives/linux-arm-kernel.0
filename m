From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:33:51 +0200
Subject: [PATCH 02/20] mtd: pxa3xx-nand: use mmp_pdma_filter_fn and
 dma_request_slave_channel_compat
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 736673a..99f56c3 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/dmaengine.h>
+#include <linux/dma/mmp-pdma.h>
 
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 
@@ -396,6 +397,7 @@ static void start_data_dma(struct pxa3xx_nand_info *info)
 	int dma_len = ALIGN(info->data_size + info->oob_size, 32);
 	struct dma_slave_config conf;
 
+	memset(&conf, 0, sizeof(conf));
 	dma_dev = info->data_dma_ch->device;
 
 	switch (info->state) {
@@ -419,7 +421,6 @@ static void start_data_dma(struct pxa3xx_nand_info *info)
 		BUG();
 	}
 
-	conf.slave_id = info->drcmr_dat;
 	dmaengine_slave_config(info->data_dma_ch, &conf);
 	tx = dma_dev->device_prep_dma_memcpy(info->data_dma_ch, dma_dst_addr,
 					     dma_src_addr, dma_len, 0);
@@ -940,7 +941,10 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
-	info->data_dma_ch = dma_request_channel(mask, NULL, NULL);
+	info->data_dma_ch =
+		dma_request_slave_channel_compat(mask, mmp_pdma_filter_fn,
+						 &info->drcmr_dat,
+						 &pdev->dev, "data");
 	if (!info->data_dma_ch) {
 		dev_info(&pdev->dev, "Failed to request DMA channel\n");
 		goto dma_request_fail;
@@ -1143,16 +1147,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		return ret;
 
 	if (use_dma) {
-		/*
-		 * This is a dirty hack to make this driver work from
-		 * devicetree bindings. It can be removed once we have
-		 * a prober DMA controller framework for DT.
-		 */
-		if (pdev->dev.of_node &&
-		    of_machine_is_compatible("marvell,pxa3xx")) {
-			info->drcmr_dat = 97;
-			info->drcmr_cmd = 99;
-		} else {
+		if (!pdev->dev.of_node) {
 			r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 			if (r == NULL) {
 				dev_err(&pdev->dev,
-- 
1.8.3.1
