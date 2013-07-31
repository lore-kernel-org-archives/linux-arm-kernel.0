From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 31 Jul 2013 10:33:52 +0900
Subject: [PATCH 4/4] ARM: shmobile: lager: do not annotate gpio_buttons as
 __initdata
In-Reply-To: <cover.1375234088.git.horms+renesas@verge.net.au>
References: <cover.1375234088.git.horms+renesas@verge.net.au>
Message-ID: <a601469386b543df2a4d97ad7d524716945278a3.1375234088.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the gpio-keys device is registered using
platform_device_register_data() the platform data argument,
lager_keys_pdata is duplicated and thus should be marked as __initdata
to avoid wasting memory. However, this is not true of gpio_buttons,
a reference to it rather than its value is duplicated when lager_keys_pdata
is duplicated.

This avoids accessing freed memory if gpio-key events occur
after unused kernel memory is freed late in the kernel's boot.

This but was added when support for gpio-keys was added to lager
in c3842e4fcbb7664276443b79187b7808c2e80a35
("ARM: shmobile: lager: support GPIO switches") which was included
in v3.11-rc1.

Tested-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index d73e21d..8d6bd5c 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -59,7 +59,7 @@ static __initdata struct gpio_led_platform_data lager_leds_pdata = {
 #define GPIO_KEY(c, g, d, ...) \
 	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
 
-static __initdata struct gpio_keys_button gpio_buttons[] = {
+static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_4,		RCAR_GP_PIN(1, 28),	"SW2-pin4"),
 	GPIO_KEY(KEY_3,		RCAR_GP_PIN(1, 26),	"SW2-pin3"),
 	GPIO_KEY(KEY_2,		RCAR_GP_PIN(1, 24),	"SW2-pin2"),
-- 
1.8.3.2
