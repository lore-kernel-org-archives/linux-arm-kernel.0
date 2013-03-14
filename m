From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:37 +0800
Subject: [PATCH 09/14] usb: pch_udc: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-10-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Felipe Balbi <balbi@ti.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/pch_udc.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/pch_udc.c b/drivers/usb/gadget/pch_udc.c
index a787a8e..f49d0d2 100644
--- a/drivers/usb/gadget/pch_udc.c
+++ b/drivers/usb/gadget/pch_udc.c
@@ -333,7 +333,6 @@ struct pch_vbus_gpio_data {
  * @registered:		driver regsitered with system
  * @suspended:		driver in suspended state
  * @connected:		gadget driver associated
- * @vbus_session:	required vbus_session state
  * @set_cfg_not_acked:	pending acknowledgement 4 setup
  * @waiting_zlp_ack:	pending acknowledgement 4 ZLP
  * @data_requests:	DMA pool for data requests
@@ -361,7 +360,6 @@ struct pch_udc_dev {
 			registered:1,
 			suspended:1,
 			connected:1,
-			vbus_session:1,
 			set_cfg_not_acked:1,
 			waiting_zlp_ack:1;
 	struct pci_pool		*data_requests;
@@ -614,7 +612,7 @@ static inline void pch_udc_vbus_session(struct pch_udc_dev *dev,
 {
 	if (is_active) {
 		pch_udc_reconnect(dev);
-		dev->vbus_session = 1;
+		dev->gadget.vbus_active = 1;
 	} else {
 		if (dev->driver && dev->driver->disconnect) {
 			spin_unlock(&dev->lock);
@@ -622,7 +620,7 @@ static inline void pch_udc_vbus_session(struct pch_udc_dev *dev,
 			spin_lock(&dev->lock);
 		}
 		pch_udc_set_disconnect(dev);
-		dev->vbus_session = 0;
+		dev->gadget.vbus_active = 0;
 	}
 }
 
@@ -2745,7 +2743,7 @@ static void pch_udc_dev_isr(struct pch_udc_dev *dev, u32 dev_intr)
 		}
 
 		vbus = pch_vbus_gpio_get_value(dev);
-		if ((dev->vbus_session == 0)
+		if ((dev->gadget.vbus_active == 0)
 			&& (vbus != 1)) {
 			if (dev->driver && dev->driver->disconnect) {
 				spin_unlock(&dev->lock);
@@ -2753,7 +2751,7 @@ static void pch_udc_dev_isr(struct pch_udc_dev *dev, u32 dev_intr)
 				spin_lock(&dev->lock);
 			}
 			pch_udc_reconnect(dev);
-		} else if ((dev->vbus_session == 0)
+		} else if ((dev->gadget.vbus_active == 0)
 			&& (vbus == 1)
 			&& !dev->vbus_gpio.intr)
 			schedule_work(&dev->vbus_gpio.irq_work_fall);
-- 
1.7.0.4
