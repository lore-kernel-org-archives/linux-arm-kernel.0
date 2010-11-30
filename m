From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:37:00 +0100
Subject: [PATCH 30/54] ARM: msm: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133700.GE15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-msm/board-trout-gpio.c |   42 +++++++++++-----------
 arch/arm/mach-msm/gpio.c             |   48 ++++++++++++------------
 arch/arm/mach-msm/irq-vic.c          |   65 ++++++++++++++++-----------------
 arch/arm/mach-msm/irq.c              |   45 +++++++++++------------
 arch/arm/mach-msm/sirc.c             |   39 ++++++++++----------
 5 files changed, 118 insertions(+), 121 deletions(-)

diff --git a/arch/arm/mach-msm/board-trout-gpio.c b/arch/arm/mach-msm/board-trout-gpio.c
index c50f3af..5d9e69c 100644
--- a/arch/arm/mach-msm/board-trout-gpio.c
+++ b/arch/arm/mach-msm/board-trout-gpio.c
@@ -105,52 +105,52 @@ static struct msm_gpio_chip msm_gpio_banks[] = {
 	TROUT_GPIO_BANK("VIRTUAL", 0x12, TROUT_GPIO_VIRTUAL_BASE, 0),
 };
 
-static void trout_gpio_irq_ack(unsigned int irq)
+static void trout_gpio_irq_ack(struct irq_data *d)
 {
-	int bank = TROUT_INT_TO_BANK(irq);
-	uint8_t mask = TROUT_INT_TO_MASK(irq);
+	int bank = TROUT_INT_TO_BANK(d->irq);
+	uint8_t mask = TROUT_INT_TO_MASK(d->irq);
 	int reg = TROUT_BANK_TO_STAT_REG(bank);
-	/*printk(KERN_INFO "trout_gpio_irq_ack irq %d\n", irq);*/
+	/*printk(KERN_INFO "trout_gpio_irq_ack irq %d\n", d->irq);*/
 	writeb(mask, TROUT_CPLD_BASE + reg);
 }
 
-static void trout_gpio_irq_mask(unsigned int irq)
+static void trout_gpio_irq_mask(struct irq_data *d)
 {
 	unsigned long flags;
 	uint8_t reg_val;
-	int bank = TROUT_INT_TO_BANK(irq);
-	uint8_t mask = TROUT_INT_TO_MASK(irq);
+	int bank = TROUT_INT_TO_BANK(d->irq);
+	uint8_t mask = TROUT_INT_TO_MASK(d->irq);
 	int reg = TROUT_BANK_TO_MASK_REG(bank);
 
 	local_irq_save(flags);
 	reg_val = trout_int_mask[bank] |= mask;
 	/*printk(KERN_INFO "trout_gpio_irq_mask irq %d => %d:%02x\n",
-	       irq, bank, reg_val);*/
+	       d->irq, bank, reg_val);*/
 	writeb(reg_val, TROUT_CPLD_BASE + reg);
 	local_irq_restore(flags);
 }
 
-static void trout_gpio_irq_unmask(unsigned int irq)
+static void trout_gpio_irq_unmask(struct irq_data *d)
 {
 	unsigned long flags;
 	uint8_t reg_val;
-	int bank = TROUT_INT_TO_BANK(irq);
-	uint8_t mask = TROUT_INT_TO_MASK(irq);
+	int bank = TROUT_INT_TO_BANK(d->irq);
+	uint8_t mask = TROUT_INT_TO_MASK(d->irq);
 	int reg = TROUT_BANK_TO_MASK_REG(bank);
 
 	local_irq_save(flags);
 	reg_val = trout_int_mask[bank] &= ~mask;
 	/*printk(KERN_INFO "trout_gpio_irq_unmask irq %d => %d:%02x\n",
-	       irq, bank, reg_val);*/
+	       d->irq, bank, reg_val);*/
 	writeb(reg_val, TROUT_CPLD_BASE + reg);
 	local_irq_restore(flags);
 }
 
