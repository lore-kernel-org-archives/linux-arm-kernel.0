From: rogerq@ti.com (Roger Quadros)
Date: Thu, 7 Feb 2013 18:02:45 +0200
Subject: [PATCH v2 05/14] USB: ehci-omap: Get platform resources by index
 rather than by name
In-Reply-To: <1360252974-7912-1-git-send-email-rogerq@ti.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
Message-ID: <1360252974-7912-6-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there is only one resource per type we don't really need
to use resource name to obtain it. This also also makes it easier
for device tree adaptation.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-omap.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 0aa12f6..02a7893 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -148,16 +148,15 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_irq_byname(pdev, "ehci-irq");
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "EHCI irq failed\n");
 		return -ENODEV;
 	}
 
-	res =  platform_get_resource_byname(pdev,
-				IORESOURCE_MEM, "ehci");
+	res =  platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_request_and_ioremap(dev, res);
-	if (!regs) {
+	if (IS_ERR(regs)) {
 		dev_err(dev, "Resource request/ioremap failed\n");
 		return -EADDRNOTAVAIL;
 	}
-- 
1.7.4.1
