From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 10:59:00 +0900
Subject: [PATCH 1/4] ARM: shmobile: ape6evm: support GPIO switches
In-Reply-To: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
References: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1375149543-27564-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ape6evm board has switches S16 - S23 wired up to GPIO pins.
This patch allows access to those pins as gpio-keys.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index ccf8b04..677752c 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -19,6 +19,8 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/tmio.h>
@@ -37,6 +39,24 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* GPIO KEY */
+#define GPIO_KEY(c, g, d, ...) \
+	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
+
+static struct gpio_keys_button gpio_buttons[] = {
+	GPIO_KEY(KEY_0,			324,	"S16"),
+	GPIO_KEY(KEY_MENU,		325,	"S17"),
+	GPIO_KEY(KEY_HOME,		326,	"S18"),
+	GPIO_KEY(KEY_BACK,		327,	"S19"),
+	GPIO_KEY(KEY_VOLUMEUP,		328,	"S20"),
+	GPIO_KEY(KEY_VOLUMEDOWN,	329,	"S21"),
+};
+
+static struct __initdata gpio_keys_platform_data ape6evm_keys_pdata = {
+	.buttons	= gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(gpio_buttons),
+};
+
 /* Dummy supplies, where voltage doesn't matter */
 static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vddvario", "smsc911x"),
@@ -172,6 +192,9 @@ static void __init ape6evm_add_standard_devices(void)
 	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 1,
 					  sdhi1_resources, ARRAY_SIZE(sdhi1_resources),
 					  &sdhi1_pdata, sizeof(sdhi1_pdata));
+	platform_device_register_data(&platform_bus, "gpio-keys", -1,
+				      &ape6evm_keys_pdata,
+				      sizeof(ape6evm_keys_pdata));
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
-- 
1.8.3.2
