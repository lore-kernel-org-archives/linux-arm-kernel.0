From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Apr 2016 09:04:50 +0200
Subject: [PATCH v2 2/3] i2c: s3c2410: Minor function-level comment cleanup
In-Reply-To: <1461222291-5642-1-git-send-email-k.kozlowski@samsung.com>
References: <1461222291-5642-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1461222291-5642-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup the weird function-level comments and remove obvious
documentation for probe/remove.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's reviewed-by.
2. Fix typo in commit msg (pointed by Javier).
---
 drivers/i2c/busses/i2c-s3c2410.c | 110 ++++++++++++---------------------------
 1 file changed, 32 insertions(+), 78 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index e9658af36f2e..fd3695a921f1 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -163,11 +163,9 @@ static const struct of_device_id s3c24xx_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, s3c24xx_i2c_match);
 #endif
 
-/* s3c24xx_get_device_quirks
- *
+/*
  * Get controller type either from device tree or platform device variant.
-*/
-
+ */
 static inline kernel_ulong_t s3c24xx_get_device_quirks(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
@@ -179,12 +177,10 @@ static inline kernel_ulong_t s3c24xx_get_device_quirks(struct platform_device *p
 	return platform_get_device_id(pdev)->driver_data;
 }
 
-/* s3c24xx_i2c_master_complete
- *
- * complete the message and wake up the caller, using the given return code,
+/*
+ * Complete the message and wake up the caller, using the given return code,
  * or zero to mean ok.
-*/
-
+ */
 static inline void s3c24xx_i2c_master_complete(struct s3c24xx_i2c *i2c, int ret)
 {
 	dev_dbg(i2c->dev, "master_complete %d\n", ret);
@@ -217,7 +213,6 @@ static inline void s3c24xx_i2c_enable_ack(struct s3c24xx_i2c *i2c)
 }
 
 /* irq enable/disable functions */
-
 static inline void s3c24xx_i2c_disable_irq(struct s3c24xx_i2c *i2c)
 {
 	unsigned long tmp;
@@ -251,11 +246,9 @@ static bool is_ack(struct s3c24xx_i2c *i2c)
 	return false;
 }
 
-/* s3c24xx_i2c_message_start
- *
+/*
  * put the start of a message onto the bus
-*/
-
+ */
 static void s3c24xx_i2c_message_start(struct s3c24xx_i2c *i2c,
 				      struct i2c_msg *msg)
 {
@@ -364,21 +357,17 @@ static inline void s3c24xx_i2c_stop(struct s3c24xx_i2c *i2c, int ret)
 /* helper functions to determine the current state in the set of
  * messages we are sending */
 
-/* is_lastmsg()
- *
+/*
  * returns TRUE if the current message is the last in the set
-*/
-
+ */
 static inline int is_lastmsg(struct s3c24xx_i2c *i2c)
 {
 	return i2c->msg_idx >= (i2c->msg_num - 1);
 }
 
-/* is_msglast
- *
+/*
  * returns TRUE if we this is the last byte in the current message
-*/
-
+ */
 static inline int is_msglast(struct s3c24xx_i2c *i2c)
 {
 	/* msg->len is always 1 for the first byte of smbus block read.
@@ -390,21 +379,17 @@ static inline int is_msglast(struct s3c24xx_i2c *i2c)
 	return i2c->msg_ptr == i2c->msg->len-1;
 }
 
-/* is_msgend
- *
+/*
  * returns TRUE if we reached the end of the current message
-*/
-
+ */
 static inline int is_msgend(struct s3c24xx_i2c *i2c)
 {
 	return i2c->msg_ptr >= i2c->msg->len;
 }
 
-/* i2c_s3c_irq_nextbyte
- *
+/*
  * process an interrupt and work out what to do
  */
-
 static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 {
 	unsigned long tmp;
@@ -568,11 +553,9 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 	return ret;
 }
 
-/* s3c24xx_i2c_irq
- *
+/*
  * top level IRQ servicing routine
-*/
-
+ */
 static irqreturn_t s3c24xx_i2c_irq(int irqno, void *dev_id)
 {
 	struct s3c24xx_i2c *i2c = dev_id;
@@ -630,11 +613,9 @@ static inline void s3c24xx_i2c_disable_bus(struct s3c24xx_i2c *i2c)
 }
 
 
-/* s3c24xx_i2c_set_master
- *
+/*
  * get the i2c bus for a master transaction
-*/
-
+ */
 static int s3c24xx_i2c_set_master(struct s3c24xx_i2c *i2c)
 {
 	unsigned long iicstat;
@@ -652,11 +633,9 @@ static int s3c24xx_i2c_set_master(struct s3c24xx_i2c *i2c)
 	return -ETIMEDOUT;
 }
 
-/* s3c24xx_i2c_wait_idle
- *
+/*
  * wait for the i2c bus to become idle.
-*/
-
+ */
 static void s3c24xx_i2c_wait_idle(struct s3c24xx_i2c *i2c)
 {
 	unsigned long iicstat;
@@ -706,11 +685,9 @@ static void s3c24xx_i2c_wait_idle(struct s3c24xx_i2c *i2c)
 		dev_warn(i2c->dev, "timeout waiting for bus idle\n");
 }
 
-/* s3c24xx_i2c_doxfer
- *
+/*
  * this starts an i2c transfer
-*/
-
+ */
 static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 			      struct i2c_msg *msgs, int num)
 {
@@ -771,12 +748,10 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	return ret;
 }
 
-/* s3c24xx_i2c_xfer
- *
+/*
  * first port of call from the i2c bus code when an message needs
  * transferring across the i2c bus.
-*/
-
+ */
 static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 			struct i2c_msg *msgs, int num)
 {
@@ -814,17 +789,14 @@ static u32 s3c24xx_i2c_func(struct i2c_adapter *adap)
 }
 
 /* i2c bus registration info */
-
 static const struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.master_xfer		= s3c24xx_i2c_xfer,
 	.functionality		= s3c24xx_i2c_func,
 };
 