-int trout_gpio_irq_set_wake(unsigned int irq, unsigned int on)
+int trout_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	unsigned long flags;
-	int bank = TROUT_INT_TO_BANK(irq);
-	uint8_t mask = TROUT_INT_TO_MASK(irq);
+	int bank = TROUT_INT_TO_BANK(d->irq);
+	uint8_t mask = TROUT_INT_TO_MASK(d->irq);
 
 	local_irq_save(flags);
 	if(on)
@@ -190,15 +190,15 @@ static void trout_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		}
 		int_base += TROUT_INT_BANK0_COUNT;
 	}
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 }
 
 static struct irq_chip trout_gpio_irq_chip = {
-	.name      = "troutgpio",
-	.ack       = trout_gpio_irq_ack,
-	.mask      = trout_gpio_irq_mask,
-	.unmask    = trout_gpio_irq_unmask,
-	.set_wake  = trout_gpio_irq_set_wake,
+	.name          = "troutgpio",
+	.irq_ack       = trout_gpio_irq_ack,
+	.irq_mask      = trout_gpio_irq_mask,
+	.irq_unmask    = trout_gpio_irq_unmask,
+	.irq_set_wake  = trout_gpio_irq_set_wake,
 };
 
 /*
diff --git a/arch/arm/mach-msm/gpio.c b/arch/arm/mach-msm/gpio.c
index 33051b5..176af9d 100644
--- a/arch/arm/mach-msm/gpio.c
+++ b/arch/arm/mach-msm/gpio.c
@@ -225,21 +225,21 @@ struct msm_gpio_chip msm_gpio_chips[] = {
 #endif
 };
 
-static void msm_gpio_irq_ack(unsigned int irq)
+static void msm_gpio_irq_ack(struct irq_data *d)
 {
 	unsigned long irq_flags;
-	struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
+	struct msm_gpio_chip *msm_chip = irq_data_get_irq_chip_data(d);
 	spin_lock_irqsave(&msm_chip->lock, irq_flags);
 	msm_gpio_clear_detect_status(msm_chip,
-				     irq - gpio_to_irq(msm_chip->chip.base));
+				     d->irq - gpio_to_irq(msm_chip->chip.base));
 	spin_unlock_irqrestore(&msm_chip->lock, irq_flags);
 }
 
-static void msm_gpio_irq_mask(unsigned int irq)
+static void msm_gpio_irq_mask(struct irq_data *d)
 {
 	unsigned long irq_flags;
-	struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
-	unsigned offset = irq - gpio_to_irq(msm_chip->chip.base);
+	struct msm_gpio_chip *msm_chip = irq_data_get_irq_chip_data(d);
+	unsigned offset = d->irq - gpio_to_irq(msm_chip->chip.base);
 
 	spin_lock_irqsave(&msm_chip->lock, irq_flags);
 	/* level triggered interrupts are also latched */
@@ -250,11 +250,11 @@ static void msm_gpio_irq_mask(unsigned int irq)
 	spin_unlock_irqrestore(&msm_chip->lock, irq_flags);
 }
 
-static void msm_gpio_irq_unmask(unsigned int irq)
+static void msm_gpio_irq_unmask(struct irq_data *d)
 {
 	unsigned long irq_flags;
-	struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
-	unsigned offset = irq - gpio_to_irq(msm_chip->chip.base);
+	struct msm_gpio_chip *msm_chip = irq_data_get_irq_chip_data(d);
+	unsigned offset = d->irq - gpio_to_irq(msm_chip->chip.base);
 
 	spin_lock_irqsave(&msm_chip->lock, irq_flags);
 	/* level triggered interrupts are also latched */
@@ -265,11 +265,11 @@ static void msm_gpio_irq_unmask(unsigned int irq)
 	spin_unlock_irqrestore(&msm_chip->lock, irq_flags);
 }
 
-static int msm_gpio_irq_set_wake(unsigned int irq, unsigned int on)
+static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	unsigned long irq_flags;
-	struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
-	unsigned offset = irq - gpio_to_irq(msm_chip->chip.base);
+	struct msm_gpio_chip *msm_chip = irq_data_get_irq_chip_data(d);
+	unsigned offset = d->irq - gpio_to_irq(msm_chip->chip.base);
 
 	spin_lock_irqsave(&msm_chip->lock, irq_flags);
 
