From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 28 Aug 2017 12:35:10 -0400
Subject: [PATCH V2] usb: dwc3: Initialize DMA ops/mask for xhci-hcd
Message-ID: <1503938110-23712-1-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma ops from the parent DWC device are not getting passed to the
child xhci-hcd device. This patch makes use of
platform_device_register_full to set the DMA ops. For the DT/OF case,
dma_ops were still null after the the device register, so
of_dma_configure is called in only the OF case.

Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
 drivers/usb/dwc3/host.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 76f0b0d..c289da1 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 #include "core.h"
 
@@ -56,6 +57,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 {
 	struct property_entry	props[3];
 	struct platform_device	*xhci;
+	struct platform_device_info dwc_plat_info = {};
 	int			ret, irq;
 	struct resource		*res;
 	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
@@ -79,22 +81,22 @@ int dwc3_host_init(struct dwc3 *dwc)
 	dwc->xhci_resources[1].flags = res->flags;
 	dwc->xhci_resources[1].name = res->name;
 
-	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
-	if (!xhci) {
-		dev_err(dwc->dev, "couldn't allocate xHCI device\n");
-		return -ENOMEM;
-	}
+	dwc_plat_info.name = "xhci-hcd";
+	dwc_plat_info.parent = dwc->sysdev;
+	dwc_plat_info.res = dwc->xhci_resources;
+	dwc_plat_info.num_res = DWC3_XHCI_RESOURCES_NUM;
+	dwc_plat_info.fwnode = dwc->sysdev->fwnode;
+	dwc_plat_info.dma_mask = *dwc->sysdev->dma_mask;
 
-	xhci->dev.parent	= dwc->dev;
+	xhci = platform_device_register_full(&dwc_plat_info);
+	if (IS_ERR(xhci)) {
+		dev_err(dwc->dev, "failed to register xHCI device\n");
+		return PTR_ERR(xhci);
+	}
 
 	dwc->xhci = xhci;
-
-	ret = platform_device_add_resources(xhci, dwc->xhci_resources,
-						DWC3_XHCI_RESOURCES_NUM);
-	if (ret) {
-		dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
-		goto err1;
-	}
+	if (dwc->sysdev->of_node)
+		of_dma_configure(&xhci->dev, dwc->sysdev->of_node);
 
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
 
@@ -117,7 +119,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 		ret = platform_device_add_properties(xhci, props);
 		if (ret) {
 			dev_err(dwc->dev, "failed to add properties to xHCI\n");
-			goto err1;
+			goto err;
 		}
 	}
 
@@ -126,19 +128,12 @@ int dwc3_host_init(struct dwc3 *dwc)
 	phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
 			  dev_name(dwc->dev));
 
-	ret = platform_device_add(xhci);
-	if (ret) {
-		dev_err(dwc->dev, "failed to register xHCI device\n");
-		goto err2;
-	}
-
 	return 0;
-err2:
+err:
 	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
 			  dev_name(dwc->dev));
 	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
 			  dev_name(dwc->dev));
-err1:
 	platform_device_put(xhci);
 	return ret;
 }
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
