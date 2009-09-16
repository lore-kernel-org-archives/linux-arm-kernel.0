From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 16 Sep 2009 11:46:44 +0200
Subject: [PATCH 2/3] at91sam9263ek: activate at91 CAN controller
In-Reply-To: <1253094405-3216-2-git-send-email-mkl@pengutronix.de>
References: <1253094405-3216-1-git-send-email-mkl@pengutronix.de>
	<1253094405-3216-2-git-send-email-mkl@pengutronix.de>
Message-ID: <1253094405-3216-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch activates the at91 CAN controller for the at91sam9263ek
development board.

Signed-off-by: Hans J. Koch <hjk@linutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-at91/board-sam9263ek.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 57d5252..e6268b3 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -400,6 +400,23 @@ static struct gpio_led ek_pwm_led[] = {
 	}
 };
 
+/*
+ * CAN
+ */
+static void sam9263ek_transceiver_switch(int on)
+{
+	if (on) {
+		at91_set_gpio_output(AT91_PIN_PA18, 1); /* CANRXEN */
+		at91_set_gpio_output(AT91_PIN_PA19, 0); /* CANRS */
+	} else {
+		at91_set_gpio_output(AT91_PIN_PA18, 0); /* CANRXEN */
+		at91_set_gpio_output(AT91_PIN_PA19, 1); /* CANRS */
+	}
+}
+
+static struct at91_can_data ek_can_data = {
+	.transceiver_switch = sam9263ek_transceiver_switch,
+};
 
 static void __init ek_board_init(void)
 {
@@ -431,6 +448,8 @@ static void __init ek_board_init(void)
 	/* LEDs */
 	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
 	at91_pwm_leds(ek_pwm_led, ARRAY_SIZE(ek_pwm_led));
+	/* CAN */
+	at91_add_device_can(&ek_can_data);
 }
 
 MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
-- 
1.6.3.3
