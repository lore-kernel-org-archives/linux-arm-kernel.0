From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 17 Jun 2015 18:00:43 -0700
Subject: [PATCH v3 4/4] gpio: brcmstb: support wakeup from S5 cold boot
In-Reply-To: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
References: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1434589243-502-5-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For wake from S5, we need to:
- register a reboot handler
- set wakeup capability before requesting IRQ so wakeup count is
  incremented
- mask all GPIO IRQs and clear any pending interrupts during driver
  probe to since no driver will yet be registered to handle any IRQs
  carried over from boot at that time, and it's possible that the
  booted kernel does not request the same IRQ anyway.

This means that /sys/.../power/wakeup_count is valid at boot time, and
we can properly account for S5 wakeup stats. e.g.:

  ### After waking from S5 from a GPIO key
  # cat /sys/bus/platform/drivers/brcmstb-gpio/f04172c0.gpio/power/wakeup
  enabled
  # cat /sys/bus/platform/drivers/brcmstb-gpio/f04172c0.gpio/power/wakeup_count
  1

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
New in v3.

 drivers/gpio/gpio-brcmstb.c | 56 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 141509b..dedb35c 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -20,6 +20,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/interrupt.h>
+#include <linux/reboot.h>
 
 #define GIO_BANK_SIZE           0x20
 #define GIO_ODEN(bank)          (((bank) * GIO_BANK_SIZE) + 0x00)
@@ -48,6 +49,7 @@ struct brcmstb_gpio_priv {
 	int gpio_base;
 	bool can_wake;
 	int parent_wake_irq;
+	struct notifier_block reboot_notifier;
 };
 
 #define MAX_GPIO_PER_BANK           32
@@ -167,10 +169,9 @@ static int brcmstb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static int brcmstb_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
+static int __brcmstb_gpio_irq_set_wake(struct brcmstb_gpio_priv *priv,
+		unsigned int enable)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
 	int ret = 0;
 
 	/*
@@ -188,6 +189,14 @@ static int brcmstb_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
 	return ret;
 }
 
+static int brcmstb_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
+
+	return __brcmstb_gpio_irq_set_wake(priv, enable);
+}
+
 static irqreturn_t brcmstb_gpio_wake_irq_handler(int irq, void *data)
 {
 	struct brcmstb_gpio_priv *priv = data;
@@ -247,6 +256,19 @@ static void brcmstb_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int brcmstb_gpio_reboot(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	struct brcmstb_gpio_priv *priv =
+		container_of(nb, struct brcmstb_gpio_priv, reboot_notifier);
+
+	/* Enable GPIO for S5 cold boot */
+	if (action == SYS_POWER_OFF)
+		__brcmstb_gpio_irq_set_wake(priv, 1);
+
+	return NOTIFY_DONE;
+}
+
 /* Make sure that the number of banks matches up between properties */
 static int brcmstb_gpio_sanity_check_banks(struct device *dev,
 		struct device_node *np, struct resource *res)
@@ -286,6 +308,12 @@ static int brcmstb_gpio_remove(struct platform_device *pdev)
 		if (ret)
 			dev_err(&pdev->dev, "gpiochip_remove fail in cleanup\n");
 	}
+	if (priv->reboot_notifier.notifier_call) {
+		ret = unregister_reboot_notifier(&priv->reboot_notifier);
+		if (ret)
+			dev_err(&pdev->dev,
+				"failed to unregister reboot notifier\n");
+	}
 	return ret;
 }
 
@@ -343,7 +371,16 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 			dev_warn(dev,
 				"Couldn't get wake IRQ - GPIOs will not be able to wake from sleep");
 		} else {
-			int err = devm_request_irq(dev, priv->parent_wake_irq,
+			int err;
+
+			/*
+			 * Set wakeup capability before requesting wakeup
+			 * interrupt, so we can process boot-time "wakeups"
+			 * (e.g., from S5 cold boot)
+			 */
+			device_set_wakeup_capable(dev, true);
+			device_wakeup_enable(dev);
+			err = devm_request_irq(dev, priv->parent_wake_irq,
 					brcmstb_gpio_wake_irq_handler, 0,
 					"brcmstb-gpio-wake", priv);
 
@@ -352,8 +389,9 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 				return err;
 			}
 
-			device_set_wakeup_capable(dev, true);
-			device_wakeup_enable(dev);
+			priv->reboot_notifier.notifier_call =
+				brcmstb_gpio_reboot;
+			register_reboot_notifier(&priv->reboot_notifier);
 			priv->can_wake = true;
 		}
 	}
@@ -456,6 +494,12 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		/* not all ngpio lines are valid, will use bank width later */
 		gc->ngpio = MAX_GPIO_PER_BANK;
 
+		/*
+		 * Mask all interrupts by default, since wakeup interrupts may
+		 * be retained from S5 cold boot
+		 */
+		bank->bgc.write_reg(reg_base + GIO_MASK(bank->id), 0);
+
 		err = gpiochip_add(gc);
 		if (err) {
 			dev_err(dev, "Could not add gpiochip for bank %d\n",
-- 
1.9.1
