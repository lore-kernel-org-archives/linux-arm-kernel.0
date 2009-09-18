From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 18 Sep 2009 15:18:55 -0400
Subject: [PATCH] ep93xx: update i2c support
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D41F55@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the ep93xx i2c support to allow the platform init to configure
the sda and scl pins as open drain or normal cmos drivers.  Also allow
the platform to set the udelay and timeout for the i2c-gpio driver.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 16b92c3..d115000 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -549,12 +549,13 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 	platform_device_register(&ep93xx_eth_device);
 }
 
+
+/*************************************************************************
+ * EP93xx i2c peripheral handling
+ *************************************************************************/
 static struct i2c_gpio_platform_data ep93xx_i2c_data = {
 	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
-	.sda_is_open_drain	= 0,
 	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
-	.scl_is_open_drain	= 0,
-	.udelay			= 2,
 };
 
 static struct platform_device ep93xx_i2c_device = {
@@ -563,8 +564,32 @@ static struct platform_device ep93xx_i2c_device = {
 	.dev.platform_data	= &ep93xx_i2c_data,
 };
 
-void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num)
+void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num,
+				int sda_is_open_drain, int scl_is_open_drain,
+				int udelay, int timeout)
 {
+	/*
+	 * Set the EEPROM interface pin drive type control.
+	 * Defines the driver type for the EECLK and EEDAT pins as either
+	 * open drain, which will require an external pull-up, or a normal
+	 * CMOS driver.
+	 */
+	ep93xx_i2c_data.sda_is_open_drain = sda_is_open_drain;
+	ep93xx_i2c_data.scl_is_open_drain = scl_is_open_drain;
+
+	__raw_write((sda_is_open_drain<<1) | (scl_is_open_drain<<0)),
+			EP93XX_GPIO_EEDRIVE);
+
+	/*
+	 * udelay: signal toggle delay. SCL frequency is (500 / udelay) kHz
+	 *         == 0 will default to 5 (100 khz)
+	 * timeout: clock stretching timeout in jiffies. If the slave keeps
+	 *          SCL low for longer than this, the transfer will time out.
+	 *          == 0 will default to HZ / 10 (100 ms)
+	 */
+	ep93xx_i2c_data.udelay = udelay;
+	ep93xx_i2c_data.timeout = timeout;
+
 	i2c_register_board_info(0, devices, num);
 	platform_device_register(&ep93xx_i2c_device);
 }
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 73145ae..39b8234 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -93,11 +93,13 @@ static void __init edb93xx_register_i2c(void)
 	if (machine_is_edb9302a() || machine_is_edb9307a() ||
 	    machine_is_edb9315a()) {
 		ep93xx_register_i2c(edb93xxa_i2c_data,
-				ARRAY_SIZE(edb93xxa_i2c_data));
+				ARRAY_SIZE(edb93xxa_i2c_data),
+				0, 0, 2, 0);
 	} else if (machine_is_edb9307() || machine_is_edb9312() ||
 		   machine_is_edb9315()) {
 		ep93xx_register_i2c(edb93xx_i2c_data,
-				ARRAY_SIZE(edb93xx_i2c_data));
+				ARRAY_SIZE(edb93xx_i2c_data),
+				0, 0, 2, 0);
 	}
 }
 
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index ea78e90..53f1277 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -126,6 +126,7 @@
 #define EP93XX_GPIO_B_INT_ACK		EP93XX_GPIO_REG(0xb4)
 #define EP93XX_GPIO_B_INT_ENABLE	EP93XX_GPIO_REG(0xb8)
 #define EP93XX_GPIO_B_INT_STATUS	EP93XX_GPIO_REG(0xbc)
+#define EP93XX_GPIO_EEDRIVE		EP93XX_GPIO_REG(0xc8)
 
 #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
 
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 5f5fa65..25aa4a3 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -32,7 +32,9 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 }
 
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
-void ep93xx_register_i2c(struct i2c_board_info *devices, int num);
+void ep93xx_register_i2c(struct i2c_board_info *devices, int num,
+			 int sda_is_open_drain, int scl_is_open_drain,
+			 int udelay, int timeout);
 void ep93xx_register_pwm(int pwm0, int pwm1);
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev); 
