From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:52:58 +0530
Subject: [PATCH 2/4] dmaengine: bcm-sba-raid: Use only single mailbox channel
In-Reply-To: <1507008180-27171-1-git-send-email-anup.patel@broadcom.com>
References: <1507008180-27171-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1507008180-27171-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each mailbox channel used by Broadcom SBA RAID driver is
a separate HW ring.

Currently, Broadcom SBA RAID driver creates one DMA channel
using one or more mailbox channels. When we are using more
than one mailbox channels for a DMA channel, the sba_request
are distributed evenly among multiple mailbox channels which
results in sba_request being completed out-of-order.

The above described out-of-order completion of sba_request
breaks the dma_async_is_complete() API because it assumes
DMA cookies are completed in orderly fashion.

To ensure correct behaviour of dma_async_is_complete() API,
this patch updates Broadcom SBA RAID driver to use only
single mailbox channel. If additional mailbox channels are
specified in DT then those will be ignored.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 104 ++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 77 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 15c5585..409da59 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -25,11 +25,8 @@
  *
  * The Broadcom SBA RAID driver does not require any register programming
  * except submitting request to SBA hardware device via mailbox channels.
- * This driver implements a DMA device with one DMA channel using a set
- * of mailbox channels provided by Broadcom SoC specific ring manager
- * driver. To exploit parallelism (as described above), all DMA request
- * coming to SBA RAID DMA channel are broken down to smaller requests
- * and submitted to multiple mailbox channels in round-robin fashion.
+ * This driver implements a DMA device with one DMA channel using a single
+ * mailbox channel provided by Broadcom SoC specific ring manager driver.
  * For having more SBA DMA channels, we can create more SBA device nodes
  * in Broadcom SoC specific DTS based on number of hardware rings supported
  * by Broadcom SoC ring manager.
@@ -85,6 +82,7 @@
 #define SBA_CMD_GALOIS					0xe
 
 #define SBA_MAX_REQ_PER_MBOX_CHANNEL			8192
+#define SBA_MAX_MSG_SEND_PER_MBOX_CHANNEL		8
 
 /* Driver helper macros */
 #define to_sba_request(tx)		\
