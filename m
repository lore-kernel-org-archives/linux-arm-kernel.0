From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 10 May 2014 17:30:09 +0530
Subject: [PATCH v2 5/6] usb: host: ehci-tegra: Use devm_ioremap_resource
 instead of devm_ioremap
In-Reply-To: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
References: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399723210-21569-6-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using devm_ioremap_resource() API should actually be preferred over
devm_ioremap(), since the former request the mem region first and then
gives back the ioremap'ed memory pointer.
devm_ioremap_resource() calls request_mem_region(), therby preventing
other drivers to make any overlapping call to the same region.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/host/ehci-tegra.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 572634c..6fdcb8a 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -411,10 +411,9 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 	}
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
-	hcd->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!hcd->regs) {
-		dev_err(&pdev->dev, "Failed to remap I/O memory\n");
-		err = -ENOMEM;
+	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hcd->regs)) {
+		err = PTR_ERR(hcd->regs);
 		goto cleanup_clk_en;
 	}
 	ehci->caps = hcd->regs + 0x100;
-- 
1.7.10.4
