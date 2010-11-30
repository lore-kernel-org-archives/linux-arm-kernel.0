From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:28 +0100
Subject: [PATCH 54/54] ARM: plat-stmp3xxx: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134128.GC15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/plat-stmp3xxx/irq.c    |    2 +-
 arch/arm/plat-stmp3xxx/pinmux.c |   32 ++++++++++++++++----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-stmp3xxx/irq.c b/arch/arm/plat-stmp3xxx/irq.c
index 20de4e0..aaa1686 100644
--- a/arch/arm/plat-stmp3xxx/irq.c
+++ b/arch/arm/plat-stmp3xxx/irq.c
@@ -34,7 +34,7 @@ void __init stmp3xxx_init_irq(struct irq_chip *chip)
 
 	/* Disable all interrupts initially */
 	for (i = 0; i < NR_REAL_IRQS; i++) {
-		chip->mask(i);
+		chip->irq_mask(irq_get_irq_data(i));
 		set_irq_chip(i, chip);
 		set_irq_handler(i, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
diff --git a/arch/arm/plat-stmp3xxx/pinmux.c b/arch/arm/plat-stmp3xxx/pinmux.c
index 6d6b1a4..66d5bac 100644
--- a/arch/arm/plat-stmp3xxx/pinmux.c
+++ b/arch/arm/plat-stmp3xxx/pinmux.c
@@ -351,27 +351,27 @@ void stmp3xxx_release_pin_group(struct pin_group *pin_group, const char *label)
 }
 EXPORT_SYMBOL(stmp3xxx_release_pin_group);
 
-static int stmp3xxx_irq_to_gpio(int irq,
+static int stmp3xxx_irq_data_to_gpio(struct irq_data *d,
 	struct stmp3xxx_pinmux_bank **bank, unsigned *gpio)
 {
 	struct stmp3xxx_pinmux_bank *pm;
 
 	for (pm = pinmux_banks; pm < pinmux_banks + NR_BANKS; pm++)
-		if (pm->virq <= irq && irq < pm->virq + 32) {
+		if (pm->virq <= d->irq && d->irq < pm->virq + 32) {
 			*bank = pm;
-			*gpio = irq - pm->virq;
+			*gpio = d->irq - pm->virq;
 			return 0;
 		}
 	return -ENOENT;
 }
 
-static int stmp3xxx_set_irqtype(unsigned irq, unsigned type)
+static int stmp3xxx_set_irqtype(struct irq_data *d, unsigned type)
 {
 	struct stmp3xxx_pinmux_bank *pm;
 	unsigned gpio;
 	int l, p;
 
-	stmp3xxx_irq_to_gpio(irq, &pm, &gpio);
+	stmp3xxx_irq_data_to_gpio(d, &pm, &gpio);
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		l = 0; p = 1; break;
@@ -398,33 +398,33 @@ static int stmp3xxx_set_irqtype(unsigned irq, unsigned type)
 	return 0;
 }
 
-static void stmp3xxx_pin_ack_irq(unsigned irq)
+static void stmp3xxx_pin_ack_irq(struct irq_data *d)
 {
 	u32 stat;
 	struct stmp3xxx_pinmux_bank *pm;
 	unsigned gpio;
 
-	stmp3xxx_irq_to_gpio(irq, &pm, &gpio);
+	stmp3xxx_irq_data_to_gpio(d, &pm, &gpio);
 	stat = __raw_readl(pm->irqstat) & (1 << gpio);
 	stmp3xxx_clearl(stat, pm->irqstat);
 }
 
-static void stmp3xxx_pin_mask_irq(unsigned irq)
+static void stmp3xxx_pin_mask_irq(struct irq_data *d)
 {
 	struct stmp3xxx_pinmux_bank *pm;
 	unsigned gpio;
 
-	stmp3xxx_irq_to_gpio(irq, &pm, &gpio);
+	stmp3xxx_irq_data_to_gpio(d, &pm, &gpio);
 	stmp3xxx_clearl(1 << gpio, pm->irqen);
 	stmp3xxx_clearl(1 << gpio, pm->pin2irq);
 }
 
-static void stmp3xxx_pin_unmask_irq(unsigned irq)
+static void stmp3xxx_pin_unmask_irq(struct irq_data *d)
 {
 	struct stmp3xxx_pinmux_bank *pm;
 	unsigned gpio;
 
-	stmp3xxx_irq_to_gpio(irq, &pm, &gpio);
+	stmp3xxx_irq_data_to_gpio(d, &pm, &gpio);
 	stmp3xxx_setl(1 << gpio, pm->irqen);
 	stmp3xxx_setl(1 << gpio, pm->pin2irq);
 }
@@ -503,10 +503,10 @@ static void stmp3xxx_gpio_irq(u32 irq, struct irq_desc *desc)
 }
 
 static struct irq_chip gpio_irq_chip = {
-	.ack	= stmp3xxx_pin_ack_irq,
-	.mask	= stmp3xxx_pin_mask_irq,
-	.unmask	= stmp3xxx_pin_unmask_irq,
-	.set_type = stmp3xxx_set_irqtype,
+	.irq_ack	= stmp3xxx_pin_ack_irq,
+	.irq_mask	= stmp3xxx_pin_mask_irq,
+	.irq_unmask	= stmp3xxx_pin_unmask_irq,
+	.irq_set_type	= stmp3xxx_set_irqtype,
 };
 
 int __init stmp3xxx_pinmux_init(int virtual_irq_start)
@@ -533,7 +533,7 @@ int __init stmp3xxx_pinmux_init(int virtual_irq_start)
 		pm->virq = virtual_irq_start + b * 32;
 
 		for (virq = pm->virq; virq < pm->virq; virq++) {
-			gpio_irq_chip.mask(virq);
+			gpio_irq_chip.irq_mask(irq_get_irq_data(virq));
 			set_irq_chip(virq, &gpio_irq_chip);
 			set_irq_handler(virq, handle_level_irq);
 			set_irq_flags(virq, IRQF_VALID);
-- 
1.7.1
