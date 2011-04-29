From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:32 +1200
Subject: [PATCH v3 23/23] at91: Remove mAgic and ISI device code
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-24-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AT572D940HF mAgic device and the AT91SAM9263 ISI device do not
have drivers yet and therefore the platform code in arch/arm/mach-at91
is unused and can be removed.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c  |   73 -----------------------------
 arch/arm/mach-at91/at91sam9263_devices.c  |   50 --------------------
 arch/arm/mach-at91/board-at572d940hf_ek.c |    2 -
 arch/arm/mach-at91/include/mach/board.h   |    6 --
 4 files changed, 0 insertions(+), 131 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 9910fc8..26aa567 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -250,79 +250,6 @@ static struct at91_dev_table_uart device_uart2 __initdata = {
 	.cts_pin	= {AT91_PIN_PA16, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-/* --------------------------------------------------------------------
- *  mAgic
- * -------------------------------------------------------------------- */
-
-#ifdef CONFIG_MAGICV
-static struct resource mAgic_resources[] = {
-	{
-		.start = AT91_MAGIC_PM_BASE,
-		.end   = AT91_MAGIC_PM_BASE + AT91_MAGIC_PM_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = AT91_MAGIC_DM_I_BASE,
-		.end   = AT91_MAGIC_DM_I_BASE + AT91_MAGIC_DM_I_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = AT91_MAGIC_DM_F_BASE,
-		.end   = AT91_MAGIC_DM_F_BASE + AT91_MAGIC_DM_F_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = AT91_MAGIC_DM_DB_BASE,
-		.end   = AT91_MAGIC_DM_DB_BASE + AT91_MAGIC_DM_DB_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = AT91_MAGIC_REGS_BASE,
-		.end   = AT91_MAGIC_REGS_BASE + AT91_MAGIC_REGS_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = AT91_MAGIC_EXTPAGE_BASE,
-		.end   = AT91_MAGIC_EXTPAGE_BASE + AT91_MAGIC_EXTPAGE_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start  = AT572D940HF_ID_MSIRQ0,
-		.end    = AT572D940HF_ID_MSIRQ0,
-		.flags  = IORESOURCE_IRQ,
-	},
-	{
-		.start  = AT572D940HF_ID_MHALT,
-		.end    = AT572D940HF_ID_MHALT,
-		.flags  = IORESOURCE_IRQ,
-	},
-	{
-		.start  = AT572D940HF_ID_MEXC,
-		.end    = AT572D940HF_ID_MEXC,
-		.flags  = IORESOURCE_IRQ,
-	},
-	{
-		.start  = AT572D940HF_ID_MEDMA,
-		.end    = AT572D940HF_ID_MEDMA,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device mAgic_device = {
-	.name           = "mAgic",
-	.id             = -1,
-	.num_resources  = ARRAY_SIZE(mAgic_resources),
-	.resource       = mAgic_resources,
-};
-
-void __init at91_add_device_mAgic(void)
-{
-	platform_device_register(&mAgic_device);
-}
-#else
-void __init at91_add_device_mAgic(void) {}
-#endif
-
 static struct at91_device_table at572d940hf_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index b06246c..4bb42ae 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -309,56 +309,6 @@ static struct at91_dev_table_lcdc device_lcdc __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  Image Sensor Interface
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_VIDEO_AT91_ISI) || defined(CONFIG_VIDEO_AT91_ISI_MODULE)
-
-struct resource isi_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_ISI,
-		.end	= AT91SAM9263_BASE_ISI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_ISI,
-		.end	= AT91SAM9263_ID_ISI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9263_isi_device = {
-	.name		= "at91_isi",
-	.id		= -1,
-	.resource	= isi_resources,
-	.num_resources	= ARRAY_SIZE(isi_resources),
-};
-
-void __init at91_add_device_isi(void)
-{
-	at91_set_A_periph(AT91_PIN_PE0, 0);	/* ISI_D0 */
-	at91_set_A_periph(AT91_PIN_PE1, 0);	/* ISI_D1 */
-	at91_set_A_periph(AT91_PIN_PE2, 0);	/* ISI_D2 */
-	at91_set_A_periph(AT91_PIN_PE3, 0);	/* ISI_D3 */
-	at91_set_A_periph(AT91_PIN_PE4, 0);	/* ISI_D4 */
-	at91_set_A_periph(AT91_PIN_PE5, 0);	/* ISI_D5 */
-	at91_set_A_periph(AT91_PIN_PE6, 0);	/* ISI_D6 */
-	at91_set_A_periph(AT91_PIN_PE7, 0);	/* ISI_D7 */
-	at91_set_A_periph(AT91_PIN_PE8, 0);	/* ISI_PCK */
-	at91_set_A_periph(AT91_PIN_PE9, 0);	/* ISI_HSYNC */
-	at91_set_A_periph(AT91_PIN_PE10, 0);	/* ISI_VSYNC */
-	at91_set_B_periph(AT91_PIN_PE11, 0);	/* ISI_MCK (PCK3) */
-	at91_set_B_periph(AT91_PIN_PE12, 0);	/* ISI_PD8 */
-	at91_set_B_periph(AT91_PIN_PE13, 0);	/* ISI_PD9 */
-	at91_set_B_periph(AT91_PIN_PE14, 0);	/* ISI_PD10 */
-	at91_set_B_periph(AT91_PIN_PE15, 0);	/* ISI_PD11 */
-}
-#else
-void __init at91_add_device_isi(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  Timer/Counter block
  * -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index 8955133..ff62346 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -312,8 +312,6 @@ static void __init eb_board_init(void)
 	at91_add_device_mmc(0, &eb_mmc_data);
 	/* Ethernet */
 	at91_add_device_eth(&eb_eth_data);
-	/* mAgic */
-	at91_add_device_mAgic();
 }
 
 MACHINE_START(AT572D940HFEB, "Atmel AT91D940HF-EB")
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 25a6127..33ba440 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -186,9 +186,6 @@ extern void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data);
  /* AC97 */
 extern void __init at91_add_device_ac97(struct ac97c_platform_data *data);
 
- /* ISI */
-extern void __init at91_add_device_isi(void);
-
  /* Touchscreen Controller */
 struct at91_tsadcc_data {
 	unsigned int    adc_clock;
@@ -208,9 +205,6 @@ extern void __init at91_init_leds(u8 cpu_led, u8 timer_led);
 extern void __init at91_gpio_leds(struct gpio_led *leds, int nr);
 extern void __init at91_pwm_leds(struct gpio_led *leds, int nr);
 
- /* AT572D940HF DSP */
-extern void __init at91_add_device_mAgic(void);
-
 /* FIXME: this needs a better location, but gets stuff building again */
 extern int at91_suspend_entering_slow_clock(void);
 
-- 
1.7.0.4
