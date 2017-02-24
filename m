From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 24 Feb 2017 02:54:56 +0100
Subject: [PATCH v2 2/2] usb: gadget: pxa27x: Test for a valid argument pointer
In-Reply-To: <cover.1487901100.git.petr.cvek@tul.cz>
References: <cover.1487901100.git.petr.cvek@tul.cz>
Message-ID: <e794578c-8805-691f-27bc-f07880013fa1@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A call usb_put_phy(udc->transceiver) must be tested for a valid pointer.
Use an already existing test for usb_unregister_notifier call.

Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 821bd8f4cae6..d48e239660c3 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2531,9 +2531,10 @@ static int pxa_udc_remove(struct platform_device *_dev)
 	usb_del_gadget_udc(&udc->gadget);
 	pxa_cleanup_debugfs(udc);
 
-	if (!IS_ERR_OR_NULL(udc->transceiver))
+	if (!IS_ERR_OR_NULL(udc->transceiver)) {
 		usb_unregister_notifier(udc->transceiver, &pxa27x_udc_phy);
-	usb_put_phy(udc->transceiver);
+		usb_put_phy(udc->transceiver);
+	}
 
 	udc->transceiver = NULL;
 	the_controller = NULL;
-- 
2.11.0