@@ -282,21 +282,21 @@ static int msm_gpio_irq_set_wake(unsigned int irq, unsigned int on)
 	return 0;
 }
 
-static int msm_gpio_irq_set_type(unsigned int irq, unsigned int flow_type)
+static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	unsigned long irq_flags;
-	struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
-	unsigned offset = irq - gpio_to_irq(msm_chip->chip.base);
+	struct msm_gpio_chip *msm_chip = irq_data_get_irq_chip_data(d);
+	unsigned offset = d->irq - gpio_to_irq(msm_chip->chip.base);
 	unsigned val, mask = BIT(offset);
 
 	spin_lock_irqsave(&msm_chip->lock, irq_flags);
 	val = readl(msm_chip->regs.int_edge);
 	if (flow_type & IRQ_TYPE_EDGE_BOTH) {
 		writel(val | mask, msm_chip->regs.int_edge);
-		irq_desc[irq].handle_irq = handle_edge_irq;
+		irq_desc[d->irq].handle_irq = handle_edge_irq;
 	} else {
 		writel(val & ~mask, msm_chip->regs.int_edge);
-		irq_desc[irq].handle_irq = handle_level_irq;
+		irq_desc[d->irq].handle_irq = handle_level_irq;
 	}
 	if ((flow_type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
 		msm_chip->both_edge_detect |= mask;
@@ -333,16 +333,16 @@ static void msm_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 					   msm_chip->chip.base + j);
 		}
 	}
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 }
 
 static struct irq_chip msm_gpio_irq_chip = {
-	.name      = "msmgpio",
-	.ack       = msm_gpio_irq_ack,
-	.mask      = msm_gpio_irq_mask,
-	.unmask    = msm_gpio_irq_unmask,
-	.set_wake  = msm_gpio_irq_set_wake,
-	.set_type  = msm_gpio_irq_set_type,
+	.name          = "msmgpio",
+	.irq_ack       = msm_gpio_irq_ack,
+	.irq_mask      = msm_gpio_irq_mask,
+	.irq_unmask    = msm_gpio_irq_unmask,
+	.irq_set_wake  = msm_gpio_irq_set_wake,
+	.irq_set_type  = msm_gpio_irq_set_type,
 };
 
 static int __init msm_init_gpio(void)
diff --git a/arch/arm/mach-msm/irq-vic.c b/arch/arm/mach-msm/irq-vic.c
index 99f2c34..68c28bb 100644
--- a/arch/arm/mach-msm/irq-vic.c
+++ b/arch/arm/mach-msm/irq-vic.c
@@ -226,19 +226,18 @@ static inline void msm_irq_write_all_regs(void __iomem *base, unsigned int val)
 		writel(val, base + (i * 4));
 }
 
-static void msm_irq_ack(unsigned int irq)
+static void msm_irq_ack(struct irq_data *d)
 {
-	void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_CLEAR0, irq);
-	irq = 1 << (irq & 31);
-	writel(irq, reg);
+	void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_CLEAR0, d->irq);
+	writel(1 << (d->irq & 31), reg);
 }
 
-static void msm_irq_mask(unsigned int irq)
+static void msm_irq_mask(struct irq_data *d)
 {
-	void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_ENCLEAR0, irq);
-	unsigned index = VIC_INT_TO_REG_INDEX(irq);
-	uint32_t mask = 1UL << (irq & 31);
-	int smsm_irq = msm_irq_to_smsm[irq];
+	void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_ENCLEAR0, d->irq);
+	unsigned index = VIC_INT_TO_REG_INDEX(d->irq);
+	uint32_t mask = 1UL << (d->irq & 31);
+	int smsm_irq = msm_irq_to_smsm[d->irq];
 
 	msm_irq_shadow_reg[index].int_en[0] &= ~mask;
 	writel(mask, reg);
