From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Apr 2012 13:32:14 +0800
Subject: [PATCH] dma: mxs-dma: enable channel in device_issue_pending call
Message-ID: <1334122334-27930-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable channel in device_issue_pending call, so that the order between
cookie assignment and channel enabling can be ensured naturally.

It fixes the mxs gpmi-nand breakage which is caused by the incorrect
order of cookie assigning and channel enabling.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
[resend to cc LAKML, sorry]

Shijie,

I tested the patch with mmc and sound driver.  Can you give it a test
with gpmi-nand to see if it fixes the problem for you?

Thanks,
Shawn

 drivers/dma/mxs-dma.c                  |   10 +++-------
 drivers/mmc/host/mxs-mmc.c             |    3 +++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    1 +
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index c81ef7e..655d4ce 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -201,10 +201,6 @@ static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
 
 static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
-	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
-
-	mxs_dma_enable_chan(mxs_chan);
-
 	return dma_cookie_assign(tx);
 }
 
@@ -558,9 +554,9 @@ static enum dma_status mxs_dma_tx_status(struct dma_chan *chan,
 
 static void mxs_dma_issue_pending(struct dma_chan *chan)
 {
-	/*
-	 * Nothing to do. We only have a single descriptor.
-	 */
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+
+	mxs_dma_enable_chan(mxs_chan);
 }
 
 static int __init mxs_dma_init(struct mxs_dma_engine *mxs_dma)
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index b0f2ef9..e3f5af9 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -363,6 +363,7 @@ static void mxs_mmc_bc(struct mxs_mmc_host *host)
 		goto out;
 
 	dmaengine_submit(desc);
+	dma_async_issue_pending(host->dmach);
 	return;
 
 out:
@@ -403,6 +404,7 @@ static void mxs_mmc_ac(struct mxs_mmc_host *host)
 		goto out;
 
 	dmaengine_submit(desc);
+	dma_async_issue_pending(host->dmach);
 	return;
 
 out:
@@ -531,6 +533,7 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
 		goto out;
 
 	dmaengine_submit(desc);
+	dma_async_issue_pending(host->dmach);
 	return;
 out:
 	dev_warn(mmc_dev(host->mmc),
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 75b1dde..9ec51ce 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -266,6 +266,7 @@ int start_dma_without_bch_irq(struct gpmi_nand_data *this,
 	desc->callback		= dma_irq_callback;
 	desc->callback_param	= this;
 	dmaengine_submit(desc);
+	dma_async_issue_pending(get_dma_chan(this));
 
 	/* Wait for the interrupt from the DMA block. */
 	err = wait_for_completion_timeout(dma_c, msecs_to_jiffies(1000));
-- 
1.7.4.1
