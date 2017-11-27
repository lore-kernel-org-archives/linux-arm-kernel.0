From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 18:38:46 +0000
Subject: [PATCH 3/6] ARM: sa1111: remove special sa1111 mmio accessors
In-Reply-To: <20171127183811.GM31757@n2100.armlinux.org.uk>
References: <20171127183811.GM31757@n2100.armlinux.org.uk>
Message-ID: <E1eJOIo-0006oY-6T@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the special sa1111 mmio accessors from core sa1111 code, and
their definition in sa1111.h now that all users are gone.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c               | 180 ++++++++++++++++-----------------
 arch/arm/include/asm/hardware/sa1111.h |   3 -
 2 files changed, 89 insertions(+), 94 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index c5f5341c05b7..36c2162c95af 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -204,14 +204,14 @@ static void sa1111_irq_handler(struct irq_desc *desc)
 	struct sa1111 *sachip = irq_desc_get_handler_data(desc);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
 
-	stat0 = sa1111_readl(mapbase + SA1111_INTSTATCLR0);
-	stat1 = sa1111_readl(mapbase + SA1111_INTSTATCLR1);
+	stat0 = readl_relaxed(mapbase + SA1111_INTSTATCLR0);
+	stat1 = readl_relaxed(mapbase + SA1111_INTSTATCLR1);
 
-	sa1111_writel(stat0, mapbase + SA1111_INTSTATCLR0);
+	writel_relaxed(stat0, mapbase + SA1111_INTSTATCLR0);
 
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
-	sa1111_writel(stat1, mapbase + SA1111_INTSTATCLR1);
+	writel_relaxed(stat1, mapbase + SA1111_INTSTATCLR1);
 
 	if (stat0 == 0 && stat1 == 0) {
 		do_bad_IRQ(desc);
@@ -257,9 +257,9 @@ static void sa1111_mask_irq(struct irq_data *d)
 	void __iomem *mapbase = sachip->base + SA1111_INTC + sa1111_irqbank(d);
 	u32 ie;
 
-	ie = sa1111_readl(mapbase + SA1111_INTEN0);
+	ie = readl_relaxed(mapbase + SA1111_INTEN0);
 	ie &= ~sa1111_irqmask(d);
-	sa1111_writel(ie, mapbase + SA1111_INTEN0);
+	writel(ie, mapbase + SA1111_INTEN0);
 }
 
 static void sa1111_unmask_irq(struct irq_data *d)
@@ -268,9 +268,9 @@ static void sa1111_unmask_irq(struct irq_data *d)
 	void __iomem *mapbase = sachip->base + SA1111_INTC + sa1111_irqbank(d);
 	u32 ie;
 
-	ie = sa1111_readl(mapbase + SA1111_INTEN0);
+	ie = readl_relaxed(mapbase + SA1111_INTEN0);
 	ie |= sa1111_irqmask(d);
