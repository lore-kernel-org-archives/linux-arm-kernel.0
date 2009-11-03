From: ospite@studenti.unina.it (Antonio Ospite)
Date: Tue,  3 Nov 2009 17:45:33 +0100
Subject: [PATCH 2/3] ezx: Add leds-lp3944 support for A910 EZX phone
In-Reply-To: <1257266734-28673-2-git-send-email-ospite@studenti.unina.it>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
	<1257266734-28673-2-git-send-email-ospite@studenti.unina.it>
Message-ID: <1257266734-28673-3-git-send-email-ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 arch/arm/mach-pxa/ezx.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 9faa6e5..ac58083 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/leds-lp3944.h>
 
 #include <media/soc_camera.h>
 
@@ -1039,6 +1040,57 @@ static struct platform_device a910_camera = {
 	},
 };
 
+/* leds-lp3944 */
+static struct lp3944_platform_data a910_lp3944_leds = {
+	.leds_size = LP3944_LEDS_MAX,
+	.leds = {
+		[0] = {
+			.name = "a910:red:",
+			.status = LP3944_LED_STATUS_OFF,
+			.type = LP3944_LED_TYPE_LED,
+		},
+		[1] = {
+			.name = "a910:green:",
+			.status = LP3944_LED_STATUS_OFF,
+			.type = LP3944_LED_TYPE_LED,
+		},
+		[2] {
+			.name = "a910:blue:",
+			.status = LP3944_LED_STATUS_OFF,
+			.type = LP3944_LED_TYPE_LED,
+		},
+		/* Leds 3 and 4 are used as display power switches */
+		[3] = {
+			.name = "a910::cli_display",
+			.status = LP3944_LED_STATUS_OFF,
+			.type = LP3944_LED_TYPE_LED_INVERTED
+		},
+		[4] = {
+			.name = "a910::main_display",
+			.status = LP3944_LED_STATUS_ON,
+			.type = LP3944_LED_TYPE_LED_INVERTED
+		},
+		[5] = { .type = LP3944_LED_TYPE_NONE },
+		[6] = {
+			.name = "a910::torch",
+			.status = LP3944_LED_STATUS_OFF,
+			.type = LP3944_LED_TYPE_LED,
+		},
+		[7] = {
+			.name = "a910::flash",
+			.status = LP3944_LED_STATUS_OFF,
+			.type = LP3944_LED_TYPE_LED_INVERTED,
+		},
+	},
+};
+
+static struct i2c_board_info __initdata a910_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("lp3944", 0x60),
+		.platform_data = &a910_lp3944_leds,
+	},
+};
+
 static struct platform_device *a910_devices[] __initdata = {
 	&a910_gpio_keys,
 	&a910_camera,
@@ -1051,6 +1103,7 @@ static void __init a910_init(void)
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(a910_pin_config));
 
 	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(a910_i2c_board_info));
 
 	set_pxa_fb_info(&ezx_fb_info_2);
 
-- 
1.6.5.2
