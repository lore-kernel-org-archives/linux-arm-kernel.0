From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 13 Oct 2011 12:07:05 +0800
Subject: [PATCH v4 8/8] ARM: pxa: move macros into gpio-pxa.c
In-Reply-To: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
References: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1318478825-17187-9-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move macro like PXA_GPLR(). Use pxa_gpio_bank_read()/pxa_gpio_bank_write()
instead. And append pxa_gpio_pin_get()/ pxa_gpio_pin_set() /
pxa_gpio_pin_clear() for operation on single GPIO pin.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/corgi_pm.c         |   13 ++-
 arch/arm/mach-pxa/include/mach/idp.h |    2 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c       |   16 ++--
 arch/arm/mach-pxa/spitz_pm.c         |   11 ++-
 drivers/gpio/gpio-pxa.c              |  149 ++++++++++++++++++++--------------
 include/linux/gpio-pxa.h             |   66 +++++----------
 6 files changed, 135 insertions(+), 122 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 96183c6..a0ee790 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/apm-emulation.h>
@@ -90,7 +91,8 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 {
 	int is_resume = 0;
 
-	dev_dbg(sharpsl_pm.dev, "PXA_GPLR0 = %x,%x\n", PXA_GPLR(0), PEDR);
+	dev_dbg(sharpsl_pm.dev, "PXA_GPLR0 = %x,%x\n",
+		pxa_gpio_bank_read(PXA_GPLR, 0), PEDR);
 
 	if ((PEDR & PXA_GPIO_bit(CORGI_GPIO_AC_IN))) {
 		if (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN)) {
@@ -124,15 +126,18 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 
 static unsigned long corgi_charger_wakeup(void)
 {
-	return ~PXA_GPLR(CORGI_GPIO_AC_IN) & ( PXA_GPIO_bit(CORGI_GPIO_AC_IN)
-		| PXA_GPIO_bit(CORGI_GPIO_KEY_INT) | PXA_GPIO_bit(CORGI_GPIO_WAKEUP) );
+	unsigned long ret;
+	ret = pxa_gpio_pin_get(PXA_GPLR, CORGI_GPIO_AC_IN)
+		| pxa_gpio_pin_get(PXA_GPLR, CORGI_GPIO_KEY_INT)
+		| pxa_gpio_pin_get(PXA_GPLR, CORGI_GPIO_WAKEUP);
+	return !ret;
 }
 
 unsigned long corgipm_read_devdata(int type)
 {
 	switch(type) {
 	case SHARPSL_STATUS_ACIN:
-		return ((PXA_GPLR(CORGI_GPIO_AC_IN) & PXA_GPIO_bit(CORGI_GPIO_AC_IN)) != 0);
+		return pxa_gpio_pin_get(PXA_GPLR, CORGI_GPIO_AC_IN);
 	case SHARPSL_STATUS_LOCK:
 		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
diff --git a/arch/arm/mach-pxa/include/mach/idp.h b/arch/arm/mach-pxa/include/mach/idp.h
index d784e4c..4ccc385 100644
--- a/arch/arm/mach-pxa/include/mach/idp.h
+++ b/arch/arm/mach-pxa/include/mach/idp.h
@@ -131,7 +131,7 @@
 #define PCC_VS2		(1 << 1)
 #define PCC_VS1		(1 << 0)
 
-#define PCC_DETECT(x)	(PXA_GPLR(7 + (x)) & PXA_GPIO_bit(7 + (x)))
+#define PCC_DETECT(x)	(pxa_gpio_pin_get(PXA_GPLR, 7 + (x)))
 
 /* A listing of interrupts used by external hardware devices */
 
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index 290af99..93d2830 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -67,9 +67,9 @@ static int __mfp_config_gpio(unsigned gpio, unsigned long c)
 		GAFR_U(bank) = gafr;
 
 	if (is_out ^ gpio_desc[gpio].dir_inverted)
-		PXA_GPDR(gpio) |= mask;
+		pxa_gpio_pin_set(PXA_GPDR, gpio);
 	else
-		PXA_GPDR(gpio) &= ~mask;
+		pxa_gpio_pin_clear(PXA_GPDR, gpio);
 
 	/* alternate function and direction@low power mode */
 	switch (c & MFP_LPM_STATE_MASK) {
@@ -345,8 +345,8 @@ static int pxa2xx_mfp_suspend(void)
 	/* set corresponding PGSR bit of those marked MFP_LPM_KEEP_OUTPUT */
 	for (i = 0; i < pxa_last_gpio; i++) {
 		if ((gpio_desc[i].config & MFP_LPM_KEEP_OUTPUT) &&
-		    (PXA_GPDR(i) & PXA_GPIO_bit(i))) {
-			if (PXA_GPLR(i) & PXA_GPIO_bit(i))
+			pxa_gpio_pin_get(PXA_GPDR, i)) {
+			if (pxa_gpio_pin_get(PXA_GPLR, i))
 				PGSR(pxa_gpio_to_bank(i)) |= PXA_GPIO_bit(i);
 			else
 				PGSR(pxa_gpio_to_bank(i)) &= ~PXA_GPIO_bit(i);
@@ -357,10 +357,10 @@ static int pxa2xx_mfp_suspend(void)
 
 		saved_gafr[0][i] = GAFR_L(i);
 		saved_gafr[1][i] = GAFR_U(i);
-		saved_gpdr[i] = PXA_GPDR(i * 32);
+		saved_gpdr[i] = pxa_gpio_bank_read(PXA_GPDR, i);
 		saved_pgsr[i] = PGSR(i);
 
-		PXA_GPDR(i * 32) = gpdr_lpm[i];
+		pxa_gpio_bank_write(PXA_GPDR, gpdr_lpm[i], i);
 	}
 	return 0;
 }
@@ -372,7 +372,7 @@ static void pxa2xx_mfp_resume(void)
 	for (i = 0; i <= pxa_gpio_to_bank(pxa_last_gpio); i++) {
 		GAFR_L(i) = saved_gafr[0][i];
 		GAFR_U(i) = saved_gafr[1][i];
-		PXA_GPDR(i * 32) = saved_gpdr[i];
+		pxa_gpio_bank_write(PXA_GPDR, saved_gpdr[i], i);
 		PGSR(i) = saved_pgsr[i];
 	}
 	PSSR = PSSR_RDH | PSSR_PH;
@@ -405,7 +405,7 @@ static int __init pxa2xx_mfp_init(void)
 
 	/* initialize gafr_run[], pgsr_lpm[] from existing values */
 	for (i = 0; i <= pxa_gpio_to_bank(pxa_last_gpio); i++)
-		gpdr_lpm[i] = PXA_GPDR(i * 32);
+		gpdr_lpm[i] = pxa_gpio_bank_read(PXA_GPDR, i);
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index a8d9aee..62bd42d 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/apm-emulation.h>
@@ -173,17 +174,17 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
 
 static unsigned long spitz_charger_wakeup(void)
 {
-	return (~PXA_GPLR(SPITZ_GPIO_KEY_INT)
-		& PXA_GPIO_bit(SPITZ_GPIO_KEY_INT))
-		| (PXA_GPLR(SPITZ_GPIO_SYNC) & PXA_GPIO_bit(SPITZ_GPIO_SYNC));
+	unsigned long key, sync;
+	key = pxa_gpio_pin_get(PXA_GPLR, SPITZ_GPIO_KEY_INT);
+	sync = pxa_gpio_pin_get(PXA_GPLR, SPITZ_GPIO_SYNC);
+	return !key | sync;
 }
 
 unsigned long spitzpm_read_devdata(int type)
 {
 	switch (type) {
 	case SHARPSL_STATUS_ACIN:
-		return (((~PXA_GPLR(SPITZ_GPIO_AC_IN))
-			& PXA_GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);
+		return !pxa_gpio_pin_get(PXA_GPLR, SPITZ_GPIO_AC_IN);
 	case SHARPSL_STATUS_LOCK:
 		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 11fd69e..095cf9e 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -22,15 +22,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
 
-#define GPLR_OFFSET	0x00
-#define GPDR_OFFSET	0x0C
-#define GPSR_OFFSET	0x18
-#define GPCR_OFFSET	0x24
-#define GRER_OFFSET	0x30
-#define GFER_OFFSET	0x3C
-#define GEDR_OFFSET	0x48
-#define GAFR_OFFSET	0x54
-#define ED_MASK_OFFSET	0x9C	/* GPIO edge detection for AP side */
+#define PXA_BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 
 struct pxa_gpio_chip {
 	struct gpio_chip chip;
@@ -59,11 +51,11 @@ enum {
 	MMP2_GPIO,
 };
 
-struct pxa_gpio_regs pxa_gpio_regs;
 int pxa_last_gpio;
 
 static DEFINE_SPINLOCK(gpio_lock);
 static struct pxa_gpio_chip *pxa_gpio_chips;
+static void __iomem *pxa_gpio_regbase;
 static int gpio_type;
 
 #define for_each_gpio_chip(i, c)			\
@@ -93,7 +85,7 @@ static inline int gpio_is_mmp_type(int type)
 	return 0;
 }
 
-/* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
+/* GPIO86/87/88/89 on PXA26x have their direction bits in GPDR2 inverted,
  * as well as their Alternate Function value being '1' for GPIO in GAFRx.
  */
 static inline int __gpio_is_inverted(int gpio)
@@ -111,14 +103,20 @@ static inline int __gpio_is_inverted(int gpio)
  */
 static inline int __gpio_is_occupied(unsigned gpio)
 {
-	int ret, af = 0, dir = 0;
+	int ret, af = 0, dir = 0, bank = 0;
+	unsigned int data = 0;
 
 	switch (gpio_type) {
 	case PXA25X_GPIO:
 	case PXA26X_GPIO:
 	case PXA27X_GPIO:
-		af = (PXA_GAFR(gpio) >> ((gpio & 0xf) * 2)) & 0x3;
-		dir = PXA_GPDR(gpio) & PXA_GPIO_bit(gpio);
+		bank = pxa_gpio_to_bank(gpio);
+		data = readl_relaxed(pxa_gpio_regbase + PXA_GAFR
+			+ PXA_BANK_OFF(bank));
+		af = (data >> ((gpio & 0xf) * 2)) & 0x3;
+		data = readl_relaxed(pxa_gpio_regbase + PXA_GPDR
+			+ PXA_BANK_OFF(bank));
+		dir = pxa_gpio_pin_get(PXA_GPDR, gpio);
 
 		if (__gpio_is_inverted(gpio))
 			ret = (af != 1) || (dir == 0);
@@ -126,7 +124,7 @@ static inline int __gpio_is_occupied(unsigned gpio)
 			ret = (af != 0) || (dir != 0);
 		break;
 	default:
-		ret = PXA_GPDR(gpio) & PXA_GPIO_bit(gpio);
+		ret = pxa_gpio_pin_get(PXA_GPDR, gpio);
 		break;
 	}
 	return ret;
@@ -161,6 +159,45 @@ int pxa_irq_to_gpio(int irq)
 	return 0;
 }
 
+unsigned int pxa_gpio_pin_get(enum pxa_gpios reg, unsigned int gpio)
+{
+	unsigned int bank = pxa_gpio_to_bank(gpio);
+	unsigned int data, ret;
+
+	data = readl_relaxed(pxa_gpio_regbase + reg + PXA_BANK_OFF(bank));
+	ret = (data & PXA_GPIO_bit(gpio)) ? 1 : 0;
+	return ret;
+}
+
+void pxa_gpio_pin_set(enum pxa_gpios reg, unsigned int gpio)
+{
+	unsigned int bank = pxa_gpio_to_bank(gpio);
+	unsigned int data;
+	data = pxa_gpio_pin_get(reg, gpio);
+	data |= PXA_GPIO_bit(gpio);
+	writel_relaxed(data, pxa_gpio_regbase + reg + PXA_BANK_OFF(bank));
+}
+
+void pxa_gpio_pin_clear(enum pxa_gpios reg, unsigned int gpio)
+{
+	unsigned int bank = pxa_gpio_to_bank(gpio);
+	unsigned int data;
+	data = pxa_gpio_pin_get(reg, gpio);
+	data &= ~PXA_GPIO_bit(gpio);
+	writel_relaxed(data, pxa_gpio_regbase + reg + PXA_BANK_OFF(bank));
+}
+
+unsigned int pxa_gpio_bank_read(enum pxa_gpios reg, unsigned int bank)
+{
+	return readl_relaxed(pxa_gpio_regbase + reg + PXA_BANK_OFF(bank));
+}
+
+void pxa_gpio_bank_write(enum pxa_gpios reg, unsigned int value,
+			 unsigned int bank)
+{
+	writel_relaxed(value, pxa_gpio_regbase + reg + PXA_BANK_OFF(bank));
+}
+
 static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	void __iomem *base = gpio_chip_base(chip);
@@ -169,12 +206,12 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
-	value = __raw_readl(base + GPDR_OFFSET);
+	value = __raw_readl(base + PXA_GPDR);
 	if (__gpio_is_inverted(chip->base + offset))
 		value |= mask;
 	else
 		value &= ~mask;
-	__raw_writel(value, base + GPDR_OFFSET);
+	__raw_writel(value, base + PXA_GPDR);
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 	return 0;
@@ -187,16 +224,16 @@ static int pxa_gpio_direction_output(struct gpio_chip *chip,
 	uint32_t tmp, mask = 1 << offset;
 	unsigned long flags;
 
-	__raw_writel(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
+	__raw_writel(mask, base + (value ? PXA_GPSR : PXA_GPCR));
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
-	tmp = __raw_readl(base + GPDR_OFFSET);
+	tmp = __raw_readl(base + PXA_GPDR);
 	if (__gpio_is_inverted(chip->base + offset))
 		tmp &= ~mask;
 	else
 		tmp |= mask;
-	__raw_writel(tmp, base + GPDR_OFFSET);
+	__raw_writel(tmp, base + PXA_GPDR);
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 	return 0;
@@ -204,13 +241,13 @@ static int pxa_gpio_direction_output(struct gpio_chip *chip,
 
 static int pxa_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return __raw_readl(gpio_chip_base(chip) + GPLR_OFFSET) & (1 << offset);
+	return __raw_readl(gpio_chip_base(chip) + PXA_GPLR) & (1 << offset);
 }
 
 static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	__raw_writel(1 << offset, gpio_chip_base(chip) +
-				(value ? GPSR_OFFSET : GPCR_OFFSET));
+				(value ? PXA_GPSR : PXA_GPCR));
 }
 
 static int __init pxa_init_gpio_chip(int gpio_end)
@@ -228,7 +265,7 @@ static int __init pxa_init_gpio_chip(int gpio_end)
 		struct gpio_chip *c = &chips[i].chip;
 
 		sprintf(chips[i].label, "gpio-%d", i);
-		chips[i].regbase = (void __iomem *)PXA_GPIO_BANK(i);
+		chips[i].regbase = pxa_gpio_regbase + PXA_BANK_OFF(i);
 
 		c->base  = gpio;
 		c->label = chips[i].label;
@@ -254,12 +291,12 @@ static inline void update_edge_detect(struct pxa_gpio_chip *c)
 {
 	uint32_t grer, gfer;
 
-	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~c->irq_mask;
-	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~c->irq_mask;
+	grer = __raw_readl(c->regbase + PXA_GRER) & ~c->irq_mask;
+	gfer = __raw_readl(c->regbase + PXA_GFER) & ~c->irq_mask;
 	grer |= c->irq_edge_rise & c->irq_mask;
 	gfer |= c->irq_edge_fall & c->irq_mask;
-	__raw_writel(grer, c->regbase + GRER_OFFSET);
-	__raw_writel(gfer, c->regbase + GFER_OFFSET);
+	__raw_writel(grer, c->regbase + PXA_GRER);
+	__raw_writel(gfer, c->regbase + PXA_GFER);
 }
 
 static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
@@ -283,12 +320,12 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
 	}
 
-	gpdr = __raw_readl(c->regbase + GPDR_OFFSET);
+	gpdr = __raw_readl(c->regbase + PXA_GPDR);
 
 	if (__gpio_is_inverted(gpio))
-		__raw_writel(gpdr | mask,  c->regbase + GPDR_OFFSET);
+		__raw_writel(gpdr | mask,  c->regbase + PXA_GPDR);
 	else
-		__raw_writel(gpdr & ~mask, c->regbase + GPDR_OFFSET);
+		__raw_writel(gpdr & ~mask, c->regbase + PXA_GPDR);
 
 	if (type & IRQ_TYPE_EDGE_RISING)
 		c->irq_edge_rise |= mask;
@@ -319,9 +356,9 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 		for_each_gpio_chip(gpio, c) {
 			gpio_base = c->chip.base;
 
-			gedr = __raw_readl(c->regbase + GEDR_OFFSET);
+			gedr = __raw_readl(c->regbase + PXA_GEDR);
 			gedr = gedr & c->irq_mask;
-			__raw_writel(gedr, c->regbase + GEDR_OFFSET);
+			__raw_writel(gedr, c->regbase + PXA_GEDR);
 
 			n = find_first_bit(&gedr, BITS_PER_LONG);
 			while (n < BITS_PER_LONG) {
@@ -339,7 +376,7 @@ static void pxa_ack_muxed_gpio(struct irq_data *d)
 	int gpio = pxa_irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 
-	__raw_writel(PXA_GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
+	__raw_writel(PXA_GPIO_bit(gpio), c->regbase + PXA_GEDR);
 }
 
 static void pxa_mask_muxed_gpio(struct irq_data *d)
@@ -350,10 +387,10 @@ static void pxa_mask_muxed_gpio(struct irq_data *d)
 
 	c->irq_mask &= ~PXA_GPIO_bit(gpio);
 
-	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~PXA_GPIO_bit(gpio);
-	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~PXA_GPIO_bit(gpio);
-	__raw_writel(grer, c->regbase + GRER_OFFSET);
-	__raw_writel(gfer, c->regbase + GFER_OFFSET);
+	grer = __raw_readl(c->regbase + PXA_GRER) & ~PXA_GPIO_bit(gpio);
+	gfer = __raw_readl(c->regbase + PXA_GFER) & ~PXA_GPIO_bit(gpio);
+	__raw_writel(grer, c->regbase + PXA_GRER);
+	__raw_writel(gfer, c->regbase + PXA_GFER);
 }
 
 static void pxa_unmask_muxed_gpio(struct irq_data *d)
@@ -433,15 +470,7 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 					   "gpio_virtual_base");
 	if (!res)
 		return -EINVAL;
-	pxa_gpio_regs.gplr = res->start + GPLR_OFFSET;
-	pxa_gpio_regs.gpdr = res->start + GPDR_OFFSET;
-	pxa_gpio_regs.gpsr = res->start + GPSR_OFFSET;
-	pxa_gpio_regs.gpcr = res->start + GPCR_OFFSET;
-	pxa_gpio_regs.grer = res->start + GRER_OFFSET;
-	pxa_gpio_regs.gfer = res->start + GFER_OFFSET;
-	pxa_gpio_regs.gedr = res->start + GEDR_OFFSET;
-	pxa_gpio_regs.gafr = res->start + GAFR_OFFSET;
-	pxa_gpio_regs.ed_mask = res->start + ED_MASK_OFFSET;
+	pxa_gpio_regbase = (void __iomem *)res->start;
 
 	if (irq0 > 0)
 		gpio_offset = 2;
@@ -458,12 +487,12 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 
 	/* clear all GPIO edge detects */
 	for_each_gpio_chip(gpio, c) {
-		__raw_writel(0, c->regbase + GFER_OFFSET);
-		__raw_writel(0, c->regbase + GRER_OFFSET);
-		__raw_writel(~0,c->regbase + GEDR_OFFSET);
+		__raw_writel(0, c->regbase + PXA_GFER);
+		__raw_writel(0, c->regbase + PXA_GRER);
+		__raw_writel(~0,c->regbase + PXA_GEDR);
 #ifdef CONFIG_ARCH_MMP
 		/* unmask GPIO edge detect for AP side */
-		__raw_writel(~0,c->regbase + ED_MASK_OFFSET);
+		__raw_writel(~0,c->regbase + PXA_ED_MASK);
 #endif
 	}
 
@@ -513,13 +542,13 @@ static int pxa_gpio_suspend(void)
 	int gpio;
 
 	for_each_gpio_chip(gpio, c) {
-		c->saved_gplr = __raw_readl(c->regbase + GPLR_OFFSET);
-		c->saved_gpdr = __raw_readl(c->regbase + GPDR_OFFSET);
-		c->saved_grer = __raw_readl(c->regbase + GRER_OFFSET);
-		c->saved_gfer = __raw_readl(c->regbase + GFER_OFFSET);
+		c->saved_gplr = __raw_readl(c->regbase + PXA_GPLR);
+		c->saved_gpdr = __raw_readl(c->regbase + PXA_GPDR);
+		c->saved_grer = __raw_readl(c->regbase + PXA_GRER);
+		c->saved_gfer = __raw_readl(c->regbase + PXA_GFER);
 
 		/* Clear GPIO transition detect bits */
-		__raw_writel(0xffffffff, c->regbase + GEDR_OFFSET);
+		__raw_writel(0xffffffff, c->regbase + PXA_GEDR);
 	}
 	return 0;
 }
@@ -531,12 +560,12 @@ static void pxa_gpio_resume(void)
 
 	for_each_gpio_chip(gpio, c) {
 		/* restore level with set/clear */
-		__raw_writel( c->saved_gplr, c->regbase + GPSR_OFFSET);
-		__raw_writel(~c->saved_gplr, c->regbase + GPCR_OFFSET);
+		__raw_writel( c->saved_gplr, c->regbase + PXA_GPSR);
+		__raw_writel(~c->saved_gplr, c->regbase + PXA_GPCR);
 
-		__raw_writel(c->saved_grer, c->regbase + GRER_OFFSET);
-		__raw_writel(c->saved_gfer, c->regbase + GFER_OFFSET);
-		__raw_writel(c->saved_gpdr, c->regbase + GPDR_OFFSET);
+		__raw_writel(c->saved_grer, c->regbase + PXA_GRER);
+		__raw_writel(c->saved_gfer, c->regbase + PXA_GFER);
+		__raw_writel(c->saved_gpdr, c->regbase + PXA_GPDR);
 	}
 }
 #else
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index dd47850..3f655da 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -3,20 +3,6 @@
 
 #include <linux/kernel.h>
 
-struct irq_data;
-
-struct pxa_gpio_regs {
-	u32	gplr;
-	u32	gpdr;
-	u32	gpsr;
-	u32	gpcr;
-	u32	grer;
-	u32	gfer;
-	u32	gedr;
-	u32	gafr;
-	u32	ed_mask;
-};
-
 /*
  * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
  * one set of registers. The register offsets are organized below:
@@ -35,39 +21,22 @@ struct pxa_gpio_regs {
  *   BANK 4 and 5 are only available on PXA935
  */
 
-#define PXA_BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 
-#define PXA_GPIO_BANK(n)	(pxa_gpio_regs.gplr + PXA_BANK_OFF(n))
 #define PXA_GPIO_bit(x)		(1 << ((x) & 0x1f))
 #define pxa_gpio_to_bank(gpio)	((gpio) >> 5)
 
 
-/* GPIO Pin Level Registers */
-#define PXA_GPLR(x)	(*(volatile u32 *)(pxa_gpio_regs.gplr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Pin Direction Registers */
-#define PXA_GPDR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpdr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Pin Output Set Registers */
-#define PXA_GPSR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpsr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Pin Output Clear Registers */
-#define PXA_GPCR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpcr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Rising Edge Detect Registers */
-#define PXA_GRER(x)	(*(volatile u32 *)(pxa_gpio_regs.grer	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Falling Edge Detect Registers */
-#define PXA_GFER(x)	(*(volatile u32 *)(pxa_gpio_regs.gfer	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Edge Detect Status Registers */
-#define PXA_GEDR(x)	(*(volatile u32 *)(pxa_gpio_regs.gedr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Alternate Function Select Registers */
-#define PXA_GAFR(x)	(*(volatile u32 *)(pxa_gpio_regs.gafr	\
-			+ (((x) & 0x70) >> 2)))
-
-extern struct pxa_gpio_regs pxa_gpio_regs;
+enum pxa_gpios {
+	PXA_GPLR = 0x00,	/* GPIO Pin Level Registers */
+	PXA_GPDR = 0x0C,	/* GPIO Pin Direction Registers */
+	PXA_GPSR = 0x18,	/* GPIO Pin Output Set Registers */
+	PXA_GPCR = 0x24,	/* GPIO Pin Output Clear Registers */
+	PXA_GRER = 0x30,	/* GPIO Rising Edge Detect Registers */
+	PXA_GFER = 0x3C,	/* GPIO Falling Edge Detect Registers */
+	PXA_GEDR = 0x48,	/* GPIO Edge Detect Status Registers */
+	PXA_GAFR = 0x54,	/* GPIO Alternate Function Select Registers */
+	PXA_ED_MASK = 0x9C,	/* GPIO edge detection for AP side */
+};
 
 /* NOTE: some PXAs have fewer on-chip GPIOs (like PXA255, with 85).
  * Those cases currently cause holes in the GPIO number space, the
@@ -75,8 +44,17 @@ extern struct pxa_gpio_regs pxa_gpio_regs;
  */
 extern int pxa_last_gpio;
 
-typedef int (*set_wake_t)(struct irq_data *d, unsigned int on);
-
 extern int pxa_irq_to_gpio(int irq);
 
+extern unsigned int pxa_gpio_pin_get(enum pxa_gpios reg, unsigned int gpio);
+
+extern void pxa_gpio_pin_set(enum pxa_gpios reg, unsigned int gpio);
+
+extern void pxa_gpio_pin_clear(enum pxa_gpios reg, unsigned int gpio);
+
+extern unsigned int pxa_gpio_bank_read(enum pxa_gpios reg, unsigned int bank);
+
+extern void pxa_gpio_bank_write(enum pxa_gpios reg, unsigned int value,
+				unsigned int bank);
+
 #endif /* __GPIO_PXA_H */
-- 
1.7.2.5
