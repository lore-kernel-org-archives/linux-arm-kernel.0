From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Thu, 30 Jul 2015 13:13:42 +0000
Subject: [PATCH] drivers/usb/: Simplify return statements
Message-ID: <20150730131337.GA2715@alcatraz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

This patch is created using simple_return.cocci coccinelle script.
It replaces the redundant instances where variables are assigned
return value from functions and then used in return statements.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/host/ehci-st.c      |  7 +------
 drivers/usb/host/oxu210hp-hcd.c |  7 +------
 drivers/usb/host/u132-hcd.c     | 27 +++++----------------------
 drivers/usb/host/xhci.c         |  6 +-----
 drivers/usb/misc/ftdi-elan.c    | 10 ++--------
 drivers/usb/musb/musb_dsps.c    |  6 +-----
 drivers/usb/phy/phy-keystone.c  |  6 +-----
 drivers/usb/phy/phy-mxs-usb.c   |  6 +-----
 drivers/usb/serial/mxuport.c    |  6 +-----
 9 files changed, 14 insertions(+), 67 deletions(-)

diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index 7e4bd39..b7c5cfa 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -54,7 +54,6 @@ static int st_ehci_platform_reset(struct usb_hcd *hcd)
 	struct platform_device *pdev = to_platform_device(hcd->self.controller);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
-	int retval;
 	u32 threshold;
 
 	/* Set EHCI packet buffer IN/OUT threshold to 128 bytes */
@@ -62,11 +61,7 @@ static int st_ehci_platform_reset(struct usb_hcd *hcd)
 	writel(threshold, hcd->regs + AHB2STBUS_INSREG01);
 
 	ehci->caps = hcd->regs + pdata->caps_offset;
-	retval = ehci_setup(hcd);
-	if (retval)
-		return retval;
-
-	return 0;
+	return ehci_setup(hcd);
 }
 
 static int st_ehci_platform_power_on(struct platform_device *dev)
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 6352f54..fe3bd1c 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -2670,7 +2670,6 @@ static int oxu_hcd_init(struct usb_hcd *hcd)
 static int oxu_reset(struct usb_hcd *hcd)
 {
 	struct oxu_hcd *oxu = hcd_to_oxu(hcd);
-	int ret;
 
 	spin_lock_init(&oxu->mem_lock);
 	INIT_LIST_HEAD(&oxu->urb_list);
@@ -2696,11 +2695,7 @@ static int oxu_reset(struct usb_hcd *hcd)
 	oxu->hcs_params = readl(&oxu->caps->hcs_params);
 	oxu->sbrn = 0x20;
 
-	ret = oxu_hcd_init(hcd);
-	if (ret)
-		return ret;
-
-	return 0;
+	return oxu_hcd_init(hcd);
 }
 
 static int oxu_run(struct usb_hcd *hcd)
diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index d516877..1cfb811 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -1542,11 +1542,8 @@ static int u132_periodic_reinit(struct u132 *u132)
 		(fit ^ FIT) | u132->hc_fminterval);
 	if (retval)
 		return retval;
-	retval = u132_write_pcimem(u132, periodicstart,
+	return u132_write_pcimem(u132, periodicstart,
 		((9 * fi) / 10) & 0x3fff);
-	if (retval)
-		return retval;
-	return 0;
 }
 
 static char *hcfs2string(int state)
