From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 24 Mar 2010 22:16:29 -0500
Subject: [PATCH] locomo.c: use precalculated mmio address for LOCOMO_DAC access
Message-ID: <0D753D10438DA54287A00B02708426976368EBDA71@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of calculating the LOCOMO_DAC address for every read/write
operation lets just do it once at the start of locomo_m62332_sendata
and use 'mmio' instead of 'mapbase + LOCOMO_DAC'.

Also, pass the 'mmio' to locomo_m62332_sendbit instead of 'mapbase'
to remove those extra calculations also.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Eric Miao <eric.y.miao@gmail.com>

---

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 9dff07c..24461d0 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -625,37 +625,37 @@ void locomo_gpio_write(struct device *dev, unsigned int bits, unsigned int set)
 }
 EXPORT_SYMBOL(locomo_gpio_write);
 
-static void locomo_m62332_sendbit(void *mapbase, int bit)
+static void locomo_m62332_sendbit(void *mmio, int bit)
 {
 	unsigned int r;
 
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_DATA_HOLD_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
 
 	if (bit & 1) {
-		r = locomo_readl(mapbase + LOCOMO_DAC);
+		r = locomo_readl(mmio);
 		r |=  LOCOMO_DAC_SDAOEB;
-		locomo_writel(r, mapbase + LOCOMO_DAC);
+		locomo_writel(r, mmio);
 		udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	} else {
-		r = locomo_readl(mapbase + LOCOMO_DAC);
+		r = locomo_readl(mmio);
 		r &=  ~(LOCOMO_DAC_SDAOEB);
-		locomo_writel(r, mapbase + LOCOMO_DAC);
+		locomo_writel(r, mmio);
 		udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	}
 
 	udelay(DAC_DATA_SETUP_TIME);	/* 250 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/*  4.0 usec */
 }
@@ -663,49 +663,49 @@ static void locomo_m62332_sendbit(void *mapbase, int bit)
 void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int channel)
 {
 	struct locomo *lchip = locomo_chip_driver(ldev);
+	void *mmio = lchip->base + LOCOMO_DAC;
 	int i;
 	unsigned char data;
 	unsigned int r;
-	void *mapbase = lchip->base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&lchip->lock, flags);
 
 	/* Start */
 	udelay(DAC_BUS_FREE_TIME);	/* 5.0 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r |=  LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.0 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_START_HOLD_TIME);	/* 5.0 usec */
 	udelay(DAC_DATA_HOLD_TIME);	/* 300 nsec */
 
 	/* Send slave address and W bit (LSB is W bit) */
 	data = (M62332_SLAVE_ADDR << 1) | M62332_W_BIT;
 	for (i = 1; i <= 8; i++) {
-		locomo_m62332_sendbit(mapbase, data >> (8 - i));
+		locomo_m62332_sendbit(mmio, data >> (8 - i));
 	}
 
 	/* Check A bit */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
-	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
+	if (locomo_readl(mmio) & LOCOMO_DAC_SDAOEB) {	/* High is error */
 		printk(KERN_WARNING "locomo: m62332_senddata Error 1\n");
 		goto out;
 	}
@@ -715,74 +715,74 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
 	/*            = 1 : ch2 select              */
 	data = M62332_SUB_ADDR + channel;
 	for (i = 1; i <= 8; i++) {
-		locomo_m62332_sendbit(mapbase, data >> (8 - i));
+		locomo_m62332_sendbit(mmio, data >> (8 - i));
 	}
 
 	/* Check A bit */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
-	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
+	if (locomo_readl(mmio) & LOCOMO_DAC_SDAOEB) {	/* High is error */
 		printk(KERN_WARNING "locomo: m62332_senddata Error 2\n");
 		goto out;
 	}
 
 	/* Send DAC data */
 	for (i = 1; i <= 8; i++) {
-		locomo_m62332_sendbit(mapbase, dac_data >> (8 - i));
+		locomo_m62332_sendbit(mmio, dac_data >> (8 - i));
 	}
 
 	/* Check A bit */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
-	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
+	if (locomo_readl(mmio) & LOCOMO_DAC_SDAOEB) {	/* High is error */
 		printk(KERN_WARNING "locomo: m62332_senddata Error 3\n");
 	}
 
 out:
 	/* stop */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r |=  LOCOMO_DAC_SDAOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4 usec */
 
-	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r = locomo_readl(mmio);
 	r |=  LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
+	locomo_writel(r, mmio);
 	udelay(DAC_LOW_SETUP_TIME);	/* 1000 nsec */
 	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
 
