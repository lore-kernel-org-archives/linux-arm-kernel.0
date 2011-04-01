From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri,  1 Apr 2011 17:56:25 +0400
Subject: [PATCH 4/7] pxa25x: separate lubbock handling to lubbock-usb
	transceiver
In-Reply-To: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
References: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1301666188-11822-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move all handling of lubbock board to separate lubbock-usb transceiver,
removing cruft from pxa25x_udc.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/gadget/pxa25x_udc.c |   74 ----------------
 drivers/usb/otg/Kconfig         |    8 ++
 drivers/usb/otg/Makefile        |    1 +
 drivers/usb/otg/lubbock-usb.c   |  178 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 74 deletions(-)
 create mode 100644 drivers/usb/otg/lubbock-usb.c

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index 444b60a..6cb32b8 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -65,10 +65,6 @@
 #include <mach/pxa25x-udc.h>
 #endif
 
-#ifdef CONFIG_ARCH_LUBBOCK
-#include <mach/lubbock.h>
-#endif
-
 #include <asm/mach/udc_pxa2xx.h>
 
 
@@ -1383,42 +1379,6 @@ EXPORT_SYMBOL(usb_gadget_unregister_driver);
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_LUBBOCK
-
-/* Lubbock has separate connect and disconnect irqs.  More typical designs
- * use one GPIO as the VBUS IRQ, and another to control the D+ pullup.
- */
-
-static irqreturn_t
-lubbock_vbus_irq(int irq, void *_dev)
-{
-	struct pxa25x_udc	*dev = _dev;
-	int			vbus;
-
-	dev->stats.irqs++;
-	switch (irq) {
-	case LUBBOCK_USB_IRQ:
-		vbus = 1;
-		disable_irq(LUBBOCK_USB_IRQ);
-		enable_irq(LUBBOCK_USB_DISC_IRQ);
-		break;
-	case LUBBOCK_USB_DISC_IRQ:
-		vbus = 0;
-		disable_irq(LUBBOCK_USB_DISC_IRQ);
-		enable_irq(LUBBOCK_USB_IRQ);
-		break;
-	default:
-		return IRQ_NONE;
-	}
-
-	pxa25x_udc_vbus_session(&dev->gadget, vbus);
-	return IRQ_HANDLED;
-}
-
-#endif
-
-
-/*-------------------------------------------------------------------------*/
 
 static inline void clear_ep_state (struct pxa25x_udc *dev)
 {
@@ -2206,38 +2166,10 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 	}
 	dev->got_irq = 1;
 
-#ifdef CONFIG_ARCH_LUBBOCK
-	if (machine_is_lubbock()) {
-		retval = request_irq(LUBBOCK_USB_DISC_IRQ,
-				lubbock_vbus_irq,
-				IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
-				driver_name, dev);
-		if (retval != 0) {
-			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, LUBBOCK_USB_DISC_IRQ, retval);
-lubbock_fail0:
-			goto err_irq_lub;
-		}
-		retval = request_irq(LUBBOCK_USB_IRQ,
-				lubbock_vbus_irq,
-				IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
-				driver_name, dev);
-		if (retval != 0) {
-			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, LUBBOCK_USB_IRQ, retval);
-			free_irq(LUBBOCK_USB_DISC_IRQ, dev);
-			goto lubbock_fail0;
-		}
-	} else
-#endif
 	create_debug_files(dev);
 
 	return 0;
 
-#ifdef	CONFIG_ARCH_LUBBOCK
-	free_irq(LUBBOCK_USB_DISC_IRQ, dev);
- err_irq_lub:
-#endif
 	free_irq(irq, dev);
  err_irq1:
 	if (gpio_is_valid(dev->mach->gpio_pullup))
@@ -2273,12 +2205,6 @@ static int __exit pxa25x_udc_remove(struct platform_device *pdev)
 		free_irq(platform_get_irq(pdev, 0), dev);
 		dev->got_irq = 0;
 	}
-#ifdef CONFIG_ARCH_LUBBOCK
-	if (machine_is_lubbock()) {
-		free_irq(LUBBOCK_USB_DISC_IRQ, dev);
-		free_irq(LUBBOCK_USB_IRQ, dev);
-	}
-#endif
 	if (gpio_is_valid(dev->mach->gpio_pullup))
 		gpio_free(dev->mach->gpio_pullup);
 
diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index daf3e5f..7ddfc54 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -122,4 +122,12 @@ config AB8500_USB
           This transceiver supports high and full speed devices plus,
           in host mode, low speed.
 
+config LUBBOCK_USB
+	tristate "Intel DBPXA250 (Lubbock) Tranceiver Driver"
+	depends on ARCH_LUBBOCK
+        select USB_OTG_UTILS
+	help
+	  Enable this to support the USB UDC connectivity on Intel DBPXA250
+	  development platform (so-called Lubbock).
+
 endif # USB || OTG
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index e22d917..5ed42cd 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_USB_ULPI)		+= ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)	+= ulpi_viewport.o
 obj-$(CONFIG_USB_MSM_OTG)	+= msm_otg.o
 obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
