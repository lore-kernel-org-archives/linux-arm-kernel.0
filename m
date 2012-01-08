From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 8 Jan 2012 21:58:28 +0100
Subject: [PATCH 2/3] s3c-hsudc: add basic runtime_pm calls
In-Reply-To: <201201082156.44142.heiko@sntech.de>
References: <201201082156.44142.heiko@sntech.de>
Message-ID: <201201082158.28694.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will enable the system to check for activity of the usb gadget
and also in a later patch to control the usbphy power-domain.
When handling the power domain there, it will be possible to remove
another reference to architecture code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/usb/gadget/s3c-hsudc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index 41b3a58..5e87293 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -30,6 +30,7 @@
 #include <linux/prefetch.h>
 #include <linux/platform_data/s3c-hsudc.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 
 #include <mach/regs-s3c2443-clock.h>
 
@@ -1178,6 +1179,9 @@ static int s3c_hsudc_start(struct usb_gadget *gadget,
 	dev_info(hsudc->dev, "bound driver %s\n", driver->driver.name);
 
 	s3c_hsudc_reconfig(hsudc);
+
+	pm_runtime_get_sync(hsudc->dev);
+
 	s3c_hsudc_init_phy();
 	if (hsudc->pd->gpio_init)
 		hsudc->pd->gpio_init();
@@ -1208,6 +1212,9 @@ static int s3c_hsudc_stop(struct usb_gadget *gadget,
 	hsudc->gadget.dev.driver = NULL;
 	hsudc->gadget.speed = USB_SPEED_UNKNOWN;
 	s3c_hsudc_uninit_phy();
+
+	pm_runtime_put(hsudc->dev);
+
 	if (hsudc->pd->gpio_uninit)
 		hsudc->pd->gpio_uninit();
 	s3c_hsudc_stop_activity(hsudc);
@@ -1362,6 +1369,8 @@ static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add_udc;
 
+	pm_runtime_enable(dev);
+
 	return 0;
 err_add_udc:
 	device_unregister(&hsudc->gadget.dev);
-- 
1.7.2.3
