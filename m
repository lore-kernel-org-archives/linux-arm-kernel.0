From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:21 +0100
Subject: [PATCH 07/17] ARM: pxa/raumfeld: add GPIO connected LEDs
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-8-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 23bf890..d03d180 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -26,6 +26,7 @@
 #include <linux/input.h>
 #include <linux/rotary_encoder.h>
 #include <linux/gpio_keys.h>
+#include <linux/leds.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -252,8 +253,42 @@ static struct platform_device raumfeld_gpio_keys_device = {
 	}
 };
 
+/**
+ * GPIO LEDs
+ */
+
+static struct gpio_led raumfeld_leds[] = {
+	{
+		.name		= "raumfeld:1",
+		.gpio		= mfp_to_gpio(GPIO_LED1),
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+	{
+		.name		= "raumfeld:2",
+		.gpio		= mfp_to_gpio(GPIO_LED2),
+		.active_low	= 0,
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
+	}
+};
+
+static struct gpio_led_platform_data raumfeld_led_platform_data = {
+	.leds		= raumfeld_leds,
+	.num_leds	= ARRAY_SIZE(raumfeld_leds),
+};
+
+static struct platform_device raumfeld_led_device = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &raumfeld_led_platform_data,
+	},
+};
+
+
 static struct platform_device *raumfeld_common_devices[] = {
 	&raumfeld_gpio_keys_device,
+	&raumfeld_led_device,
 };
 
 static void __init raumfeld_common_init(void)
-- 
1.6.5.2
