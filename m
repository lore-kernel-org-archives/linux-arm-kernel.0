From: opendmb@gmail.com (Doug Berger)
Date: Fri, 29 Sep 2017 20:40:51 -0700
Subject: [PATCH 1/7] gpio: brcmstb: allow all instances to be wakeup sources
In-Reply-To: <20170930034057.15166-1-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
Message-ID: <20170930034057.15166-2-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit allows a wakeup parent interrupt to be shared between
instances.

It also removes the redundant can_wake member of the private data
structure by using whether the parent_wake_irq has been defined to
indicate that the GPIO device can wake.

Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 27e92e57adae..7f39b160a4d5 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2015 Broadcom Corporation
+ * Copyright (C) 2015-2017 Broadcom
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -46,7 +46,6 @@ struct brcmstb_gpio_priv {
 	struct platform_device *pdev;
 	int parent_irq;
 	int gpio_base;
-	bool can_wake;
 	int parent_wake_irq;
 	struct notifier_block reboot_notifier;
 };
@@ -349,10 +348,11 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 	/* Ensures that all non-wakeup IRQs are disabled at suspend */
 	bank->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
 
-	if (IS_ENABLED(CONFIG_PM_SLEEP) && !priv->can_wake &&
+	if (IS_ENABLED(CONFIG_PM_SLEEP) && !priv->parent_wake_irq &&
 			of_property_read_bool(np, "wakeup-source")) {
 		priv->parent_wake_irq = platform_get_irq(pdev, 1);
 		if (priv->parent_wake_irq < 0) {
+			priv->parent_wake_irq = 0;
 			dev_warn(dev,
 				"Couldn't get wake IRQ - GPIOs will not be able to wake from sleep");
 		} else {
@@ -364,8 +364,9 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 			device_set_wakeup_capable(dev, true);
 			device_wakeup_enable(dev);
 			err = devm_request_irq(dev, priv->parent_wake_irq,
-					brcmstb_gpio_wake_irq_handler, 0,
-					"brcmstb-gpio-wake", priv);
+					       brcmstb_gpio_wake_irq_handler,
+					       IRQF_SHARED,
+					       "brcmstb-gpio-wake", priv);
 
 			if (err < 0) {
 				dev_err(dev, "Couldn't request wake IRQ");
@@ -375,11 +376,10 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 			priv->reboot_notifier.notifier_call =
 				brcmstb_gpio_reboot;
 			register_reboot_notifier(&priv->reboot_notifier);
-			priv->can_wake = true;
 		}
 	}
 
-	if (priv->can_wake)
+	if (priv->parent_wake_irq)
 		bank->irq_chip.irq_set_wake = brcmstb_gpio_irq_set_wake;
 
 	err = gpiochip_irqchip_add(&bank->gc, &bank->irq_chip, 0,
-- 
2.14.1
