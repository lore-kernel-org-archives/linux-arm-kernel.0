From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 17 Dec 2011 20:26:33 +0100
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <201112172023.05519.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
Message-ID: <201112172026.34215.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the driver is also buildable as a module it should need
a cleanup function for the removal of the module.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/usb/gadget/s3c-hsudc.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index 3e5673d..7cb0850 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -1370,12 +1370,37 @@ err_res:
 	return ret;
 }
 
+static int __devexit s3c_hsudc_remove(struct platform_device *pdev)
+{
+	struct s3c_hsudc *hsudc = the_controller;
+
+	usb_del_gadget_udc(&hsudc->gadget);
+
+	clk_disable(hsudc->uclk);
+	clk_put(hsudc->uclk);
+
+	free_irq(hsudc->irq, hsudc);
+
+	iounmap(hsudc->regs);
+
+	release_resource(hsudc->mem_rsrc);
+	kfree(hsudc->mem_rsrc);
+
+	if (hsudc->transceiver)
+		otg_put_transceiver(hsudc->transceiver);
+
+	the_controller = NULL;
+	kfree(hsudc);
+	return 0;
+}
+
 static struct platform_driver s3c_hsudc_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c-hsudc",
 	},
 	.probe		= s3c_hsudc_probe,
+	.remove		= __devexit_p(s3c_hsudc_remove),
 };
 
 module_platform_driver(s3c_hsudc_driver);
-- 
1.7.2.3
