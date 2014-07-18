From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 18 Jul 2014 11:31:27 +0200
Subject: [PATCH 6/9] usb: musb: core: properly setup the HW before registering
 it to the USB core
In-Reply-To: <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
Message-ID: <1405675890-8802-7-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch overriding the USBOTG_ID pin by setting the iddig
bit in the USB_MODE register doesn't work because it happens too late
to be recognized correctly.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/usb/musb/musb_core.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f867b44..bbf2aefb 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1988,18 +1988,21 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 	switch (musb->port_mode) {
 	case MUSB_PORT_MODE_HOST:
-		status = musb_host_setup(musb, plat->power);
+		status = musb_platform_set_mode(musb, MUSB_HOST);
 		if (status < 0)
 			goto fail3;
-		status = musb_platform_set_mode(musb, MUSB_HOST);
+		status = musb_host_setup(musb, plat->power);
 		break;
 	case MUSB_PORT_MODE_GADGET:
-		status = musb_gadget_setup(musb);
+		status = musb_platform_set_mode(musb, MUSB_PERIPHERAL);
 		if (status < 0)
 			goto fail3;
-		status = musb_platform_set_mode(musb, MUSB_PERIPHERAL);
+		status = musb_gadget_setup(musb);
 		break;
 	case MUSB_PORT_MODE_DUAL_ROLE:
+		status = musb_platform_set_mode(musb, MUSB_OTG);
+		if (status < 0)
+			goto fail3;
 		status = musb_host_setup(musb, plat->power);
 		if (status < 0)
 			goto fail3;
@@ -2008,7 +2011,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 			musb_host_cleanup(musb);
 			goto fail3;
 		}
-		status = musb_platform_set_mode(musb, MUSB_OTG);
 		break;
 	default:
 		dev_err(dev, "unsupported port mode %d\n", musb->port_mode);
-- 
1.7.10.4