@@ -250,12 +249,12 @@ static void msm_irq_mask(unsigned int irq)
 	}
 }
 
-static void msm_irq_unmask(unsigned int irq)
+static void msm_irq_unmask(struct irq_data *d)
 {
-	void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_ENSET0, irq);
-	unsigned index = VIC_INT_TO_REG_INDEX(irq);
-	uint32_t mask = 1UL << (irq & 31);
-	int smsm_irq = msm_irq_to_smsm[irq];
+	void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_ENSET0, d->irq);
+	unsigned index = VIC_INT_TO_REG_INDEX(d->irq);
+	uint32_t mask = 1UL << (d->irq & 31);
+	int smsm_irq = msm_irq_to_smsm[d->irq];
 
 	msm_irq_shadow_reg[index].int_en[0] |= mask;
 	writel(mask, reg);
@@ -268,14 +267,14 @@ static void msm_irq_unmask(unsigned int irq)
 	}
 }
 
-static int msm_irq_set_wake(unsigned int irq, unsigned int on)
+static int msm_irq_set_wake(struct irq_data *d, unsigned int on)
 {
-	unsigned index = VIC_INT_TO_REG_INDEX(irq);
-	uint32_t mask = 1UL << (irq & 31);
-	int smsm_irq = msm_irq_to_smsm[irq];
+	unsigned index = VIC_INT_TO_REG_INDEX(d->irq);
+	uint32_t mask = 1UL << (d->irq & 31);
+	int smsm_irq = msm_irq_to_smsm[d->irq];
 
 	if (smsm_irq == 0) {
-		printk(KERN_ERR "msm_irq_set_wake: bad wakeup irq %d\n", irq);
+		printk(KERN_ERR "msm_irq_set_wake: bad wakeup irq %d\n", d->irq);
 		return -EINVAL;
 	}
 	if (on)
@@ -294,12 +293,12 @@ static int msm_irq_set_wake(unsigned int irq, unsigned int on)
 	return 0;
 }
 
-static int msm_irq_set_type(unsigned int irq, unsigned int flow_type)
+static int msm_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	void __iomem *treg = VIC_INT_TO_REG_ADDR(VIC_INT_TYPE0, irq);
-	void __iomem *preg = VIC_INT_TO_REG_ADDR(VIC_INT_POLARITY0, irq);
-	unsigned index = VIC_INT_TO_REG_INDEX(irq);
-	int b = 1 << (irq & 31);
+	void __iomem *treg = VIC_INT_TO_REG_ADDR(VIC_INT_TYPE0, d->irq);
+	void __iomem *preg = VIC_INT_TO_REG_ADDR(VIC_INT_POLARITY0, d->irq);
+	unsigned index = VIC_INT_TO_REG_INDEX(d->irq);
+	int b = 1 << (d->irq & 31);
 	uint32_t polarity;
 	uint32_t type;
 
@@ -314,11 +313,11 @@ static int msm_irq_set_type(unsigned int irq, unsigned int flow_type)
 	type = msm_irq_shadow_reg[index].int_type;
 	if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
 		type |= b;
-		irq_desc[irq].handle_irq = handle_edge_irq;
+		irq_desc[d->irq].handle_irq = handle_edge_irq;
 	}
 	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW)) {
 		type &= ~b;
-		irq_desc[irq].handle_irq = handle_level_irq;
+		irq_desc[d->irq].handle_irq = handle_level_irq;
 	}
 	writel(type, treg);
 	msm_irq_shadow_reg[index].int_type = type;
@@ -326,13 +325,13 @@ static int msm_irq_set_type(unsigned int irq, unsigned int flow_type)
 }
 
 static struct irq_chip msm_irq_chip = {
-	.name      = "msm",
-	.disable   = msm_irq_mask,
-	.ack       = msm_irq_ack,
-	.mask      = msm_irq_mask,
-	.unmask    = msm_irq_unmask,
-	.set_wake  = msm_irq_set_wake,
-	.set_type  = msm_irq_set_type,
+	.name          = "msm",
+	.irq_disable   = msm_irq_mask,
+	.irq_ack       = msm_irq_ack,
+	.irq_mask      = msm_irq_mask,
+	.irq_unmask    = msm_irq_unmask,
+	.irq_set_wake  = msm_irq_set_wake,
+	.irq_set_type  = msm_irq_set_type,
 };
 
 void __init msm_init_irq(void)
