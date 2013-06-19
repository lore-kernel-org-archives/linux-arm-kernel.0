From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 18 Jun 2013 22:31:20 -0400
Subject: [PATCH V2] USB: initialize or shutdown PHY when add or remove host
 controller
Message-ID: <1371609080-30595-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controller need software to initialize PHY before add
host controller, and shut down PHY after remove host controller.
Add the generic code for these controllers so they do not need
do it in its own host controller driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/core/hcd.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index d53547d..301c639 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -40,9 +40,11 @@
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
 #include <linux/pm_runtime.h>
+#include <linux/err.h>
 
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/phy.h>
 
 #include "usb.h"
 
@@ -2531,12 +2533,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	 */
 	set_bit(HCD_FLAG_RH_RUNNING, &hcd->flags);
 
+	/* In case hcd->phy contains the error code. */
+	if (IS_ERR(hcd->phy))
+		hcd->phy = NULL;
+
+	/* Initialize the PHY before other hardware operation. */
+	if (hcd->phy) {
+		retval = usb_phy_init(hcd->phy);
+		if (retval) {
+			dev_err(hcd->self.controller,
+				"can't initialize phy\n");
+			goto err_hcd_driver_setup;
+		}
+	}
+
 	/* "reset" is misnamed; its role is now one-time init. the controller
 	 * should already have been reset (and boot firmware kicked off etc).
 	 */
 	if (hcd->driver->reset && (retval = hcd->driver->reset(hcd)) < 0) {
 		dev_err(hcd->self.controller, "can't setup\n");
-		goto err_hcd_driver_setup;
+		goto err_hcd_driver_init_phy;
 	}
 	hcd->rh_pollable = 1;
 
@@ -2608,6 +2624,9 @@ err_hcd_driver_start:
 	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
 		free_irq(irqnum, hcd);
 err_request_irq:
+err_hcd_driver_init_phy:
+	if (hcd->phy)
+		usb_phy_shutdown(hcd->phy);
 err_hcd_driver_setup:
 err_set_rh_speed:
 	usb_put_dev(hcd->self.root_hub);
@@ -2674,6 +2693,9 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 			free_irq(hcd->irq, hcd);
 	}
 
+	if (hcd->phy)
+		usb_phy_shutdown(hcd->phy);
+
 	usb_put_dev(hcd->self.root_hub);
 	usb_deregister_bus(&hcd->self);
 	hcd_buffer_destroy(hcd);
-- 
1.7.4.1
