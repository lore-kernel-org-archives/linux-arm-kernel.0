From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 10 Dec 2013 13:27:37 +0400
Subject: [PATCH 08/20] mmc: host: pxamci: switch over to dmaengine use
In-Reply-To: <1375889649-14638-9-git-send-email-zonque>
References: <1375889649-14638-9-git-send-email-zonque>
Message-ID: <1386667657-26355-1-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested this patch rebased onto v3.13-rc2

In-kernel DMA driver was not modified.

Below is the full diff against Daniel's version based on v3.11-rc5

My changes are at the line 572 to fix build failure and at the lines
630 and 780 to receive DMA channels from device tree.

The device works in general, but it is slower than with the old DMA
and it reports sporadic failures like that
--->8---
[ 2848.451688] mmc0: DMA error on rx channel, status 1
[ 2848.458326] mmcblk0: error -5 transferring data, sector 7037462, nr 2, cmd response 0x900, card status 0x0
[ 2848.469245] end_request: I/O error, dev mmcblk0, sector 7037462
[ 2883.228720] mmc0: DMA error on rx channel, status 1
[ 2883.263844] mmcblk0: error -5 transferring data, sector 7163928, nr 8, cmd response 0x900, card status 0xb00
[ 2883.274240] mmcblk0: retrying using single block read
--->8---

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 7aa97eb..e5bafd2 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -85,7 +85,7 @@ struct pxamci_host {
 static inline void pxamci_init_ocr(struct pxamci_host *host)
 {
 #ifdef CONFIG_REGULATOR
-	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
+	host->vcc = regulator_get_optional(mmc_dev(host->mmc), "vmmc");
 
 	if (IS_ERR(host->vcc))
 		host->vcc = NULL;
@@ -555,6 +555,12 @@ static void pxamci_dma_irq(void *param)
 	struct dma_tx_state state;
 	enum dma_status status;
 	struct dma_chan *chan;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (!host->data)
+		goto out_unlock;
 
 	if (host->data->flags & MMC_DATA_READ)
 		chan = host->dma_chan_rx;
@@ -563,14 +569,17 @@ static void pxamci_dma_irq(void *param)
 
 	status = dmaengine_tx_status(chan, host->dma_cookie, &state);
 
-	if (likely(status == DMA_SUCCESS)) {
+	if (likely(status == DMA_COMPLETE)) {
 		writel(BUF_PART_FULL, host->base + MMC_PRTBUF);
 	} else {
-		pr_err("%s: DMA error on %s channel\n", mmc_hostname(host->mmc),
-			host->data->flags & MMC_DATA_READ ? "rx" : "tx");
+		pr_err("%s: DMA error on %s channel, status %i\n", mmc_hostname(host->mmc),
+			host->data->flags & MMC_DATA_READ ? "rx" : "tx", status);
 		host->data->error = -EIO;
 		pxamci_data_done(host, 0);
 	}
+
+out_unlock:
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static irqreturn_t pxamci_detect_irq(int irq, void *devid)
@@ -618,11 +627,46 @@ static int pxamci_of_init(struct platform_device *pdev)
 
         return 0;
 }
+
+static int pxamci_of_init_dma(struct platform_device *pdev,
+		struct pxamci_host *host)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 tmp;
+	int i;
+	int ret;
+
+	i = of_property_match_string(np, "dma-names", "rx");
+	if (i < 0)
+		return i;
+
+	ret = of_property_read_u32_index(np, "dmas", 2 * i + 1, &tmp);
+	if (ret < 0)
+		return ret;
+	host->dma_drcmrrx = tmp;
+
+	i = of_property_match_string(np, "dma-names", "tx");
+	if (i < 0)
+		return i;
+
+	ret = of_property_read_u32_index(np, "dmas", 2 * i + 1, &tmp);
+	if (ret < 0)
+		return ret;
+	host->dma_drcmrtx = tmp;
+
+	return 0;
+}
 #else
 static int pxamci_of_init(struct platform_device *pdev)
 {
         return 0;
 }
+
+static int pxamci_of_init_dma(struct platform_device *pdev,
+		struct pxamci_host *host)
+{
+	return -ENODATA;
+}
 #endif
 
 static int pxamci_probe(struct platform_device *pdev)
@@ -733,7 +777,7 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mmc);
 
-	if (!pdev->dev.of_node) {
+	if (pxamci_of_init_dma(pdev, host) < 0) {
 		dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 		if (!dmarx) {
 			ret = -ENXIO;
@@ -896,35 +940,6 @@ static int pxamci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int pxamci_suspend(struct device *dev)
-{
-	struct mmc_host *mmc = dev_get_drvdata(dev);
-	int ret = 0;
-
-	if (mmc)
-		ret = mmc_suspend_host(mmc);
-
-	return ret;
-}
-
-static int pxamci_resume(struct device *dev)
-{
-	struct mmc_host *mmc = dev_get_drvdata(dev);
-	int ret = 0;
-
-	if (mmc)
-		ret = mmc_resume_host(mmc);
-
-	return ret;
-}
-
-static const struct dev_pm_ops pxamci_pm_ops = {
-	.suspend	= pxamci_suspend,
-	.resume		= pxamci_resume,
-};
-#endif
-
 static struct platform_driver pxamci_driver = {
 	.probe		= pxamci_probe,
 	.remove		= pxamci_remove,
@@ -932,9 +947,6 @@ static struct platform_driver pxamci_driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(pxa_mmc_dt_ids),
-#ifdef CONFIG_PM
-		.pm	= &pxamci_pm_ops,
-#endif
 	},
 };
 