-/* s3c24xx_i2c_calcdivisor
- *
+/*
  * return the divisor settings for a given frequency
-*/
-
+ */
 static int s3c24xx_i2c_calcdivisor(unsigned long clkin, unsigned int wanted,
 				   unsigned int *div1, unsigned int *divs)
 {
@@ -850,13 +822,11 @@ static int s3c24xx_i2c_calcdivisor(unsigned long clkin, unsigned int wanted,
 	return clkin / (calc_divs * calc_div1);
 }
 
-/* s3c24xx_i2c_clockrate
- *
+/*
  * work out a divisor for the user requested frequency setting,
  * either by the requested frequency, or scanning the acceptable
  * range of frequencies until something is found
-*/
-
+ */
 static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 {
 	struct s3c2410_platform_i2c *pdata = i2c->pdata;
@@ -1028,11 +998,9 @@ static void s3c24xx_i2c_dt_gpio_free(struct s3c24xx_i2c *i2c)
 }
 #endif
 
-/* s3c24xx_i2c_init
- *
+/*
  * initialise the controller, set the IO lines and frequency
-*/
-
+ */
 static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 {
 	struct s3c2410_platform_i2c *pdata;
@@ -1068,11 +1036,9 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 }
 
 #ifdef CONFIG_OF
-/* s3c24xx_i2c_parse_dt
- *
+/*
  * Parse the device tree node and retreive the platform data.
-*/
-
+ */
 static void
 s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
 {
@@ -1111,11 +1077,6 @@ s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
 }
 #endif
 
-/* s3c24xx_i2c_probe
- *
- * called by the bus driver when a suitable device is found
-*/
-
 static int s3c24xx_i2c_probe(struct platform_device *pdev)
 {
 	struct s3c24xx_i2c *i2c;
@@ -1258,11 +1219,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/* s3c24xx_i2c_remove
- *
- * called when device is removed from the bus
-*/
-
 static int s3c24xx_i2c_remove(struct platform_device *pdev)
 {
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
@@ -1332,8 +1288,6 @@ static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
 #define S3C24XX_DEV_PM_OPS NULL
 #endif
 
-/* device driver for platform bus bits */
-
 static struct platform_driver s3c24xx_i2c_driver = {
 	.probe		= s3c24xx_i2c_probe,
 	.remove		= s3c24xx_i2c_remove,
-- 
1.9.1
