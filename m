From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 09:20:57 +0100
Subject: [PATCH 11/11] USB: s3c-hsotg: Fix OUT packet request retry
In-Reply-To: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1276244457-4072-12-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there is more data in the request than we could fit into a single
hardware request, then check when the OutDone event is received if
we have more data, and if so, schedule the new data instead of trying
to complete the request (and in the case of EP0, sending a 0 packet
in the middle of a transfer).

Also, move the debug message about the current transfer state before
the warning about a bad transfer.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/usb/gadget/s3c-hsotg.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index b34a05d..3da45f5 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -1384,6 +1384,9 @@ static void s3c_hsotg_rx_data(struct s3c_hsotg *hsotg, int ep_idx, int size)
 	read_ptr = hs_req->req.actual;
 	max_req = hs_req->req.length - read_ptr;
 
+	dev_dbg(hsotg->dev, "%s: read %d/%d, done %d/%d\n",
+		__func__, to_read, max_req, read_ptr, hs_req->req.length);
+
 	if (to_read > max_req) {
 		/* more data appeared than we where willing
 		 * to deal with in this request.
@@ -1393,9 +1396,6 @@ static void s3c_hsotg_rx_data(struct s3c_hsotg *hsotg, int ep_idx, int size)
 		WARN_ON_ONCE(1);
 	}
 
-	dev_dbg(hsotg->dev, "%s: read %d/%d, done %d/%d\n",
-		__func__, to_read, max_req, read_ptr, hs_req->req.length);
-
 	hs_ep->total_data += to_read;
 	hs_req->req.actual += to_read;
 	to_read = DIV_ROUND_UP(to_read, 4);
@@ -1464,9 +1464,11 @@ static void s3c_hsotg_send_zlp(struct s3c_hsotg *hsotg,
 static void s3c_hsotg_handle_outdone(struct s3c_hsotg *hsotg,
 				     int epnum, bool was_setup)
 {
+	u32 epsize = readl(hsotg->regs + S3C_DOEPTSIZ(epnum));
 	struct s3c_hsotg_ep *hs_ep = &hsotg->eps[epnum];
 	struct s3c_hsotg_req *hs_req = hs_ep->req;
 	struct usb_request *req = &hs_req->req;
+	unsigned size_left = S3C_DxEPTSIZ_XferSize_GET(epsize);
 	int result = 0;
 
 	if (!hs_req) {
@@ -1475,9 +1477,7 @@ static void s3c_hsotg_handle_outdone(struct s3c_hsotg *hsotg,
 	}
 
 	if (using_dma(hsotg)) {
-		u32 epsize = readl(hsotg->regs + S3C_DOEPTSIZ(epnum));
 		unsigned size_done;
-		unsigned size_left;
 
 		/* Calculate the size of the transfer by checking how much
 		 * is left in the endpoint size register and then working it
@@ -1487,14 +1487,18 @@ static void s3c_hsotg_handle_outdone(struct s3c_hsotg *hsotg,
 		 * so may overshoot/undershoot the transfer.
 		 */
 
-		size_left = S3C_DxEPTSIZ_XferSize_GET(epsize);
-
 		size_done = hs_ep->size_loaded - size_left;
 		size_done += hs_ep->last_load;
 
 		req->actual = size_done;
 	}
 
+	/* if there is more request to do, schedule new transfer */
+	if (req->actual < req->length && size_left == 0) {
+		s3c_hsotg_start_req(hsotg, hs_ep, hs_req, true);
+		return;
+	}
+
 	if (req->actual < req->length && req->short_not_ok) {
 		dev_dbg(hsotg->dev, "%s: got %d/%d (short not ok) => error\n",
 			__func__, req->actual, req->length);
-- 
1.7.0.4
