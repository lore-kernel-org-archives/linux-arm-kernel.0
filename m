From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:22 +0100
Subject: [PATCH 08/17] ARM: pxa/raumfeld: add one-wire function
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-9-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'Controller' device has a battery pack connected to an One-Wire bus.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d03d180..5d85f98 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -27,6 +27,8 @@
 #include <linux/rotary_encoder.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
+#include <linux/w1-gpio.h>
+#include <linux/sched.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -285,6 +287,41 @@ static struct platform_device raumfeld_led_device = {
 	},
 };
 
+/**
+ * One-wire (W1 bus) support
+ */
+static void w1_enable_external_pullup(int enable)
+{
+	gpio_set_value(mfp_to_gpio(GPIO_W1_PULLUP_ENABLE), enable);
+	schedule_timeout(HZ);
+}
+
+static struct w1_gpio_platform_data w1_gpio_platform_data = {
+	.pin			= mfp_to_gpio(GPIO_ONE_WIRE),
+	.is_open_drain		= 0,
+	.enable_external_pullup	= w1_enable_external_pullup,
+};
+
+struct platform_device raumfeld_w1_gpio_device = {
+	.name	= "w1-gpio",
+	.dev	= {
+		.platform_data = &w1_gpio_platform_data
+	}
+};
+
+static void __init raumfeld_w1_init(void)
+{
+	mfp_cfg_t raumfeld_onewire_pin_config[] = {
+		GPIO126_GPIO | MFP_LPM_FLOAT,
+		GPIO105_GPIO | MFP_PULL_LOW | MFP_LPM_PULL_LOW,
+	};
+
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_onewire_pin_config));
+	gpio_request(mfp_to_gpio(GPIO_W1_PULLUP_ENABLE),
+		"W1 external pullup enable");
+	gpio_direction_output(mfp_to_gpio(GPIO_W1_PULLUP_ENABLE), 0);
+	platform_device_register(&raumfeld_w1_gpio_device);
+}
 
 static struct platform_device *raumfeld_common_devices[] = {
 	&raumfeld_gpio_keys_device,
@@ -329,6 +366,7 @@ static void __init raumfeld_controller_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_controller_devices));
 
 	raumfeld_common_init();
+	raumfeld_w1_init();
 }
 
 static void __init raumfeld_connector_init(void)
-- 
1.6.5.2
