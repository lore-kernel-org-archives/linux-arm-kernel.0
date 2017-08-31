From: awallis@codeaurora.org (Adam Wallis)
Date: Thu, 31 Aug 2017 13:54:17 -0400
Subject: [PATCH] usb: host: xhci-plat: allow sysdev to inherit from ACPI
Message-ID: <1504202057-23634-1-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, xhci_plat is not set up properly when the parent device is an
ACPI node. The conditions that xhci_plat_probe should satisfy are

1. xhci_plat comes from firmware
2. xhci_plat is child of a device from firmware (dwc3-plat)
3. xhci_plat is grandchild of a pci device (dwc3-pci)

Case 2 is covered when the child is an OF node (by checking
sysdev->parent->of_node), however, an ACPI parent will return NULL in
the of_node check and will thus not result in sysdev being set to
sysdev->parent

[   17.591549] xhci-hcd: probe of xhci-hcd.6.auto failed with error -5

This change adds a check for ACPI to completely allow for condition 2.
This is done by first checking if the parent node is of type ACPI (e.g.,
dwc3-plat) and set sysdev to sysdev->parent if either of the two
following conditions are met:

1: If fwnode is empty (in the case that platform_device_add_properties
was not called on the allocated platform device)
2: fwnode exists but is not of type ACPI (this would happen if
platform_device_add_properties was called on the allocated device.
Instead of type FWNODE_ACPI, you would end up with FWNODE_PDATA)

Cc: stable at vger.kernel.org # 4.12.x
Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
 drivers/usb/host/xhci-plat.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c04144b..c4ac59a 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -163,6 +163,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	const struct hc_driver	*driver;
 	struct device		*sysdev;
+	struct device		*parent;
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd;
@@ -187,12 +188,17 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
 	 */
 	sysdev = &pdev->dev;
-	if (sysdev->parent && !sysdev->of_node && sysdev->parent->of_node)
-		sysdev = sysdev->parent;
+	parent = sysdev->parent;
+	if (parent && !sysdev->of_node && parent->of_node)
+		sysdev = parent;
+	else if (parent && is_acpi_device_node(parent->fwnode) &&
+		 (!sysdev->fwnode ||
+		 (sysdev->fwnode && !is_acpi_device_node(sysdev->fwnode))))
+		sysdev = parent;
 #ifdef CONFIG_PCI
-	else if (sysdev->parent && sysdev->parent->parent &&
-		 sysdev->parent->parent->bus == &pci_bus_type)
-		sysdev = sysdev->parent->parent;
+	else if (parent && parent->parent &&
+		 parent->parent->bus == &pci_bus_type)
+		sysdev = parent->parent;
 #endif
 
 	/* Try to set 64-bit DMA first */
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
