From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 14 Dec 2017 15:21:36 +0100
Subject: [RFC PATCH 5/7] pinctrl: at91-pio4: allow the gpiolib to set pin
 configuration
In-Reply-To: <20171214142138.23008-1-ludovic.desroches@microchip.com>
References: <20171214142138.23008-1-ludovic.desroches@microchip.com>
Message-ID: <20171214142138.23008-6-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpiochip_generic_config to allow the gpiolib to set pin
configuration. Since it relies on .pin_config_set(), add it too.
For this controller, one pin is on group so we can use
atmel_conf_pin_config_group_set() function.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index b1ca838dd80a..4b8dda770af8 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -364,6 +364,7 @@ static struct gpio_chip atmel_gpio_chip = {
 	.set                    = atmel_gpio_set,
 	.to_irq                 = atmel_gpio_to_irq,
 	.base                   = 0,
+	.set_config		= gpiochip_generic_config,
 };
 
 /* --- PINCTRL --- */
@@ -817,6 +818,7 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinconf_ops atmel_confops = {
+	.pin_config_set		= atmel_conf_pin_config_group_set, /* In our case, a pin = a group */
 	.pin_config_group_get	= atmel_conf_pin_config_group_get,
 	.pin_config_group_set	= atmel_conf_pin_config_group_set,
 	.pin_config_dbg_show	= atmel_conf_pin_config_dbg_show,
-- 
2.12.2
