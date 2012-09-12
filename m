From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 12 Sep 2012 08:42:13 +0200
Subject: [PATCH v3 4/8] ARM: at91: do not configure at91sam9g10 twi pio as
 open-drain
In-Reply-To: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
References: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1347432137-25058-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

As indicated in the datasheet, TWD and TWCK must not be programmed as
open-drain.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nikolaus Voss <n.voss@weinmann.de>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9261_devices.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 29188ef..50d3179 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -327,16 +327,16 @@ void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
 	/* IP version is not the same on 9261 and g10 */
 	if (cpu_is_at91sam9g10()) {
 		at91sam9261_twi_device.name = "i2c-at91sam9g10";
+		/* I2C PIO must not be configured as open-drain on this chip */
 	} else {
 		at91sam9261_twi_device.name = "i2c-at91sam9261";
+		at91_set_multi_drive(AT91_PIN_PA7, 1);
+		at91_set_multi_drive(AT91_PIN_PA8, 1);
 	}
 
 	/* pins used for TWI interface */
 	at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PA7, 1);
-
 	at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PA8, 1);
 
 	i2c_register_board_info(0, devices, nr_devices);
 	platform_device_register(&at91sam9261_twi_device);
-- 
1.7.11.3
