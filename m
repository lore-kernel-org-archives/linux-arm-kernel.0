From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 23 Feb 2017 02:35:26 +0100
Subject: [PATCH 2/2] usb: gadget: Add test if argument pointer has a valid
 value in pxa27x_udc
In-Reply-To: <cover.1487812323.git.petr.cvek@tul.cz>
References: <cover.1487812323.git.petr.cvek@tul.cz>
Message-ID: <3c2b75a6-55ec-bf5e-1f84-4c9a50e04660@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move call usb_put_phy(udc->transceiver) inside a valid pointer test.

Reported-by: robert.jarzmik at free.fr
Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 6fa675bf2c6f..9d2e1a8aa69d 100644
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
