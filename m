From: rogerq@ti.com (Roger Quadros)
Date: Mon, 4 Feb 2013 17:58:52 +0200
Subject: [PATCH 05/13] USB: ehci-omap: Get platform resources by index rather
 than by name
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Message-ID: <1359993540-20780-6-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there is only one resource per type we don't really need
to use resource name to obtain it. This also also makes it easier
for device tree adaptation.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/host/ehci-omap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 60c4a2d..5a831aef 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -148,14 +148,13 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
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
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs)) {
 		dev_err(dev, "Resource request/ioremap failed\n");
-- 
1.7.4.1
