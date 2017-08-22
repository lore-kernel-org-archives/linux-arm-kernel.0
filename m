From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:57 +0530
Subject: [PATCH v3 08/17] dmaengine: bcm-sba-raid: Increase number of free
 sba_request
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-9-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we have only 1024 free sba_request created
by sba_prealloc_channel_resources(). This is too low
and the prep_xxx() callbacks start failing more often
at time of RAID array setup over NVMe disks.

This patch sets number of free sba_request created by
sba_prealloc_channel_resources() to be:
<number_of_mailbox_channels> x 8192

Due to above, we will have sufficient number of free
sba_request and prep_xxx() callbacks failing is very
unlikely.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index cd6e3cd..af6cc8e 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -83,6 +83,8 @@
 #define SBA_CMD_WRITE_BUFFER				0xc
 #define SBA_CMD_GALOIS					0xe
 
+#define SBA_MAX_REQ_PER_MBOX_CHANNEL			8192
+
 /* Driver helper macros */
 #define to_sba_request(tx)		\
 	container_of(tx, struct sba_request, tx)
@@ -1622,6 +1624,13 @@ static int sba_probe(struct platform_device *pdev)
 	sba->dev = &pdev->dev;
 	platform_set_drvdata(pdev, sba);
 
+	/* Number of channels equals number of mailbox channels */
+	ret = of_count_phandle_with_args(pdev->dev.of_node,
+					 "mboxes", "#mbox-cells");
+	if (ret <= 0)
+		return -ENODEV;
+	mchans_count = ret;
+
 	/* Determine SBA version from DT compatible string */
 	if (of_device_is_compatible(sba->dev->of_node, "brcm,iproc-sba"))
 		sba->ver = SBA_VER_1;
@@ -1634,14 +1643,12 @@ static int sba_probe(struct platform_device *pdev)
 	/* Derived Configuration parameters */
 	switch (sba->ver) {
 	case SBA_VER_1:
-		sba->max_req = 1024;
 		sba->hw_buf_size = 4096;
 		sba->hw_resp_size = 8;
 		sba->max_pq_coefs = 6;
 		sba->max_pq_srcs = 6;
 		break;
 	case SBA_VER_2:
-		sba->max_req = 1024;
 		sba->hw_buf_size = 4096;
 		sba->hw_resp_size = 8;
 		sba->max_pq_coefs = 30;
@@ -1655,6 +1662,7 @@ static int sba_probe(struct platform_device *pdev)
 	default:
 		return -EINVAL;
 	}
+	sba->max_req = SBA_MAX_REQ_PER_MBOX_CHANNEL * mchans_count;
 	sba->max_cmd_per_req = sba->max_pq_srcs + 3;
 	sba->max_xor_srcs = sba->max_cmd_per_req - 1;
 	sba->max_resp_pool_size = sba->max_req * sba->hw_resp_size;
@@ -1668,22 +1676,14 @@ static int sba_probe(struct platform_device *pdev)
 	sba->client.knows_txdone	= false;
 	sba->client.tx_tout		= 0;
 
-	/* Number of channels equals number of mailbox channels */
-	ret = of_count_phandle_with_args(pdev->dev.of_node,
-					 "mboxes", "#mbox-cells");
-	if (ret <= 0)
-		return -ENODEV;
-	mchans_count = ret;
-	sba->mchans_count = 0;
-	atomic_set(&sba->mchans_current, 0);
-
 	/* Allocate mailbox channel array */
-	sba->mchans = devm_kcalloc(&pdev->dev, sba->mchans_count,
+	sba->mchans = devm_kcalloc(&pdev->dev, mchans_count,
 				   sizeof(*sba->mchans), GFP_KERNEL);
 	if (!sba->mchans)
 		return -ENOMEM;
 
 	/* Request mailbox channels */
+	sba->mchans_count = 0;
 	for (i = 0; i < mchans_count; i++) {
 		sba->mchans[i] = mbox_request_channel(&sba->client, i);
 		if (IS_ERR(sba->mchans[i])) {
@@ -1692,6 +1692,7 @@ static int sba_probe(struct platform_device *pdev)
 		}
 		sba->mchans_count++;
 	}
+	atomic_set(&sba->mchans_current, 0);
 
 	/* Find-out underlying mailbox device */
 	ret = of_parse_phandle_with_args(pdev->dev.of_node,
-- 
2.7.4
