From: awallis@codeaurora.org (Adam Wallis)
Date: Tue,  5 Sep 2017 11:07:39 -0400
Subject: [PATCH V3] usb: host: xhci-plat: allow sysdev to inherit from ACPI
Message-ID: <1504624059-2004-1-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4c39d4b949d3 ("usb: xhci: use bus->sysdev for DMA configuration")
updated the method determining DMA for XHCI from sysdev. However, this
patch broke the ability to enumerate the FWNODE from parent ACPI devices
from the child plat XHCI device.

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

Cc: stable at vger.kernel.org #4.12.x
Cc: stable at vger.kernel.org #4.13.x

Fixes: 4c39d4b949d3 ("usb: xhci: use bus->sysdev for DMA configuration")
Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
Changes in v3: Add "fixes" to commit message per greg k-h
Changes in v2: Incorporate the simplified fwnode check as suggested
by Mathias

 drivers/usb/host/xhci-plat.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c04144b..2087407 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -186,14 +186,18 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	 * 2. xhci_plat is child of a device from firmware (dwc3-plat)
 	 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
 	 */
-	sysdev = &pdev->dev;
-	if (sysdev->parent && !sysdev->of_node && sysdev->parent->of_node)
-		sysdev = sysdev->parent;
+	for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
+		if (is_of_node(sysdev->fwnode) ||
+			is_acpi_device_node(sysdev->fwnode))
+			break;
 #ifdef CONFIG_PCI
-	else if (sysdev->parent && sysdev->parent->parent &&
-		 sysdev->parent->parent->bus == &pci_bus_type)
-		sysdev = sysdev->parent->parent;
+		else if (sysdev->bus == &pci_bus_type)
+			break;
 #endif
+	}
+
+	if (!sysdev)
+		sysdev = &pdev->dev;
 
 	/* Try to set 64-bit DMA first */
 	if (WARN_ON(!sysdev->dma_mask))
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
