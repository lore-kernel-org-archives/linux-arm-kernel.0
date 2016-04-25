From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 25 Apr 2016 22:21:34 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
Message-ID: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now not all DMA paremters configured properly for "xhci-hcd" platform
device which is created manually. For example: dma_pfn_offset, dam_ops
and iommu configuration will not corresponds "dwc3" devices
configuration. As result, this will cause problems like wrong DMA
addresses translation on platforms with LPAE enabled like Keystone 2.

When platform is using DT boot mode the DMA configuration will be
parsed and applied from DT, so, to fix this issue, reuse
of_dma_configure() API and retrieve DMA configuartion for "xhci-hcd"
from DWC3 device node.

Cc: David Fisher <david.fisher1@synopsys.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/usb/dwc3/host.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index c679f63..93c8ef9 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -17,6 +17,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/usb/xhci_pdriver.h>
+#include <linux/of_device.h>
 
 #include "core.h"
 
@@ -32,12 +33,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 		return -ENOMEM;
 	}
 
-	dma_set_coherent_mask(&xhci->dev, dwc->dev->coherent_dma_mask);
-
 	xhci->dev.parent	= dwc->dev;
-	xhci->dev.dma_mask	= dwc->dev->dma_mask;
-	xhci->dev.dma_parms	= dwc->dev->dma_parms;
-
 	dwc->xhci = xhci;
 
 	ret = platform_device_add_resources(xhci, dwc->xhci_resources,
@@ -62,6 +58,15 @@ int dwc3_host_init(struct dwc3 *dwc)
 	phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
 			  dev_name(&xhci->dev));
 
+	if (IS_ENABLED(CONFIG_OF) && dwc->dev->of_node) {
+		of_dma_configure(&xhci->dev, dwc->dev->of_node);
+	} else {
+		dma_set_coherent_mask(&xhci->dev, dwc->dev->coherent_dma_mask);
+
+		xhci->dev.dma_mask	= dwc->dev->dma_mask;
+		xhci->dev.dma_parms	= dwc->dev->dma_parms;
+	}
+
 	ret = platform_device_add(xhci);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register xHCI device\n");
-- 
2.8.1
