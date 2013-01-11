From: rogerq@ti.com (Roger Quadros)
Date: Fri, 11 Jan 2013 18:03:21 +0200
Subject: [PATCH 07/14] usb: ehci-omap: Instantiate PHY devices if required
In-Reply-To: <Pine.LNX.4.44L0.1301111019340.1730-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1301111019340.1730-100000@iolanthe.rowland.org>
Message-ID: <50F037C9.40306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2013 05:28 PM, Alan Stern wrote:
> On Fri, 11 Jan 2013, Roger Quadros wrote:
> 
>> Alan,
>>
>> Thanks for the patch. I've pasted the version that builds and works and
>> put you as the Author of the patch, hope it is fine.
> 
> As far as I can see, yours is the same as what I posted except that:
> 
> 	You altered the changes to ehci-hcd.c and Makefile to remove 
> 	the dependency on the ehci-mxc patch;
> 
> 	You made an unimportant whitespace change in ehci-omap.c
> 	(moved a blank line before ehci_write()).
> 
> Right?  It's hard to compare the patches directly because the one you 
> posted was whitespace-damaged.

My bad pasting it. Patch is attached now.

Apart from what you mentioned I did some more trivial changes. e.g.

+       !IS_ENABLED(CONFIG_USB_EHCI_HCD_OMAP) && \
instead of
+	!defined(CONFIG_USB_EHCI_HCD_OMAP) && \

use ehci_hcd_omap_driver instead of ehci_omap_driver


> 
> Anyway, if this is okay and there's nothing wrong with the ehci-mxc 
> change (other than the comment for ehci->priv), I'll submit both of 
> them to Greg soon.
> 

OK, thanks.

I tried using ehci->priv in ehci-omap driver but noticed that the
private data gets corrupted after the EHCI controller is running and has
enumerated a few devices.

If I disable USB_DEBUG then things are fine. Could it be possible
that someone is overflowing data when USB_DEBUG is enabled?

My implementation is pasted below. (May contain whitespace errors due to
MS exchange). Patch 2 attached in case.

What was happening there is that omap_priv->phy was not the same during
remove() as it was set to during probe().

Would be nice if you could check if the same happens with ehci-mxc.

cheers,
-roger

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 6388aa6..23c9b9c 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -70,6 +70,11 @@ static const char hcd_name[] = "ehci-omap";

 /*-------------------------------------------------------------------------*/

+struct omap_ehci_hcd {
+	struct usb_hcd *hcd;
+	struct usb_phy **phy;	/* one PHY for each port */
+	int nports;
+};

 static inline void ehci_write(void __iomem *base, u32 reg, u32 val)
 {
@@ -194,6 +199,8 @@ static int ehci_hcd_omap_probe(struct
platform_device *pdev)
 	struct usbhs_omap_platform_data		*pdata = dev->platform_data;
 	struct resource				*res;
 	struct usb_hcd				*hcd;
+	struct omap_ehci_hcd			*omap_hcd;
+	struct usb_phy				*phy;
 	void __iomem				*regs;
 	int					ret = -ENODEV;
 	int					irq;
@@ -208,6 +215,25 @@ static int ehci_hcd_omap_probe(struct
platform_device *pdev)
 		return -ENODEV;
 	}

