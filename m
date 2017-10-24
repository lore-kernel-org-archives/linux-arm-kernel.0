From: opendmb@gmail.com (Doug Berger)
Date: Tue, 24 Oct 2017 12:54:51 -0700
Subject: [PATCH v2 7/7] gpio: brcmstb: implement suspend/resume/shutdown
In-Reply-To: <20171024195451.30535-1-opendmb@gmail.com>
References: <20171024195451.30535-1-opendmb@gmail.com>
Message-ID: <20171024195451.30535-8-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit corrects problems with the previous wake implementation
by implementing suspend and resume power management operations and
the driver shutdown operation.

Wake masks are used to keep track of which GPIO should wake the
device.  On suspend the GPIO state is saved and the possible wakeup
sources are explicitly unmasked in the hardware. Non-wakeup sources
are explicitly masked so IRQCHIP_MASK_ON_SUSPEND is no longer
necessary.  The saved state of the GPIO is restored upon resume.
It is important not to write to the GPIO status register since this
has the effect of clearing bits.  The status register is explicitly
removed from the register save and restore to ensure this.

The shutdown operation allows the hardware to be put into the same
quiesced state as the suspend operation and removes the need for
the reboot notifier.

Unfortunately, there appears to be some confusion about whether
a pending disabled wake interrupt should wake the system. If a wake
capable interrupt is disabled using the default "lazy disable"
behavior and it is triggered before the suspend_device_irq call
the interrupt hardware will be acknowledged by mask_ack_irq and the
IRQS_PENDING flag is added to its state. However, the IRQS_PENDING
flag of wake interrupts is not checked to prevent the transition to
suspend and the hardware has been acked which prevents its wakeup.
If the lazy disabled interrupt is triggered after the call to
suspend_device_irqs then the wakeup logic will abort the suspend.
The irq_disable method is defined by this GPIO driver to prevent
lazy disable so that the pending hardware state remains asserted
allowing the hardware to wake and providing a consistent behavior.

In addition, the IRQ_DISABLE_UNLAZY flag is set for the non-wake
parent interrupt as a convenience to prevent the need to add code
to the brcmstb_gpio_irq_handler to support "lazy disable" of the
non-wake parent interrupt when it is disabled during suspend and
resume. Chained interrupt parents are not normally disabled, but
these GPIO devices have different parent interrupts for wake and
non-wake handling. It is convenient to mask the non-wake parent
when suspending to preserve the hardware state for proper wakeup
accounting when the driver is resumed.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 201 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 151 insertions(+), 50 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 9a8c603625a3..545d43a587b7 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -19,18 +19,30 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/interrupt.h>
-#include <linux/reboot.h>
 #include <linux/bitops.h>
 
