From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:33 +0400
Subject: [PATCH 07/15] pxa25x_udc: drop support for udc_command
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-8-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of pxa25x devices use udc_command() for UDC functionality.
Stop calling this callback from pxa25x_udc code.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/gadget/pxa25x_udc.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index 6f543c7..aa34698 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -144,8 +144,6 @@ static void pullup_off(void)
 
 	if (gpio_is_valid(mach->gpio_pullup))
 		gpio_set_value(mach->gpio_pullup, off_level);
-	else if (mach->udc_command)
-		mach->udc_command(PXA2XX_UDC_CMD_DISCONNECT);
 }
 
 static void pullup_on(void)
@@ -155,8 +153,6 @@ static void pullup_on(void)
 
 	if (gpio_is_valid(mach->gpio_pullup))
 		gpio_set_value(mach->gpio_pullup, on_level);
-	else if (mach->udc_command)
-		mach->udc_command(PXA2XX_UDC_CMD_CONNECT);
 }
 
 static void pio_irq_enable(int bEndpointAddress)
@@ -984,7 +980,7 @@ static int pxa25x_udc_pullup(struct usb_gadget *_gadget, int is_active)
 	udc = container_of(_gadget, struct pxa25x_udc, gadget);
 
 	/* not all boards support pullup control */
-	if (!gpio_is_valid(udc->mach->gpio_pullup) && !udc->mach->udc_command)
+	if (!gpio_is_valid(udc->mach->gpio_pullup))
 		return -EOPNOTSUPP;
 
 	udc->pullup = (is_active != 0);
@@ -2241,7 +2237,7 @@ static int pxa25x_udc_suspend(struct platform_device *dev, pm_message_t state)
 	struct pxa25x_udc	*udc = platform_get_drvdata(dev);
 	unsigned long flags;
 
-	if (!gpio_is_valid(udc->mach->gpio_pullup) && !udc->mach->udc_command)
+	if (!gpio_is_valid(udc->mach->gpio_pullup))
 		WARNING("USB host won't detect disconnect!\n");
 	udc->suspended = 1;
 
-- 
1.7.5.4
