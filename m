From: robherring2@gmail.com (Rob Herring)
Date: Fri,  6 Jul 2012 13:40:38 -0500
Subject: =?UTF-8?q?=5BPATCH=2013/15=5D=20i2c=3A=20iop3xx=3A=20clean-up=20trailing=20whitespace?=
In-Reply-To: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
Message-ID: <1341600040-30993-14-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove a bunch of trailing whitespace. No functional changes.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
Cc: "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>
Cc: linux-i2c at vger.kernel.org
---
 drivers/i2c/busses/i2c-iop3xx.c |  112 +++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 93f147a..567d873 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -4,13 +4,13 @@
 /* Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
  *                    <Peter dot Milne@D hyphen TACQ dot com>
  *
- * With acknowledgements to i2c-algo-ibm_ocp.c by 
+ * With acknowledgements to i2c-algo-ibm_ocp.c by
  * Ian DaSilva, MontaVista Software, Inc. idasilva at mvista.com
  *
  * And i2c-algo-pcf.c, which was created by Simon G. Vogl and Hans Berglund:
  *
  * Copyright (C) 1995-1997 Simon G. Vogl, 1998-2000 Hans Berglund
- *  
+ *
  * And which acknowledged Ky?sti M?lkki <kmalkki@cc.hut.fi>,
  * Frodo Looijaard <frodol@dds.nl>, Martin Bailey<mbailey@littlefeet-inc.com>
  *
@@ -45,8 +45,8 @@
 /* global unit counter */
 static int i2c_id;
 
-static inline unsigned char 
-iic_cook_addr(struct i2c_msg *msg) 
+static inline unsigned char
+iic_cook_addr(struct i2c_msg *msg)
 {
 	unsigned char addr;
 
@@ -55,24 +55,24 @@ iic_cook_addr(struct i2c_msg *msg)
 	if (msg->flags & I2C_M_RD)
 		addr |= 1;
 
-	return addr;   
+	return addr;
 }
 
-static void 
+static void
 iop3xx_i2c_reset(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	/* Follows devman 9.3 */
 	__raw_writel(IOP3XX_ICR_UNIT_RESET, iop3xx_adap->ioaddr + CR_OFFSET);
 	__raw_writel(IOP3XX_ISR_CLEARBITS, iop3xx_adap->ioaddr + SR_OFFSET);
 	__raw_writel(0, iop3xx_adap->ioaddr + CR_OFFSET);
-} 
+}
 
-static void 
+static void
 iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	u32 cr = IOP3XX_ICR_GCD | IOP3XX_ICR_SCLEN | IOP3XX_ICR_UE;
 
-	/* 
+	/*
 	 * Every time unit enable is asserted, GPOD needs to be cleared
 	 * on IOP3XX to avoid data corruption on the bus.
 	 */
@@ -86,7 +86,7 @@ iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
 	}
 #endif
 	/* NB SR bits not same position as CR IE bits :-( */
-	iop3xx_adap->SR_enabled = 
+	iop3xx_adap->SR_enabled =
 		IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD |
 		IOP3XX_ISR_RXFULL | IOP3XX_ISR_TXEMPTY;
 
@@ -96,23 +96,23 @@ iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
 	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
 
-static void 
+static void
 iop3xx_i2c_transaction_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
-	
-	cr &= ~(IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE | 
+
+	cr &= ~(IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE |
 		IOP3XX_ICR_MSTOP | IOP3XX_ICR_SCLEN);
 
 	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
 
-/* 
- * NB: the handler has to clear the source of the interrupt! 
+/*
+ * NB: the handler has to clear the source of the interrupt!
  * Then it passes the SR flags of interest to BH via adap data
  */
-static irqreturn_t 
-iop3xx_i2c_irq_handler(int this_irq, void *dev_id) 
+static irqreturn_t
+iop3xx_i2c_irq_handler(int this_irq, void *dev_id)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = dev_id;
 	u32 sr = __raw_readl(iop3xx_adap->ioaddr + SR_OFFSET);
@@ -126,7 +126,7 @@ iop3xx_i2c_irq_handler(int this_irq, void *dev_id)
 }
 
 /* check all error conditions, clear them , report most important */
-static int 
+static int
 iop3xx_i2c_error(u32 sr)
 {
 	int rc = 0;
@@ -135,12 +135,12 @@ iop3xx_i2c_error(u32 sr)
 		if ( !rc ) rc = -I2C_ERR_BERR;
 	}
 	if ((sr & IOP3XX_ISR_ALD)) {
-		if ( !rc ) rc = -I2C_ERR_ALD;		
+		if ( !rc ) rc = -I2C_ERR_ALD;
 	}
-	return rc;	
+	return rc;
 }
 
