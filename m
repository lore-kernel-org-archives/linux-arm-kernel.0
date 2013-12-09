From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon,  9 Dec 2013 09:51:54 +0100
Subject: [PATCH v5 2/3] usb: ohci-at91: use dev variable instead of &pdev->dev
In-Reply-To: <1386579115-4324-1-git-send-email-b.brezillon@overkiz.com>
References: <1386579115-4324-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1386579115-4324-3-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the dev variable instead of referencing the dev field of the
pdev struct.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-at91.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 9dc50f8..8c0c4a4 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -152,7 +152,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 		return irq;
 	}
 
-	hcd = usb_create_hcd(driver, &pdev->dev, "at91");
+	hcd = usb_create_hcd(driver, dev, "at91");
 	if (!hcd)
 		return -ENOMEM;
 	hcd->rsrc_start = res->start;
@@ -164,28 +164,28 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 		goto err;
 	}
 
-	iclk = clk_get(&pdev->dev, "ohci_clk");
+	iclk = clk_get(dev, "ohci_clk");
 	if (IS_ERR(iclk)) {
-		dev_err(&pdev->dev, "failed to get ohci_clk\n");
+		dev_err(dev, "failed to get ohci_clk\n");
 		retval = PTR_ERR(iclk);
 		goto err;
 	}
-	fclk = clk_get(&pdev->dev, "uhpck");
+	fclk = clk_get(dev, "uhpck");
 	if (IS_ERR(fclk)) {
-		dev_err(&pdev->dev, "failed to get uhpck\n");
+		dev_err(dev, "failed to get uhpck\n");
 		retval = PTR_ERR(fclk);
 		goto err4;
 	}
-	hclk = clk_get(&pdev->dev, "hclk");
+	hclk = clk_get(dev, "hclk");
 	if (IS_ERR(hclk)) {
-		dev_err(&pdev->dev, "failed to get hclk\n");
+		dev_err(dev, "failed to get hclk\n");
 		retval = PTR_ERR(hclk);
 		goto err5;
 	}
 	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
-		uclk = clk_get(&pdev->dev, "usb_clk");
+		uclk = clk_get(dev, "usb_clk");
 		if (IS_ERR(uclk)) {
-			dev_err(&pdev->dev, "failed to get uclk\n");
+			dev_err(dev, "failed to get uclk\n");
 			retval = PTR_ERR(uclk);
 			goto err6;
 		}
-- 
1.7.9.5