-#define GIO_BANK_SIZE           0x20
-#define GIO_ODEN(bank)          (((bank) * GIO_BANK_SIZE) + 0x00)
-#define GIO_DATA(bank)          (((bank) * GIO_BANK_SIZE) + 0x04)
-#define GIO_IODIR(bank)         (((bank) * GIO_BANK_SIZE) + 0x08)
-#define GIO_EC(bank)            (((bank) * GIO_BANK_SIZE) + 0x0c)
-#define GIO_EI(bank)            (((bank) * GIO_BANK_SIZE) + 0x10)
-#define GIO_MASK(bank)          (((bank) * GIO_BANK_SIZE) + 0x14)
-#define GIO_LEVEL(bank)         (((bank) * GIO_BANK_SIZE) + 0x18)
-#define GIO_STAT(bank)          (((bank) * GIO_BANK_SIZE) + 0x1c)
+enum gio_reg_index {
+	GIO_REG_ODEN = 0,
+	GIO_REG_DATA,
+	GIO_REG_IODIR,
+	GIO_REG_EC,
+	GIO_REG_EI,
+	GIO_REG_MASK,
+	GIO_REG_LEVEL,
+	GIO_REG_STAT,
+	NUMBER_OF_GIO_REGISTERS
+};
+
+#define GIO_BANK_SIZE           (NUMBER_OF_GIO_REGISTERS * sizeof(u32))
+#define GIO_BANK_OFF(bank, off)	(((bank) * GIO_BANK_SIZE) + (off * sizeof(u32)))
+#define GIO_ODEN(bank)          GIO_BANK_OFF(bank, GIO_REG_ODEN)
+#define GIO_DATA(bank)          GIO_BANK_OFF(bank, GIO_REG_DATA)
+#define GIO_IODIR(bank)         GIO_BANK_OFF(bank, GIO_REG_IODIR)
+#define GIO_EC(bank)            GIO_BANK_OFF(bank, GIO_REG_EC)
+#define GIO_EI(bank)            GIO_BANK_OFF(bank, GIO_REG_EI)
+#define GIO_MASK(bank)          GIO_BANK_OFF(bank, GIO_REG_MASK)
+#define GIO_LEVEL(bank)         GIO_BANK_OFF(bank, GIO_REG_LEVEL)
+#define GIO_STAT(bank)          GIO_BANK_OFF(bank, GIO_REG_STAT)
 
 struct brcmstb_gpio_bank {
 	struct list_head node;
@@ -38,6 +50,8 @@ struct brcmstb_gpio_bank {
 	struct gpio_chip gc;
 	struct brcmstb_gpio_priv *parent_priv;
 	u32 width;
+	u32 wake_active;
+	u32 saved_regs[GIO_REG_STAT]; /* Don't save and restore GIO_REG_STAT */
 };
 
 struct brcmstb_gpio_priv {
@@ -50,7 +64,6 @@ struct brcmstb_gpio_priv {
 	int gpio_base;
 	int num_gpios;
 	int parent_wake_irq;
-	struct notifier_block reboot_notifier;
 };
 
 #define MAX_GPIO_PER_BANK       32
@@ -66,15 +79,22 @@ brcmstb_gpio_gc_to_priv(struct gpio_chip *gc)
 }
 
 static unsigned long
-brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
+__brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
 {
 	void __iomem *reg_base = bank->parent_priv->reg_base;
+
+	return bank->gc.read_reg(reg_base + GIO_STAT(bank->id)) &
+	       bank->gc.read_reg(reg_base + GIO_MASK(bank->id));
+}
+
+static unsigned long
+brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
+{
 	unsigned long status;
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
-	status = bank->gc.read_reg(reg_base + GIO_STAT(bank->id)) &
-		 bank->gc.read_reg(reg_base + GIO_MASK(bank->id));
+	status = __brcmstb_gpio_get_active_irqs(bank);
 	spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
 
 	return status;
@@ -210,11 +230,6 @@ static int brcmstb_gpio_priv_set_wake(struct brcmstb_gpio_priv *priv,
 {
 	int ret = 0;
 
-	/*
-	 * Only enable wake IRQ once for however many hwirqs can wake
-	 * since they all use the same wake IRQ.  Mask will be set
-	 * up appropriately thanks to IRQCHIP_MASK_ON_SUSPEND flag.
-	 */
 	if (enable)
 		ret = enable_irq_wake(priv->parent_wake_irq);
 	else
@@ -228,7 +243,18 @@ static int brcmstb_gpio_priv_set_wake(struct brcmstb_gpio_priv *priv,
 static int brcmstb_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
+	struct brcmstb_gpio_bank *bank = gpiochip_get_data(gc);
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	u32 mask = BIT(brcmstb_gpio_hwirq_to_offset(d->hwirq, bank));
+
+	/*
+	 * Do not do anything specific for now, suspend/resume callbacks will
+	 * configure the interrupt mask appropriately
+	 */
+	if (enable)
+		bank->wake_active |= mask;
+	else
+		bank->wake_active &= ~mask;
 
 	return brcmstb_gpio_priv_set_wake(priv, enable);
 }
@@ -239,7 +265,8 @@ static irqreturn_t brcmstb_gpio_wake_irq_handler(int irq, void *data)
 
 	if (!priv || irq != priv->parent_wake_irq)
 		return IRQ_NONE;
-	pm_wakeup_event(&priv->pdev->dev, 0);
+
+	/* Nothing to do */
 	return IRQ_HANDLED;
 }
 
@@ -280,19 +307,6 @@ static void brcmstb_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int brcmstb_gpio_reboot(struct notifier_block *nb,
-		unsigned long action, void *data)
-{
-	struct brcmstb_gpio_priv *priv =
-		container_of(nb, struct brcmstb_gpio_priv, reboot_notifier);
-
-	/* Enable GPIO for S5 cold boot */
-	if (action == SYS_POWER_OFF)
-		brcmstb_gpio_priv_set_wake(priv, 1);
-
-	return NOTIFY_DONE;
-}
-
 static struct brcmstb_gpio_bank *brcmstb_gpio_hwirq_to_bank(
 		struct brcmstb_gpio_priv *priv, irq_hw_number_t hwirq)
 {
@@ -397,12 +411,6 @@ static int brcmstb_gpio_remove(struct platform_device *pdev)
 	list_for_each_entry(bank, &priv->bank_list, node)
 		gpiochip_remove(&bank->gc);
 
-	if (priv->reboot_notifier.notifier_call) {
-		ret = unregister_reboot_notifier(&priv->reboot_notifier);
-		if (ret)
-			dev_err(&pdev->dev,
-				"failed to unregister reboot notifier\n");
-	}
 	return ret;
 }
 
@@ -462,9 +470,8 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 				"Couldn't get wake IRQ - GPIOs will not be able to wake from sleep");
 		} else {
 			/*
-			 * Set wakeup capability before requesting wakeup
-			 * interrupt, so we can process boot-time "wakeups"
-			 * (e.g., from S5 cold boot)
+			 * Set wakeup capability so we can process boot-time
+			 * "wakeups" (e.g., from S5 cold boot)
 			 */
 			device_set_wakeup_capable(dev, true);
 			device_wakeup_enable(dev);
@@ -477,10 +484,6 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 				dev_err(dev, "Couldn't request wake IRQ");
 				goto out_free_domain;
 			}
-
-			priv->reboot_notifier.notifier_call =
-				brcmstb_gpio_reboot;
-			register_reboot_notifier(&priv->reboot_notifier);
 		}
 	}
 
