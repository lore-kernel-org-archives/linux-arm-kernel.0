From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 10 May 2014 17:30:08 +0530
Subject: [PATCH v2 4/6] usb: host: ehci-spear: Use devm_ioremap_resource
 instead of devm_ioremap
In-Reply-To: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
References: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399723210-21569-5-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using devm_ioremap_resource() API should actually be preferred over
devm_ioremap(), since the former request the mem region first and then
gives back the ioremap'ed memory pointer.
devm_ioremap_resource() calls request_mem_region(), therby preventing
other drivers to make any overlapping call to the same region.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/host/ehci-spear.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index 8bd915b..1d59958 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -106,16 +106,9 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
-	if (!devm_request_mem_region(&pdev->dev, hcd->rsrc_start, hcd->rsrc_len,
-				driver->description)) {
-		retval = -EBUSY;
-		goto err_put_hcd;
-	}
-
-	hcd->regs = devm_ioremap(&pdev->dev, hcd->rsrc_start, hcd->rsrc_len);
-	if (hcd->regs == NULL) {
-		dev_dbg(&pdev->dev, "error mapping memory\n");
-		retval = -ENOMEM;
+	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hcd->regs)) {
+		retval = PTR_ERR(hcd->regs);
 		goto err_put_hcd;
 	}
 
-- 
1.7.10.4
