From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 9 Dec 2010 22:46:29 +0100 (CET)
Subject: [PATCH] otg: fix link breakage, when the NOP USB Xceiver is a module
Message-ID: <Pine.LNX.4.64.1012092241260.20186@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the NOP USB OTG transceiver driver is built as a module, the otg.h 
header declares external functions, but if they are referenced from the 
kernel proper, as, e.g., in the OMAP3 case, where the omap3evm board is 
calling the usb_nop_xceiv_register() function, linkage breaks. This patch 
fixes this problem.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 0a5b371..a1a1e7a 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -116,7 +116,7 @@ struct otg_transceiver {
 /* for board-specific init logic */
 extern int otg_set_transceiver(struct otg_transceiver *);
 
-#if defined(CONFIG_NOP_USB_XCEIV) || defined(CONFIG_NOP_USB_XCEIV_MODULE)
+#if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
 /* sometimes transceivers are accessed only through e.g. ULPI */
 extern void usb_nop_xceiv_register(void);
 extern void usb_nop_xceiv_unregister(void);