@@ -142,9 +140,7 @@ struct sba_device {
 	u32 max_cmds_pool_size;
 	/* Maibox client and Mailbox channels */
 	struct mbox_client client;
-	int mchans_count;
-	atomic_t mchans_current;
-	struct mbox_chan **mchans;
+	struct mbox_chan *mchan;
 	struct device *mbox_dev;
 	/* DMA device and DMA channel */
 	struct dma_device dma_dev;
@@ -200,14 +196,6 @@ static inline u32 __pure sba_cmd_pq_c_mdata(u32 d, u32 b1, u32 b0)
 
 /* ====== General helper routines ===== */
 
-static void sba_peek_mchans(struct sba_device *sba)
-{
-	int mchan_idx;
-
-	for (mchan_idx = 0; mchan_idx < sba->mchans_count; mchan_idx++)
-		mbox_client_peek_data(sba->mchans[mchan_idx]);
-}
-
 static struct sba_request *sba_alloc_request(struct sba_device *sba)
 {
 	bool found = false;
@@ -231,7 +219,7 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 		 * would have completed which will create more
 		 * room for new requests.
 		 */
-		sba_peek_mchans(sba);
+		mbox_client_peek_data(sba->mchan);
 		return NULL;
 	}
 
@@ -369,15 +357,11 @@ static void sba_cleanup_pending_requests(struct sba_device *sba)
 static int sba_send_mbox_request(struct sba_device *sba,
 				 struct sba_request *req)
 {
-	int mchans_idx, ret = 0;
-
-	/* Select mailbox channel in round-robin fashion */
-	mchans_idx = atomic_inc_return(&sba->mchans_current);
-	mchans_idx = mchans_idx % sba->mchans_count;
+	int ret = 0;
 
 	/* Send message for the request */
 	req->msg.error = 0;
-	ret = mbox_send_message(sba->mchans[mchans_idx], &req->msg);
+	ret = mbox_send_message(sba->mchan, &req->msg);
 	if (ret < 0) {
 		dev_err(sba->dev, "send message failed with error %d", ret);
 		return ret;
@@ -390,7 +374,7 @@ static int sba_send_mbox_request(struct sba_device *sba,
 	}
 
 	/* Signal txdone for mailbox channel */
-	mbox_client_txdone(sba->mchans[mchans_idx], ret);
+	mbox_client_txdone(sba->mchan, ret);
 
 	return ret;
 }
@@ -402,13 +386,8 @@ static void _sba_process_pending_requests(struct sba_device *sba)
 	u32 count;
 	struct sba_request *req;
 
-	/*
-	 * Process few pending requests
-	 *
-	 * For now, we process (<number_of_mailbox_channels> * 8)
-	 * number of requests at a time.
-	 */
-	count = sba->mchans_count * 8;
+	/* Process few pending requests */
+	count = SBA_MAX_MSG_SEND_PER_MBOX_CHANNEL;
 	while (!list_empty(&sba->reqs_pending_list) && count) {
 		/* Get the first pending request */
 		req = list_first_entry(&sba->reqs_pending_list,
@@ -572,7 +551,7 @@ static enum dma_status sba_tx_status(struct dma_chan *dchan,
 	if (ret == DMA_COMPLETE)
 		return ret;
 
-	sba_peek_mchans(sba);
+	mbox_client_peek_data(sba->mchan);
 
 	return dma_cookie_status(dchan, cookie, txstate);
 }
@@ -1639,7 +1618,7 @@ static int sba_async_register(struct sba_device *sba)
 
 static int sba_probe(struct platform_device *pdev)
 {
-	int i, ret = 0, mchans_count;
+	int ret = 0;
 	struct sba_device *sba;
 	struct platform_device *mbox_pdev;
 	struct of_phandle_args args;
@@ -1652,12 +1631,11 @@ static int sba_probe(struct platform_device *pdev)
 	sba->dev = &pdev->dev;
 	platform_set_drvdata(pdev, sba);
 
-	/* Number of channels equals number of mailbox channels */
+	/* Number of mailbox channels should be atleast 1 */
 	ret = of_count_phandle_with_args(pdev->dev.of_node,
 					 "mboxes", "#mbox-cells");
 	if (ret <= 0)
 		return -ENODEV;
-	mchans_count = ret;
 
 	/* Determine SBA version from DT compatible string */
 	if (of_device_is_compatible(sba->dev->of_node, "brcm,iproc-sba"))
@@ -1690,7 +1668,7 @@ static int sba_probe(struct platform_device *pdev)
 	default:
 		return -EINVAL;
 	}
-	sba->max_req = SBA_MAX_REQ_PER_MBOX_CHANNEL * mchans_count;
+	sba->max_req = SBA_MAX_REQ_PER_MBOX_CHANNEL;
 	sba->max_cmd_per_req = sba->max_pq_srcs + 3;
 	sba->max_xor_srcs = sba->max_cmd_per_req - 1;
 	sba->max_resp_pool_size = sba->max_req * sba->hw_resp_size;
@@ -1704,55 +1682,30 @@ static int sba_probe(struct platform_device *pdev)
 	sba->client.knows_txdone	= true;
 	sba->client.tx_tout		= 0;
 
-	/* Allocate mailbox channel array */
-	sba->mchans = devm_kcalloc(&pdev->dev, mchans_count,
-				   sizeof(*sba->mchans), GFP_KERNEL);
-	if (!sba->mchans)
-		return -ENOMEM;
-
-	/* Request mailbox channels */
-	sba->mchans_count = 0;
-	for (i = 0; i < mchans_count; i++) {
-		sba->mchans[i] = mbox_request_channel(&sba->client, i);
-		if (IS_ERR(sba->mchans[i])) {
-			ret = PTR_ERR(sba->mchans[i]);
-			goto fail_free_mchans;
-		}
-		sba->mchans_count++;
+	/* Request mailbox channel */
+	sba->mchan = mbox_request_channel(&sba->client, 0);
+	if (IS_ERR(sba->mchan)) {
+		ret = PTR_ERR(sba->mchan);
+		goto fail_free_mchan;
 	}
-	atomic_set(&sba->mchans_current, 0);
 
 	/* Find-out underlying mailbox device */
 	ret = of_parse_phandle_with_args(pdev->dev.of_node,
 					 "mboxes", "#mbox-cells", 0, &args);
 	if (ret)
-		goto fail_free_mchans;
+		goto fail_free_mchan;
 	mbox_pdev = of_find_device_by_node(args.np);
 	of_node_put(args.np);
 	if (!mbox_pdev) {
 		ret = -ENODEV;
-		goto fail_free_mchans;
+		goto fail_free_mchan;
 	}
 	sba->mbox_dev = &mbox_pdev->dev;
 
-	/* All mailbox channels should be of same ring manager device */
-	for (i = 1; i < mchans_count; i++) {
-		ret = of_parse_phandle_with_args(pdev->dev.of_node,
-					 "mboxes", "#mbox-cells", i, &args);
-		if (ret)
-			goto fail_free_mchans;
-		mbox_pdev = of_find_device_by_node(args.np);
-		of_node_put(args.np);
-		if (sba->mbox_dev != &mbox_pdev->dev) {
-			ret = -EINVAL;
-			goto fail_free_mchans;
-		}
-	}
-
 	/* Prealloc channel resource */
 	ret = sba_prealloc_channel_resources(sba);
 	if (ret)
-		goto fail_free_mchans;
+		goto fail_free_mchan;
 
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())
@@ -1779,24 +1732,22 @@ static int sba_probe(struct platform_device *pdev)
 		goto fail_free_resources;
 
 	/* Print device info */
-	dev_info(sba->dev, "%s using SBAv%d and %d mailbox channels",
+	dev_info(sba->dev, "%s using SBAv%d mailbox channel from %s",
 		 dma_chan_name(&sba->dma_chan), sba->ver+1,
-		 sba->mchans_count);
+		 dev_name(sba->mbox_dev));
 
 	return 0;
 
 fail_free_resources:
 	debugfs_remove_recursive(sba->root);
 	sba_freeup_channel_resources(sba);
-fail_free_mchans:
-	for (i = 0; i < sba->mchans_count; i++)
-		mbox_free_channel(sba->mchans[i]);
+fail_free_mchan:
+	mbox_free_channel(sba->mchan);
 	return ret;
 }
 
 static int sba_remove(struct platform_device *pdev)
 {
-	int i;
 	struct sba_device *sba = platform_get_drvdata(pdev);
 
 	dma_async_device_unregister(&sba->dma_dev);
@@ -1805,8 +1756,7 @@ static int sba_remove(struct platform_device *pdev)
 
 	sba_freeup_channel_resources(sba);
 
-	for (i = 0; i < sba->mchans_count; i++)
-		mbox_free_channel(sba->mchans[i]);
+	mbox_free_channel(sba->mchan);
 
 	return 0;
 }
-- 
2.7.4
