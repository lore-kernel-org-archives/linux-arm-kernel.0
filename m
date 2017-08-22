From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:27:05 +0530
Subject: [PATCH v3 16/17] dmaengine: bcm-sba-raid: Explicitly ACK mailbox
 message after sending
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-17-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should explicitly ACK mailbox message because after
sending message we can know the send status via error
attribute of brcm_message.

This will also help SBA-RAID to use "txdone_ack" method
whenever mailbox controller supports it.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 12310aa..0c41136 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -396,13 +396,17 @@ static int sba_send_mbox_request(struct sba_device *sba,
 		dev_err(sba->dev, "send message failed with error %d", ret);
 		return ret;
 	}
+
+	/* Check error returned by mailbox controller */
 	ret = req->msg.error;
 	if (ret < 0) {
 		dev_err(sba->dev, "message error %d", ret);
-		return ret;
 	}
 
-	return 0;
+	/* Signal txdone for mailbox channel */
+	mbox_client_txdone(sba->mchans[mchans_idx], ret);
+
+	return ret;
 }
 
 /* Note: Must be called with sba->reqs_lock held */
@@ -1724,7 +1728,7 @@ static int sba_probe(struct platform_device *pdev)
 	sba->client.dev			= &pdev->dev;
 	sba->client.rx_callback		= sba_receive_message;
 	sba->client.tx_block		= false;
-	sba->client.knows_txdone	= false;
+	sba->client.knows_txdone	= true;
 	sba->client.tx_tout		= 0;
 
 	/* Allocate mailbox channel array */
-- 
2.7.4
