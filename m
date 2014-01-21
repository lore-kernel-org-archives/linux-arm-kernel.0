From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 21 Jan 2014 16:48:34 +0100
Subject: [PATCH 1/2] ohci-platform: Add support for controllers with
 big-endian regs / descriptors
Message-ID: <1390319315-8391-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note this commit uses the same devicetree booleans for this as the ones
already existing in the usb-ehci bindings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/usb/usb-ohci.txt |  3 +++
 drivers/usb/host/Kconfig                           |  4 ++++
 drivers/usb/host/ohci-platform.c                   | 27 ++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-ohci.txt b/Documentation/devicetree/bindings/usb/usb-ohci.txt
index f9d6c73..aa1d765 100644
--- a/Documentation/devicetree/bindings/usb/usb-ohci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ohci.txt
@@ -6,6 +6,9 @@ Required properties:
 - interrupts : ohci controller interrupt
 
 Optional properties:
+- big-endian-regs : boolean, set this for hcds with big-endian registers
+- big-endian-desc : boolean, set this for hcds with big-endian descriptors
+- big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
 - clocks : a list of phandle + clock specifier pairs
 - phys : phandle + phy specifier pair
 - phy-names : "usb"
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index e28cbe0..237d7b1 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -512,6 +512,10 @@ config USB_CNS3XXX_OHCI
 
 config USB_OHCI_HCD_PLATFORM
 	tristate "Generic OHCI driver for a platform device"
+	# Always support LE, support BE on architectures which have readl_be
+	select USB_OHCI_LITTLE_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_DESC if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
+	select USB_OHCI_BIG_ENDIAN_MMIO if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
 	default n
 	---help---
 	  Adds an OHCI host driver for a generic platform device, which
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index b2d0e1e..71e9d8e 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -128,6 +128,7 @@ static int ohci_platform_probe(struct platform_device *dev)
 	struct resource *res_mem;
 	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct ohci_platform_priv *priv;
+	struct ohci_hcd *ohci;
 	int err, irq, clk = 0;
 
 	if (usb_disabled())
@@ -164,8 +165,34 @@ static int ohci_platform_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, hcd);
 	dev->dev.platform_data = pdata;
 	priv = hcd_to_ohci_priv(hcd);
+	ohci = hcd_to_ohci(hcd);
 
 	if (pdata == &ohci_platform_defaults && dev->dev.of_node) {
+		if (of_property_read_bool(dev->dev.of_node, "big-endian-regs"))
+			ohci->flags |= OHCI_QUIRK_BE_MMIO;
+
+		if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
+			ohci->flags |= OHCI_QUIRK_BE_DESC;
+
+		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
+			ohci->flags |= OHCI_QUIRK_BE_MMIO | OHCI_QUIRK_BE_DESC;
+
+#ifndef CONFIG_USB_OHCI_BIG_ENDIAN_MMIO
+		if (ohci->flags & OHCI_QUIRK_BE_MMIO) {
+			dev_err(&dev->dev,
+				"Error big-endian-regs not compiled in\n");
+			err = -EINVAL;
+			goto err_put_hcd;
+		}
+#endif
+#ifndef CONFIG_USB_OHCI_BIG_ENDIAN_DESC
+		if (ohci->flags & OHCI_QUIRK_BE_DESC) {
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
