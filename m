From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  8 Dec 2011 16:32:00 +0100
Subject: [PATCH 1/2] usb: at91: fix clk_get error handling
Message-ID: <1323358321-19918-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-usb at vger.kernel.org
---
Hi,

	can we apply via at91 as it's depend on patch already on arm-soc

Best Regarfds,
J.
 drivers/usb/host/ohci-at91.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 5df0b0e..dc33517 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -139,8 +139,23 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	}
 
 	iclk = clk_get(&pdev->dev, "ohci_clk");
+	if (IS_ERR(iclk)) {
+		dev_err(&pdev->dev, "failed to get ohci_clk\n");
+		retval = PTR_ERR(iclk);
+		goto err3;
+	}
 	fclk = clk_get(&pdev->dev, "uhpck");
+	if (IS_ERR(fclk)) {
+		dev_err(&pdev->dev, "failed to get uhpck\n");
+		retval = PTR_ERR(fclk);
+		goto err4;
+	}
 	hclk = clk_get(&pdev->dev, "hclk");
+	if (IS_ERR(hclk)) {
+		dev_err(&pdev->dev, "failed to get hclk\n");
+		retval = PTR_ERR(hclk);
+		goto err5;
+	}
 
 	at91_start_hc(pdev);
 	ohci_hcd_init(hcd_to_ohci(hcd));
@@ -153,9 +168,12 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	at91_stop_hc(pdev);
 
 	clk_put(hclk);
+ err5:
 	clk_put(fclk);
+ err4:
 	clk_put(iclk);
 
+ err3:
 	iounmap(hcd->regs);
 
  err2:
-- 
1.7.7
