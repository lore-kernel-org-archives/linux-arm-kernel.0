From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon,  9 Dec 2013 09:51:53 +0100
Subject: [PATCH v5 1/3] usb: ohci-at91: replace request_mem_region + ioremap
 by devm_ioremap_resource
In-Reply-To: <1386579115-4324-1-git-send-email-b.brezillon@overkiz.com>
References: <1386579115-4324-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1386579115-4324-2-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the request_mem_region + ioremap calls by the
devm_ioremap_resource call which does the same things but with device
managed resources.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-at91.c |   27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 8c356af..9dc50f8 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -158,24 +158,17 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 
-	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
-		pr_debug("request_mem_region failed\n");
-		retval = -EBUSY;
-		goto err1;
-	}
-
-	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
-	if (!hcd->regs) {
-		pr_debug("ioremap failed\n");
-		retval = -EIO;
-		goto err2;
+	hcd->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(hcd->regs)) {
+		retval = PTR_ERR(hcd->regs);
+		goto err;
 	}
 
 	iclk = clk_get(&pdev->dev, "ohci_clk");
 	if (IS_ERR(iclk)) {
 		dev_err(&pdev->dev, "failed to get ohci_clk\n");
 		retval = PTR_ERR(iclk);
-		goto err3;
+		goto err;
 	}
 	fclk = clk_get(&pdev->dev, "uhpck");
 	if (IS_ERR(fclk)) {
@@ -219,13 +212,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
  err4:
 	clk_put(iclk);
 
- err3:
-	iounmap(hcd->regs);
-
- err2:
-	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
-
- err1:
+ err:
 	usb_put_hcd(hcd);
 	return retval;
 }
@@ -248,8 +235,6 @@ static void usb_hcd_at91_remove(struct usb_hcd *hcd,
 {
 	usb_remove_hcd(hcd);
 	at91_stop_hc(pdev);
-	iounmap(hcd->regs);
-	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
 
 	if (IS_ENABLED(CONFIG_COMMON_CLK))
-- 
1.7.9.5
