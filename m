From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Mon, 3 Sep 2012 12:16:03 +0200
Subject: [PATCH v2 4/8] ARM: at91: do not configure at91sam9g10 twi pio as
 open-drain
In-Reply-To: <1346667367-7969-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346667367-7969-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1346667367-7969-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

As indicated in the datasheet, TWD and TWCK must not be programmed as
open-drain.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nikolaus Voss <n.voss@weinmann.de>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9261_devices.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index fdb5675..991a7e4 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -324,20 +324,22 @@ static struct platform_device at91sam9261_twi_device = {
 
 void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
 {
-	/* IP version is not the same on 9261 and g10 */
+	/*
+	 * IP version is not the same on 9261 and g10 and only 9261 one
+	 * requires to configure PIO as open-drain.
+	 */
 	if (cpu_is_at91sam9g10()) {
 		at91sam9261_twi_device.name = "i2c-at91sam9g10";
+		at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
+		at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
 	} else {
 		at91sam9261_twi_device.name = "i2c-at91sam9261";
+		at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
+		at91_set_multi_drive(AT91_PIN_PA7, 1);
+		at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
+		at91_set_multi_drive(AT91_PIN_PA8, 1);
 	}
 
-	/* pins used for TWI interface */
-	at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PA7, 1);
-
-	at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PA8, 1);
-
 	i2c_register_board_info(0, devices, nr_devices);
 	platform_device_register(&at91sam9261_twi_device);
 }
-- 
1.7.11.3