diff --git a/arch/arm/mach-msm/irq.c b/arch/arm/mach-msm/irq.c
index 6c8d5f8..0b27d89 100644
--- a/arch/arm/mach-msm/irq.c
+++ b/arch/arm/mach-msm/irq.c
@@ -64,35 +64,34 @@
 #define VIC_VECTPRIORITY(n) VIC_REG(0x0200+((n) * 4))
 #define VIC_VECTADDR(n)     VIC_REG(0x0400+((n) * 4))
 
-static void msm_irq_ack(unsigned int irq)
+static void msm_irq_ack(struct irq_data *d)
 {
-	void __iomem *reg = VIC_INT_CLEAR0 + ((irq & 32) ? 4 : 0);
-	irq = 1 << (irq & 31);
-	writel(irq, reg);
+	void __iomem *reg = VIC_INT_CLEAR0 + ((d->irq & 32) ? 4 : 0);
+	writel(1 << (d->irq & 31), reg);
 }
 
-static void msm_irq_mask(unsigned int irq)
+static void msm_irq_mask(struct irq_data *d)
 {
-	void __iomem *reg = VIC_INT_ENCLEAR0 + ((irq & 32) ? 4 : 0);
-	writel(1 << (irq & 31), reg);
+	void __iomem *reg = VIC_INT_ENCLEAR0 + ((d->irq & 32) ? 4 : 0);
+	writel(1 << (d->irq & 31), reg);
 }
 
-static void msm_irq_unmask(unsigned int irq)
+static void msm_irq_unmask(struct irq_data *d)
 {
-	void __iomem *reg = VIC_INT_ENSET0 + ((irq & 32) ? 4 : 0);
-	writel(1 << (irq & 31), reg);
+	void __iomem *reg = VIC_INT_ENSET0 + ((d->irq & 32) ? 4 : 0);
+	writel(1 << (d->irq & 31), reg);
 }
 
-static int msm_irq_set_wake(unsigned int irq, unsigned int on)
+static int msm_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	return -EINVAL;
 }
 
-static int msm_irq_set_type(unsigned int irq, unsigned int flow_type)
+static int msm_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	void __iomem *treg = VIC_INT_TYPE0 + ((irq & 32) ? 4 : 0);
-	void __iomem *preg = VIC_INT_POLARITY0 + ((irq & 32) ? 4 : 0);
-	int b = 1 << (irq & 31);
+	void __iomem *treg = VIC_INT_TYPE0 + ((d->irq & 32) ? 4 : 0);
+	void __iomem *preg = VIC_INT_POLARITY0 + ((d->irq & 32) ? 4 : 0);
+	int b = 1 << (d->irq & 31);
 
 	if (flow_type & (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_LOW))
 		writel(readl(preg) | b, preg);
@@ -101,22 +100,22 @@ static int msm_irq_set_type(unsigned int irq, unsigned int flow_type)
 
 	if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
 		writel(readl(treg) | b, treg);
-		irq_desc[irq].handle_irq = handle_edge_irq;
+		irq_desc[d->irq].handle_irq = handle_edge_irq;
 	}
 	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW)) {
 		writel(readl(treg) & (~b), treg);
-		irq_desc[irq].handle_irq = handle_level_irq;
+		irq_desc[d->irq].handle_irq = handle_level_irq;
 	}
 	return 0;
 }
 
 static struct irq_chip msm_irq_chip = {
-	.name      = "msm",
-	.ack       = msm_irq_ack,
-	.mask      = msm_irq_mask,
-	.unmask    = msm_irq_unmask,
-	.set_wake  = msm_irq_set_wake,
-	.set_type  = msm_irq_set_type,
+	.name          = "msm",
+	.irq_ack       = msm_irq_ack,
+	.irq_mask      = msm_irq_mask,
+	.irq_unmask    = msm_irq_unmask,
+	.irq_set_wake  = msm_irq_set_wake,
+	.irq_set_type  = msm_irq_set_type,
 };
 
 void __init msm_init_irq(void)
