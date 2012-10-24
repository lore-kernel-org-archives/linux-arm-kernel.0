From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Wed, 24 Oct 2012 19:57:27 +0900
Subject: [PATCH 2/5] i2c: i2c-sh_mobile: optimize ICCH/ICCL values according to
 I2C bus speed
In-Reply-To: <5087C93F.6080601@renesas.com>
References: <5087C93F.6080601@renesas.com>
Message-ID: <5087C997.5040503@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ICCH/ICCL values is supposed to be calculated/optimized to strictly meet
the timing specs required by the I2C standard.  The resulting I2C bus
speed does not matter at all, if it's less than 100 or 400 kHz.

Also fix a typo in the comment, print icch/iccl values at probe, etc.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 121 ++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 49 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 309d0d5..1ad80c9 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -122,9 +122,9 @@ struct sh_mobile_i2c_data {
 	unsigned long bus_speed;
 	struct clk *clk;
 	u_int8_t icic;
-	u_int8_t iccl;
-	u_int8_t icch;
 	u_int8_t flags;
+	u_int16_t iccl;
+	u_int16_t icch;
 
 	spinlock_t lock;
 	wait_queue_head_t wait;
@@ -135,7 +135,8 @@ struct sh_mobile_i2c_data {
 
 #define IIC_FLAG_HAS_ICIC67	(1 << 0)
 
-#define NORMAL_SPEED		100000 /* FAST_SPEED 400000 */
+#define STANDARD_MODE		100000
+#define FAST_MODE		400000
 
 /* Register offsets */
 #define ICDR			0x00
@@ -187,55 +188,76 @@ static void iic_set_clr(struct sh_mobile_i2c_data *pd, int offs,
 	iic_wr(pd, offs, (iic_rd(pd, offs) | set) & ~clr);
 }
 
+static u32 sh_mobile_i2c_iccl(unsigned long count_khz, u32 tLOW, u32 tf, int offset)
+{
+	/*
+	 * Conditional expression:
+	 *   ICCL >= COUNT_CLK * (tLOW + tf)
+	 *
+	 * SH-Mobile IIC hardware starts counting the LOW period of
+	 * the SCL signal (tLOW) as soon as it pulls the SCL line.
+	 * In order to meet the tLOW timing spec, we need to take into
+	 * account the fall time of SCL signal (tf).  Default tf value
+	 * should be 0.3 us, for safety.
+	 */
+	return (((count_khz * (tLOW + tf)) + 5000) / 10000) + offset;
+}
+
+static u32 sh_mobile_i2c_icch(unsigned long count_khz, u32 tHIGH, int offset)
+{
+	/*
+	 * Conditional expression:
+	 *   ICCH >= COUNT_CLK * tHIGH
+	 *
+	 * SH-Mobile IIC hardware is aware of SCL transition period 'tr',
+	 * and can ignore it.  SH-Mobile IIC controller starts counting
+	 * the HIGH period of the SCL signal (tHIGH) after the SCL input
+	 * voltage increases at VIH.
+	 */
+	return ((count_khz * tHIGH) + 5000) / 10000 + offset;
+}
+
 static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 {
-	unsigned long i2c_clk;
-	u_int32_t num;
-	u_int32_t denom;
-	u_int32_t tmp;
+	unsigned long i2c_clk_khz;
+	u32 tHIGH, tLOW, tf;
+	int offset;
 
 	/* Get clock rate after clock is enabled */
 	clk_enable(pd->clk);
-	i2c_clk = clk_get_rate(pd->clk);
-
-	/* Calculate the value for iccl. From the data sheet:
-	 * iccl = (p clock / transfer rate) * (L / (L + H))
-	 * where L and H are the SCL low/high ratio (5/4 in this case).
-	 * We also round off the result.
-	 */
-	num = i2c_clk * 5;
-	denom = pd->bus_speed * 9;
-	tmp = num * 10 / denom;
-	if (tmp % 10 >= 5)
-		pd->iccl = (u_int8_t)((num/denom) + 1);
-	else
-		pd->iccl = (u_int8_t)(num/denom);
-
-	/* one more bit of ICCL in ICIC */
-	if (pd->flags & IIC_FLAG_HAS_ICIC67) {
-		if ((num/denom) > 0xff)
-			pd->icic |= ICIC_ICCLB8;
-		else
-			pd->icic &= ~ICIC_ICCLB8;
+	i2c_clk_khz = clk_get_rate(pd->clk) / 1000;
+
+	if (pd->bus_speed == STANDARD_MODE) {
+		tLOW	= 47;	/* tLOW = 4.7 us */
+		tHIGH	= 40;	/* tHD;STA = tHIGH = 4.0 us */
+		tf	= 3;	/* tf = 0.3 us */
+		offset	= 0;	/* No offset */
+	} else if (pd->bus_speed == FAST_MODE) {
+		tLOW	= 13;	/* tLOW = 1.3 us */
+		tHIGH	= 6;	/* tHD;STA = tHIGH = 0.6 us */
+		tf	= 3;	/* tf = 0.3 us */
+		offset	= 0;	/* No offset */
+	} else {
+		dev_err(pd->dev, "unrecognized bus speed %lu Hz\n",
+			pd->bus_speed);
+		goto out;
 	}
 
-	/* Calculate the value for icch. From the data sheet:
-	   icch = (p clock / transfer rate) * (H / (L + H)) */
-	num = i2c_clk * 4;
-	tmp = num * 10 / denom;
-	if (tmp % 10 >= 5)
-		pd->icch = (u_int8_t)((num/denom) + 1);
+	pd->iccl = sh_mobile_i2c_iccl(i2c_clk_khz, tLOW, tf, offset);
+	/* one more bit of ICCL in ICIC */
+	if ((pd->iccl > 0xff) && (pd->flags & IIC_FLAG_HAS_ICIC67))
+		pd->icic |= ICIC_ICCLB8;
 	else
-		pd->icch = (u_int8_t)(num/denom);
+		pd->icic &= ~ICIC_ICCLB8;
 
+	pd->icch = sh_mobile_i2c_icch(i2c_clk_khz, tHIGH, offset);
 	/* one more bit of ICCH in ICIC */
-	if (pd->flags & IIC_FLAG_HAS_ICIC67) {
-		if ((num/denom) > 0xff)
-			pd->icic |= ICIC_ICCHB8;
-		else
-			pd->icic &= ~ICIC_ICCHB8;
-	}
+	if ((pd->icch > 0xff) && (pd->flags & IIC_FLAG_HAS_ICIC67))
+		pd->icic |= ICIC_ICCHB8;
+	else
+		pd->icic &= ~ICIC_ICCHB8;
 
+out:
 	clk_disable(pd->clk);
 }
 
@@ -252,8 +274,8 @@ static void activate_ch(struct sh_mobile_i2c_data *pd)
 	iic_wr(pd, ICIC, 0);
 
 	/* Set the clock */
-	iic_wr(pd, ICCL, pd->iccl);
-	iic_wr(pd, ICCH, pd->icch);
+	iic_wr(pd, ICCL, pd->iccl & 0xff);
+	iic_wr(pd, ICCH, pd->icch & 0xff);
 }
 
 static void deactivate_ch(struct sh_mobile_i2c_data *pd)
@@ -457,8 +479,8 @@ static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg)
 	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
 
 	/* Set the clock */
-	iic_wr(pd, ICCL, pd->iccl);
-	iic_wr(pd, ICCH, pd->icch);
+	iic_wr(pd, ICCL, pd->iccl & 0xff);
+	iic_wr(pd, ICCH, pd->icch & 0xff);
 
 	pd->msg = usr_msg;
 	pd->pos = -1;
@@ -627,8 +649,8 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		goto err_irq;
 	}
 
-	/* Use platformd data bus speed or NORMAL_SPEED */
-	pd->bus_speed = NORMAL_SPEED;
+	/* Use platform data bus speed or STANDARD_MODE */
+	pd->bus_speed = STANDARD_MODE;
 	if (pdata && pdata->bus_speed)
 		pd->bus_speed = pdata->bus_speed;
 
@@ -675,8 +697,9 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		goto err_all;
 	}
 
-	dev_info(&dev->dev, "I2C adapter %d with bus speed %lu Hz\n",
-		 adap->nr, pd->bus_speed);
+	dev_info(&dev->dev,
+		 "I2C adapter %d with bus speed %lu Hz (L/H=%x/%x)\n",
+		 adap->nr, pd->bus_speed, pd->iccl, pd->icch);
 
 	of_i2c_register_devices(adap);
 	return 0;
-- 
1.7.12.4
