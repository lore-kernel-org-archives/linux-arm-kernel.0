From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 29 Jul 2010 05:16:27 +0200
Subject: [PATCH 11/13] [ARM] pxa/balloon3: PCF857x GPIO expander and LEDs
In-Reply-To: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1280373389-32475-11-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add supported for PCF8574A GPIO expander and LEDs attached to it.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c              |   84 +++++++++++++++++++++++++++-
 arch/arm/mach-pxa/include/mach/balloon3.h |   11 ++++
 2 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 91ad56d..6f594bd 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -26,6 +26,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/types.h>
+#include <linux/i2c/pcf857x.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -375,15 +376,65 @@ static struct gpio_led_platform_data balloon3_gpio_led_info = {
 
 static struct platform_device balloon3_leds = {
 	.name	= "leds-gpio",
-	.id	= -1,
+	.id	= 0,
 	.dev	= {
 		.platform_data	= &balloon3_gpio_led_info,
 	}
 };
 
+struct gpio_led balloon3_pcf_gpio_leds[] = {
+	{
+		.name			= "balloon3:green:led0",
+		.gpio			= BALLOON3_PCF_GPIO_LED0,
+		.active_low		= 1,
+	}, {
+		.name			= "balloon3:green:led1",
+		.gpio			= BALLOON3_PCF_GPIO_LED1,
+		.active_low		= 1,
+	}, {
+		.name			= "balloon3:orange:led2",
+		.gpio			= BALLOON3_PCF_GPIO_LED2,
+		.active_low		= 1,
+	}, {
+		.name			= "balloon3:orange:led3",
+		.gpio			= BALLOON3_PCF_GPIO_LED3,
+		.active_low		= 1,
+	}, {
+		.name			= "balloon3:orange:led4",
+		.gpio			= BALLOON3_PCF_GPIO_LED4,
+		.active_low		= 1,
+	}, {
+		.name			= "balloon3:orange:led5",
+		.gpio			= BALLOON3_PCF_GPIO_LED5,
+		.active_low		= 1,
+	}, {
+		.name			= "balloon3:red:led6",
+		.gpio			= BALLOON3_PCF_GPIO_LED6,
+		.active_low		= 1,
+	}, {
+		.name			= "balloon3:red:led7",
+		.gpio			= BALLOON3_PCF_GPIO_LED7,
+		.active_low		= 1,
+	},
+};
+
+static struct gpio_led_platform_data balloon3_pcf_gpio_led_info = {
+	.leds		= balloon3_pcf_gpio_leds,
+	.num_leds	= ARRAY_SIZE(balloon3_pcf_gpio_leds),
+};
+
+static struct platform_device balloon3_pcf_leds = {
+	.name	= "leds-gpio",
+	.id	= 1,
+	.dev	= {
+		.platform_data	= &balloon3_pcf_gpio_led_info,
+	}
+};
+
 static void __init balloon3_leds_init(void)
 {
 	platform_device_register(&balloon3_leds);
+	platform_device_register(&balloon3_pcf_leds);
 }
 #else
 static inline void balloon3_leds_init(void) {}
@@ -451,6 +502,34 @@ static void __init balloon3_init_irq(void)
 }
 
 /******************************************************************************
+ * GPIO expander
+ ******************************************************************************/
+#if defined(CONFIG_GPIO_PCF857X) || defined(CONFIG_GPIO_PCF857X_MODULE)
+static struct pcf857x_platform_data balloon3_pcf857x_pdata = {
+	.gpio_base	= BALLOON3_PCF_GPIO_BASE,
+	.n_latch	= 0,
+	.setup		= NULL,
+	.teardown	= NULL,
+	.context	= NULL,
+};
+
+static struct i2c_board_info __initdata balloon3_i2c_devs[] = {
+	{
+		I2C_BOARD_INFO("pcf8574a", 0x38),
+		.platform_data	= &balloon3_pcf857x_pdata,
+	},
+};
+
+static void __init balloon3_i2c_init(void)
+{
+	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(balloon3_i2c_devs));
+}
+#else
+static inline void balloon3_i2c_init(void) {}
+#endif
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void __init balloon3_init(void)
@@ -463,8 +542,7 @@ static void __init balloon3_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	pxa_set_i2c_info(NULL);
-
+	balloon3_i2c_init();
 	balloon3_irda_init();
 	balloon3_lcd_init();
 	balloon3_leds_init();
diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index 14f4bd5..8886c23 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -50,6 +50,17 @@ enum balloon3_features {
 
 #define BALLOON3_GPIO_S0_CD		(105)
 
+/* PCF8574A Leds */
+#define	BALLOON3_PCF_GPIO_BASE		160
+#define	BALLOON3_PCF_GPIO_LED0		(BALLOON3_PCF_GPIO_BASE + 0)
+#define	BALLOON3_PCF_GPIO_LED1		(BALLOON3_PCF_GPIO_BASE + 1)
+#define	BALLOON3_PCF_GPIO_LED2		(BALLOON3_PCF_GPIO_BASE + 2)
+#define	BALLOON3_PCF_GPIO_LED3		(BALLOON3_PCF_GPIO_BASE + 3)
+#define	BALLOON3_PCF_GPIO_LED4		(BALLOON3_PCF_GPIO_BASE + 4)
+#define	BALLOON3_PCF_GPIO_LED5		(BALLOON3_PCF_GPIO_BASE + 5)
+#define	BALLOON3_PCF_GPIO_LED6		(BALLOON3_PCF_GPIO_BASE + 6)
+#define	BALLOON3_PCF_GPIO_LED7		(BALLOON3_PCF_GPIO_BASE + 7)
+
 /* FPGA Interrupt Mask/Acknowledge Register */
 #define BALLOON3_INT_S0_IRQ		(1 << 0)  /* PCMCIA 0 IRQ */
 #define BALLOON3_INT_S0_STSCHG		(1 << 1)  /* PCMCIA 0 status changed */
-- 
1.7.1
