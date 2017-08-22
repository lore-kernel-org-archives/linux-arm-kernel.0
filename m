From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:59 +0530
Subject: [PATCH v3 10/17] dmaengine: bcm-sba-raid: Alloc resources before
 registering DMA device
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-11-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should allocate DMA channel resources before registering the
DMA device in sba_probe() because we can get DMA request soon
after registering the DMA device. If DMA channel resources are
not allocated before first DMA request then SBA-RAID driver will
crash.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index f6616da..f14ed0a 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -1478,13 +1478,13 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 	int i, j, ret = 0;
 	struct sba_request *req = NULL;
 
-	sba->resp_base = dma_alloc_coherent(sba->dma_dev.dev,
+	sba->resp_base = dma_alloc_coherent(sba->mbox_dev,
 					    sba->max_resp_pool_size,
 					    &sba->resp_dma_base, GFP_KERNEL);
 	if (!sba->resp_base)
 		return -ENOMEM;
 
-	sba->cmds_base = dma_alloc_coherent(sba->dma_dev.dev,
+	sba->cmds_base = dma_alloc_coherent(sba->mbox_dev,
 					    sba->max_cmds_pool_size,
 					    &sba->cmds_dma_base, GFP_KERNEL);
 	if (!sba->cmds_base) {
@@ -1534,11 +1534,11 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 	return 0;
 
 fail_free_cmds_pool:
-	dma_free_coherent(sba->dma_dev.dev,
+	dma_free_coherent(sba->mbox_dev,
 			  sba->max_cmds_pool_size,
 			  sba->cmds_base, sba->cmds_dma_base);
 fail_free_resp_pool:
-	dma_free_coherent(sba->dma_dev.dev,
+	dma_free_coherent(sba->mbox_dev,
 			  sba->max_resp_pool_size,
 			  sba->resp_base, sba->resp_dma_base);
 	return ret;
@@ -1547,9 +1547,9 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 static void sba_freeup_channel_resources(struct sba_device *sba)
 {
 	dmaengine_terminate_all(&sba->dma_chan);
-	dma_free_coherent(sba->dma_dev.dev, sba->max_cmds_pool_size,
+	dma_free_coherent(sba->mbox_dev, sba->max_cmds_pool_size,
 			  sba->cmds_base, sba->cmds_dma_base);
-	dma_free_coherent(sba->dma_dev.dev, sba->max_resp_pool_size,
+	dma_free_coherent(sba->mbox_dev, sba->max_resp_pool_size,
 			  sba->resp_base, sba->resp_dma_base);
 	sba->resp_base = NULL;
 	sba->resp_dma_base = 0;
@@ -1737,15 +1737,15 @@ static int sba_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Register DMA device with linux async framework */
-	ret = sba_async_register(sba);
+	/* Prealloc channel resource */
+	ret = sba_prealloc_channel_resources(sba);
 	if (ret)
 		goto fail_free_mchans;
 
-	/* Prealloc channel resource */
-	ret = sba_prealloc_channel_resources(sba);
+	/* Register DMA device with Linux async framework */
+	ret = sba_async_register(sba);
 	if (ret)
-		goto fail_async_dev_unreg;
+		goto fail_free_resources;
 
 	/* Print device info */
 	dev_info(sba->dev, "%s using SBAv%d and %d mailbox channels",
@@ -1754,8 +1754,8 @@ static int sba_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail_async_dev_unreg:
-	dma_async_device_unregister(&sba->dma_dev);
+fail_free_resources:
+	sba_freeup_channel_resources(sba);
 fail_free_mchans:
 	for (i = 0; i < sba->mchans_count; i++)
 		mbox_free_channel(sba->mchans[i]);
@@ -1767,10 +1767,10 @@ static int sba_remove(struct platform_device *pdev)
 	int i;
 	struct sba_device *sba = platform_get_drvdata(pdev);
 
-	sba_freeup_channel_resources(sba);
-
 	dma_async_device_unregister(&sba->dma_dev);
 
+	sba_freeup_channel_resources(sba);
+
 	for (i = 0; i < sba->mchans_count; i++)
 		mbox_free_channel(sba->mchans[i]);
 
-- 
2.7.4
