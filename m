From: rogerq@ti.com (Roger Quadros)
Date: Mon, 28 Jan 2013 13:30:10 +0200
Subject: [PATCH 09/30] USB: ehci-omap: Use devm_request_and_ioremap()
In-Reply-To: <1359372631-8180-1-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
Message-ID: <1359372631-8180-10-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of devm_request_and_ioremap() and correct comment.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/host/ehci-omap.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 30fc482..fd2f5450 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -216,23 +216,17 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	res =  platform_get_resource_byname(pdev,
 				IORESOURCE_MEM, "ehci");
-	if (!res) {
-		dev_err(dev, "UHH EHCI get resource failed\n");
-		return -ENODEV;
-	}
-
-	regs = ioremap(res->start, resource_size(res));
+	regs = devm_request_and_ioremap(dev, res);
 	if (!regs) {
-		dev_err(dev, "UHH EHCI ioremap failed\n");
-		return -ENOMEM;
+		dev_err(dev, "Resource request/ioremap failed\n");
+		return -EADDRNOTAVAIL;
 	}
 
 	hcd = usb_create_hcd(&ehci_omap_hc_driver, dev,
 			dev_name(dev));
 	if (!hcd) {
-		dev_err(dev, "failed to create hcd with err %d\n", ret);
-		ret = -ENOMEM;
-		goto err_io;
+		dev_err(dev, "Failed to create HCD\n");
+		return -ENOMEM;
 	}
 
 	hcd->rsrc_start = res->start;
@@ -285,8 +279,6 @@ err_pm_runtime:
 	pm_runtime_put_sync(dev);
 	usb_put_hcd(hcd);
 
-err_io:
-	iounmap(regs);
 	return ret;
 }
 
@@ -306,7 +298,6 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 
 	usb_remove_hcd(hcd);
 	disable_put_regulator(dev->platform_data);
-	iounmap(hcd->regs);
 	usb_put_hcd(hcd);
 
 	pm_runtime_put_sync(dev);
-- 
1.7.4.1
