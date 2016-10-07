From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:48 +0200
Subject: [PATCH/RFT 03/12] ARM: davinci: rename root_hub to platform_data
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-4-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

To prepare for DT support we will remove the usb callback function
pointers. Since this structure will only pass data to the driver, It
seems better to rename the structure root_hub structure to platform_data

There is no functional change.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h  |  2 +-
 arch/arm/mach-davinci/usb-da8xx.c           |  2 +-
 drivers/usb/host/ohci-da8xx.c               | 36 ++++++++++++++---------------
 include/linux/platform_data/usb-davinci.h   |  6 ++---
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index c62766e..18d2b10 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -87,7 +87,7 @@ static int da830_evm_usb_ocic_notify(da8xx_ocic_handler_t handler)
 	return error;
 }
 
-static struct da8xx_ohci_root_hub da830_evm_usb11_pdata = {
+static struct da8xx_ohci_platform_data da830_evm_usb11_pdata = {
 	.set_power	= da830_evm_usb_set_power,
 	.get_power	= da830_evm_usb_get_power,
 	.get_oci	= da830_evm_usb_get_oci,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 1dc6112..a2bf3eb 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -226,7 +226,7 @@ static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
 	return error;
 }
 
-static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
+static struct da8xx_ohci_platform_data omapl138_hawk_usb11_pdata = {
 	.set_power      = hawk_usb_set_power,
 	.get_power      = hawk_usb_get_power,
 	.get_oci        = hawk_usb_get_oci,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 38d932e..f7d6fd9 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -94,7 +94,7 @@ int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb_phy(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
-int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
+int da8xx_register_usb11(struct da8xx_ohci_platform_data *pdata);
 int da8xx_register_emac(void);
 int da8xx_register_uio_pruss(void);
 int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 982e105..36e3460 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -337,7 +337,7 @@ static struct platform_device da8xx_usb11_device = {
 	.resource	= da8xx_usb11_resources,
 };
 
-int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
+int __init da8xx_register_usb11(struct da8xx_ohci_platform_data *pdata)
 {
 	da8xx_usb11_device.dev.platform_data = pdata;
 	return platform_device_register(&da8xx_usb11_device);
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 3656d7c..8ed9a52 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -64,20 +64,20 @@ static void ohci_da8xx_disable(void)
 /*
  * Handle the port over-current indicator change.
  */
-static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub,
+static void ohci_da8xx_ocic_handler(struct da8xx_ohci_platform_data *pdata,
 				    unsigned port)
 {
 	ocic_mask |= 1 << port;
 
 	/* Once over-current is detected, the port needs to be powered down */
-	if (hub->get_oci(port) > 0)
-		hub->set_power(port, 0);
+	if (pdata->get_oci(port) > 0)
+		pdata->set_power(port, 0);
 }
 
 static int ohci_da8xx_init(struct usb_hcd *hcd)
 {
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+	struct da8xx_ohci_platform_data *pdata	= dev_get_platdata(dev);
 	struct ohci_hcd	*ohci		= hcd_to_ohci(hcd);
 	int result;
 	u32 rh_a;
@@ -107,16 +107,16 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
 	 * the correct hub descriptor...
 	 */
 	rh_a = ohci_readl(ohci, &ohci->regs->roothub.a);
-	if (hub->set_power) {
+	if (pdata->set_power) {
 		rh_a &= ~RH_A_NPS;
 		rh_a |=  RH_A_PSM;
 	}
-	if (hub->get_oci) {
+	if (pdata->get_oci) {
 		rh_a &= ~RH_A_NOCP;
 		rh_a |=  RH_A_OCPM;
 	}
 	rh_a &= ~RH_A_POTPGT;
-	rh_a |= hub->potpgt << 24;
+	rh_a |= pdata->potpgt << 24;
 	ohci_writel(ohci, rh_a, &ohci->regs->roothub.a);
 
 	return result;
@@ -167,7 +167,7 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				  u16 wIndex, char *buf, u16 wLength)
 {
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+	struct da8xx_ohci_platform_data *pdata	= dev_get_platdata(dev);
 	int temp;
 
 	switch (typeReq) {
@@ -181,11 +181,11 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		temp = roothub_portstatus(hcd_to_ohci(hcd), wIndex - 1);
 
 		/* The port power status (PPS) bit defaults to 1 */
-		if (hub->get_power && hub->get_power(wIndex) == 0)
+		if (pdata->get_power && pdata->get_power(wIndex) == 0)
 			temp &= ~RH_PS_PPS;
 
 		/* The port over-current indicator (POCI) bit is always 0 */
-		if (hub->get_oci && hub->get_oci(wIndex) > 0)
+		if (pdata->get_oci && pdata->get_oci(wIndex) > 0)
 			temp |=  RH_PS_POCI;
 
 		/* The over-current indicator change (OCIC) bit is 0 too */
@@ -210,10 +210,10 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex, "POWER");
 
-			if (!hub->set_power)
+			if (!pdata->set_power)
 				return -EPIPE;
 
-			return hub->set_power(wIndex, temp) ? -EPIPE : 0;
+			return pdata->set_power(wIndex, temp) ? -EPIPE : 0;
 		case USB_PORT_FEAT_C_OVER_CURRENT:
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex,
@@ -288,12 +288,12 @@ static const struct hc_driver ohci_da8xx_hc_driver = {
 static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 			       struct platform_device *pdev)
 {
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(&pdev->dev);
+	struct da8xx_ohci_platform_data *pdata	= dev_get_platdata(&pdev->dev);
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
 
-	if (hub == NULL)
+	if (pdata == NULL)
 		return -ENODEV;
 
 	usb11_clk = devm_clk_get(&pdev->dev, "usb11");
@@ -337,8 +337,8 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 
 	device_wakeup_enable(hcd->self.controller);
 
-	if (hub->ocic_notify) {
-		error = hub->ocic_notify(ohci_da8xx_ocic_handler);
+	if (pdata->ocic_notify) {
+		error = pdata->ocic_notify(ohci_da8xx_ocic_handler);
 		if (!error)
 			return 0;
 	}
@@ -361,9 +361,9 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 static inline void
 usb_hcd_da8xx_remove(struct usb_hcd *hcd, struct platform_device *pdev)
 {
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(&pdev->dev);
+	struct da8xx_ohci_platform_data *pdata	= dev_get_platdata(&pdev->dev);
 
-	hub->ocic_notify(NULL);
+	pdata->ocic_notify(NULL);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 }
diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index e0bc4ab..dffe3bf 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -34,13 +34,13 @@
 #define CFGCHIP2_REFFREQ_24MHZ	(2 << 0)
 #define CFGCHIP2_REFFREQ_48MHZ	(3 << 0)
 
-struct	da8xx_ohci_root_hub;
+struct	da8xx_ohci_platform_data;
 
-typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub,
+typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_platform_data *pdata,
 				     unsigned port);
 
 /* Passed as the platform data to the OHCI driver */
-struct	da8xx_ohci_root_hub {
+struct	da8xx_ohci_platform_data {
 	/* Switch the port power on/off */
 	int	(*set_power)(unsigned port, int on);
 	/* Read the port power status */
-- 
2.7.1
