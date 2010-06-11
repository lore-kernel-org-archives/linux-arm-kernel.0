From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 09:20:50 +0100
Subject: [PATCH 04/11] USB: s3c-hsotg: Avoid overwriting contents of perodic
	in 'fifo'
In-Reply-To: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1276244457-4072-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In shared fifo mode (used on older SoCs) the periodic in fifo beahves
much more like a packet buffer, discarding old data when writing new
data. Avoid this by ensuring that we do not load new transactions in
when there is data sitting already in the FIFO.

Note, this may not be an observed bug, we are fixing the case that this
may happen.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/usb/gadget/s3c-hsotg.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index a018b6a..df3e8d1 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -92,7 +92,9 @@ struct s3c_hsotg_req;
  * For periodic IN endpoints, we have fifo_size and fifo_load to try
  * and keep track of the amount of data in the periodic FIFO for each
  * of these as we don't have a status register that tells us how much
- * is in each of them.
+ * is in each of them. (note, this may actually be useless information
+ * as in shared-fifo mode periodic in acts like a single-frame packet
+ * buffer than a fifo)
  */
 struct s3c_hsotg_ep {
 	struct usb_ep		ep;
@@ -475,6 +477,14 @@ static int s3c_hsotg_write_fifo(struct s3c_hsotg *hsotg,
 
 		size_left = S3C_DxEPTSIZ_XferSize_GET(epsize);
 
+		/* if shared fifo, we cannot write anything until the
+		 * previous data has been completely sent.
+		 */
+		if (hs_ep->fifo_load != 0) {
+			s3c_hsotg_en_gsint(hsotg, S3C_GINTSTS_PTxFEmp);
+			return -ENOSPC;
+		}
+
 		dev_dbg(hsotg->dev, "%s: left=%d, load=%d, fifo=%d, size %d\n",
 			__func__, size_left,
 			hs_ep->size_loaded, hs_ep->fifo_load, hs_ep->fifo_size);
-- 
1.7.0.4
