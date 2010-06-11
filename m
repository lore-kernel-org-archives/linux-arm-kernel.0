From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 09:20:54 +0100
Subject: [PATCH 08/11] USB: s3c-hsotg: Check for new request before enqueing
	new setup
In-Reply-To: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1276244457-4072-9-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before trying a new setup transaction after getting an EP0 in complete
interrupt, check that the driver did not try and send more EP0 IN data
before enqueing a new setup transaction.

This fixes a bug where we cannot send all of the IN data in one go
so split the transfer, but then fail to send all the data as we start
waiting for a new OUT transaction

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/usb/gadget/s3c-hsotg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 7c35bfe..2555f27 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -1791,7 +1791,7 @@ static void s3c_hsotg_epint(struct s3c_hsotg *hsotg, unsigned int idx,
 		if (dir_in) {
 			s3c_hsotg_complete_in(hsotg, hs_ep);
 
-			if (idx == 0)
+			if (idx == 0 && !hs_ep->req)
 				s3c_hsotg_enqueue_setup(hsotg);
 		} else if (using_dma(hsotg)) {
 			/* We're using DMA, we need to fire an OutDone here
-- 
1.7.0.4
