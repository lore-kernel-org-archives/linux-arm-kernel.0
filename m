From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 09:20:53 +0100
Subject: [PATCH 07/11] USB: s3c-hsotg: Only load packet per fifo write
In-Reply-To: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1276244457-4072-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Limit the IN FIFO write to a single packet per attempt at writing,
as per the specifications and ensure that we don't return fifo-full
so that we can continue writing packets if we have the space.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/usb/gadget/s3c-hsotg.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 819e75a..7c35bfe 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -539,6 +539,17 @@ static int s3c_hsotg_write_fifo(struct s3c_hsotg *hsotg,
 	if (can_write > 512)
 		can_write = 512;
 
+	/* limit the write to one max-packet size worth of data, but allow
+	 * the transfer to return that it did not run out of fifo space
+	 * doing it. */
+	if (to_write > hs_ep->ep.maxpacket) {
+		to_write = hs_ep->ep.maxpacket;
+
+		s3c_hsotg_en_gsint(hsotg,
+				   periodic ? S3C_GINTSTS_PTxFEmp :
+				   S3C_GINTSTS_NPTxFEmp);
+	}
+
 	/* see if we can write data */
 
 	if (to_write > can_write) {
-- 
1.7.0.4
