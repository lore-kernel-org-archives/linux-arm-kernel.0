From: tony.lin@freescale.com (Tony Lin)
Date: Tue, 2 Aug 2011 16:39:41 +0800
Subject: [PATCH v4 2/7] ARM: mxs: make ehci-mxc more flexible to be used on
	different platforms
In-Reply-To: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
References: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1312274386-6833-3-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change ehci_irq to mxc_ehci_irq to give chance do some platform specific
actions in irq handler for different platforms.
add void pointer in the last of mxc_usbh_platform_data structure so that
additional information could be added to that field if needed.

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 drivers/usb/host/Kconfig    |    2 +-
 drivers/usb/host/ehci-mxc.c |   13 ++++++++++++-
 include/linux/fsl_devices.h |    2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index ab085f1..6a5905b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -139,7 +139,7 @@ config USB_EHCI_FSL
 
 config USB_EHCI_MXC
 	bool "Support for Freescale on-chip EHCI USB controller"
-	depends on USB_EHCI_HCD && ARCH_MXC
+	depends on USB_EHCI_HCD && (ARCH_MXC || ARCH_MXS)
 	select USB_EHCI_ROOT_HUB_TT
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index cbf60a6..6d3c53c 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -64,6 +64,17 @@ static int ehci_mxc_setup(struct usb_hcd *hcd)
 	return 0;
 }
 
+static irqreturn_t mxc_ehci_irq(struct usb_hcd *hcd)
+{
+	struct mxc_usbh_platform_data *pdata;
+
+	pdata = hcd->self.controller->platform_data;
+	if (pdata->plt_irq_handler)
+		pdata->plt_irq_handler(pdata);
+
+	return ehci_irq(hcd);
+}
+
 static const struct hc_driver ehci_mxc_hc_driver = {
 	.description = hcd_name,
 	.product_desc = "Freescale On-Chip EHCI Host Controller",
@@ -72,7 +83,7 @@ static const struct hc_driver ehci_mxc_hc_driver = {
 	/*
 	 * generic hardware linkage
 	 */
-	.irq = ehci_irq,
+	.irq = mxc_ehci_irq,
 	.flags = HCD_USB2 | HCD_MEMORY,
 
 	/*
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index cb19260..d94e9e5 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -120,6 +120,8 @@ struct mxc_usbh_platform_data {
 
 	unsigned int		portsc;
 	struct otg_transceiver	*otg;
+	void (*plt_irq_handler)(struct mxc_usbh_platform_data *pdata);
+	void		*priv;
 };
 
 struct spi_device;
-- 
1.7.0.4
