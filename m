From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 19 Sep 2011 16:03:21 +0200
Subject: [PATCH 10/11] at91/gpio: drop PIN_BASE
In-Reply-To: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1316441002-27381-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Reviewed-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-at91/gpio.c              |   54 ++--
 arch/arm/mach-at91/include/mach/gpio.h |  454 ++++++++++++++++----------------
 2 files changed, 254 insertions(+), 254 deletions(-)
 rewrite arch/arm/mach-at91/include/mach/gpio.h (78%)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 04beff1..e709406 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -60,18 +60,17 @@ static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 	}
 
 static struct at91_gpio_chip gpio_chip[] = {
-	AT91_GPIO_CHIP("A", 0x00 + PIN_BASE, 32),
-	AT91_GPIO_CHIP("B", 0x20 + PIN_BASE, 32),
-	AT91_GPIO_CHIP("C", 0x40 + PIN_BASE, 32),
-	AT91_GPIO_CHIP("D", 0x60 + PIN_BASE, 32),
-	AT91_GPIO_CHIP("E", 0x80 + PIN_BASE, 32),
+	AT91_GPIO_CHIP("A", 0x00, 32),
+	AT91_GPIO_CHIP("B", 0x20, 32),
+	AT91_GPIO_CHIP("C", 0x40, 32),
+	AT91_GPIO_CHIP("D", 0x60, 32),
+	AT91_GPIO_CHIP("E", 0x80, 32),
 };
 
 static int gpio_banks;
 
 static inline void __iomem *pin_to_controller(unsigned pin)
 {
-	pin -= PIN_BASE;
 	pin /= 32;
 	if (likely(pin < gpio_banks))
 		return gpio_chip[pin].regbase;
@@ -81,7 +80,6 @@ static inline void __iomem *pin_to_controller(unsigned pin)
 
 static inline unsigned pin_to_mask(unsigned pin)
 {
-	pin -= PIN_BASE;
 	return 1 << (pin % 32);
 }
 
@@ -276,8 +274,9 @@ static u32 backups[MAX_GPIO_BANKS];
 
 static int gpio_irq_set_wake(struct irq_data *d, unsigned state)
 {
-	unsigned	mask = pin_to_mask(d->irq);
-	unsigned	bank = (d->irq - PIN_BASE) / 32;
+	unsigned	pin = irq_to_gpio(d->irq);
+	unsigned	mask = pin_to_mask(pin);
+	unsigned	bank = pin / 32;
 
 	if (unlikely(bank >= MAX_GPIO_BANKS))
 		return -EINVAL;
@@ -346,8 +345,9 @@ void at91_gpio_resume(void)
 
 static void gpio_irq_mask(struct irq_data *d)
 {
-	void __iomem	*pio = pin_to_controller(d->irq);
-	unsigned	mask = pin_to_mask(d->irq);
+	unsigned	pin = irq_to_gpio(d->irq);
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
 
 	if (pio)
 		__raw_writel(mask, pio + PIO_IDR);
@@ -355,8 +355,9 @@ static void gpio_irq_mask(struct irq_data *d)
 
 static void gpio_irq_unmask(struct irq_data *d)
 {
-	void __iomem	*pio = pin_to_controller(d->irq);
-	unsigned	mask = pin_to_mask(d->irq);
+	unsigned	pin = irq_to_gpio(d->irq);
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
 
 	if (pio)
 		__raw_writel(mask, pio + PIO_IER);
@@ -384,7 +385,7 @@ static struct irq_chip gpio_irqchip = {
 
 static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	unsigned	pin;
+	unsigned	irq_pin;
 	struct irq_data *idata = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(idata);
 	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(idata);
@@ -407,12 +408,12 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 			continue;
 		}
 
-		pin = at91_gpio->chip.base;
+		irq_pin = gpio_to_irq(at91_gpio->chip.base);
 
 		while (isr) {
 			if (isr & 1)
-				generic_handle_irq(pin);
-			pin++;
+				generic_handle_irq(irq_pin);
+			irq_pin++;
 			isr >>= 1;
 		}
 	}
@@ -440,7 +441,7 @@ static int at91_gpio_show(struct seq_file *s, void *unused)
 		seq_printf(s, "%i:\t", j);
 
 		for (bank = 0; bank < gpio_banks; bank++) {
-			unsigned	pin  = PIN_BASE + (32 * bank) + j;
+			unsigned	pin  = (32 * bank) + j;
 			void __iomem	*pio = pin_to_controller(pin);
 			unsigned	mask = pin_to_mask(pin);
 
@@ -493,10 +494,10 @@ static struct lock_class_key gpio_lock_class;
  */
 void __init at91_gpio_irq_setup(void)
 {
-	unsigned		pioc, pin;
+	unsigned		pioc, irq = gpio_to_irq(0);
 	struct at91_gpio_chip	*this, *prev;
 
-	for (pioc = 0, pin = PIN_BASE, this = gpio_chip, prev = NULL;
+	for (pioc = 0, this = gpio_chip, prev = NULL;
 			pioc++ < gpio_banks;
 			prev = this, this++) {
 		unsigned	id = this->bank->id;
@@ -504,16 +505,17 @@ void __init at91_gpio_irq_setup(void)
 
 		__raw_writel(~0, this->regbase + PIO_IDR);
 
-		for (i = 0, pin = this->chip.base; i < 32; i++, pin++) {
-			irq_set_lockdep_class(pin, &gpio_lock_class);
+		for (i = 0, irq = gpio_to_irq(this->chip.base); i < 32;
+		     i++, irq++) {
+			irq_set_lockdep_class(irq, &gpio_lock_class);
 
 			/*
 			 * Can use the "simple" and not "edge" handler since it's
 			 * shorter, and the AIC handles interrupts sanely.
 			 */
-			irq_set_chip_and_handler(pin, &gpio_irqchip,
+			irq_set_chip_and_handler(irq, &gpio_irqchip,
 						 handle_simple_irq);
-			set_irq_flags(pin, IRQF_VALID);
+			set_irq_flags(irq, IRQF_VALID);
 		}
 
 		/* The toplevel handler handles one bank of GPIOs, except
@@ -526,7 +528,7 @@ void __init at91_gpio_irq_setup(void)
 		irq_set_chip_data(id, this);
 		irq_set_chained_handler(id, gpio_irq_handler);
 	}
-	pr_info("AT91: %d gpio irqs in %d banks\n", pin - PIN_BASE, gpio_banks);
+	pr_info("AT91: %d gpio irqs in %d banks\n", irq, gpio_banks);
 }
 
 /* gpiolib support */
@@ -615,7 +617,7 @@ void __init at91_gpio_init(struct at91_gpio_bank *data, int nr_banks)
 		at91_gpio = &gpio_chip[i];
 
 		at91_gpio->bank = &data[i];
-		at91_gpio->chip.base = PIN_BASE + i * 32;
+		at91_gpio->chip.base = i * 32;
 
 		at91_gpio->regbase = ioremap(at91_gpio->bank->regbase, 512);
 		if (!at91_gpio->regbase) {
diff --git a/arch/arm/mach-at91/include/mach/gpio.h b/arch/arm/mach-at91/include/mach/gpio.h
dissimilarity index 78%
index 056dc66..5213879 100644
--- a/arch/arm/mach-at91/include/mach/gpio.h
+++ b/arch/arm/mach-at91/include/mach/gpio.h
@@ -1,228 +1,226 @@
-/*
- * arch/arm/mach-at91/include/mach/gpio.h
- *
- *  Copyright (C) 2005 HP Labs
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#ifndef __ASM_ARCH_AT91RM9200_GPIO_H
-#define __ASM_ARCH_AT91RM9200_GPIO_H
-
-#include <linux/kernel.h>
-#include <asm/irq.h>
-
-#define PIN_BASE		NR_AIC_IRQS
-
-#define MAX_GPIO_BANKS		5
-#define NR_BUILTIN_GPIO		(PIN_BASE + (MAX_GPIO_BANKS * 32))
-
-/* these pin numbers double as IRQ numbers, like AT91xxx_ID_* values */
-
-#define	AT91_PIN_PA0	(PIN_BASE + 0x00 + 0)
-#define	AT91_PIN_PA1	(PIN_BASE + 0x00 + 1)
-#define	AT91_PIN_PA2	(PIN_BASE + 0x00 + 2)
-#define	AT91_PIN_PA3	(PIN_BASE + 0x00 + 3)
-#define	AT91_PIN_PA4	(PIN_BASE + 0x00 + 4)
-#define	AT91_PIN_PA5	(PIN_BASE + 0x00 + 5)
-#define	AT91_PIN_PA6	(PIN_BASE + 0x00 + 6)
-#define	AT91_PIN_PA7	(PIN_BASE + 0x00 + 7)
-#define	AT91_PIN_PA8	(PIN_BASE + 0x00 + 8)
-#define	AT91_PIN_PA9	(PIN_BASE + 0x00 + 9)
-#define	AT91_PIN_PA10	(PIN_BASE + 0x00 + 10)
-#define	AT91_PIN_PA11	(PIN_BASE + 0x00 + 11)
-#define	AT91_PIN_PA12	(PIN_BASE + 0x00 + 12)
-#define	AT91_PIN_PA13	(PIN_BASE + 0x00 + 13)
-#define	AT91_PIN_PA14	(PIN_BASE + 0x00 + 14)
-#define	AT91_PIN_PA15	(PIN_BASE + 0x00 + 15)
-#define	AT91_PIN_PA16	(PIN_BASE + 0x00 + 16)
-#define	AT91_PIN_PA17	(PIN_BASE + 0x00 + 17)
-#define	AT91_PIN_PA18	(PIN_BASE + 0x00 + 18)
-#define	AT91_PIN_PA19	(PIN_BASE + 0x00 + 19)
-#define	AT91_PIN_PA20	(PIN_BASE + 0x00 + 20)
-#define	AT91_PIN_PA21	(PIN_BASE + 0x00 + 21)
-#define	AT91_PIN_PA22	(PIN_BASE + 0x00 + 22)
-#define	AT91_PIN_PA23	(PIN_BASE + 0x00 + 23)
-#define	AT91_PIN_PA24	(PIN_BASE + 0x00 + 24)
-#define	AT91_PIN_PA25	(PIN_BASE + 0x00 + 25)
-#define	AT91_PIN_PA26	(PIN_BASE + 0x00 + 26)
-#define	AT91_PIN_PA27	(PIN_BASE + 0x00 + 27)
-#define	AT91_PIN_PA28	(PIN_BASE + 0x00 + 28)
-#define	AT91_PIN_PA29	(PIN_BASE + 0x00 + 29)
-#define	AT91_PIN_PA30	(PIN_BASE + 0x00 + 30)
-#define	AT91_PIN_PA31	(PIN_BASE + 0x00 + 31)
-
-#define	AT91_PIN_PB0	(PIN_BASE + 0x20 + 0)
-#define	AT91_PIN_PB1	(PIN_BASE + 0x20 + 1)
-#define	AT91_PIN_PB2	(PIN_BASE + 0x20 + 2)
-#define	AT91_PIN_PB3	(PIN_BASE + 0x20 + 3)
-#define	AT91_PIN_PB4	(PIN_BASE + 0x20 + 4)
-#define	AT91_PIN_PB5	(PIN_BASE + 0x20 + 5)
-#define	AT91_PIN_PB6	(PIN_BASE + 0x20 + 6)
-#define	AT91_PIN_PB7	(PIN_BASE + 0x20 + 7)
-#define	AT91_PIN_PB8	(PIN_BASE + 0x20 + 8)
-#define	AT91_PIN_PB9	(PIN_BASE + 0x20 + 9)
-#define	AT91_PIN_PB10	(PIN_BASE + 0x20 + 10)
-#define	AT91_PIN_PB11	(PIN_BASE + 0x20 + 11)
-#define	AT91_PIN_PB12	(PIN_BASE + 0x20 + 12)
-#define	AT91_PIN_PB13	(PIN_BASE + 0x20 + 13)
-#define	AT91_PIN_PB14	(PIN_BASE + 0x20 + 14)
-#define	AT91_PIN_PB15	(PIN_BASE + 0x20 + 15)
-#define	AT91_PIN_PB16	(PIN_BASE + 0x20 + 16)
-#define	AT91_PIN_PB17	(PIN_BASE + 0x20 + 17)
-#define	AT91_PIN_PB18	(PIN_BASE + 0x20 + 18)
-#define	AT91_PIN_PB19	(PIN_BASE + 0x20 + 19)
-#define	AT91_PIN_PB20	(PIN_BASE + 0x20 + 20)
-#define	AT91_PIN_PB21	(PIN_BASE + 0x20 + 21)
-#define	AT91_PIN_PB22	(PIN_BASE + 0x20 + 22)
-#define	AT91_PIN_PB23	(PIN_BASE + 0x20 + 23)
-#define	AT91_PIN_PB24	(PIN_BASE + 0x20 + 24)
-#define	AT91_PIN_PB25	(PIN_BASE + 0x20 + 25)
-#define	AT91_PIN_PB26	(PIN_BASE + 0x20 + 26)
-#define	AT91_PIN_PB27	(PIN_BASE + 0x20 + 27)
-#define	AT91_PIN_PB28	(PIN_BASE + 0x20 + 28)
-#define	AT91_PIN_PB29	(PIN_BASE + 0x20 + 29)
-#define	AT91_PIN_PB30	(PIN_BASE + 0x20 + 30)
-#define	AT91_PIN_PB31	(PIN_BASE + 0x20 + 31)
-
-#define	AT91_PIN_PC0	(PIN_BASE + 0x40 + 0)
-#define	AT91_PIN_PC1	(PIN_BASE + 0x40 + 1)
-#define	AT91_PIN_PC2	(PIN_BASE + 0x40 + 2)
-#define	AT91_PIN_PC3	(PIN_BASE + 0x40 + 3)
-#define	AT91_PIN_PC4	(PIN_BASE + 0x40 + 4)
-#define	AT91_PIN_PC5	(PIN_BASE + 0x40 + 5)
-#define	AT91_PIN_PC6	(PIN_BASE + 0x40 + 6)
-#define	AT91_PIN_PC7	(PIN_BASE + 0x40 + 7)
-#define	AT91_PIN_PC8	(PIN_BASE + 0x40 + 8)
-#define	AT91_PIN_PC9	(PIN_BASE + 0x40 + 9)
-#define	AT91_PIN_PC10	(PIN_BASE + 0x40 + 10)
-#define	AT91_PIN_PC11	(PIN_BASE + 0x40 + 11)
-#define	AT91_PIN_PC12	(PIN_BASE + 0x40 + 12)
-#define	AT91_PIN_PC13	(PIN_BASE + 0x40 + 13)
-#define	AT91_PIN_PC14	(PIN_BASE + 0x40 + 14)
-#define	AT91_PIN_PC15	(PIN_BASE + 0x40 + 15)
-#define	AT91_PIN_PC16	(PIN_BASE + 0x40 + 16)
-#define	AT91_PIN_PC17	(PIN_BASE + 0x40 + 17)
-#define	AT91_PIN_PC18	(PIN_BASE + 0x40 + 18)
-#define	AT91_PIN_PC19	(PIN_BASE + 0x40 + 19)
-#define	AT91_PIN_PC20	(PIN_BASE + 0x40 + 20)
-#define	AT91_PIN_PC21	(PIN_BASE + 0x40 + 21)
-#define	AT91_PIN_PC22	(PIN_BASE + 0x40 + 22)
-#define	AT91_PIN_PC23	(PIN_BASE + 0x40 + 23)
-#define	AT91_PIN_PC24	(PIN_BASE + 0x40 + 24)
-#define	AT91_PIN_PC25	(PIN_BASE + 0x40 + 25)
-#define	AT91_PIN_PC26	(PIN_BASE + 0x40 + 26)
-#define	AT91_PIN_PC27	(PIN_BASE + 0x40 + 27)
-#define	AT91_PIN_PC28	(PIN_BASE + 0x40 + 28)
-#define	AT91_PIN_PC29	(PIN_BASE + 0x40 + 29)
-#define	AT91_PIN_PC30	(PIN_BASE + 0x40 + 30)
-#define	AT91_PIN_PC31	(PIN_BASE + 0x40 + 31)
-
-#define	AT91_PIN_PD0	(PIN_BASE + 0x60 + 0)
-#define	AT91_PIN_PD1	(PIN_BASE + 0x60 + 1)
-#define	AT91_PIN_PD2	(PIN_BASE + 0x60 + 2)
-#define	AT91_PIN_PD3	(PIN_BASE + 0x60 + 3)
-#define	AT91_PIN_PD4	(PIN_BASE + 0x60 + 4)
-#define	AT91_PIN_PD5	(PIN_BASE + 0x60 + 5)
-#define	AT91_PIN_PD6	(PIN_BASE + 0x60 + 6)
-#define	AT91_PIN_PD7	(PIN_BASE + 0x60 + 7)
-#define	AT91_PIN_PD8	(PIN_BASE + 0x60 + 8)
-#define	AT91_PIN_PD9	(PIN_BASE + 0x60 + 9)
-#define	AT91_PIN_PD10	(PIN_BASE + 0x60 + 10)
-#define	AT91_PIN_PD11	(PIN_BASE + 0x60 + 11)
-#define	AT91_PIN_PD12	(PIN_BASE + 0x60 + 12)
-#define	AT91_PIN_PD13	(PIN_BASE + 0x60 + 13)
-#define	AT91_PIN_PD14	(PIN_BASE + 0x60 + 14)
-#define	AT91_PIN_PD15	(PIN_BASE + 0x60 + 15)
-#define	AT91_PIN_PD16	(PIN_BASE + 0x60 + 16)
-#define	AT91_PIN_PD17	(PIN_BASE + 0x60 + 17)
-#define	AT91_PIN_PD18	(PIN_BASE + 0x60 + 18)
-#define	AT91_PIN_PD19	(PIN_BASE + 0x60 + 19)
-#define	AT91_PIN_PD20	(PIN_BASE + 0x60 + 20)
-#define	AT91_PIN_PD21	(PIN_BASE + 0x60 + 21)
-#define	AT91_PIN_PD22	(PIN_BASE + 0x60 + 22)
-#define	AT91_PIN_PD23	(PIN_BASE + 0x60 + 23)
-#define	AT91_PIN_PD24	(PIN_BASE + 0x60 + 24)
-#define	AT91_PIN_PD25	(PIN_BASE + 0x60 + 25)
-#define	AT91_PIN_PD26	(PIN_BASE + 0x60 + 26)
-#define	AT91_PIN_PD27	(PIN_BASE + 0x60 + 27)
-#define	AT91_PIN_PD28	(PIN_BASE + 0x60 + 28)
-#define	AT91_PIN_PD29	(PIN_BASE + 0x60 + 29)
-#define	AT91_PIN_PD30	(PIN_BASE + 0x60 + 30)
-#define	AT91_PIN_PD31	(PIN_BASE + 0x60 + 31)
-
-#define	AT91_PIN_PE0	(PIN_BASE + 0x80 + 0)
-#define	AT91_PIN_PE1	(PIN_BASE + 0x80 + 1)
-#define	AT91_PIN_PE2	(PIN_BASE + 0x80 + 2)
-#define	AT91_PIN_PE3	(PIN_BASE + 0x80 + 3)
-#define	AT91_PIN_PE4	(PIN_BASE + 0x80 + 4)
-#define	AT91_PIN_PE5	(PIN_BASE + 0x80 + 5)
-#define	AT91_PIN_PE6	(PIN_BASE + 0x80 + 6)
-#define	AT91_PIN_PE7	(PIN_BASE + 0x80 + 7)
-#define	AT91_PIN_PE8	(PIN_BASE + 0x80 + 8)
-#define	AT91_PIN_PE9	(PIN_BASE + 0x80 + 9)
-#define	AT91_PIN_PE10	(PIN_BASE + 0x80 + 10)
-#define	AT91_PIN_PE11	(PIN_BASE + 0x80 + 11)
-#define	AT91_PIN_PE12	(PIN_BASE + 0x80 + 12)
-#define	AT91_PIN_PE13	(PIN_BASE + 0x80 + 13)
-#define	AT91_PIN_PE14	(PIN_BASE + 0x80 + 14)
-#define	AT91_PIN_PE15	(PIN_BASE + 0x80 + 15)
-#define	AT91_PIN_PE16	(PIN_BASE + 0x80 + 16)
-#define	AT91_PIN_PE17	(PIN_BASE + 0x80 + 17)
-#define	AT91_PIN_PE18	(PIN_BASE + 0x80 + 18)
-#define	AT91_PIN_PE19	(PIN_BASE + 0x80 + 19)
-#define	AT91_PIN_PE20	(PIN_BASE + 0x80 + 20)
-#define	AT91_PIN_PE21	(PIN_BASE + 0x80 + 21)
-#define	AT91_PIN_PE22	(PIN_BASE + 0x80 + 22)
-#define	AT91_PIN_PE23	(PIN_BASE + 0x80 + 23)
-#define	AT91_PIN_PE24	(PIN_BASE + 0x80 + 24)
-#define	AT91_PIN_PE25	(PIN_BASE + 0x80 + 25)
-#define	AT91_PIN_PE26	(PIN_BASE + 0x80 + 26)
-#define	AT91_PIN_PE27	(PIN_BASE + 0x80 + 27)
-#define	AT91_PIN_PE28	(PIN_BASE + 0x80 + 28)
-#define	AT91_PIN_PE29	(PIN_BASE + 0x80 + 29)
-#define	AT91_PIN_PE30	(PIN_BASE + 0x80 + 30)
-#define	AT91_PIN_PE31	(PIN_BASE + 0x80 + 31)
-
-#ifndef __ASSEMBLY__
-/* setup setup routines, called from board init or driver probe() */
-extern int __init_or_module at91_set_GPIO_periph(unsigned pin, int use_pullup);
-extern int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup);
-extern int __init_or_module at91_set_B_periph(unsigned pin, int use_pullup);
-extern int __init_or_module at91_set_gpio_input(unsigned pin, int use_pullup);
-extern int __init_or_module at91_set_gpio_output(unsigned pin, int value);
-extern int __init_or_module at91_set_deglitch(unsigned pin, int is_on);
-extern int __init_or_module at91_set_multi_drive(unsigned pin, int is_on);
-
-/* callable at any time */
-extern int at91_set_gpio_value(unsigned pin, int value);
-extern int at91_get_gpio_value(unsigned pin);
-
-/* callable only from core power-management code */
-extern void at91_gpio_suspend(void);
-extern void at91_gpio_resume(void);
-
-/*-------------------------------------------------------------------------*/
-
-/* wrappers for "new style" GPIO calls. the old AT91-specific ones should
- * eventually be removed (along with this errno.h inclusion), and the
- * gpio request/free calls should probably be implemented.
- */
-
-#include <asm/errno.h>
-#include <asm-generic/gpio.h>		/* cansleep wrappers */
-
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
-
-#define gpio_to_irq(gpio) (gpio)
-#define irq_to_gpio(irq)  (irq)
-
-#endif	/* __ASSEMBLY__ */
-
-#endif
+/*
+ * arch/arm/mach-at91/include/mach/gpio.h
+ *
+ *  Copyright (C) 2005 HP Labs
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef __ASM_ARCH_AT91RM9200_GPIO_H
+#define __ASM_ARCH_AT91RM9200_GPIO_H
+
+#include <linux/kernel.h>
+#include <asm/irq.h>
+
+#define MAX_GPIO_BANKS		5
+#define NR_BUILTIN_GPIO		(MAX_GPIO_BANKS * 32)
+
+/* these pin numbers double as IRQ numbers, like AT91xxx_ID_* values */
+
+#define	AT91_PIN_PA0	(0x00 + 0)
+#define	AT91_PIN_PA1	(0x00 + 1)
+#define	AT91_PIN_PA2	(0x00 + 2)
+#define	AT91_PIN_PA3	(0x00 + 3)
+#define	AT91_PIN_PA4	(0x00 + 4)
+#define	AT91_PIN_PA5	(0x00 + 5)
+#define	AT91_PIN_PA6	(0x00 + 6)
+#define	AT91_PIN_PA7	(0x00 + 7)
+#define	AT91_PIN_PA8	(0x00 + 8)
+#define	AT91_PIN_PA9	(0x00 + 9)
+#define	AT91_PIN_PA10	(0x00 + 10)
+#define	AT91_PIN_PA11	(0x00 + 11)
+#define	AT91_PIN_PA12	(0x00 + 12)
+#define	AT91_PIN_PA13	(0x00 + 13)
+#define	AT91_PIN_PA14	(0x00 + 14)
+#define	AT91_PIN_PA15	(0x00 + 15)
+#define	AT91_PIN_PA16	(0x00 + 16)
+#define	AT91_PIN_PA17	(0x00 + 17)
+#define	AT91_PIN_PA18	(0x00 + 18)
+#define	AT91_PIN_PA19	(0x00 + 19)
+#define	AT91_PIN_PA20	(0x00 + 20)
+#define	AT91_PIN_PA21	(0x00 + 21)
+#define	AT91_PIN_PA22	(0x00 + 22)
+#define	AT91_PIN_PA23	(0x00 + 23)
+#define	AT91_PIN_PA24	(0x00 + 24)
+#define	AT91_PIN_PA25	(0x00 + 25)
+#define	AT91_PIN_PA26	(0x00 + 26)
+#define	AT91_PIN_PA27	(0x00 + 27)
+#define	AT91_PIN_PA28	(0x00 + 28)
+#define	AT91_PIN_PA29	(0x00 + 29)
+#define	AT91_PIN_PA30	(0x00 + 30)
+#define	AT91_PIN_PA31	(0x00 + 31)
+
+#define	AT91_PIN_PB0	(0x20 + 0)
+#define	AT91_PIN_PB1	(0x20 + 1)
+#define	AT91_PIN_PB2	(0x20 + 2)
+#define	AT91_PIN_PB3	(0x20 + 3)
+#define	AT91_PIN_PB4	(0x20 + 4)
+#define	AT91_PIN_PB5	(0x20 + 5)
+#define	AT91_PIN_PB6	(0x20 + 6)
+#define	AT91_PIN_PB7	(0x20 + 7)
+#define	AT91_PIN_PB8	(0x20 + 8)
+#define	AT91_PIN_PB9	(0x20 + 9)
+#define	AT91_PIN_PB10	(0x20 + 10)
+#define	AT91_PIN_PB11	(0x20 + 11)
+#define	AT91_PIN_PB12	(0x20 + 12)
+#define	AT91_PIN_PB13	(0x20 + 13)
+#define	AT91_PIN_PB14	(0x20 + 14)
+#define	AT91_PIN_PB15	(0x20 + 15)
+#define	AT91_PIN_PB16	(0x20 + 16)
+#define	AT91_PIN_PB17	(0x20 + 17)
+#define	AT91_PIN_PB18	(0x20 + 18)
+#define	AT91_PIN_PB19	(0x20 + 19)
+#define	AT91_PIN_PB20	(0x20 + 20)
+#define	AT91_PIN_PB21	(0x20 + 21)
+#define	AT91_PIN_PB22	(0x20 + 22)
+#define	AT91_PIN_PB23	(0x20 + 23)
+#define	AT91_PIN_PB24	(0x20 + 24)
+#define	AT91_PIN_PB25	(0x20 + 25)
+#define	AT91_PIN_PB26	(0x20 + 26)
+#define	AT91_PIN_PB27	(0x20 + 27)
+#define	AT91_PIN_PB28	(0x20 + 28)
+#define	AT91_PIN_PB29	(0x20 + 29)
+#define	AT91_PIN_PB30	(0x20 + 30)
+#define	AT91_PIN_PB31	(0x20 + 31)
+
+#define	AT91_PIN_PC0	(0x40 + 0)
+#define	AT91_PIN_PC1	(0x40 + 1)
+#define	AT91_PIN_PC2	(0x40 + 2)
+#define	AT91_PIN_PC3	(0x40 + 3)
+#define	AT91_PIN_PC4	(0x40 + 4)
+#define	AT91_PIN_PC5	(0x40 + 5)
+#define	AT91_PIN_PC6	(0x40 + 6)
+#define	AT91_PIN_PC7	(0x40 + 7)
+#define	AT91_PIN_PC8	(0x40 + 8)
+#define	AT91_PIN_PC9	(0x40 + 9)
+#define	AT91_PIN_PC10	(0x40 + 10)
+#define	AT91_PIN_PC11	(0x40 + 11)
+#define	AT91_PIN_PC12	(0x40 + 12)
+#define	AT91_PIN_PC13	(0x40 + 13)
+#define	AT91_PIN_PC14	(0x40 + 14)
+#define	AT91_PIN_PC15	(0x40 + 15)
+#define	AT91_PIN_PC16	(0x40 + 16)
+#define	AT91_PIN_PC17	(0x40 + 17)
+#define	AT91_PIN_PC18	(0x40 + 18)
+#define	AT91_PIN_PC19	(0x40 + 19)
+#define	AT91_PIN_PC20	(0x40 + 20)
+#define	AT91_PIN_PC21	(0x40 + 21)
+#define	AT91_PIN_PC22	(0x40 + 22)
+#define	AT91_PIN_PC23	(0x40 + 23)
+#define	AT91_PIN_PC24	(0x40 + 24)
+#define	AT91_PIN_PC25	(0x40 + 25)
+#define	AT91_PIN_PC26	(0x40 + 26)
+#define	AT91_PIN_PC27	(0x40 + 27)
+#define	AT91_PIN_PC28	(0x40 + 28)
+#define	AT91_PIN_PC29	(0x40 + 29)
+#define	AT91_PIN_PC30	(0x40 + 30)
+#define	AT91_PIN_PC31	(0x40 + 31)
+
+#define	AT91_PIN_PD0	(0x60 + 0)
+#define	AT91_PIN_PD1	(0x60 + 1)
+#define	AT91_PIN_PD2	(0x60 + 2)
+#define	AT91_PIN_PD3	(0x60 + 3)
+#define	AT91_PIN_PD4	(0x60 + 4)
+#define	AT91_PIN_PD5	(0x60 + 5)
+#define	AT91_PIN_PD6	(0x60 + 6)
+#define	AT91_PIN_PD7	(0x60 + 7)
+#define	AT91_PIN_PD8	(0x60 + 8)
+#define	AT91_PIN_PD9	(0x60 + 9)
+#define	AT91_PIN_PD10	(0x60 + 10)
+#define	AT91_PIN_PD11	(0x60 + 11)
+#define	AT91_PIN_PD12	(0x60 + 12)
+#define	AT91_PIN_PD13	(0x60 + 13)
+#define	AT91_PIN_PD14	(0x60 + 14)
+#define	AT91_PIN_PD15	(0x60 + 15)
+#define	AT91_PIN_PD16	(0x60 + 16)
+#define	AT91_PIN_PD17	(0x60 + 17)
+#define	AT91_PIN_PD18	(0x60 + 18)
+#define	AT91_PIN_PD19	(0x60 + 19)
+#define	AT91_PIN_PD20	(0x60 + 20)
+#define	AT91_PIN_PD21	(0x60 + 21)
+#define	AT91_PIN_PD22	(0x60 + 22)
+#define	AT91_PIN_PD23	(0x60 + 23)
+#define	AT91_PIN_PD24	(0x60 + 24)
+#define	AT91_PIN_PD25	(0x60 + 25)
+#define	AT91_PIN_PD26	(0x60 + 26)
+#define	AT91_PIN_PD27	(0x60 + 27)
+#define	AT91_PIN_PD28	(0x60 + 28)
+#define	AT91_PIN_PD29	(0x60 + 29)
+#define	AT91_PIN_PD30	(0x60 + 30)
+#define	AT91_PIN_PD31	(0x60 + 31)
+
+#define	AT91_PIN_PE0	(0x80 + 0)
+#define	AT91_PIN_PE1	(0x80 + 1)
+#define	AT91_PIN_PE2	(0x80 + 2)
+#define	AT91_PIN_PE3	(0x80 + 3)
+#define	AT91_PIN_PE4	(0x80 + 4)
+#define	AT91_PIN_PE5	(0x80 + 5)
+#define	AT91_PIN_PE6	(0x80 + 6)
+#define	AT91_PIN_PE7	(0x80 + 7)
+#define	AT91_PIN_PE8	(0x80 + 8)
+#define	AT91_PIN_PE9	(0x80 + 9)
+#define	AT91_PIN_PE10	(0x80 + 10)
+#define	AT91_PIN_PE11	(0x80 + 11)
+#define	AT91_PIN_PE12	(0x80 + 12)
+#define	AT91_PIN_PE13	(0x80 + 13)
+#define	AT91_PIN_PE14	(0x80 + 14)
+#define	AT91_PIN_PE15	(0x80 + 15)
+#define	AT91_PIN_PE16	(0x80 + 16)
+#define	AT91_PIN_PE17	(0x80 + 17)
+#define	AT91_PIN_PE18	(0x80 + 18)
+#define	AT91_PIN_PE19	(0x80 + 19)
+#define	AT91_PIN_PE20	(0x80 + 20)
+#define	AT91_PIN_PE21	(0x80 + 21)
+#define	AT91_PIN_PE22	(0x80 + 22)
+#define	AT91_PIN_PE23	(0x80 + 23)
+#define	AT91_PIN_PE24	(0x80 + 24)
+#define	AT91_PIN_PE25	(0x80 + 25)
+#define	AT91_PIN_PE26	(0x80 + 26)
+#define	AT91_PIN_PE27	(0x80 + 27)
+#define	AT91_PIN_PE28	(0x80 + 28)
+#define	AT91_PIN_PE29	(0x80 + 29)
+#define	AT91_PIN_PE30	(0x80 + 30)
+#define	AT91_PIN_PE31	(0x80 + 31)
+
+#ifndef __ASSEMBLY__
+/* setup setup routines, called from board init or driver probe() */
+extern int __init_or_module at91_set_GPIO_periph(unsigned pin, int use_pullup);
+extern int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup);
+extern int __init_or_module at91_set_B_periph(unsigned pin, int use_pullup);
+extern int __init_or_module at91_set_gpio_input(unsigned pin, int use_pullup);
+extern int __init_or_module at91_set_gpio_output(unsigned pin, int value);
+extern int __init_or_module at91_set_deglitch(unsigned pin, int is_on);
+extern int __init_or_module at91_set_multi_drive(unsigned pin, int is_on);
+
+/* callable at any time */
+extern int at91_set_gpio_value(unsigned pin, int value);
+extern int at91_get_gpio_value(unsigned pin);
+
+/* callable only from core power-management code */
+extern void at91_gpio_suspend(void);
+extern void at91_gpio_resume(void);
+
+/*-------------------------------------------------------------------------*/
+
+/* wrappers for "new style" GPIO calls. the old AT91-specific ones should
+ * eventually be removed (along with this errno.h inclusion), and the
+ * gpio request/free calls should probably be implemented.
+ */
+
+#include <asm/errno.h>
+#include <asm-generic/gpio.h>		/* cansleep wrappers */
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+
+#define gpio_to_irq(gpio) (gpio + NR_AIC_IRQS)
+#define irq_to_gpio(irq)  (irq - NR_AIC_IRQS)
+
+#endif	/* __ASSEMBLY__ */
+
+#endif
-- 
1.7.5.4
