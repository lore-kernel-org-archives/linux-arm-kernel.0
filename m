From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 28 Dec 2016 14:56:54 -0800
Subject: [PATCH v6 08/25] usb: chipidea: Remove locking in ci_udc_start()
In-Reply-To: <20161228225711.698-1-stephen.boyd@linaro.org>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
Message-ID: <20161228225711.698-9-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't call hw_device_reset() with the ci->lock held, so it
doesn't seem like this lock here is protecting anything. Let's
just remove it. This allows us to call sleeping functions like
phy_init() from within the CI_HDRC_CONTROLLER_RESET_EVENT hook.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/udc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index cf132f057137..732b281485de 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1725,7 +1725,6 @@ static int ci_udc_start(struct usb_gadget *gadget,
 			 struct usb_gadget_driver *driver)
 {
 	struct ci_hdrc *ci = container_of(gadget, struct ci_hdrc, gadget);
-	unsigned long flags;
 	int retval = -ENOMEM;
 
 	if (driver->disconnect == NULL)
@@ -1752,7 +1751,6 @@ static int ci_udc_start(struct usb_gadget *gadget,
 
 	pm_runtime_get_sync(&ci->gadget.dev);
 	if (ci->vbus_active) {
-		spin_lock_irqsave(&ci->lock, flags);
 		hw_device_reset(ci);
 	} else {
 		usb_udc_vbus_handler(&ci->gadget, false);
@@ -1761,7 +1759,6 @@ static int ci_udc_start(struct usb_gadget *gadget,
 	}
 
 	retval = hw_device_state(ci, ci->ep0out->qh.dma);
-	spin_unlock_irqrestore(&ci->lock, flags);
 	if (retval)
 		pm_runtime_put_sync(&ci->gadget.dev);
 
-- 
2.10.0.297.gf6727b0
