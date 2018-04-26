From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 26 Apr 2018 18:18:29 +0200
Subject: [PATCH 06/11] irqchip: stm32: prepare common functions
In-Reply-To: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1524759514-12392-7-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch prepares functions which could be reused by
next variant of stm32 exti controller.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 91 +++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 9655a57..b38c655 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -145,37 +145,50 @@ static void stm32_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
+static int stm32_exti_set_type(struct irq_data *d,
+			       unsigned int type, u32 *rtsr, u32 *ftsr)
 {
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	struct stm32_exti_chip_data *chip_data = gc->private;
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	int pin = data->hwirq % IRQS_PER_BANK;
-	u32 rtsr, ftsr;
-
-	irq_gc_lock(gc);
-
-	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
-	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		rtsr |= BIT(pin);
-		ftsr &= ~BIT(pin);
+		*rtsr |= mask;
+		*ftsr &= ~mask;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		rtsr &= ~BIT(pin);
-		ftsr |= BIT(pin);
+		*rtsr &= ~mask;
+		*ftsr |= mask;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		rtsr |= BIT(pin);
-		ftsr |= BIT(pin);
+		*rtsr |= mask;
+		*ftsr |= mask;
 		break;
 	default:
-		irq_gc_unlock(gc);
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	u32 rtsr, ftsr;
+	int err;
+
+	irq_gc_lock(gc);
+
+	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
+	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
+
+	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
+	if (err) {
+		irq_gc_unlock(gc);
+		return err;
+	}
+
 	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
 
@@ -184,35 +197,47 @@ static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
-static void stm32_irq_suspend(struct irq_chip_generic *gc)
+static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
+			       u32 wake_active)
 {
-	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	irq_gc_lock(gc);
+	void __iomem *base = chip_data->host_data->base;
 
 	/* save rtsr, ftsr registers */
-	chip_data->rtsr_cache = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
-	chip_data->ftsr_cache = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
+	chip_data->rtsr_cache = readl_relaxed(base + stm32_bank->rtsr_ofst);
+	chip_data->ftsr_cache = readl_relaxed(base + stm32_bank->ftsr_ofst);
 
-	irq_reg_writel(gc, gc->wake_active, stm32_bank->imr_ofst);
+	writel_relaxed(wake_active, base + stm32_bank->imr_ofst);
+}
 
-	irq_gc_unlock(gc);
+static void stm32_chip_resume(struct stm32_exti_chip_data *chip_data,
+			      u32 mask_cache)
+{
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+
+	/* restore rtsr, ftsr, registers */
+	writel_relaxed(chip_data->rtsr_cache, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(chip_data->ftsr_cache, base + stm32_bank->ftsr_ofst);
+
+	writel_relaxed(mask_cache, base + stm32_bank->imr_ofst);
 }
 
-static void stm32_irq_resume(struct irq_chip_generic *gc)
+static void stm32_irq_suspend(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
 
 	irq_gc_lock(gc);
+	stm32_chip_suspend(chip_data, gc->wake_active);
+	irq_gc_unlock(gc);
+}
 
-	/* restore rtsr, ftsr registers */
-	irq_reg_writel(gc, chip_data->rtsr_cache, stm32_bank->rtsr_ofst);
-	irq_reg_writel(gc, chip_data->ftsr_cache, stm32_bank->ftsr_ofst);
-
-	irq_reg_writel(gc, gc->mask_cache, stm32_bank->imr_ofst);
+static void stm32_irq_resume(struct irq_chip_generic *gc)
+{
+	struct stm32_exti_chip_data *chip_data = gc->private;
 
+	irq_gc_lock(gc);
+	stm32_chip_resume(chip_data, gc->mask_cache);
 	irq_gc_unlock(gc);
 }
 
-- 
2.7.4
