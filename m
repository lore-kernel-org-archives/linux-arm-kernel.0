From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 14 Dec 2010 19:00:30 +0100
Subject: [PATCH v2] USB: atmel_usba_udc: fix freeing irq in usba_udc_remove()
In-Reply-To: <636999.52551.qm@web180309.mail.gq1.yahoo.com>
References: <636999.52551.qm@web180309.mail.gq1.yahoo.com>
Message-ID: <1292349630-3610-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Emanuele <rje@crystalfontz.com>

Add a free_irq() call on vbus gpio when we remove udc so that the
vbus irq is properly released.

Signed-off-by: Rob Emanuele <rje@crystalfontz.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
David,

I modified $SUBJECT to be more explicit about which driver is modified.
Hope that makes sense now...

Bye,

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
