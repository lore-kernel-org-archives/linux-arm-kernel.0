From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 13 Mar 2012 09:48:18 +1100
Subject: [PATCH v4 07/11] ep93xx: Configure GPIO ports in core code
Message-ID: <1331592502-9083-8-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the pinmux setting of the EP93xx GPIOs to the core code. This
removes the need for the GPIO driver to have access to the system
controller registers.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: Hartley Sweeten <hsweeten@visionengravers.com>
---
 arch/arm/mach-ep93xx/core.c |    7 +++++++
 drivers/gpio/gpio-ep93xx.c  |    7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 776b346..bab6e47 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -909,6 +909,13 @@ void __init ep93xx_init_devices(void)
 	/* Disallow access to MaverickCrunch initially */
 	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_CPENA);
 
+	/* Default all ports to GPIO */
+	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
+			       EP93XX_SYSCON_DEVCFG_GONK |
+			       EP93XX_SYSCON_DEVCFG_EONIDE |
+			       EP93XX_SYSCON_DEVCFG_GONIDE |
+			       EP93XX_SYSCON_DEVCFG_HONIDE);
+
 	/* Get the GPIO working early, other devices need it */
 	platform_device_register(&ep93xx_gpio_device);
 
diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 1c0fc37..4ca5642 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -378,13 +378,6 @@ static int __devinit ep93xx_gpio_probe(struct platform_device *pdev)
 	}
 	ep93xx_gpio->mmio_base = mmio;
 
-	/* Default all ports to GPIO */
-	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
-			       EP93XX_SYSCON_DEVCFG_GONK |
-			       EP93XX_SYSCON_DEVCFG_EONIDE |
-			       EP93XX_SYSCON_DEVCFG_GONIDE |
-			       EP93XX_SYSCON_DEVCFG_HONIDE);
-
 	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++) {
 		struct bgpio_chip *bgc = &ep93xx_gpio->bgc[i];
 		struct ep93xx_gpio_bank *bank = &ep93xx_gpio_banks[i];
-- 
1.7.0.4
