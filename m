From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 May 2013 07:28:48 +0900
Subject: [PATCH 1/2] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
In-Reply-To: <1369866529-6372-1-git-send-email-horms+renesas@verge.net.au>
References: <1369866529-6372-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369866529-6372-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The USB_OVCn pins are alternate options for USB over-current detection
when using a 3.3V USB interface. As they're not mandatory they can be
used independently of the USB PENC pins. Don't group the USB_OVCn and
PENC pins to avoid conflicts when the USB_OVCn pins are used by another
function.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   45 +++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 791a671..8cd90e7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2357,27 +2357,48 @@ static const unsigned int sdhi3_wp_mux[] = {
 };
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
-	/* OVC */
-	150, 154,
+	/* PENC */
+	154,
 };
 static const unsigned int usb0_mux[] = {
-	USB_OVC0_MARK, USB_PENC0_MARK,
+	USB_PENC0_MARK,
+};
+static const unsigned int usb0_ovc_pins[] = {
+	/* USB_OVC */
+	150
+};
+static const unsigned int usb0_ovc_mux[] = {
+	USB_OVC0_MARK,
 };
 /* - USB1 ------------------------------------------------------------------- */
 static const unsigned int usb1_pins[] = {
-	/* OVC */
-	152, 155,
+	/* PENC */
+	155,
 };
 static const unsigned int usb1_mux[] = {
-	USB_OVC1_MARK, USB_PENC1_MARK,
+	USB_PENC1_MARK,
+};
+static const unsigned int usb1_ovc_pins[] = {
+	/* USB_OVC */
+	152,
+};
+static const unsigned int usb1_ovc_mux[] = {
+	USB_OVC1_MARK,
 };
 /* - USB2 ------------------------------------------------------------------- */
 static const unsigned int usb2_pins[] = {
-	/* OVC, PENC */
-	125, 156,
+	/* PENC */
+	156,
 };
 static const unsigned int usb2_mux[] = {
-	USB_OVC2_MARK, USB_PENC2_MARK,
+	USB_PENC2_MARK,
+};
+static const unsigned int usb2_ovc_pins[] = {
+	/* USB_OVC */
+	125,
+};
+static const unsigned int usb2_ovc_mux[] = {
+	USB_OVC2_MARK,
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
@@ -2501,8 +2522,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi3_cd),
 	SH_PFC_PIN_GROUP(sdhi3_wp),
 	SH_PFC_PIN_GROUP(usb0),
+	SH_PFC_PIN_GROUP(usb0_ovc),
 	SH_PFC_PIN_GROUP(usb1),
+	SH_PFC_PIN_GROUP(usb1_ovc),
 	SH_PFC_PIN_GROUP(usb2),
+	SH_PFC_PIN_GROUP(usb2_ovc),
 };
 
 static const char * const du0_groups[] = {
@@ -2683,14 +2707,17 @@ static const char * const sdhi3_groups[] = {
 
 static const char * const usb0_groups[] = {
 	"usb0",
+	"usb0_ovc",
 };
 
 static const char * const usb1_groups[] = {
 	"usb1",
+	"usb1_ovc",
 };
 
 static const char * const usb2_groups[] = {
 	"usb2",
+	"usb2_ovc",
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
-- 
1.7.10.4
