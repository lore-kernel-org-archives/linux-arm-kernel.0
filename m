From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  5 Jul 2011 11:05:27 +0200
Subject: [PATCH 2/3] at91-ohci: support overcurrent notification
In-Reply-To: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1309856728-8265-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several USB power switches (AIC1526 or MIC2026) have a digital output
that is used to notify that an overcurrent situation is taking
place. This digital outputs are typically connected to GPIO inputs of
the processor and can be used to be notified of those overcurrent
situations.

Therefore, we add a new overcurrent_pin[] array in the at91_usbh_data
structure so that boards can tell the AT91 OHCI driver which pins are
used for the overcurrent notification. The AT91 OHCI driver simply
registers an interrupt handler which will log the entry and exit of an
overcurrent situation in the kernel logs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/include/mach/board.h |    1 +
 drivers/usb/host/ohci-at91.c            |   37 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 61d52dc..1f90d79 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -99,6 +99,7 @@ struct at91_usbh_data {
 	u8		ports;		/* number of ports on root hub */
 	u8		vbus_pin[2];	/* port power-control pin */
 	u8              vbus_pin_inverted;
+	u8              overcurrent_pin[2]; /* over-current signal pins */
 };
 extern void __init at91_add_device_usbh(struct at91_usbh_data *data);
 extern void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data);
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 52e50ba..2801c77 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -269,6 +269,19 @@ static const struct hc_driver ohci_at91_hc_driver = {
 
 /*-------------------------------------------------------------------------*/
 
+static irqreturn_t ohci_hcd_at91_overcurrent_irq(int irq, void *data)
+{
+	struct platform_device *pdev = data;
+	int val;
+
+	val = gpio_get_value(irq_to_gpio(irq));
+	dev_err(& pdev->dev, "overcurrent situation %s\n",
+		val ? "exited" : "notified");
+	return IRQ_HANDLED;
+}
+
+/*-------------------------------------------------------------------------*/
+
 static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 {
 	struct at91_usbh_data	*pdata = pdev->dev.platform_data;
@@ -286,6 +299,23 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 			gpio_request(pdata->vbus_pin[i], "ohci_vbus");
 			gpio_direction_output(pdata->vbus_pin[i], 0 ^ pdata->vbus_pin_inverted);
 		}
+
+		for (i = 0; i < ARRAY_SIZE(pdata->overcurrent_pin); i++) {
+			int ret;
+
+			if (pdata->overcurrent_pin[i] <= 0)
+				continue;
+			gpio_request(pdata->overcurrent_pin[i], "ohci_overcurrent");
+			gpio_direction_input(pdata->overcurrent_pin[i]);
+
+			ret = request_irq(gpio_to_irq(pdata->overcurrent_pin[i]),
+					  ohci_hcd_at91_overcurrent_irq,
+					  IRQF_SHARED, "ohci_overcurrent", pdev);
+			if (ret) {
+				gpio_free(pdata->overcurrent_pin[i]);
+				dev_warn(& pdev->dev, "cannot get GPIO IRQ for overcurrent\n");
+			}
+		}
 	}
 
 	device_init_wakeup(&pdev->dev, 1);
@@ -304,6 +334,13 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
 			gpio_direction_output(pdata->vbus_pin[i], 1 ^ pdata->vbus_pin_inverted);
 			gpio_free(pdata->vbus_pin[i]);
 		}
+
+		for (i = 0; i < ARRAY_SIZE(pdata->overcurrent_pin); i++) {
+			if (pdata->overcurrent_pin[i] <= 0)
+				continue;
+			free_irq(gpio_to_irq(pdata->overcurrent_pin[i]), pdev);
+			gpio_free(pdata->overcurrent_pin[i]);
+		}
 	}
 
 	device_init_wakeup(&pdev->dev, 0);
-- 
1.7.4.1
