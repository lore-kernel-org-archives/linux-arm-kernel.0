From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Sep 2009 19:41:42 +0200
Subject: [PATCH] at91: add AC97 support to at91sam9g45 series and
	at91sam9m10g45ek board
In-Reply-To: <1253122902-15647-1-git-send-email-nicolas.ferre@atmel.com>
References: <1253122902-15647-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1253122902-15647-2-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the support of AC97 on the at91sam9g45 chip series and -ek board.
It will share the code with AVR32 ac97c alsa driver "atmel_ac97c".

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9g45_devices.c |   55 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/board-sam9m10g45ek.c  |   10 +++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 45720c8..d581cff 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -598,6 +598,61 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 
 
 /* --------------------------------------------------------------------
+ *  AC97
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_SND_ATMEL_AC97C) || defined(CONFIG_SND_ATMEL_AC97C_MODULE)
+static u64 ac97_dmamask = DMA_BIT_MASK(32);
+static struct ac97c_platform_data ac97_data;
+
+static struct resource ac97_resources[] = {
+	[0] = {
+		.start	= AT91SAM9G45_BASE_AC97C,
+		.end	= AT91SAM9G45_BASE_AC97C + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9G45_ID_AC97C,
+		.end	= AT91SAM9G45_ID_AC97C,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9g45_ac97_device = {
+	.name		= "atmel_ac97c",
+	.id		= 0,
+	.dev		= {
+				.dma_mask		= &ac97_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &ac97_data,
+	},
+	.resource	= ac97_resources,
+	.num_resources	= ARRAY_SIZE(ac97_resources),
+};
+
+void __init at91_add_device_ac97(struct ac97c_platform_data *data)
+{
+	if (!data)
+		return;
+
+	at91_set_A_periph(AT91_PIN_PD8, 0);	/* AC97FS */
+	at91_set_A_periph(AT91_PIN_PD9, 0);	/* AC97CK */
+	at91_set_A_periph(AT91_PIN_PD7, 0);	/* AC97TX */
+	at91_set_A_periph(AT91_PIN_PD6, 0);	/* AC97RX */
+
+	/* reset */
+	if (data->reset_pin)
+		at91_set_gpio_output(data->reset_pin, 0);
+
+	ac97_data = *data;
+	platform_device_register(&at91sam9g45_ac97_device);
+}
+#else
+void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
+#endif
+
+
+/* --------------------------------------------------------------------
  *  LCD Controller
  * -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index b8558ea..64c3843 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -311,6 +311,14 @@ static void __init ek_add_device_buttons(void) {}
 
 
 /*
+ * AC97
+ * reset_pin is not connected: NRST
+ */
+static struct ac97c_platform_data ek_ac97_data = {
+};
+
+
+/*
  * LEDs ... these could all be PWM-driven, for variable brightness
  */
 static struct gpio_led ek_leds[] = {
@@ -372,6 +380,8 @@ static void __init ek_board_init(void)
 	at91_add_device_lcdc(&ek_lcdc_data);
 	/* Push Buttons */
 	ek_add_device_buttons();
+	/* AC97 */
+	at91_add_device_ac97(&ek_ac97_data);
 	/* LEDs */
 	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
 	at91_pwm_leds(ek_pwm_led, ARRAY_SIZE(ek_pwm_led));
-- 
1.5.6.5
