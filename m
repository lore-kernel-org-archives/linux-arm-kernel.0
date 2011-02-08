From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 10:20:49 +0100
Subject: [PATCH 4/9] plat-nomadik: support secondary GPIO interrupts
In-Reply-To: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1297156854-32295-5-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

When GPIOs wake up the system from sleep mode, the normal GPIO interrupt
handler does not hit and the normal interrupt status register does not
contain the status. Instead the secondary GPIO handler does, and the
interrupt status needs to be retrieved from the wakeup status saved by
the suspend/resume code.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c              |   51 +++++++++++++++++++++++++---
 arch/arm/plat-nomadik/include/plat/gpio.h |    1 +
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 46f1af8..971e5d3 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -39,7 +39,10 @@ struct nmk_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem *addr;
 	struct clk *clk;
+	unsigned int bank;
 	unsigned int parent_irq;
+	unsigned int secondary_parent_irq;
+	u32 (*get_secondary_status)(unsigned int bank);
 	spinlock_t lock;
 	/* Keep track of configured edges */
 	u32 edge_rising;
@@ -514,12 +517,11 @@ static struct irq_chip nmk_gpio_irq_chip = {
 	.irq_set_wake	= nmk_gpio_irq_set_wake,
 };
 
-static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
+				   u32 status)
 {
 	struct nmk_gpio_chip *nmk_chip;
 	struct irq_chip *host_chip = get_irq_chip(irq);
-	unsigned int gpio_irq;
-	u32 pending;
 	unsigned int first_irq;
 
 	if (host_chip->irq_mask_ack)
@@ -532,14 +534,33 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 	nmk_chip = get_irq_data(irq);
 	first_irq = NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base);
-	while ( (pending = readl(nmk_chip->addr + NMK_GPIO_IS)) ) {
-		gpio_irq = first_irq + __ffs(pending);
-		generic_handle_irq(gpio_irq);
+	while (status) {
+		int bit = __ffs(status);
+
+		generic_handle_irq(first_irq + bit);
+		status &= ~BIT(bit);
 	}
 
 	host_chip->irq_unmask(&desc->irq_data);
 }
 
+static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct nmk_gpio_chip *nmk_chip = get_irq_data(irq);
+	u32 status = readl(nmk_chip->addr + NMK_GPIO_IS);
+
+	__nmk_gpio_irq_handler(irq, desc, status);
+}
+
+static void nmk_gpio_secondary_irq_handler(unsigned int irq,
+					   struct irq_desc *desc)
+{
+	struct nmk_gpio_chip *nmk_chip = get_irq_data(irq);
+	u32 status = nmk_chip->get_secondary_status(nmk_chip->bank);
+
+	__nmk_gpio_irq_handler(irq, desc, status);
+}
+
 static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
 {
 	unsigned int first_irq;
@@ -553,8 +574,16 @@ static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
 		set_irq_chip_data(i, nmk_chip);
 		set_irq_type(i, IRQ_TYPE_EDGE_FALLING);
 	}
+
 	set_irq_chained_handler(nmk_chip->parent_irq, nmk_gpio_irq_handler);
 	set_irq_data(nmk_chip->parent_irq, nmk_chip);
+
+	if (nmk_chip->secondary_parent_irq >= 0) {
+		set_irq_chained_handler(nmk_chip->secondary_parent_irq,
+					nmk_gpio_secondary_irq_handler);
+		set_irq_data(nmk_chip->secondary_parent_irq, nmk_chip);
+	}
+
 	return 0;
 }
 
@@ -714,6 +743,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	struct gpio_chip *chip;
 	struct resource *res;
 	struct clk *clk;
+	int secondary_irq;
 	int irq;
 	int ret;
 
@@ -732,6 +762,12 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 		goto out;
 	}
 
+	secondary_irq = platform_get_irq(dev, 1);
+	if (secondary_irq >= 0 && !pdata->get_secondary_status) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (request_mem_region(res->start, resource_size(res),
 			       dev_name(&dev->dev)) == NULL) {
 		ret = -EBUSY;
@@ -755,10 +791,13 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	 * The virt address in nmk_chip->addr is in the nomadik register space,
 	 * so we can simply convert the resource address, without remapping
 	 */
+	nmk_chip->bank = dev->id;
 	nmk_chip->clk = clk;
 	nmk_chip->addr = io_p2v(res->start);
 	nmk_chip->chip = nmk_gpio_template;
 	nmk_chip->parent_irq = irq;
+	nmk_chip->secondary_parent_irq = secondary_irq;
+	nmk_chip->get_secondary_status = pdata->get_secondary_status;
 	spin_lock_init(&nmk_chip->lock);
 
 	chip = &nmk_chip->chip;
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index d745f3a..d108a32 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -83,6 +83,7 @@ struct nmk_gpio_platform_data {
 	int first_gpio;
 	int first_irq;
 	int num_gpio;
+	u32 (*get_secondary_status)(unsigned int bank);
 };
 
 #endif /* __ASM_PLAT_GPIO_H */
-- 
1.7.3.2
