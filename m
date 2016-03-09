From: david@lechnology.com (David Lechner)
Date: Wed,  9 Mar 2016 17:50:05 -0600
Subject: [PATCH 4/4] mmc: davinci: suppress waring when using DT
In-Reply-To: <1457567405-30475-1-git-send-email-david@lechnology.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
Message-ID: <1457567405-30475-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using device tree dms resources are not obtained via IORESOURCE_DMA.
As a result, we would get warning even though DMA was working.

This fixes the problem by checking for dev.of_node and skipping trying to
get the dma platform resource if we are using device tree.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/mmc/host/davinci_mmc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index b160feb..475704d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1261,17 +1261,19 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;	/* Important */
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r)
-		dev_warn(&pdev->dev, "RX DMA resource not specified\n");
-	else
-		host->rxdma = r->start;
+	if (!pdev->dev.of_node) {
+		r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (!r)
+			dev_warn(&pdev->dev, "RX DMA resource not specified\n");
+		else
+			host->rxdma = r->start;
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!r)
-		dev_warn(&pdev->dev, "TX DMA resource not specified\n");
-	else
-		host->txdma = r->start;
+		r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+		if (!r)
+			dev_warn(&pdev->dev, "TX DMA resource not specified\n");
+		else
+			host->txdma = r->start;
+	}
 
 	host->mem_res = mem;
 	host->base = ioremap(mem->start, mem_size);
-- 
1.9.1
