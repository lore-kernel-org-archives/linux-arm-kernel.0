From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 14 Dec 2010 16:05:39 +0100
Subject: [PATCH] AT91: usb gadget: fix freeing irq in _udc_remove()
In-Reply-To: <AANLkTimV2ENcWajrrMQ2Too4pf=XBfLczJ9HehNt4V_8@mail.gmail.com>
References: <AANLkTimV2ENcWajrrMQ2Too4pf=XBfLczJ9HehNt4V_8@mail.gmail.com>
Message-ID: <1292339139-26212-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Emanuele <rje@crystalfontz.com>

Add a free_irq() call on vbus gpio when we remove udc so that the
vbus irq is properly released.

Signed-off-by: Rob Emanuele <rje@crystalfontz.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/gadget/atmel_usba_udc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 717ff65..e7c65a4 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -2057,8 +2057,10 @@ static int __exit usba_udc_remove(struct platform_device *pdev)
 		usba_ep_cleanup_debugfs(&usba_ep[i]);
 	usba_cleanup_debugfs(udc);
 
-	if (gpio_is_valid(udc->vbus_pin))
+	if (gpio_is_valid(udc->vbus_pin)) {
+		free_irq(gpio_to_irq(udc->vbus_pin), udc);
 		gpio_free(udc->vbus_pin);
+	}
 
 	free_irq(udc->irq, udc);
 	kfree(usba_ep);
-- 
1.7.3
