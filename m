From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 29 Jul 2015 10:42:05 +0800
Subject: [PATCH 01/10] usb: chipidea: udc: zero-length packet is only needed
 for TX
In-Reply-To: <1438137734-27311-1-git-send-email-peter.chen@freescale.com>
References: <1438137734-27311-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1438137734-27311-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zero-length packet is the sendor tells the receiver that there
is no more data, so it is only needed at the TX side.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 06b7224..51e66a1 100644
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
