From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 10 May 2014 15:27:01 +0530
Subject: [PATCH 4/6] usb: host: ehci-spear: Use devm_ioremap_resource instead
 of devm_ioremap
In-Reply-To: <1399715823-19839-1-git-send-email-gautam.vivek@samsung.com>
References: <1399715823-19839-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399715823-19839-5-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using devm_ioremap_resource() API should actually be preferred over
devm_ioremap(), since the former request the mem region first and then
gives back the ioremap'ed memory pointer.
devm_ioremap_resource() calls request_mem_region(), therby preventing
other drivers to make any overlapping call to the same region.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/host/ehci-spear.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index 8bd915b..6d84cf2 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -106,15 +106,8 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
-	if (!devm_request_mem_region(&pdev->dev, hcd->rsrc_start, hcd->rsrc_len,
-				driver->description)) {
-		retval = -EBUSY;
-		goto err_put_hcd;
-	}
-
-	hcd->regs = devm_ioremap(&pdev->dev, hcd->rsrc_start, hcd->rsrc_len);
+	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (hcd->regs == NULL) {
-		dev_dbg(&pdev->dev, "error mapping memory\n");
 		retval = -ENOMEM;
 		goto err_put_hcd;
 	}
-- 
1.7.10.4
