From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:38 +0800
Subject: [PATCH 10/14] usb: pxa25x_udc: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-11-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/pxa25x_udc.c |    6 +++---
 drivers/usb/gadget/pxa25x_udc.h |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index 2bbcdce..1007546 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -926,7 +926,7 @@ static void udc_disable(struct pxa25x_udc *);
  */
 static int pullup(struct pxa25x_udc *udc)
 {
-	int is_active = udc->vbus && udc->pullup && !udc->suspended;
+	int is_active = udc->gadget.vbus_active && udc->pullup && !udc->suspended;
 	DMSG("%s\n", is_active ? "active" : "inactive");
 	if (is_active) {
 		if (!udc->active) {
@@ -959,7 +959,7 @@ static int pxa25x_udc_vbus_session(struct usb_gadget *_gadget, int is_active)
 	struct pxa25x_udc	*udc;
 
 	udc = container_of(_gadget, struct pxa25x_udc, gadget);
-	udc->vbus = is_active;
+	udc->gadget.vbus_active = is_active;
 	DMSG("vbus %s\n", is_active ? "supplied" : "inactive");
 	pullup(udc);
 	return 0;
@@ -2152,7 +2152,7 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 	udc_disable(dev);
 	udc_reinit(dev);
 
-	dev->vbus = 0;
+	dev->gadget.vbus_active = 0;
 
 	/* irq setup after old hardware state is cleaned up */
 	retval = request_irq(irq, pxa25x_udc_irq,
diff --git a/drivers/usb/gadget/pxa25x_udc.h b/drivers/usb/gadget/pxa25x_udc.h
index 3fe5931..3039992 100644
--- a/drivers/usb/gadget/pxa25x_udc.h
+++ b/drivers/usb/gadget/pxa25x_udc.h
@@ -103,7 +103,6 @@ struct pxa25x_udc {
 	enum ep0_state				ep0state;
 	struct udc_stats			stats;
 	unsigned				got_irq : 1,
-						vbus : 1,
 						pullup : 1,
 						has_cfr : 1,
 						req_pending : 1,
-- 
1.7.0.4
