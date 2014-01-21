From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 21 Jan 2014 16:48:35 +0100
Subject: [PATCH 2/2] ehci-platform: Add support for controllers with
 big-endian regs / descriptors
In-Reply-To: <1390319315-8391-1-git-send-email-hdegoede@redhat.com>
References: <1390319315-8391-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390319315-8391-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This uses the already documented devicetree booleans for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/host/Kconfig         |  3 +++
 drivers/usb/host/ehci-platform.c | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 237d7b1..4af41f3 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -256,6 +256,9 @@ config USB_EHCI_ATH79
 config USB_EHCI_HCD_PLATFORM
 	tristate "Generic EHCI driver for a platform device"
 	depends on !PPC_OF
+	# Support BE on architectures which have readl_be
+	select USB_EHCI_BIG_ENDIAN_DESC if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
+	select USB_EHCI_BIG_ENDIAN_MMIO if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
 	default n
 	---help---
 	  Adds an EHCI host driver for a generic platform device, which
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index d8aebc0..5888abb 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -55,8 +55,10 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 
 	hcd->has_tt = pdata->has_tt;
 	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
-	ehci->big_endian_desc = pdata->big_endian_desc;
-	ehci->big_endian_mmio = pdata->big_endian_mmio;
+	if (pdata->big_endian_desc)
+		ehci->big_endian_desc = 1;
+	if (pdata->big_endian_mmio)
+		ehci->big_endian_mmio = 1;
 
 	if (pdata->pre_setup) {
 		retval = pdata->pre_setup(hcd);
@@ -142,6 +144,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 	struct resource *res_mem;
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct ehci_platform_priv *priv;
+	struct ehci_hcd *ehci;
 	int err, irq, clk = 0;
 
 	if (usb_disabled())
@@ -177,8 +180,34 @@ static int ehci_platform_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, hcd);
 	dev->dev.platform_data = pdata;
 	priv = hcd_to_ehci_priv(hcd);
+	ehci = hcd_to_ehci(hcd);
 
 	if (pdata == &ehci_platform_defaults && dev->dev.of_node) {
+		if (of_property_read_bool(dev->dev.of_node, "big-endian-regs"))
+			ehci->big_endian_mmio = 1;
+
+		if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
+			ehci->big_endian_desc = 1;
+
+		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
+			ehci->big_endian_mmio = ehci->big_endian_desc = 1;
+
+#ifndef CONFIG_USB_EHCI_BIG_ENDIAN_MMIO
+		if (ehci->big_endian_mmio) {
+			dev_err(&dev->dev,
+				"Error big-endian-regs not compiled in\n");
+			err = -EINVAL;
+			goto err_put_hcd;
+		}
+#endif
+#ifndef CONFIG_USB_EHCI_BIG_ENDIAN_DESC
+		if (ehci->big_endian_desc) {
+			dev_err(&dev->dev,
+				"Error big-endian-desc not compiled in\n");
+			err = -EINVAL;
+			goto err_put_hcd;
+		}
+#endif
 		priv->phy = devm_phy_get(&dev->dev, "usb");
 		if (IS_ERR(priv->phy)) {
 			err = PTR_ERR(priv->phy);
-- 
1.8.5.3
