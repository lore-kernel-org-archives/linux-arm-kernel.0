From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Mon, 24 Oct 2016 18:46:30 +0200
Subject: [PATCH/RFT v2 13/17] USB: da8xx: use ohci priv data instead of globals
In-Reply-To: <20161024164634.4330-1-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
Message-ID: <20161024164634.4330-14-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

Instead of global variables, use the extra_priv_size of the ohci driver
to add a reference to driver private data.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 135 ++++++++++++++++++++++++------------------
 1 file changed, 79 insertions(+), 56 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index f4bda4d..bebc3f0 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -37,60 +37,66 @@ static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
 			u16 wValue, u16 wIndex, char *buf, u16 wLength);
 static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
 
-static struct clk *usb11_clk;
-static struct phy *usb11_phy;
-static struct regulator *vbus_reg;
-struct notifier_block nb;
-
-/* Over-current indicator change flag */
-static int ocic_flag;
+struct da8xx_ohci_hcd {
+	struct usb_hcd *hcd;
+	struct clk *usb11_clk;
+	struct phy *usb11_phy;
+	struct regulator *vbus_reg;
+	struct notifier_block nb;
+	int ocic_flag;
+};
+#define to_da8xx_ohci(hcd) (struct da8xx_ohci_hcd *)(hcd_to_ohci(hcd)->priv)
 
-static int ohci_da8xx_enable(void)
+static int ohci_da8xx_enable(struct usb_hcd *hcd)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	int ret;
 
-	ret = clk_prepare_enable(usb11_clk);
+	ret = clk_prepare_enable(da8xx_ohci->usb11_clk);
 	if (ret)
 		return ret;
 
-	ret = phy_init(usb11_phy);
+	ret = phy_init(da8xx_ohci->usb11_phy);
 	if (ret)
 		goto err_phy_init;
 
-	ret = phy_power_on(usb11_phy);
+	ret = phy_power_on(da8xx_ohci->usb11_phy);
 	if (ret)
 		goto err_phy_power_on;
 
 	return 0;
 
 err_phy_power_on:
-	phy_exit(usb11_phy);
+	phy_exit(da8xx_ohci->usb11_phy);
 err_phy_init:
-	clk_disable_unprepare(usb11_clk);
+	clk_disable_unprepare(da8xx_ohci->usb11_clk);
 
 	return ret;
 }
 
-static void ohci_da8xx_disable(void)
+static void ohci_da8xx_disable(struct usb_hcd *hcd)
 {
-	phy_power_off(usb11_phy);
-	phy_exit(usb11_phy);
-	clk_disable_unprepare(usb11_clk);
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
+
+	phy_power_off(da8xx_ohci->usb11_phy);
+	phy_exit(da8xx_ohci->usb11_phy);
+	clk_disable_unprepare(da8xx_ohci->usb11_clk);
 }
 
-static int ohci_da8xx_set_power(int on)
+static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	int ret = 0;
 
-	if (!vbus_reg)
+	if (!da8xx_ohci->vbus_reg)
 		return 0;
 
 	if (on) {
-		ret = regulator_enable(vbus_reg);
+		ret = regulator_enable(da8xx_ohci->vbus_reg);
 		if (ret)
 			pr_err("fail to enable regulator: %d\n", ret);
 	} else {
-		ret = regulator_disable(vbus_reg);
+		ret = regulator_disable(da8xx_ohci->vbus_reg);
 		if (ret)
 			pr_err("fail to disable regulator: %d\n", ret);
 	}
@@ -98,17 +104,22 @@ static int ohci_da8xx_set_power(int on)
 	return ret;
 }
 
-static int ohci_da8xx_get_power(void)
+static int ohci_da8xx_get_power(struct usb_hcd *hcd)
 {
-	if (!vbus_reg)
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
+
+	if (!da8xx_ohci->vbus_reg)
 		return 1;
 
-	return regulator_is_enabled(vbus_reg);
+	return regulator_is_enabled(da8xx_ohci->vbus_reg);
 }
 
