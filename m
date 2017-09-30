From: opendmb@gmail.com (Doug Berger)
Date: Fri, 29 Sep 2017 20:40:52 -0700
Subject: [PATCH 2/7] gpio: brcmstb: release the bgpio lock during irq handlers
In-Reply-To: <20170930034057.15166-1-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
Message-ID: <20170930034057.15166-3-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The basic memory-mapped GPIO controller lock must be released
before calling the registered GPIO interrupt handlers to allow
the interrupt handlers to access the hardware.  Otherwise, the
hardware accesses will deadlock when they attempt to grab the
lock.

Since the lock is only needed to protect the calculation of
unmasked pending interrupts create a dedicated function to
perform this and hide the complexity.

Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 7f39b160a4d5..8945861876f9 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -62,6 +62,21 @@ brcmstb_gpio_gc_to_priv(struct gpio_chip *gc)
 	return bank->parent_priv;
 }
 
+static unsigned long
+brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
+{
+	void __iomem *reg_base = bank->parent_priv->reg_base;
+	unsigned long status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
+	status = bank->gc.read_reg(reg_base + GIO_STAT(bank->id)) &
+		 bank->gc.read_reg(reg_base + GIO_MASK(bank->id));
+	spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
+
+	return status;
+}
+
 static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
 		unsigned int offset, bool enable)
 {
@@ -204,11 +219,8 @@ static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
 	struct irq_domain *irq_domain = bank->gc.irqdomain;
 	void __iomem *reg_base = priv->reg_base;
 	unsigned long status;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
-	while ((status = bank->gc.read_reg(reg_base + GIO_STAT(bank->id)) &
-			 bank->gc.read_reg(reg_base + GIO_MASK(bank->id)))) {
+	while ((status = brcmstb_gpio_get_active_irqs(bank))) {
 		int bit;
 
 		for_each_set_bit(bit, &status, 32) {
@@ -223,7 +235,6 @@ static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
 			generic_handle_irq(irq_find_mapping(irq_domain, bit));
 		}
 	}
-	spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
 }
 
 /* Each UPG GIO block has one IRQ for all banks */
-- 
2.14.1
