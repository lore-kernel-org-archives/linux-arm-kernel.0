From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Jun 2012 11:09:34 +0200
Subject: [PATCH] usb: chipidea: cleanup dma_pool if udc_start() fails
Message-ID: <1340615374-21352-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If udc_start() fails the qh_pool dma-pool cannot be closed because
it's still in use. This patch factors out the dma_pool_free() loop
into destroy_eps() and calls it in the error path of udc_start(),
too.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/chipidea/udc.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index ebc88c1..6d166a7 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1483,6 +1483,17 @@ static int init_eps(struct ci13xxx *ci)
 	return retval;
 }
 
+static void destroy_eps(struct ci13xxx *ci)
+{
+	int i;
+
+	for (i = 0; i < ci->hw_ep_max; i++) {
+		struct ci13xxx_ep *mEp = &ci->ci13xxx_ep[i];
+
+		dma_pool_free(ci->qh_pool, mEp->qh.ptr, mEp->qh.dma);
+	}
+}
+
 /**
  * ci13xxx_start: register a gadget driver
  * @gadget: our gadget
@@ -1690,7 +1701,7 @@ static int udc_start(struct ci13xxx *ci)
 	if (ci->platdata->flags & CI13XXX_REQUIRE_TRANSCEIVER) {
 		if (ci->transceiver == NULL) {
 			retval = -ENODEV;
-			goto free_pools;
+			goto destroy_eps;
 		}
 	}
 
@@ -1741,6 +1752,8 @@ unreg_device:
 put_transceiver:
 	if (ci->transceiver && ci->global_phy)
 		usb_put_transceiver(ci->transceiver);
+destroy_eps:
+	destroy_eps(ci);
 free_pools:
 	dma_pool_destroy(ci->td_pool);
 free_qh_pool:
@@ -1755,18 +1768,12 @@ free_qh_pool:
  */
 static void udc_stop(struct ci13xxx *ci)
 {
-	int i;
-
 	if (ci == NULL)
 		return;
 
 	usb_del_gadget_udc(&ci->gadget);
 
-	for (i = 0; i < ci->hw_ep_max; i++) {
-		struct ci13xxx_ep *mEp = &ci->ci13xxx_ep[i];
-
-		dma_pool_free(ci->qh_pool, mEp->qh.ptr, mEp->qh.dma);
-	}
+	destroy_eps(ci);
 
 	dma_pool_destroy(ci->td_pool);
 	dma_pool_destroy(ci->qh_pool);
-- 
1.7.10