-static inline u32 
+static inline u32
 iop3xx_i2c_get_srstat(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	unsigned long flags;
@@ -161,8 +161,8 @@ iop3xx_i2c_get_srstat(struct i2c_algo_iop3xx_data *iop3xx_adap)
 typedef int (* compare_func)(unsigned test, unsigned mask);
 /* returns 1 on correct comparison */
 
-static int 
-iop3xx_i2c_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap, 
+static int
+iop3xx_i2c_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap,
 			  unsigned flags, unsigned* status,
 			  compare_func compare)
 {
@@ -192,47 +192,47 @@ iop3xx_i2c_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap,
 }
 
 /*
- * Concrete compare_funcs 
+ * Concrete compare_funcs
  */
-static int 
+static int
 all_bits_clear(unsigned test, unsigned mask)
 {
 	return (test & mask) == 0;
 }
 
-static int 
+static int
 any_bits_set(unsigned test, unsigned mask)
 {
 	return (test & mask) != 0;
 }
 
-static int 
+static int
 iop3xx_i2c_wait_tx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
 {
-	return iop3xx_i2c_wait_event( 
-		iop3xx_adap, 
+	return iop3xx_i2c_wait_event(
+		iop3xx_adap,
 	        IOP3XX_ISR_TXEMPTY | IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD,
 		status, any_bits_set);
 }
 
-static int 
+static int
 iop3xx_i2c_wait_rx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
 {
-	return iop3xx_i2c_wait_event( 
-		iop3xx_adap, 
+	return iop3xx_i2c_wait_event(
+		iop3xx_adap,
 		IOP3XX_ISR_RXFULL | IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD,
 		status,	any_bits_set);
 }
 
-static int 
+static int
 iop3xx_i2c_wait_idle(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
 {
-	return iop3xx_i2c_wait_event( 
+	return iop3xx_i2c_wait_event(
 		iop3xx_adap, IOP3XX_ISR_UNITBUSY, status, all_bits_clear);
 }
 
-static int 
-iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap, 
+static int
+iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,
 				struct i2c_msg* msg)
 {
 	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
@@ -247,7 +247,7 @@ iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,
 	}
 
 	__raw_writel(iic_cook_addr(msg), iop3xx_adap->ioaddr + DBR_OFFSET);
-	
+
 	cr &= ~(IOP3XX_ICR_MSTOP | IOP3XX_ICR_NACK);
 	cr |= IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE;
 
@@ -257,8 +257,8 @@ iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,
 	return rc;
 }
 
-static int 
-iop3xx_i2c_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char byte, 
+static int
+iop3xx_i2c_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char byte,
 				int stop)
 {
 	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
@@ -277,10 +277,10 @@ iop3xx_i2c_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char byte,
 	rc = iop3xx_i2c_wait_tx_done(iop3xx_adap, &status);
 
 	return rc;
-} 
+}
 
-static int 
-iop3xx_i2c_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char* byte, 
+static int
+iop3xx_i2c_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char* byte,
 				int stop)
 {
 	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
@@ -304,19 +304,19 @@ iop3xx_i2c_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char* byte,
 	return rc;
 }
 
-static int 
+static int
 iop3xx_i2c_writebytes(struct i2c_adapter *i2c_adap, const char *buf, int count)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
 	int ii;
 	int rc = 0;
 
-	for (ii = 0; rc == 0 && ii != count; ++ii) 
+	for (ii = 0; rc == 0 && ii != count; ++ii)
 		rc = iop3xx_i2c_write_byte(iop3xx_adap, buf[ii], ii==count-1);
 	return rc;
 }
 
-static int 
+static int
 iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
@@ -325,7 +325,7 @@ iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count)
 
 	for (ii = 0; rc == 0 && ii != count; ++ii)
 		rc = iop3xx_i2c_read_byte(iop3xx_adap, &buf[ii], ii==count-1);
-	
+
 	return rc;
 }
 
@@ -336,8 +336,8 @@ iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count)
  * Each transfer (i.e. a read or a write) is separated by a repeated start
  * condition.
  */
-static int 
-iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pmsg) 
+static int
+iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pmsg)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
 	int rc;
@@ -357,8 +357,8 @@ iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pmsg)
 /*
  * master_xfer() - main read/write entry
  */
-static int 
-iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, 
+static int
+iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 				int num)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
@@ -375,14 +375,14 @@ iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 	}
 
 	iop3xx_i2c_transaction_cleanup(iop3xx_adap);
-	
+
 	if(ret)
 		return ret;
 
-	return im;   
+	return im;
 }
 
-static u32 
+static u32
 iop3xx_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
@@ -393,11 +393,11 @@ static const struct i2c_algorithm iop3xx_i2c_algo = {
 	.functionality	= iop3xx_i2c_func,
 };
 
-static int 
+static int
 iop3xx_i2c_remove(struct platform_device *pdev)
 {
 	struct i2c_adapter *padapter = platform_get_drvdata(pdev);
-	struct i2c_algo_iop3xx_data *adapter_data = 
+	struct i2c_algo_iop3xx_data *adapter_data =
 		(struct i2c_algo_iop3xx_data *)padapter->algo_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	unsigned long cr = __raw_readl(adapter_data->ioaddr + CR_OFFSET);
@@ -419,7 +419,7 @@ iop3xx_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int 
+static int
 iop3xx_i2c_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-- 
1.7.9.5