-	sa1111_writel(ie, mapbase + SA1111_INTEN0);
+	writel_relaxed(ie, mapbase + SA1111_INTEN0);
 }
 
 /*
@@ -287,11 +287,11 @@ static int sa1111_retrigger_irq(struct irq_data *d)
 	u32 ip, mask = sa1111_irqmask(d);
 	int i;
 
-	ip = sa1111_readl(mapbase + SA1111_INTPOL0);
+	ip = readl_relaxed(mapbase + SA1111_INTPOL0);
 	for (i = 0; i < 8; i++) {
-		sa1111_writel(ip ^ mask, mapbase + SA1111_INTPOL0);
-		sa1111_writel(ip, mapbase + SA1111_INTPOL0);
-		if (sa1111_readl(mapbase + SA1111_INTSTATCLR0) & mask)
+		writel_relaxed(ip ^ mask, mapbase + SA1111_INTPOL0);
+		writel_relaxed(ip, mapbase + SA1111_INTPOL0);
+		if (readl_relaxed(mapbase + SA1111_INTSTATCLR0) & mask)
 			break;
 	}
 
@@ -313,13 +313,13 @@ static int sa1111_type_irq(struct irq_data *d, unsigned int flags)
 	if ((!(flags & IRQ_TYPE_EDGE_RISING) ^ !(flags & IRQ_TYPE_EDGE_FALLING)) == 0)
 		return -EINVAL;
 
-	ip = sa1111_readl(mapbase + SA1111_INTPOL0);
+	ip = readl_relaxed(mapbase + SA1111_INTPOL0);
 	if (flags & IRQ_TYPE_EDGE_RISING)
 		ip &= ~mask;
 	else
 		ip |= mask;
-	sa1111_writel(ip, mapbase + SA1111_INTPOL0);
-	sa1111_writel(ip, mapbase + SA1111_WAKEPOL0);
+	writel_relaxed(ip, mapbase + SA1111_INTPOL0);
+	writel_relaxed(ip, mapbase + SA1111_WAKEPOL0);
 
 	return 0;
 }
@@ -330,12 +330,12 @@ static int sa1111_wake_irq(struct irq_data *d, unsigned int on)
 	void __iomem *mapbase = sachip->base + SA1111_INTC + sa1111_irqbank(d);
 	u32 we, mask = sa1111_irqmask(d);
 
-	we = sa1111_readl(mapbase + SA1111_WAKEEN0);
+	we = readl_relaxed(mapbase + SA1111_WAKEEN0);
 	if (on)
 		we |= mask;
 	else
 		we &= ~mask;
-	sa1111_writel(we, mapbase + SA1111_WAKEEN0);
+	writel_relaxed(we, mapbase + SA1111_WAKEEN0);
 
 	return 0;
 }
@@ -373,23 +373,23 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 	sachip->irq_base = ret;
 
 	/* disable all IRQs */
-	sa1111_writel(0, irqbase + SA1111_INTEN0);
-	sa1111_writel(0, irqbase + SA1111_INTEN1);
-	sa1111_writel(0, irqbase + SA1111_WAKEEN0);
-	sa1111_writel(0, irqbase + SA1111_WAKEEN1);
+	writel_relaxed(0, irqbase + SA1111_INTEN0);
+	writel_relaxed(0, irqbase + SA1111_INTEN1);
+	writel_relaxed(0, irqbase + SA1111_WAKEEN0);
+	writel_relaxed(0, irqbase + SA1111_WAKEEN1);
 
 	/*
 	 * detect on rising edge.  Note: Feb 2001 Errata for SA1111
 	 * specifies that S0ReadyInt and S1ReadyInt should be '1'.
 	 */
-	sa1111_writel(0, irqbase + SA1111_INTPOL0);
-	sa1111_writel(BIT(IRQ_S0_READY_NINT & 31) |
-		      BIT(IRQ_S1_READY_NINT & 31),
-		      irqbase + SA1111_INTPOL1);
+	writel_relaxed(0, irqbase + SA1111_INTPOL0);
+	writel_relaxed(BIT(IRQ_S0_READY_NINT & 31) |
+		       BIT(IRQ_S1_READY_NINT & 31),
+		       irqbase + SA1111_INTPOL1);
 
 	/* clear all IRQs */
