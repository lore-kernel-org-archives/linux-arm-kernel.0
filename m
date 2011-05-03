From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:30 +1200
Subject: [PATCH V4 16/23] at91: Make LCD controller device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-17-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual LCD controller device code for each at91 variant with a
single implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |   96 ++++++++--------------
 arch/arm/mach-at91/at91sam9261_devices.c |  133 ++++++++++--------------------
 arch/arm/mach-at91/at91sam9263_devices.c |   94 +++++++--------------
 arch/arm/mach-at91/at91sam9g45_devices.c |  111 +++++++++----------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   89 ++++++--------------
 arch/arm/mach-at91/devices.c             |   59 +++++++++++++
 arch/arm/mach-at91/devices.h             |   11 +++
 7 files changed, 245 insertions(+), 348 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index b2392f0..e6adc98 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -332,73 +332,44 @@ static struct at91_dev_table_ac97 device_ac97 __initdata = {
  *  LCD Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
-static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
-
-static struct resource lcdc_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_LCDC_BASE,
-		.end	= AT91CAP9_LCDC_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_LCDC,
-		.end	= AT91CAP9_ID_LCDC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &lcdc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &lcdc_data,
-	},
-	.resource	= lcdc_resources,
-	.num_resources	= ARRAY_SIZE(lcdc_resources),
-};
-
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
+static void __init at91cap9_lcdc_init(void)
 {
-	if (!data)
-		return;
-
 	if (cpu_is_at91cap9_revB())
 		irq_set_irq_type(AT91CAP9_ID_LCDC, IRQ_TYPE_LEVEL_HIGH);
-
-	at91_set_A_periph(AT91_PIN_PC1, 0);	/* LCDHSYNC */
-	at91_set_A_periph(AT91_PIN_PC2, 0);	/* LCDDOTCK */
-	at91_set_A_periph(AT91_PIN_PC3, 0);	/* LCDDEN */
-	at91_set_B_periph(AT91_PIN_PB9, 0);	/* LCDCC */
-	at91_set_A_periph(AT91_PIN_PC6, 0);	/* LCDD2 */
-	at91_set_A_periph(AT91_PIN_PC7, 0);	/* LCDD3 */
-	at91_set_A_periph(AT91_PIN_PC8, 0);	/* LCDD4 */
-	at91_set_A_periph(AT91_PIN_PC9, 0);	/* LCDD5 */
-	at91_set_A_periph(AT91_PIN_PC10, 0);	/* LCDD6 */
-	at91_set_A_periph(AT91_PIN_PC11, 0);	/* LCDD7 */
-	at91_set_A_periph(AT91_PIN_PC14, 0);	/* LCDD10 */
-	at91_set_A_periph(AT91_PIN_PC15, 0);	/* LCDD11 */
-	at91_set_A_periph(AT91_PIN_PC16, 0);	/* LCDD12 */
-	at91_set_A_periph(AT91_PIN_PC17, 0);	/* LCDD13 */
-	at91_set_A_periph(AT91_PIN_PC18, 0);	/* LCDD14 */
-	at91_set_A_periph(AT91_PIN_PC19, 0);	/* LCDD15 */
-	at91_set_A_periph(AT91_PIN_PC22, 0);	/* LCDD18 */
-	at91_set_A_periph(AT91_PIN_PC23, 0);	/* LCDD19 */
-	at91_set_A_periph(AT91_PIN_PC24, 0);	/* LCDD20 */
-	at91_set_A_periph(AT91_PIN_PC25, 0);	/* LCDD21 */
-	at91_set_A_periph(AT91_PIN_PC26, 0);	/* LCDD22 */
-	at91_set_A_periph(AT91_PIN_PC27, 0);	/* LCDD23 */
-
-	lcdc_data = *data;
-	platform_device_register(&at91_lcdc_device);
 }
-#else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
-#endif
 
