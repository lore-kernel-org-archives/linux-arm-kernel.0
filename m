From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed,  6 Jul 2011 20:34:37 +0800
Subject: [PATCH 07/17] mach-orion5x: convert custom LED code to gpio_led and
	LED CPU trigger
In-Reply-To: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1309955687-19365-8-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/configs/orion5x_defconfig           |    1 +
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c |    1 -
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c  |    1 -
 arch/arm/mach-orion5x/rd88f5182-setup.c      |   74 ++++++++------------------
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c |    1 -
 5 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index a288d70..6579baf 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -126,6 +126,7 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 9eec7c2..ddb6be1 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -19,7 +19,6 @@
 #include <net/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/gpio.h>
-#include <asm/leds.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index 0cc90bb..454f666 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -20,7 +20,6 @@
 #include <net/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/gpio.h>
-#include <asm/leds.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index 48da39b..200e02c 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -19,9 +19,9 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
-#include <asm/leds.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
@@ -54,12 +54,6 @@
 #define RD88F5182_PCI_SLOT0_IRQ_A_PIN	7
 #define RD88F5182_PCI_SLOT0_IRQ_B_PIN	6
 
-/*
- * GPIO Debug LED
- */
-
-#define RD88F5182_GPIO_DBG_LED		0
-
 /*****************************************************************************
  * 16M NOR Flash on Device bus CS1
  ****************************************************************************/
@@ -84,55 +78,32 @@ static struct platform_device rd88f5182_nor_flash = {
 	.resource		= &rd88f5182_nor_flash_resource,
 };
 
-#ifdef CONFIG_LEDS
-
 /*****************************************************************************
- * Use GPIO debug led as CPU active indication
+ * Use GPIO LED as CPU active indication
  ****************************************************************************/
 
-static void rd88f5182_dbgled_event(led_event_t evt)
-{
-	int val;
-
-	if (evt == led_idle_end)
-		val = 1;
-	else if (evt == led_idle_start)
-		val = 0;
-	else
-		return;
-
-	gpio_set_value(RD88F5182_GPIO_DBG_LED, val);
-}
-
-static int __init rd88f5182_dbgled_init(void)
-{
-	int pin;
-
-	if (machine_is_rd88f5182()) {
-		pin = RD88F5182_GPIO_DBG_LED;
+#define RD88F5182_GPIO_LED		0
 
-		if (gpio_request(pin, "DBGLED") == 0) {
-			if (gpio_direction_output(pin, 0) != 0) {
-				printk(KERN_ERR "rd88f5182_dbgled_init failed "
-						"to set output pin %d\n", pin);
-				gpio_free(pin);
-				return 0;
-			}
-		} else {
-			printk(KERN_ERR "rd88f5182_dbgled_init failed "
-					"to request gpio %d\n", pin);
-			return 0;
-		}
-
-		leds_event = rd88f5182_dbgled_event;
-	}
-
-	return 0;
-}
+static struct gpio_led rd88f5182_gpio_led_pins[] = {
+	{
+		.name		= "rd88f5182:cpu",
+		.default_trigger = "cpu",
+		.gpio		= RD88F5182_GPIO_LED,
+	},
+};
 
-__initcall(rd88f5182_dbgled_init);
+static struct gpio_led_platform_data rd88f5182_gpio_led_data = {
+	.leds		= rd88f5182_gpio_led_pins,
+	.num_leds	= ARRAY_SIZE(rd88f5182_gpio_led_pins),
+};
 
-#endif
+static struct platform_device rd88f5182_gpio_leds = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &rd88f5182_gpio_led_data,
+	},
+};
 
 /*****************************************************************************
  * PCI
@@ -299,6 +270,7 @@ static void __init rd88f5182_init(void)
 
 	orion5x_setup_dev1_win(RD88F5182_NOR_BASE, RD88F5182_NOR_SIZE);
 	platform_device_register(&rd88f5182_nor_flash);
+	platform_device_register(&rd88f5182_gpio_leds);
 
 	i2c_register_board_info(0, &rd88f5182_i2c_rtc, 1);
 }
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index ad2eba9..0c5d1d2 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -22,7 +22,6 @@
 #include <net/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/gpio.h>
-#include <asm/leds.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-- 
1.7.5