@@ -491,14 +494,12 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 	priv->irq_chip.irq_ack = brcmstb_gpio_irq_ack;
 	priv->irq_chip.irq_set_type = brcmstb_gpio_irq_set_type;
 
-	/* Ensures that all non-wakeup IRQs are disabled at suspend */
-	priv->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
-
 	if (priv->parent_wake_irq)
 		priv->irq_chip.irq_set_wake = brcmstb_gpio_irq_set_wake;
 
 	irq_set_chained_handler_and_data(priv->parent_irq,
 					 brcmstb_gpio_irq_handler, priv);
+	irq_set_status_flags(priv->parent_irq, IRQ_DISABLE_UNLAZY);
 
 	return 0;
 
@@ -508,6 +509,99 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 	return err;
 }
 
+static void brcmstb_gpio_bank_save(struct brcmstb_gpio_priv *priv,
+				   struct brcmstb_gpio_bank *bank)
+{
+	struct gpio_chip *gc = &bank->gc;
+	unsigned int i;
+
+	for (i = 0; i < GIO_REG_STAT; i++)
+		bank->saved_regs[i] = gc->read_reg(priv->reg_base +
+						   GIO_BANK_OFF(bank->id, i));
+}
+
+static void brcmstb_gpio_quiesce(struct device *dev, bool save)
+{
+	struct brcmstb_gpio_priv *priv = dev_get_drvdata(dev);
+	struct brcmstb_gpio_bank *bank;
+	struct gpio_chip *gc;
+	u32 imask;
+
+	/* disable non-wake interrupt */
+	if (priv->parent_irq >= 0)
+		disable_irq(priv->parent_irq);
+
+	list_for_each_entry(bank, &priv->bank_list, node) {
+		gc = &bank->gc;
+
+		if (save)
+			brcmstb_gpio_bank_save(priv, bank);
+
+		/* Unmask GPIOs which have been flagged as wake-up sources */
+		if (priv->parent_wake_irq)
+			imask = bank->wake_active;
+		else
+			imask = 0;
+		gc->write_reg(priv->reg_base + GIO_MASK(bank->id),
+			       imask);
+	}
+}
+
+static void brcmstb_gpio_shutdown(struct platform_device *pdev)
+{
+	/* Enable GPIO for S5 cold boot */
+	brcmstb_gpio_quiesce(&pdev->dev, false);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static void brcmstb_gpio_bank_restore(struct brcmstb_gpio_priv *priv,
+				      struct brcmstb_gpio_bank *bank)
+{
+	struct gpio_chip *gc = &bank->gc;
+	unsigned int i;
+
+	for (i = 0; i < GIO_REG_STAT; i++)
+		gc->write_reg(priv->reg_base + GIO_BANK_OFF(bank->id, i),
+			      bank->saved_regs[i]);
+}
+
+static int brcmstb_gpio_suspend(struct device *dev)
+{
+	brcmstb_gpio_quiesce(dev, true);
+	return 0;
+}
+
+static int brcmstb_gpio_resume(struct device *dev)
+{
+	struct brcmstb_gpio_priv *priv = dev_get_drvdata(dev);
+	struct brcmstb_gpio_bank *bank;
+	bool need_wakeup_event = false;
+
+	list_for_each_entry(bank, &priv->bank_list, node) {
+		need_wakeup_event |= !!__brcmstb_gpio_get_active_irqs(bank);
+		brcmstb_gpio_bank_restore(priv, bank);
+	}
+
+	if (priv->parent_wake_irq && need_wakeup_event)
+		pm_wakeup_event(dev, 0);
+
+	/* enable non-wake interrupt */
+	if (priv->parent_irq >= 0)
+		enable_irq(priv->parent_irq);
+
+	return 0;
+}
+
+#else
+#define brcmstb_gpio_suspend	NULL
+#define brcmstb_gpio_resume	NULL
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops brcmstb_gpio_pm_ops = {
+	.suspend_noirq	= brcmstb_gpio_suspend,
+	.resume_noirq = brcmstb_gpio_resume,
+};
+
 static int brcmstb_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -522,6 +616,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	int err;
 	static int gpio_base;
 	unsigned long flags = 0;
+	bool need_wakeup_event = false;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -617,6 +712,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		 * Mask all interrupts by default, since wakeup interrupts may
 		 * be retained from S5 cold boot
 		 */
+		need_wakeup_event |= !!__brcmstb_gpio_get_active_irqs(bank);
 		gc->write_reg(reg_base + GIO_MASK(bank->id), 0);
 
 		err = gpiochip_add_data(gc, bank);
@@ -646,6 +742,9 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
 			num_banks, priv->gpio_base, gpio_base - 1);
 
+	if (priv->parent_wake_irq && need_wakeup_event)
+		pm_wakeup_event(dev, 0);
+
 	return 0;
 
 fail:
@@ -664,9 +763,11 @@ static struct platform_driver brcmstb_gpio_driver = {
 	.driver = {
 		.name = "brcmstb-gpio",
 		.of_match_table = brcmstb_gpio_of_match,
+		.pm = &brcmstb_gpio_pm_ops,
 	},
 	.probe = brcmstb_gpio_probe,
 	.remove = brcmstb_gpio_remove,
+	.shutdown = brcmstb_gpio_shutdown,
 };
 module_platform_driver(brcmstb_gpio_driver);
 
-- 
2.14.1
