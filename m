From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 7 Aug 2015 15:15:38 +0800
Subject: [PATCH v3 01/10] usb: chipidea: udc: zero-length packet is only
 needed for TX
In-Reply-To: <1438931747-25209-1-git-send-email-peter.chen@freescale.com>
References: <1438931747-25209-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1438931747-25209-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zero-length packet is the sendor tells the receiver that there
is no more data, so it is only needed at the TX side.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 2a47720..15f55da 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -445,7 +445,7 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 		rest -= count;
 	}
 
-	if (hwreq->req.zero && hwreq->req.length
+	if (hwreq->req.zero && hwreq->req.length && hwep->dir == TX
 	    && (hwreq->req.length % hwep->ep.maxpacket == 0))
 		add_td_to_list(hwep, hwreq, 0);
 
-- 
1.9.1
