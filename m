From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:40 +0800
Subject: [PATCH 12/14] usb: s3c2410_udc: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-13-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/s3c2410_udc.c |    6 +++---
 drivers/usb/gadget/s3c2410_udc.h |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index fc07b43..ae7a7e3 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -1494,7 +1494,7 @@ static int s3c2410_udc_vbus_session(struct usb_gadget *gadget, int is_active)
 
 	dprintk(DEBUG_NORMAL, "%s()\n", __func__);
 
-	udc->vbus = (is_active != 0);
+	gadget->vbus_active = (is_active != 0);
 	s3c2410_udc_set_pullup(udc, is_active);
 	return 0;
 }
@@ -1520,7 +1520,7 @@ static irqreturn_t s3c2410_udc_vbus_irq(int irq, void *_dev)
 	if (udc_info->vbus_pin_inverted)
 		value = !value;
 
-	if (value != dev->vbus)
+	if (value != &dev->gadget.vbus)
 		s3c2410_udc_vbus_session(&dev->gadget, value);
 
 	return IRQ_HANDLED;
@@ -1887,7 +1887,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 
 		dev_dbg(dev, "got irq %i\n", irq);
 	} else {
-		udc->vbus = 1;
+		udc->gadget.vbus = 1;
 	}
 
 	if (udc_info && !udc_info->udc_command &&
diff --git a/drivers/usb/gadget/s3c2410_udc.h b/drivers/usb/gadget/s3c2410_udc.h
index 93bf225..ca5ad98 100644
--- a/drivers/usb/gadget/s3c2410_udc.h
+++ b/drivers/usb/gadget/s3c2410_udc.h
@@ -92,7 +92,6 @@ struct s3c2410_udc {
 	unsigned			req_std : 1;
 	unsigned			req_config : 1;
 	unsigned			req_pending : 1;
-	u8				vbus;
 	struct dentry			*regs_info;
 };
 #define to_s3c2410(g)	(container_of((g), struct s3c2410_udc, gadget))
-- 
1.7.0.4
