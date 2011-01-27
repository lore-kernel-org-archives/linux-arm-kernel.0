From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 27 Jan 2011 13:52:53 -0700
Subject: locomo.c: factor out "sendbyte" from locomo_m62332_senddata
Message-ID: <201101271352.53549.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The locomo_m62332_senddata function sends a three byte i2c message to
an attached DAC.  Each of the three byte transfers, and associated ACK,
is individually coded in the function.

Factor out the "sendbyte" code to make locomo_m62332_senddata more
legible.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
 
---

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index a026a6b..25a9642 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -660,15 +660,56 @@ static void locomo_m62332_sendbit(void *mapbase, int bit)
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/*  4.0 usec */
 }
 
+static int locomo_m62332_sendbyte(void *mapbase, unsigned char data)
+{
+	unsigned int r;
+	int i;
+
+	/* Send the data */
+	for (i = 1; i <= 8; i++)
+		locomo_m62332_sendbit(mapbase, data >> (8 - i));
+
+	/* Check A bit */
+	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r &=  ~(LOCOMO_DAC_SCLOEB);
+	locomo_writel(r, mapbase + LOCOMO_DAC);
+	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
+	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
+	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r &=  ~(LOCOMO_DAC_SDAOEB);
+	locomo_writel(r, mapbase + LOCOMO_DAC);
+	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
+	r = locomo_readl(mapbase + LOCOMO_DAC);
+	r |=  LOCOMO_DAC_SCLOEB;
+	locomo_writel(r, mapbase + LOCOMO_DAC);
+	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
+	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
+	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB)
+		return -ETIMEDOUT;	/* High is error */
+
+	return 0;
+}
+
 void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int channel)
 {
 	struct locomo *lchip = locomo_chip_driver(ldev);
 	int i;
-	unsigned char data;
+	unsigned char data[3];
 	unsigned int r;
 	void *mapbase = lchip->base;
 	unsigned long flags;
 
+	/*
+	 * 0 = slave address and W bit (LSB is W bit)
+	 * 1 = sub address (LSB is channel select)
+	 *     channel = 0 : ch1 select
+	 *             = 1 : ch2 select
+	 * 2 = DAC data
+	 */
+	data[0] = (M62332_SLAVE_ADDR << 1) | M62332_W_BIT;
+	data[1] = M62332_SUB_ADDR + channel;
+	data[2] = dac_data;
+
 	spin_lock_irqsave(&lchip->lock, flags);
 
 	/* Start */
@@ -684,85 +725,15 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
 	udelay(DAC_START_HOLD_TIME);	/* 5.0 usec */
 	udelay(DAC_DATA_HOLD_TIME);	/* 300 nsec */
 
-	/* Send slave address and W bit (LSB is W bit) */
-	data = (M62332_SLAVE_ADDR << 1) | M62332_W_BIT;
-	for (i = 1; i <= 8; i++) {
-		locomo_m62332_sendbit(mapbase, data >> (8 - i));
+	/* Send the data and check for each ACK */
+	for (i = 0; i < 3; i++) {
+		if (locomo_m62332_sendbyte(mapbase, data[i])) {
+			printk(KERN_WARNING "locomo: m62332_senddata Error %d\n",
+				i+1);
+			break;
+		}
 	}
 
-	/* Check A bit */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
-	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
-	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
-	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
-	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
-	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
-	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
-	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
-	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
-		printk(KERN_WARNING "locomo: m62332_senddata Error 1\n");
-		goto out;
-	}
-
-	/* Send Sub address (LSB is channel select) */
-	/*    channel = 0 : ch1 select              */
-	/*            = 1 : ch2 select              */
-	data = M62332_SUB_ADDR + channel;
-	for (i = 1; i <= 8; i++) {
-		locomo_m62332_sendbit(mapbase, data >> (8 - i));
-	}
-
-	/* Check A bit */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
-	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
-	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
-	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
-	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
-	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
-	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
-	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
-	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
-		printk(KERN_WARNING "locomo: m62332_senddata Error 2\n");
-		goto out;
-	}
-
-	/* Send DAC data */
-	for (i = 1; i <= 8; i++) {
-		locomo_m62332_sendbit(mapbase, dac_data >> (8 - i));
-	}
-
-	/* Check A bit */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
-	r &=  ~(LOCOMO_DAC_SCLOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
-	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
-	r &=  ~(LOCOMO_DAC_SDAOEB);
-	locomo_writel(r, mapbase + LOCOMO_DAC);
-	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
-	r = locomo_readl(mapbase + LOCOMO_DAC);
-	r |=  LOCOMO_DAC_SCLOEB;
-	locomo_writel(r, mapbase + LOCOMO_DAC);
-	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
-	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
-	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
-		printk(KERN_WARNING "locomo: m62332_senddata Error 3\n");
-	}
-
-out:
 	/* stop */
 	r = locomo_readl(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
