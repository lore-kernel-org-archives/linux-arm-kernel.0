From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 19 Mar 2015 15:01:07 +0100
Subject: [PATCH v2] usb: ehci-orion: add more constants for register values
Message-ID: <1426773667-29488-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds new register values for the USB_CMD and USB_MODE
registers, which allows to avoid the usage of a number of magic values
in orion_usb_phy_v1_setup().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v1: use tabs instead of spaces for alignment.

drivers/usb/host/ehci-orion.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index f6eafec..bfcbb9a 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -29,7 +29,13 @@
 #define wrl(off, val)	writel_relaxed((val), hcd->regs + (off))
 
 #define USB_CMD			0x140
+#define   USB_CMD_RUN		BIT(0)
+#define   USB_CMD_RESET		BIT(1)
 #define USB_MODE		0x1a8
+#define   USB_MODE_MASK		GENMASK(1, 0)
+#define   USB_MODE_DEVICE	0x2
+#define   USB_MODE_HOST		0x3
+#define   USB_MODE_SDIS		BIT(4)
 #define USB_CAUSE		0x310
 #define USB_MASK		0x314
 #define USB_WINDOW_CTRL(i)	(0x320 + ((i) << 4))
@@ -69,8 +75,8 @@ static void orion_usb_phy_v1_setup(struct usb_hcd *hcd)
 	/*
 	 * Reset controller
 	 */
-	wrl(USB_CMD, rdl(USB_CMD) | 0x2);
-	while (rdl(USB_CMD) & 0x2);
+	wrl(USB_CMD, rdl(USB_CMD) | USB_CMD_RESET);
+	while (rdl(USB_CMD) & USB_CMD_RESET);
 
 	/*
 	 * GL# USB-10: Set IPG for non start of frame packets
@@ -112,16 +118,16 @@ static void orion_usb_phy_v1_setup(struct usb_hcd *hcd)
 	/*
 	 * Stop and reset controller
 	 */
-	wrl(USB_CMD, rdl(USB_CMD) & ~0x1);
-	wrl(USB_CMD, rdl(USB_CMD) | 0x2);
-	while (rdl(USB_CMD) & 0x2);
+	wrl(USB_CMD, rdl(USB_CMD) & ~USB_CMD_RUN);
+	wrl(USB_CMD, rdl(USB_CMD) | USB_CMD_RESET);
+	while (rdl(USB_CMD) & USB_CMD_RESET);
 
 	/*
 	 * GL# USB-5 Streaming disable REG_USB_MODE[4]=1
 	 * TBD: This need to be done after each reset!
 	 * GL# USB-4 Setup USB Host mode
 	 */
-	wrl(USB_MODE, 0x13);
+	wrl(USB_MODE, USB_MODE_SDIS | USB_MODE_HOST);
 }
 
 static void
-- 
2.1.0
