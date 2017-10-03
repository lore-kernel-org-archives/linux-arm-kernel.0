From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:51:49 +0530
Subject: [PATCH 2/5] mailbox: bcm-flexrm-mailbox: Print ring number in errors
 and warnings
In-Reply-To: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
References: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1507008112-27117-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates all dev_err() and dev_warn() to print
ring number so that we have more info for debugging.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index f052a3e..e0443ae 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1116,8 +1116,8 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 		err = flexrm_cmpl_desc_to_error(desc);
 		if (err < 0) {
 			dev_warn(ring->mbox->dev,
-				 "got completion desc=0x%lx with error %d",
-				 (unsigned long)desc, err);
+			"ring%d got completion desc=0x%lx with error %d\n",
+			ring->num, (unsigned long)desc, err);
 		}
 
 		/* Determine request id from completion descriptor */
@@ -1127,8 +1127,8 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 		msg = ring->requests[reqid];
 		if (!msg) {
 			dev_warn(ring->mbox->dev,
-				 "null msg pointer for completion desc=0x%lx",
-				 (unsigned long)desc);
+			"ring%d null msg pointer for completion desc=0x%lx\n",
+			ring->num, (unsigned long)desc);
 			continue;
 		}
 
@@ -1238,7 +1238,9 @@ static int flexrm_startup(struct mbox_chan *chan)
 	ring->bd_base = dma_pool_alloc(ring->mbox->bd_pool,
 				       GFP_KERNEL, &ring->bd_dma_base);
 	if (!ring->bd_base) {
-		dev_err(ring->mbox->dev, "can't allocate BD memory\n");
+		dev_err(ring->mbox->dev,
+			"can't allocate BD memory for ring%d\n",
+			ring->num);
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -1261,7 +1263,9 @@ static int flexrm_startup(struct mbox_chan *chan)
 	ring->cmpl_base = dma_pool_alloc(ring->mbox->cmpl_pool,
 					 GFP_KERNEL, &ring->cmpl_dma_base);
 	if (!ring->cmpl_base) {
-		dev_err(ring->mbox->dev, "can't allocate completion memory\n");
+		dev_err(ring->mbox->dev,
+			"can't allocate completion memory for ring%d\n",
+			ring->num);
 		ret = -ENOMEM;
 		goto fail_free_bd_memory;
 	}
@@ -1269,7 +1273,8 @@ static int flexrm_startup(struct mbox_chan *chan)
 
 	/* Request IRQ */
 	if (ring->irq == UINT_MAX) {
-		dev_err(ring->mbox->dev, "ring IRQ not available\n");
+		dev_err(ring->mbox->dev,
+			"ring%d IRQ not available\n", ring->num);
 		ret = -ENODEV;
 		goto fail_free_cmpl_memory;
 	}
@@ -1278,7 +1283,8 @@ static int flexrm_startup(struct mbox_chan *chan)
 				   flexrm_irq_thread,
 				   0, dev_name(ring->mbox->dev), ring);
 	if (ret) {
-		dev_err(ring->mbox->dev, "failed to request ring IRQ\n");
+		dev_err(ring->mbox->dev,
+			"failed to request ring%d IRQ\n", ring->num);
 		goto fail_free_cmpl_memory;
 	}
 	ring->irq_requested = true;
@@ -1291,7 +1297,9 @@ static int flexrm_startup(struct mbox_chan *chan)
 			&ring->irq_aff_hint);
 	ret = irq_set_affinity_hint(ring->irq, &ring->irq_aff_hint);
 	if (ret) {
-		dev_err(ring->mbox->dev, "failed to set IRQ affinity hint\n");
+		dev_err(ring->mbox->dev,
+			"failed to set IRQ affinity hint for ring%d\n",
+			ring->num);
 		goto fail_free_irq;
 	}
 
-- 
2.7.4