+	if (!pdata) {
+		dev_err(dev, "Missing platform data\n");
+		return -ENODEV;
+	}
+
+	omap_hcd = devm_kzalloc(&pdev->dev, sizeof(*omap_hcd), GFP_KERNEL);
+	if (!omap_hcd) {
+		dev_err(dev, "Memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	omap_hcd->nports = pdata->nports;
+	i = sizeof(struct usb_phy *) * omap_hcd->nports;
+	omap_hcd->phy = devm_kzalloc(&pdev->dev, i, GFP_KERNEL);
+	if (!omap_hcd->phy) {
+		dev_err(dev, "Memory allocation failed\n");
+		return -ENOMEM;
+	}
+
 	irq = platform_get_irq_byname(pdev, "ehci-irq");
 	if (irq < 0) {
 		dev_err(dev, "EHCI irq failed\n");
@@ -238,9 +264,15 @@ static int ehci_hcd_omap_probe(struct
platform_device *pdev)
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 	hcd->regs = regs;
+	omap_hcd->hcd = hcd;
+
+	platform_set_drvdata(pdev, omap_hcd);

 	/* get ehci regulator and enable */
-	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
+	for (i = 0 ; i < omap_hcd->nports ; i++) {
+		struct platform_device *phy_pdev;
+		struct usbhs_phy_config *phy_config;
+
 		if (pdata->port_mode[i] != OMAP_EHCI_PORT_MODE_PHY) {
 			pdata->regulator[i] = NULL;
 			continue;
@@ -254,6 +286,33 @@ static int ehci_hcd_omap_probe(struct
platform_device *pdev)
 		} else {
 			regulator_enable(pdata->regulator[i]);
 		}
+
+		/* instantiate PHY */
+		if (!pdata->phy_config[i]) {
+			dev_dbg(dev, "missing phy_config for port %d\n", i);
+			continue;
+		}
+
+		phy_config = pdata->phy_config[i];
+		phy_pdev = platform_device_register_data(&pdev->dev,
+				phy_config->name, i, phy_config->pdata,
+				phy_config->pdata_size);
+		if (IS_ERR(phy_pdev)) {
+			dev_dbg(dev, "error creating PHY device for port %d\n",
+					i);
+		}
+
+		phy = usb_get_phy_from_dev(&phy_pdev->dev);
+		if (IS_ERR(phy)) {
+			dev_dbg(dev, "could not get USB PHY for port %d\n", i);
+			platform_device_unregister(phy_pdev);
+			continue;
+		}
+
+		usb_phy_init(phy);
+		omap_hcd->phy[i] = phy;
+		/* bring PHY out of suspend */
+		usb_phy_set_suspend(omap_hcd->phy[i], 0);
 	}

 	pm_runtime_enable(dev);
@@ -284,6 +343,12 @@ err_pm_runtime:
 	disable_put_regulator(pdata);
 	pm_runtime_put_sync(dev);
 	usb_put_hcd(hcd);
+	for (i = 0 ; i < omap_hcd->nports ; i++) {
+		phy = omap_hcd->phy[i];
+		if (!phy)
+			continue;
+		platform_device_unregister(to_platform_device(phy->dev));
+	}

 err_io:
 	iounmap(regs);
@@ -301,14 +366,26 @@ err_io:
  */
 static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
-	struct device *dev				= &pdev->dev;
-	struct usb_hcd *hcd				= dev_get_drvdata(dev);
+	struct device *dev		= &pdev->dev;
+	struct omap_ehci_hcd *omap_hcd	= dev_get_drvdata(dev);
+	struct usb_hcd *hcd		= omap_hcd->hcd;
+	int i;

 	usb_remove_hcd(hcd);
 	disable_put_regulator(dev->platform_data);
 	iounmap(hcd->regs);
 	usb_put_hcd(hcd);

+	for (i = 0; i < omap_hcd->nports; i++) {
+		struct usb_phy *phy = omap_hcd->phy[i];
+
+		if (!phy)
+			continue;
+
+		usb_phy_shutdown(phy);
+		platform_device_unregister(to_platform_device(phy->dev));
+	}
+
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);

diff --git a/include/linux/platform_data/usb-omap.h
b/include/linux/platform_data/usb-omap.h
index d63eb7d..927b8a1 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -38,6 +38,12 @@ enum usbhs_omap_port_mode {
 	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM
 };

+struct usbhs_phy_config {
+	char *name;		/* binds to device driver */
+	void *pdata;		/* platform data for the phy */
+	size_t pdata_size;
+};
+
 struct usbhs_omap_platform_data {
 	int				nports;
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
@@ -49,6 +55,8 @@ struct usbhs_omap_platform_data {
 	unsigned			single_ulpi_bypass:1;
 	unsigned			es2_compatibility:1;
 	unsigned			phy_reset:1;
+
+	struct usbhs_phy_config		*phy_config[OMAP3_HS_USB_PORTS];
 };

 /*-------------------------------------------------------------------------*/
-- 
1.7.4.1


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-USB-ehci-omap-Convert-to-platform-driver.patch
Type: text/x-patch
Size: 5842 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/84d5647c/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-usb-ehci-omap-Instantiate-PHY-devices-if-required.patch
Type: text/x-patch
Size: 5784 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/84d5647c/attachment-0003.bin>