+static struct at91_pin_config lcdc_pins[] __initdata = {
+	{AT91_PIN_PC1,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDHSYNC */
+	{AT91_PIN_PC2,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDOTCK */
+	{AT91_PIN_PC3,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDEN */
+	{AT91_PIN_PB9,  AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDCC */
+	{AT91_PIN_PC6,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD2 */
+	{AT91_PIN_PC7,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD3 */
+	{AT91_PIN_PC8,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD4 */
+	{AT91_PIN_PC9,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD5 */
+	{AT91_PIN_PC10, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD6 */
+	{AT91_PIN_PC11, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD7 */
+	{AT91_PIN_PC14, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD10 */
+	{AT91_PIN_PC15, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD11 */
+	{AT91_PIN_PC16, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD12 */
+	{AT91_PIN_PC17, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD13 */
+	{AT91_PIN_PC18, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD14 */
+	{AT91_PIN_PC19, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD15 */
+	{AT91_PIN_PC22, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD18 */
+	{AT91_PIN_PC23, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD19 */
+	{AT91_PIN_PC24, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD20 */
+	{AT91_PIN_PC25, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD21 */
+	{AT91_PIN_PC26, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD22 */
+	{AT91_PIN_PC27, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD23 */
+};
+
+static struct at91_dev_table_lcdc device_lcdc __initdata = {
+	.mmio_base	= AT91CAP9_LCDC_BASE,
+	.irq		= AT91CAP9_ID_LCDC,
+	.device_init	= at91cap9_lcdc_init,
+	.pins		= lcdc_pins,
+	.nr_pins	= ARRAY_SIZE(lcdc_pins),
+};
 
 /* --------------------------------------------------------------------
  *  SSC -- Synchronous Serial Controller
@@ -508,6 +479,7 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
 	.ac97		= &device_ac97,
+	.lcdc		= &device_lcdc,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index edb25f1..9871bf9 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -127,101 +127,53 @@ static struct at91_dev_table_spi device_spi1 __initdata = {
  *  LCD Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
-static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
-
-static struct resource lcdc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_LCDC_BASE,
-		.end	= AT91SAM9261_LCDC_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_LCDC,
-		.end	= AT91SAM9261_ID_LCDC,
-		.flags	= IORESOURCE_IRQ,
-	},
-#if defined(CONFIG_FB_INTSRAM)
-	[2] = {
-		.start	= AT91SAM9261_SRAM_BASE,
-		.end	= AT91SAM9261_SRAM_BASE + AT91SAM9261_SRAM_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-#endif
-};
-
-static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &lcdc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &lcdc_data,
-	},
-	.resource	= lcdc_resources,
-	.num_resources	= ARRAY_SIZE(lcdc_resources),
-};
-
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
-{
-	if (!data) {
-		return;
-	}
-
+static struct at91_pin_config lcdc_pins[] __initdata = {
 #if defined(CONFIG_FB_ATMEL_STN)
-	at91_set_A_periph(AT91_PIN_PB0, 0);     /* LCDVSYNC */
-	at91_set_A_periph(AT91_PIN_PB1, 0);     /* LCDHSYNC */
-	at91_set_A_periph(AT91_PIN_PB2, 0);     /* LCDDOTCK */
-	at91_set_A_periph(AT91_PIN_PB3, 0);     /* LCDDEN */
-	at91_set_A_periph(AT91_PIN_PB4, 0);     /* LCDCC */
-	at91_set_A_periph(AT91_PIN_PB5, 0);     /* LCDD0 */
-	at91_set_A_periph(AT91_PIN_PB6, 0);     /* LCDD1 */
-	at91_set_A_periph(AT91_PIN_PB7, 0);     /* LCDD2 */
-	at91_set_A_periph(AT91_PIN_PB8, 0);     /* LCDD3 */
+	{AT91_PIN_PB0,  AT91_PIN_PERIPH_A, 0, 0, 0},     /* LCDVSYNC */
+	{AT91_PIN_PB1,  AT91_PIN_PERIPH_A, 0, 0, 0},     /* LCDHSYNC */
+	{AT91_PIN_PB2,  AT91_PIN_PERIPH_A, 0, 0, 0},     /* LCDDOTCK */
+	{AT91_PIN_PB3,  AT91_PIN_PERIPH_A, 0, 0, 0},     /* LCDDEN */
+	{AT91_PIN_PB4,  AT91_PIN_PERIPH_A, 0, 0, 0},     /* LCDCC */
+	{AT91_PIN_PB5,  AT91_PIN_PERIPH_A, 0, 0, 0},     /* LCDD0 */
+	{AT91_PIN_PB6,  AT91_PIN_PERIPH_A, 0, 0, 0},     /* LCDD1 */
+	{AT91_PIN_PB7,  AT91_PIN_PERIPH_A, 0, 0, 0},     /* LCDD2 */
+	{AT91_PIN_PB8,  AT91_PIN_PERIPH_A, 0, 0, 0},     /* LCDD3 */
 #else
-	at91_set_A_periph(AT91_PIN_PB1, 0);	/* LCDHSYNC */
-	at91_set_A_periph(AT91_PIN_PB2, 0);	/* LCDDOTCK */
-	at91_set_A_periph(AT91_PIN_PB3, 0);	/* LCDDEN */
-	at91_set_A_periph(AT91_PIN_PB4, 0);	/* LCDCC */
-	at91_set_A_periph(AT91_PIN_PB7, 0);	/* LCDD2 */
-	at91_set_A_periph(AT91_PIN_PB8, 0);	/* LCDD3 */
-	at91_set_A_periph(AT91_PIN_PB9, 0);	/* LCDD4 */
-	at91_set_A_periph(AT91_PIN_PB10, 0);	/* LCDD5 */
-	at91_set_A_periph(AT91_PIN_PB11, 0);	/* LCDD6 */
-	at91_set_A_periph(AT91_PIN_PB12, 0);	/* LCDD7 */
-	at91_set_A_periph(AT91_PIN_PB15, 0);	/* LCDD10 */
-	at91_set_A_periph(AT91_PIN_PB16, 0);	/* LCDD11 */
-	at91_set_A_periph(AT91_PIN_PB17, 0);	/* LCDD12 */
-	at91_set_A_periph(AT91_PIN_PB18, 0);	/* LCDD13 */
-	at91_set_A_periph(AT91_PIN_PB19, 0);	/* LCDD14 */
-	at91_set_A_periph(AT91_PIN_PB20, 0);	/* LCDD15 */
-	at91_set_B_periph(AT91_PIN_PB23, 0);	/* LCDD18 */
-	at91_set_B_periph(AT91_PIN_PB24, 0);	/* LCDD19 */
-	at91_set_B_periph(AT91_PIN_PB25, 0);	/* LCDD20 */
-	at91_set_B_periph(AT91_PIN_PB26, 0);	/* LCDD21 */
-	at91_set_B_periph(AT91_PIN_PB27, 0);	/* LCDD22 */
-	at91_set_B_periph(AT91_PIN_PB28, 0);	/* LCDD23 */
+	{AT91_PIN_PB1,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDHSYNC */
+	{AT91_PIN_PB2,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDOTCK */
+	{AT91_PIN_PB3,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDEN */
+	{AT91_PIN_PB4,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDCC */
+	{AT91_PIN_PB7,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD2 */
+	{AT91_PIN_PB8,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD3 */
+	{AT91_PIN_PB9,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD4 */
+	{AT91_PIN_PB10, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD5 */
+	{AT91_PIN_PB11, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD6 */
+	{AT91_PIN_PB12, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD7 */
+	{AT91_PIN_PB15, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD10 */
+	{AT91_PIN_PB16, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD11 */
+	{AT91_PIN_PB17, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD12 */
+	{AT91_PIN_PB18, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD13 */
+	{AT91_PIN_PB19, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD14 */
+	{AT91_PIN_PB20, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD15 */
+	{AT91_PIN_PB23, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD18 */
+	{AT91_PIN_PB24, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD19 */
+	{AT91_PIN_PB25, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD20 */
+	{AT91_PIN_PB26, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD21 */
+	{AT91_PIN_PB27, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD22 */
+	{AT91_PIN_PB28, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD23 */
 #endif
+};
 
-	if (ARRAY_SIZE(lcdc_resources) > 2) {
-		void __iomem *fb;
-		struct resource *fb_res = &lcdc_resources[2];
-		size_t fb_len = fb_res->end - fb_res->start + 1;
-
-		fb = ioremap(fb_res->start, fb_len);
-		if (fb) {
-			memset(fb, 0, fb_len);
-			iounmap(fb);
-		}
-	}
-	lcdc_data = *data;
-	platform_device_register(&at91_lcdc_device);
-}
-#else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
+static struct at91_dev_table_lcdc device_lcdc __initdata = {
+	.mmio_base	= AT91SAM9261_LCDC_BASE,
+	.irq		= AT91SAM9261_ID_LCDC,
+#if defined(CONFIG_FB_INTSRAM)
+	.sram_base	= AT91SAM9261_SRAM_BASE,
+	.sram_size	= AT91SAM9261_SRAM_SIZE,
 #endif
-
+	.pins		= lcdc_pins,
+	.nr_pins	= ARRAY_SIZE(lcdc_pins),
+};
 
 /* --------------------------------------------------------------------
  *  Timer/Counter block
@@ -367,6 +319,7 @@ static struct at91_device_table at91sam9261_device_table __initdata = {
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
 	.ssc[2]		= &device_ssc2,
+	.lcdc		= &device_lcdc,
 };
 
 void __init at91sam9261_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 1375776..d858ac6 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -351,71 +351,38 @@ void __init at91_add_device_can(struct at91_can_data *data) {}
  *  LCD Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
-static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
-
-static struct resource lcdc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_LCDC_BASE,
-		.end	= AT91SAM9263_LCDC_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_LCDC,
-		.end	= AT91SAM9263_ID_LCDC,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_pin_config lcdc_pins[] __initdata = {
+	{AT91_PIN_PC1,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDHSYNC */
+	{AT91_PIN_PC2,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDOTCK */
+	{AT91_PIN_PC3,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDEN */
+	{AT91_PIN_PB9,  AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDCC */
+	{AT91_PIN_PC6,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD2 */
+	{AT91_PIN_PC7,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD3 */
+	{AT91_PIN_PC8,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD4 */
+	{AT91_PIN_PC9,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD5 */
+	{AT91_PIN_PC10, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD6 */
+	{AT91_PIN_PC11, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD7 */
+	{AT91_PIN_PC14, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD10 */
+	{AT91_PIN_PC15, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD11 */
+	{AT91_PIN_PC16, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD12 */
+	{AT91_PIN_PC12, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD13 */
+	{AT91_PIN_PC18, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD14 */
+	{AT91_PIN_PC19, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD15 */
+	{AT91_PIN_PC22, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD18 */
+	{AT91_PIN_PC23, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD19 */
+	{AT91_PIN_PC24, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD20 */
+	{AT91_PIN_PC17, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD21 */
+	{AT91_PIN_PC26, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD22 */
+	{AT91_PIN_PC27, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD23 */
+};
+
+static struct at91_dev_table_lcdc device_lcdc __initdata = {
+	.mmio_base	= AT91SAM9263_LCDC_BASE,
+	.irq		= AT91SAM9263_ID_LCDC,
+	.pins		= lcdc_pins,
+	.nr_pins	= ARRAY_SIZE(lcdc_pins),
 };
 
-static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &lcdc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &lcdc_data,
-	},
-	.resource	= lcdc_resources,
-	.num_resources	= ARRAY_SIZE(lcdc_resources),
-};
-
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
-{
-	if (!data)
-		return;
-
-	at91_set_A_periph(AT91_PIN_PC1, 0);	/* LCDHSYNC */
-	at91_set_A_periph(AT91_PIN_PC2, 0);	/* LCDDOTCK */
-	at91_set_A_periph(AT91_PIN_PC3, 0);	/* LCDDEN */
-	at91_set_B_periph(AT91_PIN_PB9, 0);	/* LCDCC */
-	at91_set_A_periph(AT91_PIN_PC6, 0);	/* LCDD2 */
-	at91_set_A_periph(AT91_PIN_PC7, 0);	/* LCDD3 */
-	at91_set_A_periph(AT91_PIN_PC8, 0);	/* LCDD4 */
-	at91_set_A_periph(AT91_PIN_PC9, 0);	/* LCDD5 */
-	at91_set_A_periph(AT91_PIN_PC10, 0);	/* LCDD6 */
-	at91_set_A_periph(AT91_PIN_PC11, 0);	/* LCDD7 */
-	at91_set_A_periph(AT91_PIN_PC14, 0);	/* LCDD10 */
-	at91_set_A_periph(AT91_PIN_PC15, 0);	/* LCDD11 */
-	at91_set_A_periph(AT91_PIN_PC16, 0);	/* LCDD12 */
-	at91_set_B_periph(AT91_PIN_PC12, 0);	/* LCDD13 */
-	at91_set_A_periph(AT91_PIN_PC18, 0);	/* LCDD14 */
-	at91_set_A_periph(AT91_PIN_PC19, 0);	/* LCDD15 */
-	at91_set_A_periph(AT91_PIN_PC22, 0);	/* LCDD18 */
-	at91_set_A_periph(AT91_PIN_PC23, 0);	/* LCDD19 */
-	at91_set_A_periph(AT91_PIN_PC24, 0);	/* LCDD20 */
-	at91_set_B_periph(AT91_PIN_PC17, 0);	/* LCDD21 */
-	at91_set_A_periph(AT91_PIN_PC26, 0);	/* LCDD22 */
-	at91_set_A_periph(AT91_PIN_PC27, 0);	/* LCDD23 */
-
-	lcdc_data = *data;
-	platform_device_register(&at91_lcdc_device);
-}
-#else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Image Sensor Interface
  * -------------------------------------------------------------------- */
@@ -618,6 +585,7 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
 	.ac97		= &device_ac97,
+	.lcdc		= &device_lcdc,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 431bc98..7d84fb7 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -346,80 +346,46 @@ static struct at91_dev_table_ac97 device_ac97 __initdata = {
  *  LCD Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
-static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
-
-static struct resource lcdc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_LCDC_BASE,
-		.end	= AT91SAM9G45_LCDC_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_LCDC,
-		.end	= AT91SAM9G45_ID_LCDC,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_pin_config lcdc_pins[] __initdata = {
+	{AT91_PIN_PE0,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDPWR */
+	{AT91_PIN_PE2,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDCC */
+	{AT91_PIN_PE3,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDVSYNC */
+	{AT91_PIN_PE4,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDHSYNC */
+	{AT91_PIN_PE5,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDOTCK */
+	{AT91_PIN_PE6,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDEN */
+	{AT91_PIN_PE7,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD0 */
+	{AT91_PIN_PE8,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD1 */
+	{AT91_PIN_PE9,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD2 */
+	{AT91_PIN_PE10, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD3 */
+	{AT91_PIN_PE11, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD4 */
+	{AT91_PIN_PE12, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD5 */
+	{AT91_PIN_PE13, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD6 */
+	{AT91_PIN_PE14, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD7 */
+	{AT91_PIN_PE15, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD8 */
+	{AT91_PIN_PE16, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD9 */
+	{AT91_PIN_PE17, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD10 */
+	{AT91_PIN_PE18, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD11 */
+	{AT91_PIN_PE19, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD12 */
+	{AT91_PIN_PE20, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD13 */
+	{AT91_PIN_PE21, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD14 */
+	{AT91_PIN_PE22, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD15 */
+	{AT91_PIN_PE23, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD16 */
+	{AT91_PIN_PE24, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD17 */
+	{AT91_PIN_PE25, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD18 */
+	{AT91_PIN_PE26, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD19 */
+	{AT91_PIN_PE27, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD20 */
+	{AT91_PIN_PE28, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD21 */
+	{AT91_PIN_PE29, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD22 */
+	{AT91_PIN_PE30, AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDD23 */
+};
+
+static struct at91_dev_table_lcdc device_lcdc __initdata = {
+	.mmio_base	= AT91SAM9G45_LCDC_BASE,
+	.irq		= AT91SAM9G45_ID_LCDC,
+	.pins		= lcdc_pins,
+	.nr_pins	= ARRAY_SIZE(lcdc_pins),
 };
 
-static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &lcdc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &lcdc_data,
-	},
-	.resource	= lcdc_resources,
-	.num_resources	= ARRAY_SIZE(lcdc_resources),
-};
-
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
-{
-	if (!data)
-		return;
-
-	at91_set_A_periph(AT91_PIN_PE0, 0);	/* LCDDPWR */
-
-	at91_set_A_periph(AT91_PIN_PE2, 0);	/* LCDCC */
-	at91_set_A_periph(AT91_PIN_PE3, 0);	/* LCDVSYNC */
-	at91_set_A_periph(AT91_PIN_PE4, 0);	/* LCDHSYNC */
-	at91_set_A_periph(AT91_PIN_PE5, 0);	/* LCDDOTCK */
-	at91_set_A_periph(AT91_PIN_PE6, 0);	/* LCDDEN */
-	at91_set_A_periph(AT91_PIN_PE7, 0);	/* LCDD0 */
-	at91_set_A_periph(AT91_PIN_PE8, 0);	/* LCDD1 */
-	at91_set_A_periph(AT91_PIN_PE9, 0);	/* LCDD2 */
-	at91_set_A_periph(AT91_PIN_PE10, 0);	/* LCDD3 */
-	at91_set_A_periph(AT91_PIN_PE11, 0);	/* LCDD4 */
-	at91_set_A_periph(AT91_PIN_PE12, 0);	/* LCDD5 */
-	at91_set_A_periph(AT91_PIN_PE13, 0);	/* LCDD6 */
-	at91_set_A_periph(AT91_PIN_PE14, 0);	/* LCDD7 */
-	at91_set_A_periph(AT91_PIN_PE15, 0);	/* LCDD8 */
-	at91_set_A_periph(AT91_PIN_PE16, 0);	/* LCDD9 */
-	at91_set_A_periph(AT91_PIN_PE17, 0);	/* LCDD10 */
-	at91_set_A_periph(AT91_PIN_PE18, 0);	/* LCDD11 */
-	at91_set_A_periph(AT91_PIN_PE19, 0);	/* LCDD12 */
-	at91_set_A_periph(AT91_PIN_PE20, 0);	/* LCDD13 */
-	at91_set_A_periph(AT91_PIN_PE21, 0);	/* LCDD14 */
-	at91_set_A_periph(AT91_PIN_PE22, 0);	/* LCDD15 */
-	at91_set_A_periph(AT91_PIN_PE23, 0);	/* LCDD16 */
-	at91_set_A_periph(AT91_PIN_PE24, 0);	/* LCDD17 */
-	at91_set_A_periph(AT91_PIN_PE25, 0);	/* LCDD18 */
-	at91_set_A_periph(AT91_PIN_PE26, 0);	/* LCDD19 */
-	at91_set_A_periph(AT91_PIN_PE27, 0);	/* LCDD20 */
-	at91_set_A_periph(AT91_PIN_PE28, 0);	/* LCDD21 */
-	at91_set_A_periph(AT91_PIN_PE29, 0);	/* LCDD22 */
-	at91_set_A_periph(AT91_PIN_PE30, 0);	/* LCDD23 */
-
-	lcdc_data = *data;
-	platform_device_register(&at91_lcdc_device);
-}
-#else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Timer/Counter block
  * -------------------------------------------------------------------- */
@@ -666,6 +632,7 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
 	.ac97		= &device_ac97,
+	.lcdc		= &device_lcdc,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 63d7fcd..50b2b8a 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -242,71 +242,37 @@ static struct at91_dev_table_ac97 device_ac97 __initdata = {
  *  LCD Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
-static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
-
-static struct resource lcdc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_LCDC_BASE,
-		.end	= AT91SAM9RL_LCDC_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_LCDC,
-		.end	= AT91SAM9RL_ID_LCDC,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_pin_config lcdc_pins[] __initdata = {
+	{AT91_PIN_PC1,  AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDPWR */
+	{AT91_PIN_PC5,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDHSYNC */
+	{AT91_PIN_PC6,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDOTCK */
+	{AT91_PIN_PC7,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDDEN */
+	{AT91_PIN_PC3,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* LCDCC */
+	{AT91_PIN_PC9,  AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD3 */
+	{AT91_PIN_PC10, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD4 */
+	{AT91_PIN_PC11, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD5 */
+	{AT91_PIN_PC12, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD6 */
+	{AT91_PIN_PC13, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD7 */
+	{AT91_PIN_PC15, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD11 */
+	{AT91_PIN_PC16, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD12 */
+	{AT91_PIN_PC17, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD13 */
+	{AT91_PIN_PC18, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD14 */
+	{AT91_PIN_PC19, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD15 */
+	{AT91_PIN_PC20, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD18 */
+	{AT91_PIN_PC21, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD19 */
+	{AT91_PIN_PC22, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD20 */
+	{AT91_PIN_PC23, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD21 */
+	{AT91_PIN_PC24, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD22 */
+	{AT91_PIN_PC25, AT91_PIN_PERIPH_B, 0, 0, 0},	/* LCDD23 */
 };
 
-static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &lcdc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &lcdc_data,
-	},
-	.resource	= lcdc_resources,
-	.num_resources	= ARRAY_SIZE(lcdc_resources),
+static struct at91_dev_table_lcdc device_lcdc __initdata = {
+	.mmio_base	= AT91SAM9RL_LCDC_BASE,
+	.irq		= AT91SAM9RL_ID_LCDC,
+	.pins		= lcdc_pins,
+	.nr_pins	= ARRAY_SIZE(lcdc_pins),
 };
 
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
-{
-	if (!data) {
-		return;
-	}
-
-	at91_set_B_periph(AT91_PIN_PC1, 0);	/* LCDPWR */
-	at91_set_A_periph(AT91_PIN_PC5, 0);	/* LCDHSYNC */
-	at91_set_A_periph(AT91_PIN_PC6, 0);	/* LCDDOTCK */
-	at91_set_A_periph(AT91_PIN_PC7, 0);	/* LCDDEN */
-	at91_set_A_periph(AT91_PIN_PC3, 0);	/* LCDCC */
-	at91_set_B_periph(AT91_PIN_PC9, 0);	/* LCDD3 */
-	at91_set_B_periph(AT91_PIN_PC10, 0);	/* LCDD4 */
-	at91_set_B_periph(AT91_PIN_PC11, 0);	/* LCDD5 */
-	at91_set_B_periph(AT91_PIN_PC12, 0);	/* LCDD6 */
-	at91_set_B_periph(AT91_PIN_PC13, 0);	/* LCDD7 */
-	at91_set_B_periph(AT91_PIN_PC15, 0);	/* LCDD11 */
-	at91_set_B_periph(AT91_PIN_PC16, 0);	/* LCDD12 */
-	at91_set_B_periph(AT91_PIN_PC17, 0);	/* LCDD13 */
-	at91_set_B_periph(AT91_PIN_PC18, 0);	/* LCDD14 */
-	at91_set_B_periph(AT91_PIN_PC19, 0);	/* LCDD15 */
-	at91_set_B_periph(AT91_PIN_PC20, 0);	/* LCDD18 */
-	at91_set_B_periph(AT91_PIN_PC21, 0);	/* LCDD19 */
-	at91_set_B_periph(AT91_PIN_PC22, 0);	/* LCDD20 */
-	at91_set_B_periph(AT91_PIN_PC23, 0);	/* LCDD21 */
-	at91_set_B_periph(AT91_PIN_PC24, 0);	/* LCDD22 */
-	at91_set_B_periph(AT91_PIN_PC25, 0);	/* LCDD23 */
-
-	lcdc_data = *data;
-	platform_device_register(&at91_lcdc_device);
-}
-#else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Timer/Counter block
  * -------------------------------------------------------------------- */
@@ -541,6 +507,7 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
 	.ac97		= &device_ac97,
+	.lcdc		= &device_lcdc,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index e0ab172..f330f72 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -1106,6 +1106,65 @@ void __init at91_add_device_ac97(struct ac97c_platform_data *data)
 void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  LCD Controller
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
+static u64 lcdc_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_lcdc_device = {
+	.name	= "atmel_lcdfb",
+	.id	= 0,
+	.dev	= {
+		.dma_mask		= &lcdc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
+{
+	struct at91_dev_table_lcdc *info = devices->lcdc;
+	struct resource resources[3] = {{0}};
+	int nr_resources = 2;
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base);
+	init_resource_irq(&resources[1], info->irq);
+
+	if (info->device_init)
+		info->device_init();
+
+#if defined(CONFIG_FB_INTSRAM)
+	if (info->sram_base) {
+		void __iomem *fb;
+		struct resource *fb_res = &lcdc_resources[2];
+		size_t fb_len;
+
+		init_resource_mem(&resources[2], info->sram_base,
+				  info->sram_size);
+		nr_resources++;
+
+		fb_len = fb_res->end - fb_res->start + 1;
+		fb = ioremap(fb_res->start, fb_len);
+		if (fb) {
+			memset(fb, 0, fb_len);
+			iounmap(fb);
+		}
+	}
+#endif
+
+	if (!data)
+		return;
+
+	at91_config_pins(info->pins, info->nr_pins);
+	at91_add_platform_device(&at91_lcdc_device, resources,
+				 nr_resources, data, sizeof(*data));
+}
+#else
+void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 3d6ca83..65a036c 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -147,6 +147,16 @@ struct at91_dev_table_ac97 {
 	struct at91_pin_config	pins[4];	/* FS, CK, TX, RX */
 };
 
+struct at91_dev_table_lcdc {
+	unsigned		mmio_base;
+	int			irq;
+	unsigned		sram_base;	/* Only on AT91SAM9261 */
+	unsigned		sram_size;
+	void			(*device_init)(void);
+	struct at91_pin_config	*pins;
+	int			nr_pins;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -163,6 +173,7 @@ struct at91_device_table {
 	struct at91_dev_table_pwm		*pwm;
 	struct at91_dev_table_ssc		*ssc[4];
 	struct at91_dev_table_ac97		*ac97;
+	struct at91_dev_table_lcdc		*lcdc;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
