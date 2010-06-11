From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 09:20:51 +0100
Subject: [PATCH 05/11] USB: s3c-hsotg: Re-initialise all FIFOs on USB bus reset
In-Reply-To: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1276244457-4072-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB documentation suggest that the FIFOs should be reset when a
bus reset event happens. Use the s3c_hsotg_init_fifo() to ensure that
the FIFO layout is correct and that the FIFOs are flushed before
acknowledging the reset.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/usb/gadget/s3c-hsotg.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index df3e8d1..5b61bcf 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -2083,17 +2083,12 @@ irq_retry:
 		kill_all_requests(hsotg, &hsotg->eps[0], -ECONNRESET, true);
 
 		/* it seems after a reset we can end up with a situation
-		 * where the TXFIFO still has data in it... try flushing
-		 * it to remove anything that may still be in it.
+		 * where the TXFIFO still has data in it... the docs
+		 * suggest resetting all the fifos, so use the init_fifo
+		 * code to relayout and flush the fifos.
 		 */
 
-		if (1) {
-			writel(S3C_GRSTCTL_TxFNum(0) | S3C_GRSTCTL_TxFFlsh,
-			       hsotg->regs + S3C_GRSTCTL);
-
-			dev_info(hsotg->dev, "GNPTXSTS=%08x\n",
-				 readl(hsotg->regs + S3C_GNPTXSTS));
-		}
+		s3c_hsotg_init_fifo(hsotg);
 
 		s3c_hsotg_enqueue_setup(hsotg);
 
-- 
1.7.0.4
