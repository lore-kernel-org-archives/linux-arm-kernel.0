From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 19 Dec 2011 14:27:07 +0100
Subject: [PATCH 6/7] s3c-hsudc: Add regulator handling
In-Reply-To: <201112191423.21461.heiko@sntech.de>
References: <201112191423.21461.heiko@sntech.de>
Message-ID: <201112191427.07682.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The udc has three supplies: vdda (3.3V), vddi (1.2V) and vddosc (1.8-3.3V).
Turn these on and off on start and stop calls.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/usb/gadget/s3c-hsudc.c |   41 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index daaccec..d6544f6 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -29,6 +29,7 @@
 #include <linux/usb/otg.h>
 #include <linux/prefetch.h>
 #include <linux/usb/s3c-hsudc.h>
+#include <linux/regulator/consumer.h>
 
 #include <mach/regs-s3c2443-clock.h>
 
@@ -87,6 +88,12 @@
 #define DATA_STATE_XMIT			(1)
 #define DATA_STATE_RECV			(2)
 
+static const char * const s3c_hsudc_supply_names[] = {
+	"vdda",		/* analog phy supply, 3.3V */
+	"vddi",		/* digital phy supply, 1.2V */
+	"vddosc",	/* oscillator supply, 1.8V - 3.3V */
+};
+
 /**
  * struct s3c_hsudc_ep - Endpoint representation used by driver.
  * @ep: USB gadget layer representation of device endpoint.
@@ -139,6 +146,7 @@ struct s3c_hsudc {
 	struct device *dev;
 	struct s3c24xx_hsudc_platdata *pd;
 	struct otg_transceiver *transceiver;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(s3c_hsudc_supply_names)];
 	spinlock_t lock;
 	void __iomem *regs;
 	struct resource *mem_rsrc;
@@ -1150,15 +1158,20 @@ static int s3c_hsudc_start(struct usb_gadget *g,
 	hsudc->driver = driver;
 	hsudc->gadget.dev.driver = &driver->driver;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(hsudc->supplies),
+				    hsudc->supplies);
+	if (ret != 0) {
+		dev_err(hsudc->dev, "failed to enable supplies: %d\n", ret);
+		goto err_supplies;
+	}
+
 	/* connect to bus through transceiver */
 	if (hsudc->transceiver) {
 		ret = otg_set_peripheral(hsudc->transceiver, &hsudc->gadget);
 		if (ret) {
 			dev_err(hsudc->dev, "%s: can't bind to transceiver\n",
 					hsudc->gadget.name);
-			hsudc->driver = NULL;
-			hsudc->gadget.dev.driver = NULL;
-			return ret;
+			goto err_otg;
 		}
 	}
 
@@ -1171,6 +1184,12 @@ static int s3c_hsudc_start(struct usb_gadget *g,
 		hsudc->pd->gpio_init();
 
 	return 0;
+err_otg:
+	regulator_bulk_disable(ARRAY_SIZE(hsudc->supplies), hsudc->supplies);
+err_supplies:
+	hsudc->driver = NULL;
+	hsudc->gadget.dev.driver = NULL;
+	return ret;
 }
 
 static int s3c_hsudc_stop(struct usb_gadget *g,
@@ -1200,6 +1219,8 @@ static int s3c_hsudc_stop(struct usb_gadget *g,
 
 	disable_irq(hsudc->irq);
 
+	regulator_bulk_disable(ARRAY_SIZE(hsudc->supplies), hsudc->supplies);
+
 	dev_info(hsudc->dev, "unregistered gadget driver '%s'\n",
 			driver->driver.name);
 	return 0;
@@ -1241,7 +1262,7 @@ static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct s3c_hsudc *hsudc;
 	struct s3c24xx_hsudc_platdata *pd = pdev->dev.platform_data;
-	int ret;
+	int ret, i;
 
 	hsudc = kzalloc(sizeof(struct s3c_hsudc) +
 			sizeof(struct s3c_hsudc_ep) * pd->epnum,
@@ -1258,6 +1279,16 @@ static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
 
 	hsudc->transceiver = otg_get_transceiver();
 
+	for (i = 0; i < ARRAY_SIZE(hsudc->supplies); i++)
+		hsudc->supplies[i].supply = s3c_hsudc_supply_names[i];
+
+	ret = regulator_bulk_get(dev, ARRAY_SIZE(hsudc->supplies),
+				 hsudc->supplies);
+	if (ret != 0) {
+		dev_err(dev, "failed to request supplies: %d\n", ret);
+		goto err_supplies;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "unable to obtain driver resource data\n");
@@ -1352,6 +1383,8 @@ err_res:
 	if (hsudc->transceiver)
 		otg_put_transceiver(hsudc->transceiver);
 
+	regulator_bulk_free(ARRAY_SIZE(hsudc->supplies), hsudc->supplies);
+err_supplies:
 	kfree(hsudc);
 	return ret;
 }
-- 
1.7.5.4
