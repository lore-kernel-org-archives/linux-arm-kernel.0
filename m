From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Tue, 5 Sep 2017 14:21:08 +0300
Subject: [PATCH] usb: host: xhci-plat: allow sysdev to inherit from ACPI
In-Reply-To: <1504202057-23634-1-git-send-email-awallis@codeaurora.org>
References: <1504202057-23634-1-git-send-email-awallis@codeaurora.org>
Message-ID: <59AE88A4.8070206@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.08.2017 20:54, Adam Wallis wrote:
> Currently, xhci_plat is not set up properly when the parent device is an
> ACPI node. The conditions that xhci_plat_probe should satisfy are
>
> 1. xhci_plat comes from firmware
> 2. xhci_plat is child of a device from firmware (dwc3-plat)
> 3. xhci_plat is grandchild of a pci device (dwc3-pci)
>
> Case 2 is covered when the child is an OF node (by checking
> sysdev->parent->of_node), however, an ACPI parent will return NULL in
> the of_node check and will thus not result in sysdev being set to
> sysdev->parent
>
> [   17.591549] xhci-hcd: probe of xhci-hcd.6.auto failed with error -5
>
> This change adds a check for ACPI to completely allow for condition 2.
> This is done by first checking if the parent node is of type ACPI (e.g.,
> dwc3-plat) and set sysdev to sysdev->parent if either of the two
> following conditions are met:
>
> 1: If fwnode is empty (in the case that platform_device_add_properties
> was not called on the allocated platform device)
> 2: fwnode exists but is not of type ACPI (this would happen if
> platform_device_add_properties was called on the allocated device.
> Instead of type FWNODE_ACPI, you would end up with FWNODE_PDATA)
>
> Cc: stable at vger.kernel.org # 4.12.x
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---

Thang Q. Nguyen  (in CC) proposed a patch for the same issue earlier,

I just replied to his patch with a new proposal (added you to CC)

Basically replace it all with:

-       sysdev = &pdev->dev;
-       if (sysdev->parent && !sysdev->of_node && sysdev->parent->of_node)
-               sysdev = sysdev->parent;
-#ifdef CONFIG_PCI
-       else if (sysdev->parent && sysdev->parent->parent &&
-                sysdev->parent->parent->bus == &pci_bus_type)
-               sysdev = sysdev->parent->parent;
-#endif
+
+       for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
+               if (is_of_node(sysdev->fwnode) ||
+                   is_acpi_device_node(sysdev->fwnode))
+                       break;
+       #ifdef CONFIG_PCI
+               else if (sysdev->bus == &pci_bus_type)
+                       break;
+       #endif
+       }
+
+       if (!sysdev)
+               sysdev = &pdev->dev;

-Mathias