diff --git a/arch/arm/mach-msm/sirc.c b/arch/arm/mach-msm/sirc.c
index b079452..59d0a25 100644
--- a/arch/arm/mach-msm/sirc.c
+++ b/arch/arm/mach-msm/sirc.c
@@ -45,12 +45,11 @@ static unsigned int save_polarity;
 
 /* Mask off the given interrupt. Keep the int_enable mask in sync with
    the enable reg, so it can be restored after power collapse. */
-static void sirc_irq_mask(unsigned int irq)
+static void sirc_irq_mask(struct irq_data *d)
 {
 	unsigned int mask;
 
-
-	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
 	writel(mask, sirc_regs.int_enable_clear);
 	int_enable &= ~mask;
 	return;
@@ -58,31 +57,31 @@ static void sirc_irq_mask(unsigned int irq)
 
 /* Unmask the given interrupt. Keep the int_enable mask in sync with
    the enable reg, so it can be restored after power collapse. */
-static void sirc_irq_unmask(unsigned int irq)
+static void sirc_irq_unmask(struct irq_data *d)
 {
 	unsigned int mask;
 
-	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
 	writel(mask, sirc_regs.int_enable_set);
 	int_enable |= mask;
 	return;
 }
 
-static void sirc_irq_ack(unsigned int irq)
+static void sirc_irq_ack(struct irq_data *d)
 {
 	unsigned int mask;
 
-	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
 	writel(mask, sirc_regs.int_clear);
 	return;
 }
 
-static int sirc_irq_set_wake(unsigned int irq, unsigned int on)
+static int sirc_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	unsigned int mask;
 
 	/* Used to set the interrupt enable mask during power collapse. */
-	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
 	if (on)
 		wake_enable |= mask;
 	else
@@ -91,12 +90,12 @@ static int sirc_irq_set_wake(unsigned int irq, unsigned int on)
 	return 0;
 }
 
-static int sirc_irq_set_type(unsigned int irq, unsigned int flow_type)
+static int sirc_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	unsigned int mask;
 	unsigned int val;
 
-	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
 	val = readl(sirc_regs.int_polarity);
 
 	if (flow_type & (IRQF_TRIGGER_LOW | IRQF_TRIGGER_FALLING))
@@ -109,10 +108,10 @@ static int sirc_irq_set_type(unsigned int irq, unsigned int flow_type)
 	val = readl(sirc_regs.int_type);
 	if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
 		val |= mask;
-		irq_desc[irq].handle_irq = handle_edge_irq;
+		irq_desc[d->irq].handle_irq = handle_edge_irq;
 	} else {
 		val &= ~mask;
-		irq_desc[irq].handle_irq = handle_level_irq;
+		irq_desc[d->irq].handle_irq = handle_level_irq;
 	}
 
 	writel(val, sirc_regs.int_type);
@@ -142,16 +141,16 @@ static void sirc_irq_handler(unsigned int irq, struct irq_desc *desc)
 		;
 	generic_handle_irq(sirq+FIRST_SIRC_IRQ);
 
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 }
 
 static struct irq_chip sirc_irq_chip = {
-	.name      = "sirc",
-	.ack       = sirc_irq_ack,
-	.mask      = sirc_irq_mask,
-	.unmask    = sirc_irq_unmask,
-	.set_wake  = sirc_irq_set_wake,
-	.set_type  = sirc_irq_set_type,
+	.name          = "sirc",
+	.irq_ack       = sirc_irq_ack,
+	.irq_mask      = sirc_irq_mask,
+	.irq_unmask    = sirc_irq_unmask,
+	.irq_set_wake  = sirc_irq_set_wake,
+	.irq_set_type  = sirc_irq_set_type,
 };
 
 void __init msm_init_sirc(void)
-- 
1.7.1
