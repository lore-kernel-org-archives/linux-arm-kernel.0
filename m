From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 1 Oct 2009 18:18:44 -0400
Subject: [PATCH] ep93xx: update i2c support
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D42E16@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901D41F55@mi8nycmail19.Mi8.com>	<BD79186B4FD85F4B8E60E381CAEE190901D41F5D@mi8nycmail19.Mi8.com>	<4AC3BB1F.9050903@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42C6B@mi8nycmail19.Mi8.com>	<4AC3C8D2.5060009@bluewatersys.com><BD79186B4FD85F4B8E60E381CAEE190901D42C7C@mi8nycmail19.Mi8.com><4AC40C11.4060401@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42E16@mi8nycmail19.Mi8.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D42E1C@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the ep93xx i2c support:

  1) The platform init code passes the configuration data for the
     i2c-gpio driver.  This allows any gpio pin do be used for the
     sda and scl pins.  It also allows the platform to specify the
     udelay and timeout.
  2) Program the gpio configuration register to enable/disable the
     open drain drivers.  Note that this really only works if the
     sda and scl pins are set to EP93XX_GPIO_LINE_EEDAT and
     EP93XX_GPIO_LINE_EECLK.
  3) Update the edb93xx.c platform init to use the new support.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: Ryan Mallon <ryan@bluewatersys.com>

--- 

V6 - add missing #include <linux/gpio.h> to edb93xx.c
V5 - use pr_warning for sda/scl messages
V4 - add warning message when sda/scl are not EEDAT/EECLK and
     configured as open drain
V3 - rebased on comments from Ryan Mallon


diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index f7ebed9..e8bae09 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -550,13 +550,11 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 	platform_device_register(&ep93xx_eth_device);
 }
 
-static struct i2c_gpio_platform_data ep93xx_i2c_data = {
-	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
-	.sda_is_open_drain	= 0,
-	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
-	.scl_is_open_drain	= 0,
-	.udelay			= 2,
-};
+
+/*************************************************************************
+ * EP93xx i2c peripheral handling
+ *************************************************************************/
+static struct i2c_gpio_platform_data ep93xx_i2c_data;
 
 static struct platform_device ep93xx_i2c_device = {
 	.name			= "i2c-gpio",
@@ -564,8 +562,25 @@ static struct platform_device ep93xx_i2c_device = {
 	.dev.platform_data	= &ep93xx_i2c_data,
 };
 
-void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num)
+void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
+				struct i2c_board_info *devices, int num)
 {
+	/*
+	 * Set the EEPROM interface pin drive type control.
+	 * Defines the driver type for the EECLK and EEDAT pins as either
+	 * open drain, which will require an external pull-up, or a normal
+	 * CMOS driver.
+	 */
+	if (data->sda_is_open_drain && data->sda_pin != EP93XX_GPIO_LINE_EEDAT)
+		pr_warning("ep93xx: sda != EEDAT, open drain has no effect\n");
+	if (data->scl_is_open_drain && data->scl_pin != EP93XX_GPIO_LINE_EECLK)
+		pr_warning("ep93xx: scl != EECLK, open drain has no effect\n");
+	
+	__raw_writel((data->sda_is_open_drain << 1) |
+		     (data->scl_is_open_drain << 0),
+		     EP93XX_GPIO_EEDRIVE);
+
+	ep93xx_i2c_data = *data;
 	i2c_register_board_info(0, devices, num);
 	platform_device_register(&ep93xx_i2c_device);
 }
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 73145ae..ca71cf1 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -27,8 +27,10 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/i2c.h>
 #include <linux/mtd/physmap.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
 
 #include <mach/hardware.h>
 
@@ -76,13 +78,26 @@ static struct ep93xx_eth_data edb93xx_eth_data = {
 	.phy_id		= 1,
 };
 
-static struct i2c_board_info __initdata edb93xxa_i2c_data[] = {
+
+/*************************************************************************
+ * EDB93xx i2c peripheral handling
+ *************************************************************************/
+static struct i2c_gpio_platform_data edb93xx_i2c_gpio_data = {
+	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
+	.sda_is_open_drain	= 0,
+	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
+	.scl_is_open_drain	= 0,
+	.udelay			= 0,	/* default to 100 kHz */
+	.timeout		= 0,	/* default to 100 ms */
+};
+
+static struct i2c_board_info __initdata edb93xxa_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("isl1208", 0x6f),
 	},
 };
 
-static struct i2c_board_info __initdata edb93xx_i2c_data[] = {
+static struct i2c_board_info __initdata edb93xx_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("ds1337", 0x68),
 	},
@@ -92,12 +107,14 @@ static void __init edb93xx_register_i2c(void)
 {
 	if (machine_is_edb9302a() || machine_is_edb9307a() ||
 	    machine_is_edb9315a()) {
-		ep93xx_register_i2c(edb93xxa_i2c_data,
-				ARRAY_SIZE(edb93xxa_i2c_data));
+		ep93xx_register_i2c(&edb93xx_i2c_gpio_data,
+				    edb93xxa_i2c_board_info,
+				    ARRAY_SIZE(edb93xxa_i2c_board_info));
 	} else if (machine_is_edb9307() || machine_is_edb9312() ||
 		   machine_is_edb9315()) {
-		ep93xx_register_i2c(edb93xx_i2c_data,
-				ARRAY_SIZE(edb93xx_i2c_data));
+		ep93xx_register_i2c(&edb93xx_i2c_gpio_data
+				    edb93xx_i2c_board_info,
+				    ARRAY_SIZE(edb93xx_i2c_board_info));
 	}
 }
 
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 0fbf87b..2b3be3c 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -127,6 +127,7 @@
 #define EP93XX_GPIO_B_INT_ACK		EP93XX_GPIO_REG(0xb4)
 #define EP93XX_GPIO_B_INT_ENABLE	EP93XX_GPIO_REG(0xb8)
 #define EP93XX_GPIO_B_INT_STATUS	EP93XX_GPIO_REG(0xbc)
+#define EP93XX_GPIO_EEDRIVE		EP93XX_GPIO_REG(0xc8)
 
 #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
 
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 01a0f08..a3ec33f 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -4,6 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
+struct i2c_gpio_platform_data;
 struct i2c_board_info;
 struct platform_device;
 struct ep93xxfb_mach_info;
@@ -33,7 +34,8 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 }
 
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
-void ep93xx_register_i2c(struct i2c_board_info *devices, int num);
+void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
+			 struct i2c_board_info *devices, int num);
 void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
 void ep93xx_register_pwm(int pwm0, int pwm1);
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev); 
