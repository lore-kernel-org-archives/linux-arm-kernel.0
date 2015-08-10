From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:23:09 +0200
Subject: [PATCH 1/4] USB: host: ohci-at91: move at91_usbh_data definition in c
 file
In-Reply-To: <1439216592-11381-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439216592-11381-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1439216592-11381-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move struct at91_usbh_data back in ohci-at91.c as this is the only user
left after switching all at91 platforms to DT only.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/host/ohci-at91.c        | 11 +++++++++++
 include/linux/platform_data/atmel.h | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 15df00cceed9..72dc4f9e2a0f 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -36,6 +36,17 @@
 #define hcd_to_ohci_at91_priv(h) \
 	((struct ohci_at91_priv *)hcd_to_ohci(h)->priv)
 
+#define AT91_MAX_USBH_PORTS	3
+struct at91_usbh_data {
+	int vbus_pin[AT91_MAX_USBH_PORTS];	/* port power-control pin */
+	int overcurrent_pin[AT91_MAX_USBH_PORTS];
+	u8 ports;				/* number of ports on root hub */
+	u8 overcurrent_supported;
+	u8 vbus_pin_active_low[AT91_MAX_USBH_PORTS];
+	u8 overcurrent_status[AT91_MAX_USBH_PORTS];
+	u8 overcurrent_changed[AT91_MAX_USBH_PORTS];
+};
+
 struct ohci_at91_priv {
 	struct clk *iclk;
 	struct clk *fclk;
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 4b452c6a2f7b..527a85c61924 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -46,18 +46,6 @@ struct at91_cf_data {
 #define AT91_IDE_SWAP_A0_A2	0x02
 };
 
- /* USB Host */
-#define AT91_MAX_USBH_PORTS	3
-struct at91_usbh_data {
-	int		vbus_pin[AT91_MAX_USBH_PORTS];	/* port power-control pin */
-	int             overcurrent_pin[AT91_MAX_USBH_PORTS];
-	u8		ports;				/* number of ports on root hub */
-	u8              overcurrent_supported;
-	u8              vbus_pin_active_low[AT91_MAX_USBH_PORTS];
-	u8              overcurrent_status[AT91_MAX_USBH_PORTS];
-	u8              overcurrent_changed[AT91_MAX_USBH_PORTS];
-};
-
  /* NAND / SmartMedia */
 struct atmel_nand_data {
 	int		enable_pin;		/* chip enable */
-- 
2.1.4