@@ -2701,28 +2698,18 @@ static int u132_roothub_setportfeature(struct u132 *u132, u16 wValue,
 	if (wIndex == 0 || wIndex > u132->num_ports) {
 		return -EINVAL;
 	} else {
-		int retval;
 		int port_index = wIndex - 1;
 		struct u132_port *port = &u132->port[port_index];
 		port->Status &= ~(1 << wValue);
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
-			retval = u132_write_pcimem(u132,
+			return u132_write_pcimem(u132,
 				roothub.portstatus[port_index], RH_PS_PSS);
-			if (retval)
-				return retval;
-			return 0;
 		case USB_PORT_FEAT_POWER:
-			retval = u132_write_pcimem(u132,
+			return u132_write_pcimem(u132,
 				roothub.portstatus[port_index], RH_PS_PPS);
-			if (retval)
-				return retval;
-			return 0;
 		case USB_PORT_FEAT_RESET:
-			retval = u132_roothub_portreset(u132, port_index);
-			if (retval)
-				return retval;
-			return 0;
+			return u132_roothub_portreset(u132, port_index);
 		default:
 			return -EPIPE;
 		}
@@ -2737,7 +2724,6 @@ static int u132_roothub_clearportfeature(struct u132 *u132, u16 wValue,
 	} else {
 		int port_index = wIndex - 1;
 		u32 temp;
-		int retval;
 		struct u132_port *port = &u132->port[port_index];
 		port->Status &= ~(1 << wValue);
 		switch (wValue) {
@@ -2773,11 +2759,8 @@ static int u132_roothub_clearportfeature(struct u132 *u132, u16 wValue,
 		default:
 			return -EPIPE;
 		}
-		retval = u132_write_pcimem(u132, roothub.portstatus[port_index],
+		return u132_write_pcimem(u132, roothub.portstatus[port_index],
 			 temp);
-		if (retval)
-			return retval;
-		return 0;
 	}
 }
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 526ebc0..19076fa 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4678,7 +4678,6 @@ int xhci_disable_usb3_lpm_timeout(struct usb_hcd *hcd,
 {
 	struct xhci_hcd	*xhci;
 	u16 mel;
-	int ret;
 
 	xhci = hcd_to_xhci(hcd);
 	if (!xhci || !(xhci->quirks & XHCI_LPM_SUPPORT) ||
@@ -4686,10 +4685,7 @@ int xhci_disable_usb3_lpm_timeout(struct usb_hcd *hcd,
 		return 0;
 
 	mel = calculate_max_exit_latency(udev, state, USB3_LPM_DISABLED);
-	ret = xhci_change_max_exit_latency(xhci, udev, mel);
-	if (ret)
-		return ret;
-	return 0;
+	return xhci_change_max_exit_latency(xhci, udev, mel);
 }
 #else /* CONFIG_PM */
 
diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index 8ab1f8f..1545f12 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -2568,11 +2568,8 @@ static int ftdi_elan_close_controller(struct usb_ftdi *ftdi, int fn)
 					    0x00);
 	if (UxxxStatus)
 		return UxxxStatus;
-	UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
+	return ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
 					   &pcidata);
-	if (UxxxStatus)
-		return UxxxStatus;
-	return 0;
 }
 
 static int ftdi_elan_found_controller(struct usb_ftdi *ftdi, int fn, int quirk)
@@ -2695,11 +2692,8 @@ static int ftdi_elan_setupOHCI(struct usb_ftdi *ftdi)
 		}
 	}
 	if (ftdi->function > 0) {
-		UxxxStatus = ftdi_elan_setup_controller(ftdi,
+		return ftdi_elan_setup_controller(ftdi,
 							ftdi->function - 1);
-		if (UxxxStatus)
-			return UxxxStatus;
-		return 0;
 	} else if (controllers > 0) {
 		return -ENXIO;
 	} else if (unrecognized > 0) {
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 1334a3d..a0cfead 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -482,11 +482,7 @@ static int dsps_musb_init(struct musb *musb)
 		dsps_writeb(musb->mregs, MUSB_BABBLE_CTL, val);
 	}
 
-	ret = dsps_musb_dbg_init(musb, glue);
-	if (ret)
-		return ret;
-
-	return 0;
+	return dsps_musb_dbg_init(musb, glue);
 }
 
 static int dsps_musb_exit(struct musb *musb)
diff --git a/drivers/usb/phy/phy-keystone.c b/drivers/usb/phy/phy-keystone.c
index e0556f7..01d4e4c 100644
--- a/drivers/usb/phy/phy-keystone.c
+++ b/drivers/usb/phy/phy-keystone.c
@@ -96,11 +96,7 @@ static int keystone_usbphy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, k_phy);
 
-	ret = usb_add_phy_dev(&k_phy->usb_phy_gen.phy);
-	if (ret)
-		return ret;
-
-	return 0;
+	return usb_add_phy_dev(&k_phy->usb_phy_gen.phy);
 }
 
 static int keystone_usbphy_remove(struct platform_device *pdev)
diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 3fcc048..4d863eb 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -506,11 +506,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	device_set_wakeup_capable(&pdev->dev, true);
 
-	ret = usb_add_phy_dev(&mxs_phy->phy);
-	if (ret)
-		return ret;
-
-	return 0;
+	return usb_add_phy_dev(&mxs_phy->phy);
 }
 
 static int mxs_phy_remove(struct platform_device *pdev)
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index 460a406..7792407 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -1137,13 +1137,9 @@ static int mxuport_port_probe(struct usb_serial_port *port)
 		return err;
 
 	/* Set interface (RS-232) */
-	err = mxuport_send_ctrl_urb(serial, RQ_VENDOR_SET_INTERFACE,
+	return mxuport_send_ctrl_urb(serial, RQ_VENDOR_SET_INTERFACE,
 				    MX_INT_RS232,
 				    port->port_number);
-	if (err)
-		return err;
-
-	return 0;
 }
 
 static int mxuport_alloc_write_urb(struct usb_serial *serial,
-- 
1.9.1