-	sa1111_writel(~0, irqbase + SA1111_INTSTATCLR0);
-	sa1111_writel(~0, irqbase + SA1111_INTSTATCLR1);
+	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR0);
+	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR1);
 
 	for (i = IRQ_GPAIN0; i <= SSPROR; i++) {
 		irq = sachip->irq_base + i;
@@ -423,10 +423,10 @@ static void sa1111_remove_irq(struct sa1111 *sachip)
 	void __iomem *irqbase = sachip->base + SA1111_INTC;
 
 	/* disable all IRQs */
-	sa1111_writel(0, irqbase + SA1111_INTEN0);
-	sa1111_writel(0, irqbase + SA1111_INTEN1);
-	sa1111_writel(0, irqbase + SA1111_WAKEEN0);
-	sa1111_writel(0, irqbase + SA1111_WAKEEN1);
+	writel_relaxed(0, irqbase + SA1111_INTEN0);
+	writel_relaxed(0, irqbase + SA1111_INTEN1);
+	writel_relaxed(0, irqbase + SA1111_WAKEEN0);
+	writel_relaxed(0, irqbase + SA1111_WAKEEN1);
 
 	if (sachip->irq != NO_IRQ) {
 		irq_set_chained_handler_and_data(sachip->irq, NULL, NULL);
@@ -618,11 +618,11 @@ static void sa1111_wake(struct sa1111 *sachip)
 	/*
 	 * Turn VCO on, and disable PLL Bypass.
 	 */
-	r = sa1111_readl(sachip->base + SA1111_SKCR);
+	r = readl_relaxed(sachip->base + SA1111_SKCR);
 	r &= ~SKCR_VCO_OFF;
-	sa1111_writel(r, sachip->base + SA1111_SKCR);
+	writel_relaxed(r, sachip->base + SA1111_SKCR);
 	r |= SKCR_PLL_BYPASS | SKCR_OE_EN;
-	sa1111_writel(r, sachip->base + SA1111_SKCR);
+	writel_relaxed(r, sachip->base + SA1111_SKCR);
 
 	/*
 	 * Wait lock time.  SA1111 manual _doesn't_
@@ -634,7 +634,7 @@ static void sa1111_wake(struct sa1111 *sachip)
 	 * Enable RCLK.  We also ensure that RDYEN is set.
 	 */
 	r |= SKCR_RCLKEN | SKCR_RDYEN;
-	sa1111_writel(r, sachip->base + SA1111_SKCR);
+	writel_relaxed(r, sachip->base + SA1111_SKCR);
 
 	/*
 	 * Wait 14 RCLK cycles for the chip to finish coming out
@@ -645,7 +645,7 @@ static void sa1111_wake(struct sa1111 *sachip)
 	/*
 	 * Ensure all clocks are initially off.
 	 */
-	sa1111_writel(0, sachip->base + SA1111_SKPCR);
+	writel_relaxed(0, sachip->base + SA1111_SKPCR);
 
 	spin_unlock_irqrestore(&sachip->lock, flags);
 }
@@ -675,7 +675,7 @@ sa1111_configure_smc(struct sa1111 *sachip, int sdram, unsigned int drac,
 	if (cas_latency == 3)
 		smcr |= SMCR_CLAT;
 
-	sa1111_writel(smcr, sachip->base + SA1111_SMCR);
+	writel_relaxed(smcr, sachip->base + SA1111_SMCR);
 
 	/*
 	 * Now clear the bits in the DMA mask to work around the SA1111
@@ -814,7 +814,7 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	/*
 	 * Probe for the chip.  Only touch the SBI registers.
 	 */
-	id = sa1111_readl(sachip->base + SA1111_SKID);
+	id = readl_relaxed(sachip->base + SA1111_SKID);
 	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
 		printk(KERN_DEBUG "SA1111 not detected: ID = %08lx\n", id);
 		ret = -ENODEV;
@@ -833,11 +833,9 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	 * The interrupt controller must be initialised before any
 	 * other device to ensure that the interrupts are available.
 	 */
-	if (sachip->irq != NO_IRQ) {
-		ret = sa1111_setup_irq(sachip, pd->irq_base);
-		if (ret)
-			goto err_clk;
-	}
+	ret = sa1111_setup_irq(sachip, pd->irq_base);
+	if (ret)
+		goto err_clk;
 
 	/* Setup the GPIOs - should really be done after the IRQ setup */
 	ret = sa1111_setup_gpios(sachip);
@@ -864,8 +862,8 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	 * DMA.  It can otherwise be held firmly in the off position.
 	 * (currently, we always enable it.)
 	 */
-	val = sa1111_readl(sachip->base + SA1111_SKPCR);
-	sa1111_writel(val | SKPCR_DCLKEN, sachip->base + SA1111_SKPCR);
+	val = readl_relaxed(sachip->base + SA1111_SKPCR);
+	writel_relaxed(val | SKPCR_DCLKEN, sachip->base + SA1111_SKPCR);
 
 	/*
 	 * Enable the SA1110 memory bus request and grant signals.
@@ -962,31 +960,31 @@ static int sa1111_suspend_noirq(struct device *dev)
 	 * Save state.
 	 */
 	base = sachip->base;
-	save->skcr     = sa1111_readl(base + SA1111_SKCR);
-	save->skpcr    = sa1111_readl(base + SA1111_SKPCR);
-	save->skcdr    = sa1111_readl(base + SA1111_SKCDR);
-	save->skaud    = sa1111_readl(base + SA1111_SKAUD);
-	save->skpwm0   = sa1111_readl(base + SA1111_SKPWM0);
-	save->skpwm1   = sa1111_readl(base + SA1111_SKPWM1);
+	save->skcr     = readl_relaxed(base + SA1111_SKCR);
+	save->skpcr    = readl_relaxed(base + SA1111_SKPCR);
+	save->skcdr    = readl_relaxed(base + SA1111_SKCDR);
+	save->skaud    = readl_relaxed(base + SA1111_SKAUD);
+	save->skpwm0   = readl_relaxed(base + SA1111_SKPWM0);
+	save->skpwm1   = readl_relaxed(base + SA1111_SKPWM1);
 
-	sa1111_writel(0, sachip->base + SA1111_SKPWM0);
-	sa1111_writel(0, sachip->base + SA1111_SKPWM1);
+	writel_relaxed(0, sachip->base + SA1111_SKPWM0);
+	writel_relaxed(0, sachip->base + SA1111_SKPWM1);
 
 	base = sachip->base + SA1111_INTC;
-	save->intpol0  = sa1111_readl(base + SA1111_INTPOL0);
-	save->intpol1  = sa1111_readl(base + SA1111_INTPOL1);
-	save->inten0   = sa1111_readl(base + SA1111_INTEN0);
-	save->inten1   = sa1111_readl(base + SA1111_INTEN1);
-	save->wakepol0 = sa1111_readl(base + SA1111_WAKEPOL0);
-	save->wakepol1 = sa1111_readl(base + SA1111_WAKEPOL1);
-	save->wakeen0  = sa1111_readl(base + SA1111_WAKEEN0);
-	save->wakeen1  = sa1111_readl(base + SA1111_WAKEEN1);
+	save->intpol0  = readl_relaxed(base + SA1111_INTPOL0);
+	save->intpol1  = readl_relaxed(base + SA1111_INTPOL1);
+	save->inten0   = readl_relaxed(base + SA1111_INTEN0);
+	save->inten1   = readl_relaxed(base + SA1111_INTEN1);
+	save->wakepol0 = readl_relaxed(base + SA1111_WAKEPOL0);
+	save->wakepol1 = readl_relaxed(base + SA1111_WAKEPOL1);
+	save->wakeen0  = readl_relaxed(base + SA1111_WAKEEN0);
+	save->wakeen1  = readl_relaxed(base + SA1111_WAKEEN1);
 
 	/*
 	 * Disable.
 	 */
-	val = sa1111_readl(sachip->base + SA1111_SKCR);
-	sa1111_writel(val | SKCR_SLEEP, sachip->base + SA1111_SKCR);
+	val = readl_relaxed(sachip->base + SA1111_SKCR);
+	writel_relaxed(val | SKCR_SLEEP, sachip->base + SA1111_SKCR);
 
 	clk_disable(sachip->clk);
 
@@ -1023,7 +1021,7 @@ static int sa1111_resume_noirq(struct device *dev)
 	 * Ensure that the SA1111 is still here.
 	 * FIXME: shouldn't do this here.
 	 */
-	id = sa1111_readl(sachip->base + SA1111_SKID);
+	id = readl_relaxed(sachip->base + SA1111_SKID);
 	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
 		__sa1111_remove(sachip);
 		dev_set_drvdata(dev, NULL);
@@ -1047,26 +1045,26 @@ static int sa1111_resume_noirq(struct device *dev)
 	 */
 	spin_lock_irqsave(&sachip->lock, flags);
 
-	sa1111_writel(0, sachip->base + SA1111_INTC + SA1111_INTEN0);
-	sa1111_writel(0, sachip->base + SA1111_INTC + SA1111_INTEN1);
+	writel_relaxed(0, sachip->base + SA1111_INTC + SA1111_INTEN0);
+	writel_relaxed(0, sachip->base + SA1111_INTC + SA1111_INTEN1);
 
 	base = sachip->base;
-	sa1111_writel(save->skcr,     base + SA1111_SKCR);
-	sa1111_writel(save->skpcr,    base + SA1111_SKPCR);
-	sa1111_writel(save->skcdr,    base + SA1111_SKCDR);
-	sa1111_writel(save->skaud,    base + SA1111_SKAUD);
-	sa1111_writel(save->skpwm0,   base + SA1111_SKPWM0);
-	sa1111_writel(save->skpwm1,   base + SA1111_SKPWM1);
+	writel_relaxed(save->skcr,     base + SA1111_SKCR);
+	writel_relaxed(save->skpcr,    base + SA1111_SKPCR);
+	writel_relaxed(save->skcdr,    base + SA1111_SKCDR);
+	writel_relaxed(save->skaud,    base + SA1111_SKAUD);
+	writel_relaxed(save->skpwm0,   base + SA1111_SKPWM0);
+	writel_relaxed(save->skpwm1,   base + SA1111_SKPWM1);
 
 	base = sachip->base + SA1111_INTC;
-	sa1111_writel(save->intpol0,  base + SA1111_INTPOL0);
-	sa1111_writel(save->intpol1,  base + SA1111_INTPOL1);
-	sa1111_writel(save->inten0,   base + SA1111_INTEN0);
-	sa1111_writel(save->inten1,   base + SA1111_INTEN1);
-	sa1111_writel(save->wakepol0, base + SA1111_WAKEPOL0);
-	sa1111_writel(save->wakepol1, base + SA1111_WAKEPOL1);
-	sa1111_writel(save->wakeen0,  base + SA1111_WAKEEN0);
-	sa1111_writel(save->wakeen1,  base + SA1111_WAKEEN1);
+	writel_relaxed(save->intpol0,  base + SA1111_INTPOL0);
+	writel_relaxed(save->intpol1,  base + SA1111_INTPOL1);
+	writel_relaxed(save->inten0,   base + SA1111_INTEN0);
+	writel_relaxed(save->inten1,   base + SA1111_INTEN1);
+	writel_relaxed(save->wakepol0, base + SA1111_WAKEPOL0);
+	writel_relaxed(save->wakepol1, base + SA1111_WAKEPOL1);
+	writel_relaxed(save->wakeen0,  base + SA1111_WAKEEN0);
+	writel_relaxed(save->wakeen1,  base + SA1111_WAKEEN1);
 
 	spin_unlock_irqrestore(&sachip->lock, flags);
 
@@ -1153,7 +1151,7 @@ static unsigned int __sa1111_pll_clock(struct sa1111 *sachip)
 {
 	unsigned int skcdr, fbdiv, ipdiv, opdiv;
 
-	skcdr = sa1111_readl(sachip->base + SA1111_SKCDR);
+	skcdr = readl_relaxed(sachip->base + SA1111_SKCDR);
 
 	fbdiv = (skcdr & 0x007f) + 2;
 	ipdiv = ((skcdr & 0x0f80) >> 7) + 2;
@@ -1195,13 +1193,13 @@ void sa1111_select_audio_mode(struct sa1111_dev *sadev, int mode)
 
 	spin_lock_irqsave(&sachip->lock, flags);
 
-	val = sa1111_readl(sachip->base + SA1111_SKCR);
+	val = readl_relaxed(sachip->base + SA1111_SKCR);
 	if (mode == SA1111_AUDIO_I2S) {
 		val &= ~SKCR_SELAC;
 	} else {
 		val |= SKCR_SELAC;
 	}
-	sa1111_writel(val, sachip->base + SA1111_SKCR);
+	writel_relaxed(val, sachip->base + SA1111_SKCR);
 
 	spin_unlock_irqrestore(&sachip->lock, flags);
 }
@@ -1226,7 +1224,7 @@ int sa1111_set_audio_rate(struct sa1111_dev *sadev, int rate)
 	if (div > 128)
 		div = 128;
 
-	sa1111_writel(div - 1, sachip->base + SA1111_SKAUD);
+	writel_relaxed(div - 1, sachip->base + SA1111_SKAUD);
 
 	return 0;
 }
@@ -1244,7 +1242,7 @@ int sa1111_get_audio_rate(struct sa1111_dev *sadev)
 	if (sadev->devid != SA1111_DEVID_SAC)
 		return -EINVAL;
 
-	div = sa1111_readl(sachip->base + SA1111_SKAUD) + 1;
+	div = readl_relaxed(sachip->base + SA1111_SKAUD) + 1;
 
 	return __sa1111_pll_clock(sachip) / (256 * div);
 }
