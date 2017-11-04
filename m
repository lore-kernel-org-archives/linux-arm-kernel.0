From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 4 Nov 2017 22:08:04 +0100
Subject: [PATCH] usb: gadget: bcm63xx_udc: Use common error handling code in
 bcm63xx_udc_probe()
Message-ID: <73cacf30-3380-0a77-559c-1ad824fb88eb@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 4 Nov 2017 22:02:46 +0100

Add a jump target so that a specific error message is stored only once
at the end of this function implementation.
Replace two calls of the function "dev_err" by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/usb/gadget/udc/bcm63xx_udc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index f78503203f42..e3caae9c1ea9 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -2389,10 +2389,8 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 		goto out_uninit;
 	}
 	if (devm_request_irq(dev, irq, &bcm63xx_udc_ctrl_isr, 0,
-			     dev_name(dev), udc) < 0) {
-		dev_err(dev, "error requesting IRQ #%d\n", irq);
-		goto out_uninit;
-	}
+			     dev_name(dev), udc) < 0)
+		goto report_request_failure;
 
 	/* IRQ resources #1-6: data interrupts for IUDMA channels 0-5 */
 	for (i = 0; i < BCM63XX_NUM_IUDMA; i++) {
@@ -2402,10 +2400,8 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 			goto out_uninit;
 		}
 		if (devm_request_irq(dev, irq, &bcm63xx_udc_data_isr, 0,
-				     dev_name(dev), &udc->iudma[i]) < 0) {
-			dev_err(dev, "error requesting IRQ #%d\n", irq);
-			goto out_uninit;
-		}
+				     dev_name(dev), &udc->iudma[i]) < 0)
+			goto report_request_failure;
 	}
 
 	bcm63xx_udc_init_debugfs(udc);
@@ -2417,6 +2413,10 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 out_uninit:
 	bcm63xx_uninit_udc_hw(udc);
 	return rc;
+
+report_request_failure:
+	dev_err(dev, "error requesting IRQ #%d\n", irq);
+	goto out_uninit;
 }
 
 /**
-- 
2.15.0
