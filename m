From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 24 Jan 2011 16:03:34 -0700
Subject: [PATCH] ep93xx: default multiplexed gpio ports to gpio mode
Message-ID: <201101241603.34433.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EP93xx C and D GPIO ports are multiplexed with the Keypad Interface
peripheral. ?At power-up they default into non-GPIO mode with the Key
Matrix controller enabled so these ports are unusable for GPIO. ?Note
that the Keypad Interface peripheral is only available in the EP9307,
EP9312, and EP9315 processor variants.

The keypad support will clear the DeviceConfig bits appropriately to
enable the Keypad Interface when the driver is loaded. ?And, when the
driver is unloaded it will set the bits to return the ports to GPIO mode.

To make these ports available for GPIO after power-up on all EP93xx
processor variants, set the KEYS and GONK bits in the DeviceConfig
register.

Similarly, the E, G, and H ports are multiplexed with the IDE Interface
peripheral. ?At power-up these also default into non-GPIO mode. ?Note
that the IDE peripheral is only available in the EP9312 and EP9315
processor variants.

Since an IDE driver is not even available in mainline, set the EONIDE,
GONIDE, and HONIDE bits in the DeviceConfig register so that these
ports will be available for GPIO use after power-up.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
index f3dc76f..bec34b8 100644
--- a/arch/arm/mach-ep93xx/gpio.c
+++ b/arch/arm/mach-ep93xx/gpio.c
@@ -427,6 +427,13 @@ void __init ep93xx_gpio_init(void)
?{
????????int i;
?
+???????/* Set Ports C, D, E, G, and H for GPIO use */
+???????ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
+??????????????????????????????? EP93XX_SYSCON_DEVCFG_GONK |
+??????????????????????????????? EP93XX_SYSCON_DEVCFG_EONIDE |
+??????????????????????????????? EP93XX_SYSCON_DEVCFG_GONIDE |
+??????????????????????????????? EP93XX_SYSCON_DEVCFG_HONIDE);
+
????????for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++)
????????????????gpiochip_add(&ep93xx_gpio_banks[i].chip);
?}