@@ -1261,10 +1259,10 @@ void sa1111_set_io_dir(struct sa1111_dev *sadev,
 
 #define MODIFY_BITS(port, mask, dir)		\
 	if (mask) {				\
-		val = sa1111_readl(port);	\
+		val = readl_relaxed(port);	\
 		val &= ~(mask);			\
 		val |= (dir) & (mask);		\
-		sa1111_writel(val, port);	\
+		writel_relaxed(val, port);	\
 	}
 
 	spin_lock_irqsave(&sachip->lock, flags);
@@ -1329,8 +1327,8 @@ int sa1111_enable_device(struct sa1111_dev *sadev)
 
 	if (ret == 0) {
 		spin_lock_irqsave(&sachip->lock, flags);
-		val = sa1111_readl(sachip->base + SA1111_SKPCR);
-		sa1111_writel(val | sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
+		val = readl_relaxed(sachip->base + SA1111_SKPCR);
+		writel_relaxed(val | sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
 		spin_unlock_irqrestore(&sachip->lock, flags);
 	}
 	return ret;
@@ -1348,8 +1346,8 @@ void sa1111_disable_device(struct sa1111_dev *sadev)
 	unsigned int val;
 
 	spin_lock_irqsave(&sachip->lock, flags);
-	val = sa1111_readl(sachip->base + SA1111_SKPCR);
-	sa1111_writel(val & ~sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
+	val = readl_relaxed(sachip->base + SA1111_SKPCR);
+	writel_relaxed(val & ~sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
 	spin_unlock_irqrestore(&sachip->lock, flags);
 
 	if (sachip->pdata && sachip->pdata->disable)
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 29fb44f51c92..8a7ccebd109d 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -30,9 +30,6 @@
 #define _SA1111(x)	((x) + sa1111->resource.start)
 #endif
 
-#define sa1111_writel(val,addr)	__raw_writel(val, addr)
-#define sa1111_readl(addr)	__raw_readl(addr)
-
 /*
  * 26 bits of the SA-1110 address bus are available to the SA-1111.
  * Use these when feeding target addresses to the DMA engines.
-- 
2.7.4
