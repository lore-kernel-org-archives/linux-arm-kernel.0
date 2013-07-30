From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 10:59:02 +0900
Subject: [PATCH 3/4] ARM: shmobile: ape6evm: Add GPIO LEDs
In-Reply-To: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
References: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1375149543-27564-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board has 6 LEDs connected to GPIOs. Add a led-gpio device to
support them.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 677752c..db97460 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -39,6 +39,40 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* LEDS */
+static struct gpio_led ape6evm_leds[] = {
+	{
+		.name		= "gnss-en",
+		.gpio		= 28,
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
+	}, {
+		.name		= "nfc-nrst",
+		.gpio		= 126,
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
+	}, {
+		.name		= "gnss-nrst",
+		.gpio		= 132,
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
+	}, {
+		.name		= "bt-wakeup",
+		.gpio		= 232,
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
+	}, {
+		.name		= "strobe",
+		.gpio		= 250,
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
+	}, {
+		.name		= "bbresetout",
+		.gpio		= 288,
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
+	},
+};
+
+static __initdata struct gpio_led_platform_data ape6evm_leds_pdata = {
+	.leds		= ape6evm_leds,
+	.num_leds	= ARRAY_SIZE(ape6evm_leds),
+};
+
 /* GPIO KEY */
 #define GPIO_KEY(c, g, d, ...) \
 	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
@@ -195,6 +229,9 @@ static void __init ape6evm_add_standard_devices(void)
 	platform_device_register_data(&platform_bus, "gpio-keys", -1,
 				      &ape6evm_keys_pdata,
 				      sizeof(ape6evm_keys_pdata));
+	platform_device_register_data(&platform_bus, "leds-gpio", -1,
+				      &ape6evm_leds_pdata,
+				      sizeof(ape6evm_leds_pdata));
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
-- 
1.8.3.2
