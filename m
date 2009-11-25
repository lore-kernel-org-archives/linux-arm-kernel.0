From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:20 +0100
Subject: [PATCH 06/17] ARM: pxa/raumfeld: add GPIO buttons
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-7-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   90 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index a2a2b18..23bf890 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -25,6 +25,7 @@
 #include <linux/smsc911x.h>
 #include <linux/input.h>
 #include <linux/rotary_encoder.h>
+#include <linux/gpio_keys.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -176,8 +177,96 @@ static struct platform_device rotary_encoder_device = {
 	}
 };
 
+/**
+ * GPIO buttons
+ */
+
+static struct gpio_keys_button gpio_keys_button[] = {
+	{
+		.code			= KEY_F1,
+		.type			= EV_KEY,
+		.gpio			= mfp_to_gpio(GPIO_KEY1),
+		.active_low		= 1,
+		.wakeup			= 0,
+		.debounce_interval	= 5, /* ms */
+		.desc			= "Button 1",
+	},
+	{
+		.code			= KEY_F2,
+		.type			= EV_KEY,
+		.gpio			= mfp_to_gpio(GPIO_KEY2),
+		.active_low		= 1,
+		.wakeup			= 0,
+		.debounce_interval	= 5, /* ms */
+		.desc			= "Button 2",
+	},
+	{
+		.code			= KEY_F3,
+		.type			= EV_KEY,
+		.gpio			= mfp_to_gpio(GPIO_KEY3),
+		.active_low		= 1,
+		.wakeup			= 0,
+		.debounce_interval	= 5, /* ms */
+		.desc			= "Button 3",
+	},
+	{
+		.code			= KEY_F4,
+		.type			= EV_KEY,
+		.gpio			= mfp_to_gpio(GPIO_RESCUE_BOOT),
+		.active_low		= 0,
+		.wakeup			= 0,
+		.debounce_interval	= 5, /* ms */
+		.desc			= "rescue boot button",
+	},
+	{
+		.code			= KEY_F5,
+		.type			= EV_KEY,
+		.gpio			= mfp_to_gpio(GPIO_DOCK_DETECT),
+		.active_low		= 0,
+		.wakeup			= 0,
+		.debounce_interval	= 5, /* ms */
+		.desc			= "dock detect",
+	},
+	{
+		.code			= KEY_F6,
+		.type			= EV_KEY,
+		.gpio			= mfp_to_gpio(GPIO_ON_OFF),
+		.active_low		= 0,
+		.wakeup			= 0,
+		.debounce_interval	= 5, /* ms */
+		.desc			= "on/off button",
+	},
+};
+
+static struct gpio_keys_platform_data gpio_keys_platform_data = {
+	.buttons	= gpio_keys_button,
+	.nbuttons	= ARRAY_SIZE(gpio_keys_button),
+	.rep		= 0,
+};
+
+static struct platform_device raumfeld_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev 	= {
+		.platform_data	= &gpio_keys_platform_data,
+	}
+};
+
+static struct platform_device *raumfeld_common_devices[] = {
+	&raumfeld_gpio_keys_device,
+};
+
 static void __init raumfeld_common_init(void)
 {
+	/* The on/off button polarity has changed after revision 1 */
+	if ((system_rev & 0xff) > 1) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(gpio_keys_button); i++)
+			if (!strcmp(gpio_keys_button[i].desc, "on/off button"))
+				gpio_keys_button[i].active_low = 1;
+	}
+
 	enable_irq_wake(IRQ_WAKEUP0);
 	pxa_set_ffuart_info(NULL);
 
@@ -193,6 +282,7 @@ static void __init raumfeld_common_init(void)
 
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_pin_config));
 	pxa_set_ohci_info(&raumfeld_ohci_info);
+	platform_add_devices(ARRAY_AND_SIZE(raumfeld_common_devices));
 }
 
 static void __init raumfeld_controller_init(void)
-- 
1.6.5.2
