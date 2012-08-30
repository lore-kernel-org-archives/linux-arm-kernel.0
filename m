From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2012 14:47:28 +0900
Subject: [PATCH] ARM: shmobile: kzm9g: use gpio-keys instead of
 gpio-keys-polled
In-Reply-To: <1346305648-25263-1-git-send-email-horms@verge.net.au>
References: <1346305648-25263-1-git-send-email-horms@verge.net.au>
Message-ID: <1346305648-25263-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

6e20a0a429bd4dc07d6de16d9c247270e04e4aa0
(gpio: pcf857x: enable gpio_to_irq() support) supports
gpio_to_irq() on pcf857x driver.
Now, we can use gpio-keys driver instead of gpio-keys-polled.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig     | 2 +-
 arch/arm/mach-shmobile/board-kzm9g.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 2388c86..175804e 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -22,7 +22,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_SHMOBILE=y
-CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_KZM9G=y
 CONFIG_MEMORY_START=0x41000000
@@ -70,6 +69,7 @@ CONFIG_INPUT_SPARSEKMAP=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ST1232=y
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 53b7ea9..4d1348e 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -482,12 +482,10 @@ static struct gpio_keys_button gpio_buttons[] = {
 static struct gpio_keys_platform_data gpio_key_info = {
 	.buttons	= gpio_buttons,
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
-	.poll_interval	= 250, /* poling at this point */
 };
 
 static struct platform_device gpio_keys_device = {
-	/* gpio-pcf857x.c driver doesn't support gpio_to_irq() */
-	.name	= "gpio-keys-polled",
+	.name	= "gpio-keys",
 	.dev	= {
 		.platform_data  = &gpio_key_info,
 	},
@@ -550,6 +548,7 @@ static struct platform_device fsi_ak4648_device = {
 /* I2C */
 static struct pcf857x_platform_data pcf8575_pdata = {
 	.gpio_base	= GPIO_PCF8575_BASE,
+	.irq		= intcs_evt2irq(0x3260), /* IRQ19 */
 };
 
 static struct i2c_board_info i2c0_devices[] = {
-- 
1.7.10.2.484.gcd07cc5
