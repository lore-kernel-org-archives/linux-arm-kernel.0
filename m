From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 10 May 2014 15:26:59 +0530
Subject: [PATCH 2/6] usb: host: ehci-msm: Use devm_ioremap_resource instead of
 devm_ioremap
In-Reply-To: <1399715823-19839-1-git-send-email-gautam.vivek@samsung.com>
References: <1399715823-19839-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399715823-19839-3-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using devm_ioremap_resource() API should actually be preferred over
devm_ioremap(), since the former request the mem region first and then
gives back the ioremap'ed memory pointer.
devm_ioremap_resource() calls request_mem_region(), therby preventing
other drivers to make any overlapping call to the same region.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/host/ehci-msm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index f341651..99989aa 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -96,9 +96,8 @@ static int ehci_msm_probe(struct platform_device *pdev)
 
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
-	hcd->regs = devm_ioremap(&pdev->dev, hcd->rsrc_start, hcd->rsrc_len);
+	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (!hcd->regs) {
-		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
 		goto put_hcd;
 	}
-- 
1.7.10.4
