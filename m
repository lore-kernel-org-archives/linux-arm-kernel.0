From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 8 Mar 2010 19:18:57 -0500
Subject: [PATCH] locomo: replace locomo_{readl/writel} macros with
	__raw_{readw/writew}
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909022427CF@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The locomo_readl and locomo_writel macros are misnamed. Both
use (*(volatile u16 *)(addr)) so they should be a *w variety.

Instead of renaming the macros just replace them tree wide with
__raw_readw and __raw_writew.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>

---

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 90ae00b..c1be46e 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -147,7 +147,7 @@ static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 	desc->chip->ack(irq);
 
 	/* check why this interrupt was generated */
-	req = locomo_readl(lchip->base + LOCOMO_ICR) & 0x0f00;
+	req = __raw_readw(lchip->base + LOCOMO_ICR) & 0x0f00;
 
 	if (req) {
 		/* generate the next interrupt(s) */
@@ -169,18 +169,18 @@ static void locomo_mask_irq(unsigned int irq)
 {
 	struct locomo *lchip = get_irq_chip_data(irq);
 	unsigned int r;
-	r = locomo_readl(lchip->base + LOCOMO_ICR);
+	r = __raw_readw(lchip->base + LOCOMO_ICR);
 	r &= ~(0x0010 << (irq - lchip->irq_base));
-	locomo_writel(r, lchip->base + LOCOMO_ICR);
+	__raw_writew(r, lchip->base + LOCOMO_ICR);
 }
 
 static void locomo_unmask_irq(unsigned int irq)
 {
 	struct locomo *lchip = get_irq_chip_data(irq);
 	unsigned int r;
-	r = locomo_readl(lchip->base + LOCOMO_ICR);
+	r = __raw_readw(lchip->base + LOCOMO_ICR);
 	r |= (0x0010 << (irq - lchip->irq_base));
-	locomo_writel(r, lchip->base + LOCOMO_ICR);
+	__raw_writew(r, lchip->base + LOCOMO_ICR);
 }
 
 static struct irq_chip locomo_chip = {
@@ -287,30 +287,31 @@ static int locomo_suspend(struct platform_device *dev, pm_message_t state)
 
 	spin_lock_irqsave(&lchip->lock, flags);
 
-	save->LCM_GPO     = locomo_readl(lchip->base + LOCOMO_GPO);	/* GPIO */
-	locomo_writel(0x00, lchip->base + LOCOMO_GPO);
-	save->LCM_SPICT   = locomo_readl(lchip->base + LOCOMO_SPI + LOCOMO_SPICT);	/* SPI */
-	locomo_writel(0x40, lchip->base + LOCOMO_SPICT);
-	save->LCM_GPE     = locomo_readl(lchip->base + LOCOMO_GPE);	/* GPIO */
-	locomo_writel(0x00, lchip->base + LOCOMO_GPE);
-	save->LCM_ASD     = locomo_readl(lchip->base + LOCOMO_ASD);	/* ADSTART */
-	locomo_writel(0x00, lchip->base + LOCOMO_ASD);
-	save->LCM_SPIMD   = locomo_readl(lchip->base + LOCOMO_SPI + LOCOMO_SPIMD);	/* SPI */
-	locomo_writel(0x3C14, lchip->base + LOCOMO_SPI + LOCOMO_SPIMD);
-
-	locomo_writel(0x00, lchip->base + LOCOMO_PAIF);
-	locomo_writel(0x00, lchip->base + LOCOMO_DAC);
-	locomo_writel(0x00, lchip->base + LOCOMO_BACKLIGHT + LOCOMO_TC);
-
-	if ((locomo_readl(lchip->base + LOCOMO_LED + LOCOMO_LPT0) & 0x88) && (locomo_readl(lchip->base + LOCOMO_LED + LOCOMO_LPT1) & 0x88))
-		locomo_writel(0x00, lchip->base + LOCOMO_C32K); 	/* CLK32 off */
+	save->LCM_GPO     = __raw_readw(lchip->base + LOCOMO_GPO);	/* GPIO */
+	__raw_writew(0x00, lchip->base + LOCOMO_GPO);
+	save->LCM_SPICT   = __raw_readw(lchip->base + LOCOMO_SPI + LOCOMO_SPICT);	/* SPI */
+	__raw_writew(0x40, lchip->base + LOCOMO_SPICT);
+	save->LCM_GPE     = __raw_readw(lchip->base + LOCOMO_GPE);	/* GPIO */
+	__raw_writew(0x00, lchip->base + LOCOMO_GPE);
+	save->LCM_ASD     = __raw_readw(lchip->base + LOCOMO_ASD);	/* ADSTART */
+	__raw_writew(0x00, lchip->base + LOCOMO_ASD);
+	save->LCM_SPIMD   = __raw_readw(lchip->base + LOCOMO_SPI + LOCOMO_SPIMD);	/* SPI */
+	__raw_writew(0x3C14, lchip->base + LOCOMO_SPI + LOCOMO_SPIMD);
+
+	__raw_writew(0x00, lchip->base + LOCOMO_PAIF);
+	__raw_writew(0x00, lchip->base + LOCOMO_DAC);
+	__raw_writew(0x00, lchip->base + LOCOMO_BACKLIGHT + LOCOMO_TC);
+
+	if ((__raw_readw(lchip->base + LOCOMO_LED + LOCOMO_LPT0) & 0x88) &&
+	    (__raw_readw(lchip->base + LOCOMO_LED + LOCOMO_LPT1) & 0x88))
+		__raw_writew(0x00, lchip->base + LOCOMO_C32K); 	/* CLK32 off */
 	else
 		/* 18MHz already enabled, so no wait */
-		locomo_writel(0xc1, lchip->base + LOCOMO_C32K); 	/* CLK32 on */
+		__raw_writew(0xc1, lchip->base + LOCOMO_C32K); 	/* CLK32 on */
 
-	locomo_writel(0x00, lchip->base + LOCOMO_TADC);		/* 18MHz clock off*/
-	locomo_writel(0x00, lchip->base + LOCOMO_AUDIO + LOCOMO_ACC);			/* 22MHz/24MHz clock off */
-	locomo_writel(0x00, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);			/* FL */
+	__raw_writew(0x00, lchip->base + LOCOMO_TADC);		/* 18MHz clock off*/
+	__raw_writew(0x00, lchip->base + LOCOMO_AUDIO + LOCOMO_ACC);	/* 22MHz/24MHz clock off */
+	__raw_writew(0x00, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);	/* FL */
 
 	spin_unlock_irqrestore(&lchip->lock, flags);
 
@@ -330,20 +331,20 @@ static int locomo_resume(struct platform_device *dev)
 
 	spin_lock_irqsave(&lchip->lock, flags);
 
-	locomo_writel(save->LCM_GPO, lchip->base + LOCOMO_GPO);
-	locomo_writel(save->LCM_SPICT, lchip->base + LOCOMO_SPI + LOCOMO_SPICT);
-	locomo_writel(save->LCM_GPE, lchip->base + LOCOMO_GPE);
-	locomo_writel(save->LCM_ASD, lchip->base + LOCOMO_ASD);
-	locomo_writel(save->LCM_SPIMD, lchip->base + LOCOMO_SPI + LOCOMO_SPIMD);
+	__raw_writew(save->LCM_GPO, lchip->base + LOCOMO_GPO);
+	__raw_writew(save->LCM_SPICT, lchip->base + LOCOMO_SPI + LOCOMO_SPICT);
+	__raw_writew(save->LCM_GPE, lchip->base + LOCOMO_GPE);
+	__raw_writew(save->LCM_ASD, lchip->base + LOCOMO_ASD);
+	__raw_writew(save->LCM_SPIMD, lchip->base + LOCOMO_SPI + LOCOMO_SPIMD);
 
-	locomo_writel(0x00, lchip->base + LOCOMO_C32K);
-	locomo_writel(0x90, lchip->base + LOCOMO_TADC);
+	__raw_writew(0x00, lchip->base + LOCOMO_C32K);
+	__raw_writew(0x90, lchip->base + LOCOMO_TADC);
 
-	locomo_writel(0, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KSC);
-	r = locomo_readl(lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
+	__raw_writew(0, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KSC);
+	r = __raw_readw(lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
 	r &= 0xFEFF;
-	locomo_writel(r, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
-	locomo_writel(0x1, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KCMD);
+	__raw_writew(r, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
+	__raw_writew(0x1, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KCMD);
 
 	spin_unlock_irqrestore(&lchip->lock, flags);
 
@@ -399,54 +400,54 @@ __locomo_probe(struct device *me, struct resource *mem, int irq)
 	}
 
 	/* locomo initialize */
-	locomo_writel(0, lchip->base + LOCOMO_ICR);
+	__raw_writew(0, lchip->base + LOCOMO_ICR);
 	/* KEYBOARD */
-	locomo_writel(0, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
+	__raw_writew(0, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
 
 	/* GPIO */
-	locomo_writel(0, lchip->base + LOCOMO_GPO);
-	locomo_writel((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
+	__raw_writew(0, lchip->base + LOCOMO_GPO);
+	__raw_writew((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
 			, lchip->base + LOCOMO_GPE);
-	locomo_writel((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
+	__raw_writew((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
 			, lchip->base + LOCOMO_GPD);
-	locomo_writel(0, lchip->base + LOCOMO_GIE);
+	__raw_writew(0, lchip->base + LOCOMO_GIE);
 
 	/* Frontlight */
-	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
-	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
+	__raw_writew(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	__raw_writew(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
 
 	/* Longtime timer */
-	locomo_writel(0, lchip->base + LOCOMO_LTINT);
+	__raw_writew(0, lchip->base + LOCOMO_LTINT);
 	/* SPI */
-	locomo_writel(0, lchip->base + LOCOMO_SPIIE);
+	__raw_writew(0, lchip->base + LOCOMO_SPIIE);
 
-	locomo_writel(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);
-	r = locomo_readl(lchip->base + LOCOMO_ASD);
+	__raw_writew(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);
+	r = __raw_readw(lchip->base + LOCOMO_ASD);
 	r |= 0x8000;
-	locomo_writel(r, lchip->base + LOCOMO_ASD);
+	__raw_writew(r, lchip->base + LOCOMO_ASD);
 
-	locomo_writel(6 + 8 + 320 + 30 - 10 - 128 + 4, lchip->base + LOCOMO_HSD);
-	r = locomo_readl(lchip->base + LOCOMO_HSD);
+	__raw_writew(6 + 8 + 320 + 30 - 10 - 128 + 4, lchip->base + LOCOMO_HSD);
+	r = __raw_readw(lchip->base + LOCOMO_HSD);
 	r |= 0x8000;
-	locomo_writel(r, lchip->base + LOCOMO_HSD);
+	__raw_writew(r, lchip->base + LOCOMO_HSD);
 
-	locomo_writel(128 / 8, lchip->base + LOCOMO_HSC);
+	__raw_writew(128 / 8, lchip->base + LOCOMO_HSC);
 
 	/* XON */
-	locomo_writel(0x80, lchip->base + LOCOMO_TADC);
+	__raw_writew(0x80, lchip->base + LOCOMO_TADC);
 	udelay(1000);
 	/* CLK9MEN */
-	r = locomo_readl(lchip->base + LOCOMO_TADC);
+	r = __raw_readw(lchip->base + LOCOMO_TADC);
 	r |= 0x10;
-	locomo_writel(r, lchip->base + LOCOMO_TADC);
+	__raw_writew(r, lchip->base + LOCOMO_TADC);
 	udelay(100);
 
 	/* init DAC */
-	r = locomo_readl(lchip->base + LOCOMO_DAC);
+	r = __raw_readw(lchip->base + LOCOMO_DAC);
 	r |= LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
-	locomo_writel(r, lchip->base + LOCOMO_DAC);
+	__raw_writew(r, lchip->base + LOCOMO_DAC);
 
-	r = locomo_readl(lchip->base + LOCOMO_VER);
+	r = __raw_readw(lchip->base + LOCOMO_VER);
 	printk(KERN_INFO "LoCoMo Chip: %lu%lu\n", (r >> 8), (r & 0xff));
 
 	/*
@@ -549,19 +550,19 @@ void locomo_gpio_set_dir(struct device *dev, unsigned int bits, unsigned int dir
 
 	spin_lock_irqsave(&lchip->lock, flags);
 
-	r = locomo_readl(lchip->base + LOCOMO_GPD);
+	r = __raw_readw(lchip->base + LOCOMO_GPD);
 	if (dir)
 		r |= bits;
 	else
 		r &= ~bits;
-	locomo_writel(r, lchip->base + LOCOMO_GPD);
+	__raw_writew(r, lchip->base + LOCOMO_GPD);
 
-	r = locomo_readl(lchip->base + LOCOMO_GPE);
+	r = __raw_readw(lchip->base + LOCOMO_GPE);
 	if (dir)
 		r |= bits;
 	else
 		r &= ~bits;
-	locomo_writel(r, lchip->base + LOCOMO_GPE);
+	__raw_writew(r, lchip->base + LOCOMO_GPE);
 
 	spin_unlock_irqrestore(&lchip->lock, flags);
 }
@@ -577,7 +578,7 @@ int locomo_gpio_read_level(struct device *dev, unsigned int bits)
 		return -ENODEV;
 
 	spin_lock_irqsave(&lchip->lock, flags);
-	ret = locomo_readl(lchip->base + LOCOMO_GPL);
+	ret = __raw_readw(lchip->base + LOCOMO_GPL);
 	spin_unlock_irqrestore(&lchip->lock, flags);
 
 	ret &= bits;
@@ -595,7 +596,7 @@ int locomo_gpio_read_output(struct device *dev, unsigned int bits)
 		return -ENODEV;
 
 	spin_lock_irqsave(&lchip->lock, flags);
-	ret = locomo_readl(lchip->base + LOCOMO_GPO);
+	ret = __raw_readw(lchip->base + LOCOMO_GPO);
 	spin_unlock_irqrestore(&lchip->lock, flags);
 
 	ret &= bits;
@@ -614,12 +615,12 @@ void locomo_gpio_write(struct device *dev, unsigned int bits, unsigned int set)
 
 	spin_lock_irqsave(&lchip->lock, flags);
 
-	r = locomo_readl(lchip->base + LOCOMO_GPO);
+	r = __raw_readw(lchip->base + LOCOMO_GPO);
 	if (set)
 		r |= bits;
 	else
 		r &= ~bits;
-	locomo_writel(r, lchip->base + LOCOMO_GPO);
+	__raw_writew(r, lchip->base + LOCOMO_GPO);
 
 	spin_unlock_irqrestore(&lchip->lock, flags);
 }
@@ -629,33 +630,33 @@ static void locomo_m62332_sendbit(void *mapbase, int bit)
 {
 	unsigned int r;
 
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_DATA_HOLD_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
 
 	if (bit & 1) {
-		r = locomo_readl(mapbase + LOCOMO_DAC);
+		r = __raw_readw(mapbase + LOCOMO_DAC);
 		r |=  LOCOMO_DAC_SDAOEB;
-		locomo_writel(r, mapbase + LOCOMO_DAC);
+		__raw_writew(r, mapbase + LOCOMO_DAC);
 		udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	} else {
-		r = locomo_readl(mapbase + LOCOMO_DAC);
+		r = __raw_readw(mapbase + LOCOMO_DAC);
 		r &=  ~(LOCOMO_DAC_SDAOEB);
-		locomo_writel(r, mapbase + LOCOMO_DAC);
+		__raw_writew(r, mapbase + LOCOMO_DAC);
 		udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	}
 
 	udelay(DAC_DATA_SETUP_TIME);	/* 250 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/*  4.0 usec */
 }
@@ -673,14 +674,14 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
 
 	/* Start */
 	udelay(DAC_BUS_FREE_TIME);	/* 5.0 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r |=  LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.0 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_START_HOLD_TIME);	/* 5.0 usec */
 	udelay(DAC_DATA_HOLD_TIME);	/* 300 nsec */
 
@@ -691,21 +692,21 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
 	}
 
 	/* Check A bit */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
-	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
+	if (__raw_readw(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
 		printk(KERN_WARNING "locomo: m62332_senddata Error 1\n");
 		return;
 	}
@@ -719,21 +720,21 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
 	}
 
 	/* Check A bit */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
-	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
+	if (__raw_readw(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
 		printk(KERN_WARNING "locomo: m62332_senddata Error 2\n");
 		return;
 	}
@@ -744,45 +745,45 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
 	}
 
 	/* Check A bit */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
-	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
+	if (__raw_readw(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
 		printk(KERN_WARNING "locomo: m62332_senddata Error 3\n");
 		return;
 	}
 
 	/* stop */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r |=  LOCOMO_DAC_SDAOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4 usec */
 
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = __raw_readw(mapbase + LOCOMO_DAC);
 	r |=  LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	__raw_writew(r, mapbase + LOCOMO_DAC);
 	udelay(DAC_LOW_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
 
@@ -805,10 +806,10 @@ void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf)
 		locomo_gpio_write(dev->dev.parent, LOCOMO_GPIO_FL_VR, 0);
 
 	spin_lock_irqsave(&lchip->lock, flags);
-	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	__raw_writew(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
 	udelay(100);
-	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
-	locomo_writel(bpwf | LOCOMO_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	__raw_writew(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
+	__raw_writew(bpwf | LOCOMO_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
 	spin_unlock_irqrestore(&lchip->lock, flags);
 }
 EXPORT_SYMBOL(locomo_frontlight_set);
diff --git a/arch/arm/include/asm/hardware/locomo.h b/arch/arm/include/asm/hardware/locomo.h
index 74e51d6..dc90c21 100644
--- a/arch/arm/include/asm/hardware/locomo.h
+++ b/arch/arm/include/asm/hardware/locomo.h
@@ -13,9 +13,6 @@
 #ifndef _ASM_ARCH_LOCOMO
 #define _ASM_ARCH_LOCOMO
 
-#define locomo_writel(val,addr)	({ *(volatile u16 *)(addr) = (val); })
-#define locomo_readl(addr)	(*(volatile u16 *)(addr))
-
 /* LOCOMO version */
 #define LOCOMO_VER	0x00
 
diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index b1ab298..01d808e 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -86,17 +86,17 @@ struct locomokbd {
 /* helper functions for reading the keyboard matrix */
 static inline void locomokbd_charge_all(unsigned long membase)
 {
-	locomo_writel(0x00FF, membase + LOCOMO_KSC);
+	__raw_writew(0x00FF, membase + LOCOMO_KSC);
 }
 
 static inline void locomokbd_activate_all(unsigned long membase)
 {
 	unsigned long r;
 
-	locomo_writel(0, membase + LOCOMO_KSC);
-	r = locomo_readl(membase + LOCOMO_KIC);
+	__raw_writew(0, membase + LOCOMO_KSC);
+	r = __raw_readw(membase + LOCOMO_KIC);
 	r &= 0xFEFF;
-	locomo_writel(r, membase + LOCOMO_KIC);
+	__raw_writew(r, membase + LOCOMO_KIC);
 }
 
 static inline void locomokbd_activate_col(unsigned long membase, int col)
@@ -106,7 +106,7 @@ static inline void locomokbd_activate_col(unsigned long membase, int col)
 
 	nset = 0xFF & ~(1 << col);
 	nbset = (nset << 8) + nset;
-	locomo_writel(nbset, membase + LOCOMO_KSC);
+	__raw_writew(nbset, membase + LOCOMO_KSC);
 }
 
 static inline void locomokbd_reset_col(unsigned long membase, int col)
@@ -114,7 +114,7 @@ static inline void locomokbd_reset_col(unsigned long membase, int col)
 	unsigned short nbset;
 
 	nbset = ((0xFF & ~(1 << col)) << 8) + 0xFF;
-	locomo_writel(nbset, membase + LOCOMO_KSC);
+	__raw_writew(nbset, membase + LOCOMO_KSC);
 }
 
 /*
@@ -141,7 +141,7 @@ static void locomokbd_scankeyboard(struct locomokbd *locomokbd)
 		locomokbd_activate_col(membase, col);
 		udelay(KB_DELAY);
 
-		rowd = ~locomo_readl(membase + LOCOMO_KIB);
+		rowd = ~__raw_readw(membase + LOCOMO_KIB);
 		for (row = 0; row < KB_ROWS; row++) {
 			unsigned int scancode, pressed, key;
 
@@ -194,11 +194,11 @@ static irqreturn_t locomokbd_interrupt(int irq, void *dev_id)
 	struct locomokbd *locomokbd = dev_id;
 	u16 r;
 
-	r = locomo_readl(locomokbd->base + LOCOMO_KIC);
+	r = __raw_readw(locomokbd->base + LOCOMO_KIC);
 	if ((r & 0x0001) == 0)
 		return IRQ_HANDLED;
 
-	locomo_writel(r & ~0x0100, locomokbd->base + LOCOMO_KIC); /* Ack */
+	__raw_writew(r & ~0x0100, locomokbd->base + LOCOMO_KIC); /* Ack */
 
 	/** wait chattering delay **/
 	udelay(100);
@@ -222,8 +222,8 @@ static int locomokbd_open(struct input_dev *dev)
 	struct locomokbd *locomokbd = input_get_drvdata(dev);
 	u16 r;
 	
-	r = locomo_readl(locomokbd->base + LOCOMO_KIC) | 0x0010;
-	locomo_writel(r, locomokbd->base + LOCOMO_KIC);
+	r = __raw_readw(locomokbd->base + LOCOMO_KIC) | 0x0010;
+	__raw_writew(r, locomokbd->base + LOCOMO_KIC);
 	return 0;
 }
 
@@ -232,8 +232,8 @@ static void locomokbd_close(struct input_dev *dev)
 	struct locomokbd *locomokbd = input_get_drvdata(dev);
 	u16 r;
 	
-	r = locomo_readl(locomokbd->base + LOCOMO_KIC) & ~0x0010;
-	locomo_writel(r, locomokbd->base + LOCOMO_KIC);
+	r = __raw_readw(locomokbd->base + LOCOMO_KIC) & ~0x0010;
+	__raw_writew(r, locomokbd->base + LOCOMO_KIC);
 }
 
 static int __devinit locomokbd_probe(struct locomo_dev *dev)
diff --git a/drivers/leds/leds-locomo.c b/drivers/leds/leds-locomo.c
index 1f7c10f..3811492 100644
--- a/drivers/leds/leds-locomo.c
+++ b/drivers/leds/leds-locomo.c
@@ -24,9 +24,9 @@ static void locomoled_brightness_set(struct led_classdev *led_cdev,
 
 	local_irq_save(flags);
 	if (value)
-		locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase + offset);
+		__raw_writew(LOCOMO_LPT_TOFH, locomo_dev->mapbase + offset);
 	else
-		locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase + offset);
+		__raw_writew(LOCOMO_LPT_TOFL, locomo_dev->mapbase + offset);
 	local_irq_restore(flags);
 }
 
diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index 00a9591..65308f9 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -49,13 +49,13 @@ static void locomolcd_on(int comadj)
 	mdelay(10);
 
 	/* TFTCRST | CPSOUT=0 | CPSEN */
-	locomo_writel(0x01, locomolcd_dev->mapbase + LOCOMO_TC);
+	__raw_writew(0x01, locomolcd_dev->mapbase + LOCOMO_TC);
 
 	/* Set CPSD */
-	locomo_writel(6, locomolcd_dev->mapbase + LOCOMO_CPSD);
+	__raw_writew(6, locomolcd_dev->mapbase + LOCOMO_CPSD);
 
 	/* TFTCRST | CPSOUT=0 | CPSEN */
-	locomo_writel((0x04 | 0x01), locomolcd_dev->mapbase + LOCOMO_TC);
+	__raw_writew((0x04 | 0x01), locomolcd_dev->mapbase + LOCOMO_TC);
 	mdelay(10);
 
 	locomo_gpio_set_dir(locomolcd_dev->dev.parent, LOCOMO_GPIO_LCD_MOD, 0);
@@ -65,7 +65,7 @@ static void locomolcd_on(int comadj)
 static void locomolcd_off(int comadj)
 {
 	/* TFTCRST=1 | CPSOUT=1 | CPSEN = 0 */
-	locomo_writel(0x06, locomolcd_dev->mapbase + LOCOMO_TC);
+	__raw_writew(0x06, locomolcd_dev->mapbase + LOCOMO_TC);
 	mdelay(1);
 
 	locomo_gpio_write(locomolcd_dev->dev.parent, LOCOMO_GPIO_LCD_VSHA_ON, 0);
@@ -75,7 +75,7 @@ static void locomolcd_off(int comadj)
 	mdelay(700);
 
 	/* TFTCRST=0 | CPSOUT=0 | CPSEN = 0 */
-	locomo_writel(0, locomolcd_dev->mapbase + LOCOMO_TC);
+	__raw_writew(0, locomolcd_dev->mapbase + LOCOMO_TC);
 	locomo_gpio_write(locomolcd_dev->dev.parent, LOCOMO_GPIO_LCD_MOD, 0);
 	locomo_gpio_write(locomolcd_dev->dev.parent, LOCOMO_GPIO_LCD_VSHD_ON, 0);
 }