+obj-$(CONFIG_LUBBOCK_USB)	+= lubbock-usb.o
diff --git a/drivers/usb/otg/lubbock-usb.c b/drivers/usb/otg/lubbock-usb.c
new file mode 100644
index 0000000..d18c101
--- /dev/null
+++ b/drivers/usb/otg/lubbock-usb.c
@@ -0,0 +1,178 @@
+/*
+ * Intel DBPXA250 Development Platform USB UDC support
+ *
+ * Copyright (C) 2011 Dmitry Eremin-Solenikov
+ *
+ * Based on pxa25x_udc driver:
+ * Copyright (C) 2002 Intrinsyc, Inc. (Frank Becker)
+ * Copyright (C) 2003 Robert Schwebel, Pengutronix
+ * Copyright (C) 2003 Benedikt Spranger, Pengutronix
+ * Copyright (C) 2003 David Brownell
+ * Copyright (C) 2003 Joshua Wise
+ *
+ * Largely based on lubbock-usb-xceiv:
+ * Copyright (C) 2009 Texas Instruments Inc
+ */
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/usb.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+
+#include <mach/lubbock.h>
+
+static int lubbock_udc_is_connected(void)
+{
+	return (LUB_MISC_RD & (1 << 9)) == 0;
+}
+
+static int lubbock_set_peripheral(struct otg_transceiver *lubbock,
+		struct usb_gadget *gadget)
+{
+	if (!lubbock)
+		return -ENODEV;
+
+	if (!gadget) {
+		lubbock->gadget = NULL;
+		return 0;
+	}
+
+	lubbock->gadget = gadget;
+	lubbock->state = OTG_STATE_B_IDLE;
+	if (lubbock_udc_is_connected()) {
+		lubbock->state = OTG_STATE_B_PERIPHERAL;
+		usb_gadget_vbus_connect(lubbock->gadget);
+	}
+
+	return 0;
+}
+
+/* Lubbock has separate connect and disconnect irqs.  More typical designs
+ * use one GPIO as the VBUS IRQ, and another to control the D+ pullup.
+ */
+
+static irqreturn_t
+lubbock_vbus_irq(int irq, void *_dev)
+{
+	struct otg_transceiver *lubbock = _dev;
+	switch (irq) {
+	case LUBBOCK_USB_IRQ:
+		lubbock->state = OTG_STATE_B_PERIPHERAL;
+		usb_gadget_vbus_connect(lubbock->gadget);
+
+		disable_irq(LUBBOCK_USB_IRQ);
+		enable_irq(LUBBOCK_USB_DISC_IRQ);
+		break;
+	case LUBBOCK_USB_DISC_IRQ:
+		usb_gadget_vbus_disconnect(lubbock->gadget);
+		lubbock->state = OTG_STATE_B_IDLE;
+
+		disable_irq(LUBBOCK_USB_DISC_IRQ);
+		enable_irq(LUBBOCK_USB_IRQ);
+		break;
+	default:
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+static int __devinit lubbock_usb_xceiv_probe(struct platform_device *pdev)
+{
+	struct otg_transceiver	*lubbock;
+	int err;
+
+	lubbock = kzalloc(sizeof *lubbock, GFP_KERNEL);
+	if (!lubbock)
+		return -ENOMEM;
+
+	lubbock->dev		= &pdev->dev;
+	lubbock->label		= "lubbock-xceiv";
+	lubbock->state		= OTG_STATE_UNDEFINED;
+	lubbock->set_peripheral	= lubbock_set_peripheral;
+
+	err = request_irq(LUBBOCK_USB_DISC_IRQ,
+			lubbock_vbus_irq,
+			IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
+			lubbock->label, lubbock);
+	if (err != 0) {
+		pr_err("%s: can't get irq %i, err %d\n",
+			lubbock->label, LUBBOCK_USB_DISC_IRQ, err);
+		goto err_irq_lub;
+	}
+	err = request_irq(LUBBOCK_USB_IRQ,
+			lubbock_vbus_irq,
+			IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
+			lubbock->label, lubbock);
+	if (err != 0) {
+		pr_err("%s: can't get irq %i, err %d\n",
+			lubbock->label, LUBBOCK_USB_IRQ, err);
+		goto err_irq_lub2;
+	}
+
+	err = otg_set_transceiver(lubbock);
+	if (err) {
+		dev_err(&pdev->dev, "can't register transceiver, err: %d\n",
+			err);
+		goto exit;
+	}
+
+	platform_set_drvdata(pdev, lubbock);
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&lubbock->notifier);
+
+	return 0;
+exit:
+	free_irq(LUBBOCK_USB_IRQ, lubbock);
+err_irq_lub2:
+	free_irq(LUBBOCK_USB_DISC_IRQ, lubbock);
+err_irq_lub:
+	kfree(lubbock);
+	return err;
+}
+
+static int __devexit lubbock_usb_xceiv_remove(struct platform_device *pdev)
+{
+	struct otg_transceiver *lubbock = platform_get_drvdata(pdev);
+
+	otg_set_transceiver(NULL);
+
+	platform_set_drvdata(pdev, NULL);
+
+	free_irq(LUBBOCK_USB_IRQ, lubbock);
+	free_irq(LUBBOCK_USB_DISC_IRQ, lubbock);
+
+	kfree(lubbock);
+
+	return 0;
+}
+
+static struct platform_driver lubbock_usb_xceiv_driver = {
+	.probe		= lubbock_usb_xceiv_probe,
+	.remove		= __devexit_p(lubbock_usb_xceiv_remove),
+	.driver		= {
+		.name	= "lubbock_usb_xceiv",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init lubbock_usb_xceiv_init(void)
+{
+	return platform_driver_register(&lubbock_usb_xceiv_driver);
+}
+subsys_initcall(lubbock_usb_xceiv_init);
+
+static void __exit lubbock_usb_xceiv_exit(void)
+{
+	platform_driver_unregister(&lubbock_usb_xceiv_driver);
+}
+module_exit(lubbock_usb_xceiv_exit);
+
+MODULE_ALIAS("platform:lubbock_usb_xceiv");
+MODULE_DESCRIPTION("lubbock USB Transceiver driver");
+MODULE_LICENSE("GPL");
+
-- 
1.7.4.1
