From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Mon, 24 Oct 2016 18:46:27 +0200
Subject: [PATCH/RFT v2 10/17] USB: da8xx: use flag instead of bitmask for over
 current change
In-Reply-To: <20161024164634.4330-1-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
Message-ID: <20161024164634.4330-11-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

The da8xx ohci has only one port connected. In hub_control we
check that the port is 1, or else we bail out early. There is no point
in passing as argument the port number, if we know, and check that it
will always be 1.

Simplify functions and callbacks, by removing the port parameter, and
converting the over current indicatior change form a mask to a flag.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  8 ++++----
 arch/arm/mach-davinci/board-omapl138-hawk.c |  8 ++++----
 drivers/usb/host/ohci-da8xx.c               | 29 ++++++++++++++---------------
 include/linux/platform_data/usb-davinci.h   |  9 ++++-----
 4 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index b33fc6b..d12fcf5 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -50,18 +50,18 @@
 
 static da8xx_ocic_handler_t da830_evm_usb_ocic_handler;
 
-static int da830_evm_usb_set_power(unsigned port, int on)
+static int da830_evm_usb_set_power(int on)
 {
 	gpio_set_value(ON_BD_USB_DRV, on);
 	return 0;
 }
 
-static int da830_evm_usb_get_power(unsigned port)
+static int da830_evm_usb_get_power(void)
 {
 	return gpio_get_value(ON_BD_USB_DRV);
 }
 
-static int da830_evm_usb_get_oci(unsigned port)
+static int da830_evm_usb_get_oci(void)
 {
 	return !gpio_get_value(ON_BD_USB_OVC);
 }
@@ -100,7 +100,7 @@ static int da830_evm_usb_ocic_notify(da8xx_ocic_handler_t handler)
 
 static irqreturn_t da830_evm_usb_ocic_irq(int irq, void *dev_id)
 {
-	da830_evm_usb_ocic_handler(&da830_evm_usb11_pdata, 1);
+	da830_evm_usb_ocic_handler(&da830_evm_usb11_pdata);
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index c3ab7ea..1d31f45 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -189,18 +189,18 @@ static __init void omapl138_hawk_mmc_init(void)
 	-1
 };
 
-static int hawk_usb_set_power(unsigned port, int on)
+static int hawk_usb_set_power(int on)
 {
 	gpio_set_value(DA850_USB1_VBUS_PIN, on);
 	return 0;
 }
 
-static int hawk_usb_get_power(unsigned port)
+static int hawk_usb_get_power(void)
 {
 	return gpio_get_value(DA850_USB1_VBUS_PIN);
 }
 
-static int hawk_usb_get_oci(unsigned port)
+static int hawk_usb_get_oci(void)
 {
 	return !gpio_get_value(DA850_USB1_OC_PIN);
 }
@@ -237,7 +237,7 @@ static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
 
 static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
 {
-	hawk_usb_ocic_handler(&omapl138_hawk_usb11_pdata, 1);
+	hawk_usb_ocic_handler(&omapl138_hawk_usb11_pdata);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 3656d7c..e98066d 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -25,8 +25,8 @@
 static struct clk *usb11_clk;
 static struct phy *usb11_phy;
 
-/* Over-current indicator change bitmask */
-static volatile u16 ocic_mask;
+/* Over-current indicator change flag */
+static int ocic_flag;
 
 static int ohci_da8xx_enable(void)
 {
@@ -64,14 +64,13 @@ static void ohci_da8xx_disable(void)
 /*
  * Handle the port over-current indicator change.
  */
-static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub,
-				    unsigned port)
+static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub)
 {
-	ocic_mask |= 1 << port;
+	ocic_flag = 1;
 
 	/* Once over-current is detected, the port needs to be powered down */
-	if (hub->get_oci(port) > 0)
-		hub->set_power(port, 0);
+	if (hub->get_oci() > 0)
+		hub->set_power(0);
 }
 
 static int ohci_da8xx_init(struct usb_hcd *hcd)
@@ -147,8 +146,8 @@ static int ohci_da8xx_hub_status_data(struct usb_hcd *hcd, char *buf)
 {
 	int length		= ohci_hub_status_data(hcd, buf);
 
-	/* See if we have OCIC bit set on port 1 */
-	if (ocic_mask & (1 << 1)) {
+	/* See if we have OCIC flag set */
+	if (ocic_flag) {
 		dev_dbg(hcd->self.controller, "over-current indicator change "
 			"on port 1\n");
 
@@ -181,15 +180,15 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		temp = roothub_portstatus(hcd_to_ohci(hcd), wIndex - 1);
 
 		/* The port power status (PPS) bit defaults to 1 */
-		if (hub->get_power && hub->get_power(wIndex) == 0)
+		if (hub->get_power && hub->get_power() == 0)
 			temp &= ~RH_PS_PPS;
 
 		/* The port over-current indicator (POCI) bit is always 0 */
-		if (hub->get_oci && hub->get_oci(wIndex) > 0)
+		if (hub->get_oci && hub->get_oci() > 0)
 			temp |=  RH_PS_POCI;
 
 		/* The over-current indicator change (OCIC) bit is 0 too */
-		if (ocic_mask & (1 << wIndex))
+		if (ocic_flag)
 			temp |=  RH_PS_OCIC;
 
 		put_unaligned(cpu_to_le32(temp), (__le32 *)buf);
@@ -213,16 +212,16 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			if (!hub->set_power)
 				return -EPIPE;
 
-			return hub->set_power(wIndex, temp) ? -EPIPE : 0;
+			return hub->set_power(temp) ? -EPIPE : 0;
 		case USB_PORT_FEAT_C_OVER_CURRENT:
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex,
 				"C_OVER_CURRENT");
 
 			if (temp)
-				ocic_mask |= 1 << wIndex;
+				ocic_flag = 1;
 			else
-				ocic_mask &= ~(1 << wIndex);
+				ocic_flag = 0;
 			return 0;
 		}
 	}
diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index 0926e99..3217fbe 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -13,17 +13,16 @@
 
 struct	da8xx_ohci_root_hub;
 
-typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub,
-				     unsigned port);
+typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub);
 
 /* Passed as the platform data to the OHCI driver */
 struct	da8xx_ohci_root_hub {
 	/* Switch the port power on/off */
-	int	(*set_power)(unsigned port, int on);
+	int	(*set_power)(int on);
 	/* Read the port power status */
-	int	(*get_power)(unsigned port);
+	int	(*get_power)(void);
 	/* Read the port over-current indicator */
-	int	(*get_oci)(unsigned port);
+	int	(*get_oci)(void);
 	/* Over-current indicator change notification (pass NULL to disable) */
 	int	(*ocic_notify)(da8xx_ocic_handler_t handler);
 
-- 
1.9.1
