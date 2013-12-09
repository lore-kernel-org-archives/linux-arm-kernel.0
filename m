From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon,  9 Dec 2013 09:51:55 +0100
Subject: [PATCH v5 3/3] usb: ohci-at91: use device managed clk retrieval
In-Reply-To: <1386579115-4324-1-git-send-email-b.brezillon@overkiz.com>
References: <1386579115-4324-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1386579115-4324-4-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clk_get calls by devm_clk_get calls.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-at91.c |   30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 8c0c4a4..9aa485e 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -164,30 +164,30 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 		goto err;
 	}
 
-	iclk = clk_get(dev, "ohci_clk");
+	iclk = devm_clk_get(dev, "ohci_clk");
 	if (IS_ERR(iclk)) {
 		dev_err(dev, "failed to get ohci_clk\n");
 		retval = PTR_ERR(iclk);
 		goto err;
 	}
-	fclk = clk_get(dev, "uhpck");
+	fclk = devm_clk_get(dev, "uhpck");
 	if (IS_ERR(fclk)) {
 		dev_err(dev, "failed to get uhpck\n");
 		retval = PTR_ERR(fclk);
-		goto err4;
+		goto err;
 	}
-	hclk = clk_get(dev, "hclk");
+	hclk = devm_clk_get(dev, "hclk");
 	if (IS_ERR(hclk)) {
 		dev_err(dev, "failed to get hclk\n");
 		retval = PTR_ERR(hclk);
-		goto err5;
+		goto err;
 	}
 	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
-		uclk = clk_get(dev, "usb_clk");
+		uclk = devm_clk_get(dev, "usb_clk");
 		if (IS_ERR(uclk)) {
 			dev_err(dev, "failed to get uclk\n");
 			retval = PTR_ERR(uclk);
-			goto err6;
+			goto err;
 		}
 	}
 
@@ -203,15 +203,6 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	/* Error handling */
 	at91_stop_hc(pdev);
 
-	if (IS_ENABLED(CONFIG_COMMON_CLK))
-		clk_put(uclk);
- err6:
-	clk_put(hclk);
- err5:
-	clk_put(fclk);
- err4:
-	clk_put(iclk);
-
  err:
 	usb_put_hcd(hcd);
 	return retval;
@@ -236,13 +227,6 @@ static void usb_hcd_at91_remove(struct usb_hcd *hcd,
 	usb_remove_hcd(hcd);
 	at91_stop_hc(pdev);
 	usb_put_hcd(hcd);
-
-	if (IS_ENABLED(CONFIG_COMMON_CLK))
-		clk_put(uclk);
-	clk_put(hclk);
-	clk_put(fclk);
-	clk_put(iclk);
-	fclk = iclk = hclk = NULL;
 }
 
 /*-------------------------------------------------------------------------*/
-- 
1.7.9.5
