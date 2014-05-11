From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 11 May 2014 20:17:50 +0200
Subject: [PATCHv5 02/20] usb: ehci-orion: rename error goto labels in
 ehci_orion_drv_probe()
In-Reply-To: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399832288-19899-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to the introduction of additional initialization steps
in ehci_orion_drv_probe(), we rename the error goto labels from err1,
err2 and err3 names to some more meaningful names.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-orion.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 7728e83..9298be7 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -160,7 +160,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 			"Found HC with no IRQ. Check %s setup!\n",
 			dev_name(&pdev->dev));
 		err = -ENODEV;
-		goto err1;
+		goto err;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -169,7 +169,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 			"Found HC with no register addr. Check %s setup!\n",
 			dev_name(&pdev->dev));
 		err = -ENODEV;
-		goto err1;
+		goto err;
 	}
 
 	/*
@@ -179,12 +179,12 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	 */
 	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err)
-		goto err1;
+		goto err;
 
 	regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(regs)) {
 		err = PTR_ERR(regs);
-		goto err1;
+		goto err;
 	}
 
 	/* Not all platforms can gate the clock, so it is not
@@ -197,7 +197,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 			&pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
 		err = -ENOMEM;
-		goto err2;
+		goto err_create_hcd;
 	}
 
 	hcd->rsrc_start = res->start;
@@ -237,17 +237,17 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err)
-		goto err3;
+		goto err_add_hcd;
 
 	device_wakeup_enable(hcd->self.controller);
 	return 0;
 
-err3:
+err_add_hcd:
 	usb_put_hcd(hcd);
-err2:
+err_create_hcd:
 	if (!IS_ERR(clk))
 		clk_disable_unprepare(clk);
-err1:
+err:
 	dev_err(&pdev->dev, "init %s fail, %d\n",
 		dev_name(&pdev->dev), err);
 
-- 
1.9.2
