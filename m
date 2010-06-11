From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 09:20:49 +0100
Subject: [PATCH 03/11] USB: s3c-hsotg: The NPTX/PTX FIFO sizes are in words,
	not bytes
In-Reply-To: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1276244457-4072-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a problem where we have been underestimating the space available in
the IN PTX/NPTX FIFOs by assuming that they where simply word aligned
instead of in number-of-words. This means all length calculations need
to be multiplied-by-4.

Note, we do not change the information about fifo size or start addresses
available to userspace as we assume the user can multiply by four easily
and is already knows these values are in words.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/usb/gadget/s3c-hsotg.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index ba00e6e..a018b6a 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -506,6 +506,7 @@ static int s3c_hsotg_write_fifo(struct s3c_hsotg *hsotg,
 		}
 
 		can_write = S3C_GNPTXSTS_NPTxFSpcAvail_GET(gnptxsts);
+		can_write *= 4;	/* fifo size is in 32bit quantities. */
 	}
 
 	dev_dbg(hsotg->dev, "%s: GNPTXSTS=%08x, can=%d, to=%d, mps %d\n",
@@ -2733,7 +2734,7 @@ static void __devinit s3c_hsotg_initep(struct s3c_hsotg *hsotg,
 	 */
 
 	ptxfifo = readl(hsotg->regs + S3C_DPTXFSIZn(epnum));
-	hs_ep->fifo_size = S3C_DPTXFSIZn_DPTxFSize_GET(ptxfifo);
+	hs_ep->fifo_size = S3C_DPTXFSIZn_DPTxFSize_GET(ptxfifo) * 4;
 
 	/* if we're using dma, we need to set the next-endpoint pointer
 	 * to be something valid.
-- 
1.7.0.4