-static int ohci_da8xx_get_oci(void)
+static int ohci_da8xx_get_oci(struct usb_hcd *hcd)
 {
-	if (regulator_get_mode(vbus_reg) == REGULATOR_MODE_OVERCURRENT)
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
+
+	if (regulator_get_mode(da8xx_ohci->vbus_reg) ==
+			REGULATOR_MODE_OVERCURRENT)
 		return 1;
 
 	return 0;
@@ -117,10 +128,13 @@ static int ohci_da8xx_get_oci(void)
 static int ohci_da8xx_regulator_event(struct notifier_block *nb,
 				unsigned long event, void *data)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci =
+			container_of(nb, struct da8xx_ohci_hcd, nb);
+
 	if (event & REGULATOR_EVENT_OVER_CURRENT) {
-		ocic_flag = 1;
-		if (ohci_da8xx_get_oci())
-			ohci_da8xx_set_power(0);
+		da8xx_ohci->ocic_flag = 1;
+		if (ohci_da8xx_get_oci(da8xx_ohci->hcd))
+			ohci_da8xx_set_power(da8xx_ohci->hcd, 0);
 	}
 
 	return 0;
@@ -130,12 +144,13 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
 {
 	struct device *dev		= hcd->self.controller;
 	struct ohci_hcd	*ohci		= hcd_to_ohci(hcd);
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	int result;
 	u32 rh_a;
 
 	dev_dbg(dev, "starting USB controller\n");
 
-	result = ohci_da8xx_enable();
+	result = ohci_da8xx_enable(hcd);
 	if (result < 0)
 		return result;
 
@@ -147,7 +162,7 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
 
 	result = ohci_setup(hcd);
 	if (result < 0) {
-		ohci_da8xx_disable();
+		ohci_da8xx_disable(hcd);
 		return result;
 	}
 
@@ -159,7 +174,7 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
 	 */
 	rh_a = ohci_readl(ohci, &ohci->regs->roothub.a);
 
-	if (vbus_reg) {
+	if (da8xx_ohci->vbus_reg) {
 		rh_a &= ~RH_A_NPS;
 		rh_a |=  RH_A_PSM;
 		rh_a &= ~RH_A_NOCP;
@@ -176,10 +191,11 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
  */
 static int ohci_da8xx_hub_status_data(struct usb_hcd *hcd, char *buf)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	int length		= orig_ohci_hub_status_data(hcd, buf);
 
 	/* See if we have OCIC flag set */
-	if (ocic_flag) {
+	if (da8xx_ohci->ocic_flag) {
 		dev_dbg(hcd->self.controller, "over-current indicator change "
 			"on port 1\n");
 
@@ -197,6 +213,7 @@ static int ohci_da8xx_hub_status_data(struct usb_hcd *hcd, char *buf)
 static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				  u16 wIndex, char *buf, u16 wLength)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
 	int temp;
 
@@ -211,15 +228,15 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		temp = roothub_portstatus(hcd_to_ohci(hcd), wIndex - 1);
 
 		/* The port power status (PPS) bit defaults to 1 */
-		if (ohci_da8xx_get_power() == 0)
+		if (ohci_da8xx_get_power(hcd) == 0)
 			temp &= ~RH_PS_PPS;
 
 		/* The port over-current indicator (POCI) bit is always 0 */
-		if (ohci_da8xx_get_oci() > 0)
+		if (ohci_da8xx_get_oci(hcd) > 0)
 			temp |=  RH_PS_POCI;
 
 		/* The over-current indicator change (OCIC) bit is 0 too */
-		if (ocic_flag)
+		if (da8xx_ohci->ocic_flag)
 			temp |=  RH_PS_OCIC;
 
 		put_unaligned(cpu_to_le32(temp), (__le32 *)buf);
@@ -240,13 +257,13 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex, "POWER");
 
-			return ohci_da8xx_set_power(temp) ? -EPIPE : 0;
+			return ohci_da8xx_set_power(hcd, temp) ? -EPIPE : 0;
 		case USB_PORT_FEAT_C_OVER_CURRENT:
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex,
 				"C_OVER_CURRENT");
 
-			ocic_flag = temp;
+			da8xx_ohci->ocic_flag = temp;
 			return 0;
 		}
 	}
@@ -259,6 +276,7 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 static int ohci_da8xx_probe(struct platform_device *pdev)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci;
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
@@ -268,30 +286,34 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 	if (!hcd)
 		return -ENOMEM;
 
-	usb11_clk = devm_clk_get(&pdev->dev, "usb11");
-	if (IS_ERR(usb11_clk)) {
-		if (PTR_ERR(usb11_clk) != -EPROBE_DEFER)
+	da8xx_ohci = to_da8xx_ohci(hcd);
+	da8xx_ohci->hcd = hcd;
+
+	da8xx_ohci->usb11_clk = devm_clk_get(&pdev->dev, "usb11");
+	if (IS_ERR(da8xx_ohci->usb11_clk)) {
+		if (PTR_ERR(da8xx_ohci->usb11_clk) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Failed to get clock.\n");
-		return PTR_ERR(usb11_clk);
+		return PTR_ERR(da8xx_ohci->usb11_clk);
 	}
 
-	usb11_phy = devm_phy_get(&pdev->dev, "usb-phy");
-	if (IS_ERR(usb11_phy)) {
-		if (PTR_ERR(usb11_phy) != -EPROBE_DEFER)
+	da8xx_ohci->usb11_phy = devm_phy_get(&pdev->dev, "usb-phy");
+	if (IS_ERR(da8xx_ohci->usb11_phy)) {
+		if (PTR_ERR(da8xx_ohci->usb11_phy) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Failed to get phy.\n");
-		return PTR_ERR(usb11_phy);
+		return PTR_ERR(da8xx_ohci->usb11_phy);
 	}
 
-	vbus_reg = devm_regulator_get(&pdev->dev, "vbus");
-	if (IS_ERR(vbus_reg)) {
-		if (PTR_ERR(vbus_reg) != -EPROBE_DEFER)
+	da8xx_ohci->vbus_reg = devm_regulator_get(&pdev->dev, "vbus");
+	if (IS_ERR(da8xx_ohci->vbus_reg)) {
+		if (PTR_ERR(da8xx_ohci->vbus_reg) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Failed to get regulator.\n");
-		return PTR_ERR(vbus_reg);
+		return PTR_ERR(da8xx_ohci->vbus_reg);
 	}
 
-	if (vbus_reg) {
-		nb.notifier_call = ohci_da8xx_regulator_event;
-		error = devm_regulator_register_notifier(vbus_reg, &nb);
+	if (da8xx_ohci->vbus_reg) {
+		da8xx_ohci->nb.notifier_call = ohci_da8xx_regulator_event;
+		error = devm_regulator_register_notifier(da8xx_ohci->vbus_reg,
+							 &da8xx_ohci->nb);
 		if (error) {
 			dev_err(&pdev->dev,
 				"Could not register regulator notifier\n");
@@ -354,7 +376,7 @@ static int ohci_da8xx_suspend(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	ohci_da8xx_disable();
+	ohci_da8xx_disable(hcd);
 	hcd->state = HC_STATE_SUSPENDED;
 
 	return ret;
@@ -370,7 +392,7 @@ static int ohci_da8xx_resume(struct platform_device *dev)
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
-	ret = ohci_da8xx_enable();
+	ret = ohci_da8xx_enable(hcd);
 	if (ret)
 		return ret;
 
@@ -382,7 +404,8 @@ static int ohci_da8xx_resume(struct platform_device *dev)
 #endif
 
 static const struct ohci_driver_overrides da8xx_overrides __initconst = {
-	.reset		= ohci_da8xx_reset
+	.reset		= ohci_da8xx_reset,
+	.extra_priv_size = sizeof(struct da8xx_ohci_hcd),
 };
 
 /*
-- 
1.9.1
