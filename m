From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:19 +1200
Subject: [PATCH V4 05/23] at91: Make MMC device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-6-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual MMC code for each at91 variant with a single
implementation in devices.c. Both the AT91 MMC and Atmel MCI drivers
are converted here to use the common data in both instances.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c |   79 +++----------
 arch/arm/mach-at91/at91cap9_devices.c    |  134 +++++----------------
 arch/arm/mach-at91/at91rm9200_devices.c  |   96 ++++------------
 arch/arm/mach-at91/at91sam9260_devices.c |  192 ++++--------------------------
 arch/arm/mach-at91/at91sam9261_devices.c |   76 ++----------
 arch/arm/mach-at91/at91sam9263_devices.c |  173 +++++++--------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |  189 ++++++------------------------
 arch/arm/mach-at91/at91sam9rl.c          |    4 +
 arch/arm/mach-at91/at91sam9rl_devices.c  |   85 ++++----------
 arch/arm/mach-at91/devices.c             |  162 +++++++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |   15 +++
 11 files changed, 380 insertions(+), 825 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index da27bdb..2d029a7 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -84,72 +84,22 @@ static struct at91_dev_table_ethernet device_eth __initdata = {
  *  MMC / SD
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct at91_mmc_data mmc_data;
-
-static struct resource mmc_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_MCI,
-		.end	= AT572D940HF_BASE_MCI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_MCI,
-		.end	= AT572D940HF_ID_MCI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at572d940hf_mmc_device = {
-	.name		= "at91_mci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc_data,
-	},
-	.resource	= mmc_resources,
-	.num_resources	= ARRAY_SIZE(mmc_resources),
+static struct at91_dev_table_mmc device_mmc __initdata = {
+	.mmio_base	= AT572D940HF_BASE_MCI,
+	.irq		= AT572D940HF_ID_MCI,
+	.clock_pin	= {AT91_PIN_PC22, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 /* mmc_id 0, slot a */
+		 .cmd_pin	= {AT91_PIN_PC23, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PC24, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PC25, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PC26, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PC27, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
+	 },
 };
 
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
-{
-	if (!data)
-		return;
-
-	/* input/irq */
-	if (data->det_pin) {
-		at91_set_gpio_input(data->det_pin, 1);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-	if (data->wp_pin)
-		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
-		at91_set_gpio_output(data->vcc_pin, 0);
-
-	/* CLK */
-	at91_set_A_periph(AT91_PIN_PC22, 0);
-
-	/* CMD */
-	at91_set_A_periph(AT91_PIN_PC23, 1);
-
-	/* DAT0, maybe DAT1..DAT3 */
-	at91_set_A_periph(AT91_PIN_PC24, 1);
-	if (data->wire4) {
-		at91_set_A_periph(AT91_PIN_PC25, 1);
-		at91_set_A_periph(AT91_PIN_PC26, 1);
-		at91_set_A_periph(AT91_PIN_PC27, 1);
-	}
-
-	mmc_data = *data;
-	platform_device_register(&at572d940hf_mmc_device);
-}
-#else
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
@@ -836,6 +786,7 @@ static struct at91_device_table at572d940hf_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
+	.mmc[0]		= &device_mmc,
 };
 
 void __init at572d940hf_init_devices(void)
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 1b213b0..9a5c59c 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -192,118 +192,38 @@ static struct at91_dev_table_ethernet device_eth __initdata = {
  *  MMC / SD
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct at91_mmc_data mmc0_data, mmc1_data;
-
-static struct resource mmc0_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_MCI0,
-		.end	= AT91CAP9_BASE_MCI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_MCI0,
-		.end	= AT91CAP9_ID_MCI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_mmc0_device = {
-	.name		= "at91_mci",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc0_data,
+static struct at91_dev_table_mmc device_mmc0 __initdata = {
+	.mmio_base	= AT91CAP9_BASE_MCI0,
+	.irq		= AT91CAP9_ID_MCI0,
+	.clock_asc	= "mci0_clk",
+	.clock_pin	= {AT91_PIN_PA2, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA1, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA0, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA3, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA4, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA5, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
-	.resource	= mmc0_resources,
-	.num_resources	= ARRAY_SIZE(mmc0_resources),
 };
 
-static struct resource mmc1_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_MCI1,
-		.end	= AT91CAP9_BASE_MCI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_MCI1,
-		.end	= AT91CAP9_ID_MCI1,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_mmc device_mmc1 __initdata = {
+	.mmio_base	= AT91CAP9_BASE_MCI1,
+	.irq		= AT91CAP9_ID_MCI1,
+	.clock_asc	= "mci1_clk",
+	.clock_pin	= {AT91_PIN_PA16, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA17, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA18, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA19, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA20, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA21, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
 };
 
-static struct platform_device at91cap9_mmc1_device = {
-	.name		= "at91_mci",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc1_data,
-	},
-	.resource	= mmc1_resources,
-	.num_resources	= ARRAY_SIZE(mmc1_resources),
-};
-
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
-{
-	if (!data)
-		return;
-
-	/* input/irq */
-	if (data->det_pin) {
-		at91_set_gpio_input(data->det_pin, 1);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-	if (data->wp_pin)
-		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
-		at91_set_gpio_output(data->vcc_pin, 0);
-
-	if (mmc_id == 0) {		/* MCI0 */
-		/* CLK */
-		at91_set_A_periph(AT91_PIN_PA2, 0);
-
-		/* CMD */
-		at91_set_A_periph(AT91_PIN_PA1, 1);
-
-		/* DAT0, maybe DAT1..DAT3 */
-		at91_set_A_periph(AT91_PIN_PA0, 1);
-		if (data->wire4) {
-			at91_set_A_periph(AT91_PIN_PA3, 1);
-			at91_set_A_periph(AT91_PIN_PA4, 1);
-			at91_set_A_periph(AT91_PIN_PA5, 1);
-		}
-
-		mmc0_data = *data;
-		at91_clock_associate("mci0_clk", &at91cap9_mmc0_device.dev, "mci_clk");
-		platform_device_register(&at91cap9_mmc0_device);
-	} else {			/* MCI1 */
-		/* CLK */
-		at91_set_A_periph(AT91_PIN_PA16, 0);
-
-		/* CMD */
-		at91_set_A_periph(AT91_PIN_PA17, 1);
-
-		/* DAT0, maybe DAT1..DAT3 */
-		at91_set_A_periph(AT91_PIN_PA18, 1);
-		if (data->wire4) {
-			at91_set_A_periph(AT91_PIN_PA19, 1);
-			at91_set_A_periph(AT91_PIN_PA20, 1);
-			at91_set_A_periph(AT91_PIN_PA21, 1);
-		}
-
-		mmc1_data = *data;
-		at91_clock_associate("mci1_clk", &at91cap9_mmc1_device.dev, "mci_clk");
-		platform_device_register(&at91cap9_mmc1_device);
-	}
-}
-#else
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
@@ -1179,6 +1099,8 @@ void __init at91_add_device_serial(void) {}
 static struct at91_device_table at91cap9_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
+	.mmc[0]		= &device_mmc0,
+	.mmc[1]		= &device_mmc1,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 09e771c..4763662 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -170,85 +170,30 @@ void __init at91_add_device_cf(struct at91_cf_data *data) {}
  *  MMC / SD
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct at91_mmc_data mmc_data;
-
-static struct resource mmc_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_MCI,
-		.end	= AT91RM9200_BASE_MCI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
+static struct at91_dev_table_mmc device_mmc __initdata = {
+	.mmio_base	= AT91RM9200_BASE_MCI,
+	.irq		= AT91RM9200_ID_MCI,
+	.clock_pin	= {AT91_PIN_PA27, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA28, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA29, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PB3,  AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PB4,  AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PB5,  AT91_PIN_PERIPH_B, 1, 0, 0},
+		 },
 	},
-	[1] = {
-		.start	= AT91RM9200_ID_MCI,
-		.end	= AT91RM9200_ID_MCI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91rm9200_mmc_device = {
-	.name		= "at91_mci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc_data,
+	.slot[1]	= {
+		 .cmd_pin	= {AT91_PIN_PA8, AT91_PIN_PERIPH_B, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA9,  AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PA10, AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PA11, AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PA12, AT91_PIN_PERIPH_B, 1, 0, 0},
+		 },
 	},
-	.resource	= mmc_resources,
-	.num_resources	= ARRAY_SIZE(mmc_resources),
 };
 
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
-{
-	if (!data)
-		return;
-
-	/* input/irq */
-	if (data->det_pin) {
-		at91_set_gpio_input(data->det_pin, 1);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-	if (data->wp_pin)
-		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
-		at91_set_gpio_output(data->vcc_pin, 0);
-
-	/* CLK */
-	at91_set_A_periph(AT91_PIN_PA27, 0);
-
-	if (data->slot_b) {
-		/* CMD */
-		at91_set_B_periph(AT91_PIN_PA8, 1);
-
-		/* DAT0, maybe DAT1..DAT3 */
-		at91_set_B_periph(AT91_PIN_PA9, 1);
-		if (data->wire4) {
-			at91_set_B_periph(AT91_PIN_PA10, 1);
-			at91_set_B_periph(AT91_PIN_PA11, 1);
-			at91_set_B_periph(AT91_PIN_PA12, 1);
-		}
-	} else {
-		/* CMD */
-		at91_set_A_periph(AT91_PIN_PA28, 1);
-
-		/* DAT0, maybe DAT1..DAT3 */
-		at91_set_A_periph(AT91_PIN_PA29, 1);
-		if (data->wire4) {
-			at91_set_B_periph(AT91_PIN_PB3, 1);
-			at91_set_B_periph(AT91_PIN_PB4, 1);
-			at91_set_B_periph(AT91_PIN_PB5, 1);
-		}
-	}
-
-	mmc_data = *data;
-	platform_device_register(&at91rm9200_mmc_device);
-}
-#else
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
@@ -1059,6 +1004,7 @@ static struct at91_device_table at91rm9200_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
+	.mmc[0]		= &device_mmc,
 };
 
 void __init at91rm9200_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 16ec548..5f1aaca 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -85,181 +85,30 @@ static struct at91_dev_table_ethernet device_eth __initdata = {
  *  MMC / SD
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct at91_mmc_data mmc_data;
-
-static struct resource mmc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_MCI,
-		.end	= AT91SAM9260_BASE_MCI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
+static struct at91_dev_table_mmc device_mmc __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_MCI,
+	.irq		= AT91SAM9260_ID_MCI,
+	.clock_pin	= {AT91_PIN_PA8, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA7, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA6,  AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA9,  AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA10, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA11, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
-	[1] = {
-		.start	= AT91SAM9260_ID_MCI,
-		.end	= AT91SAM9260_ID_MCI,
-		.flags	= IORESOURCE_IRQ,
+	.slot[1]	= {
+		 .cmd_pin	= {AT91_PIN_PA1, AT91_PIN_PERIPH_B, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA0, AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PA5, AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PA4, AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PA3, AT91_PIN_PERIPH_B, 1, 0, 0},
+		 },
 	},
 };
 
-static struct platform_device at91sam9260_mmc_device = {
-	.name		= "at91_mci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc_data,
-	},
-	.resource	= mmc_resources,
-	.num_resources	= ARRAY_SIZE(mmc_resources),
-};
-
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
-{
-	if (!data)
-		return;
-
-	/* input/irq */
-	if (data->det_pin) {
-		at91_set_gpio_input(data->det_pin, 1);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-	if (data->wp_pin)
-		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
-		at91_set_gpio_output(data->vcc_pin, 0);
-
-	/* CLK */
-	at91_set_A_periph(AT91_PIN_PA8, 0);
-
-	if (data->slot_b) {
-		/* CMD */
-		at91_set_B_periph(AT91_PIN_PA1, 1);
-
-		/* DAT0, maybe DAT1..DAT3 */
-		at91_set_B_periph(AT91_PIN_PA0, 1);
-		if (data->wire4) {
-			at91_set_B_periph(AT91_PIN_PA5, 1);
-			at91_set_B_periph(AT91_PIN_PA4, 1);
-			at91_set_B_periph(AT91_PIN_PA3, 1);
-		}
-	} else {
-		/* CMD */
-		at91_set_A_periph(AT91_PIN_PA7, 1);
-
-		/* DAT0, maybe DAT1..DAT3 */
-		at91_set_A_periph(AT91_PIN_PA6, 1);
-		if (data->wire4) {
-			at91_set_A_periph(AT91_PIN_PA9, 1);
-			at91_set_A_periph(AT91_PIN_PA10, 1);
-			at91_set_A_periph(AT91_PIN_PA11, 1);
-		}
-	}
-
-	mmc_data = *data;
-	platform_device_register(&at91sam9260_mmc_device);
-}
-#else
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
-#endif
-
-/* --------------------------------------------------------------------
- *  MMC / SD Slot for Atmel MCI Driver
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct mci_platform_data mmc_data;
-
-static struct resource mmc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_MCI,
-		.end	= AT91SAM9260_BASE_MCI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_MCI,
-		.end	= AT91SAM9260_ID_MCI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9260_mmc_device = {
-	.name		= "atmel_mci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc_data,
-	},
-	.resource	= mmc_resources,
-	.num_resources	= ARRAY_SIZE(mmc_resources),
-};
-
-void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
-{
-	unsigned int i;
-	unsigned int slot_count = 0;
-
-	if (!data)
-		return;
-
-	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
-		if (data->slot[i].bus_width) {
-			/* input/irq */
-			if (data->slot[i].detect_pin) {
-				at91_set_gpio_input(data->slot[i].detect_pin, 1);
-				at91_set_deglitch(data->slot[i].detect_pin, 1);
-			}
-			if (data->slot[i].wp_pin)
-				at91_set_gpio_input(data->slot[i].wp_pin, 1);
-
-			switch (i) {
-			case 0:
-				/* CMD */
-				at91_set_A_periph(AT91_PIN_PA7, 1);
-				/* DAT0, maybe DAT1..DAT3 */
-				at91_set_A_periph(AT91_PIN_PA6, 1);
-				if (data->slot[i].bus_width == 4) {
-					at91_set_A_periph(AT91_PIN_PA9, 1);
-					at91_set_A_periph(AT91_PIN_PA10, 1);
-					at91_set_A_periph(AT91_PIN_PA11, 1);
-				}
-				slot_count++;
-				break;
-			case 1:
-				/* CMD */
-				at91_set_B_periph(AT91_PIN_PA1, 1);
-				/* DAT0, maybe DAT1..DAT3 */
-				at91_set_B_periph(AT91_PIN_PA0, 1);
-				if (data->slot[i].bus_width == 4) {
-					at91_set_B_periph(AT91_PIN_PA5, 1);
-					at91_set_B_periph(AT91_PIN_PA4, 1);
-					at91_set_B_periph(AT91_PIN_PA3, 1);
-				}
-				slot_count++;
-				break;
-			default:
-				printk(KERN_ERR
-					"AT91: SD/MMC slot %d not available\n", i);
-				break;
-			}
-		}
-	}
-
-	if (slot_count) {
-		/* CLK */
-		at91_set_A_periph(AT91_PIN_PA8, 0);
-
-		mmc_data = *data;
-		platform_device_register(&at91sam9260_mmc_device);
-	}
-}
-#else
-void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
@@ -1215,6 +1064,7 @@ static struct at91_device_table at91sam9260_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
+	.mmc[0]		= &device_mmc,
 };
 
 void __init at91sam9260_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 8fe0fd3..4bf9a09 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -51,72 +51,21 @@ static struct at91_dev_table_basic_device device_udc __initdata = {
  *  MMC / SD
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct at91_mmc_data mmc_data;
-
-static struct resource mmc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_MCI,
-		.end	= AT91SAM9261_BASE_MCI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_MCI,
-		.end	= AT91SAM9261_ID_MCI,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_mmc device_mmc __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_MCI,
+	.irq		= AT91SAM9261_ID_MCI,
+	.clock_pin	= {AT91_PIN_PA2, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA1, AT91_PIN_PERIPH_B, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA0, AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PA4, AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PA5, AT91_PIN_PERIPH_B, 1, 0, 0},
+			  {AT91_PIN_PA6, AT91_PIN_PERIPH_B, 1, 0, 0},
+		 },
 	},
 };
 
-static struct platform_device at91sam9261_mmc_device = {
-	.name		= "at91_mci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc_data,
-	},
-	.resource	= mmc_resources,
-	.num_resources	= ARRAY_SIZE(mmc_resources),
-};
-
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
-{
-	if (!data)
-		return;
-
-	/* input/irq */
-	if (data->det_pin) {
-		at91_set_gpio_input(data->det_pin, 1);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-	if (data->wp_pin)
-		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
-		at91_set_gpio_output(data->vcc_pin, 0);
-
-	/* CLK */
-	at91_set_B_periph(AT91_PIN_PA2, 0);
-
-	/* CMD */
-	at91_set_B_periph(AT91_PIN_PA1, 1);
-
-	/* DAT0, maybe DAT1..DAT3 */
-	at91_set_B_periph(AT91_PIN_PA0, 1);
-	if (data->wire4) {
-		at91_set_B_periph(AT91_PIN_PA4, 1);
-		at91_set_B_periph(AT91_PIN_PA5, 1);
-		at91_set_B_periph(AT91_PIN_PA6, 1);
-	}
-
-	mmc_data = *data;
-	platform_device_register(&at91sam9261_mmc_device);
-}
-#else
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
@@ -970,6 +919,7 @@ void __init at91_add_device_serial(void) {}
 static struct at91_device_table at91sam9261_device_table __initdata = {
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
+	.mmc[0]		= &device_mmc,
 };
 
 void __init at91sam9261_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 2f9b0d2..708d24a 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -88,143 +88,56 @@ static struct at91_dev_table_ethernet device_eth __initdata = {
  *  MMC / SD
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct at91_mmc_data mmc0_data, mmc1_data;
-
-static struct resource mmc0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_MCI0,
-		.end	= AT91SAM9263_BASE_MCI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
+static struct at91_dev_table_mmc device_mmc0 __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_MCI0,
+	.irq		= AT91SAM9263_ID_MCI0,
+	.clock_asc	= "mci0_clk",
+	.clock_pin	= {AT91_PIN_PA12, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA1, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA0, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA3, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA4, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA5, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
-	[1] = {
-		.start	= AT91SAM9263_ID_MCI0,
-		.end	= AT91SAM9263_ID_MCI0,
-		.flags	= IORESOURCE_IRQ,
+	.slot[1]	= {
+		 .cmd_pin	= {AT91_PIN_PA16, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA17, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA18, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA19, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA20, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
 };
 
-static struct platform_device at91sam9263_mmc0_device = {
-	.name		= "at91_mci",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc0_data,
+static struct at91_dev_table_mmc device_mmc1 __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_MCI1,
+	.irq		= AT91SAM9263_ID_MCI1,
+	.clock_asc	= "mci1_clk",
+	.clock_pin	= {AT91_PIN_PA6, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA7, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA8, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA9, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA10, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA11, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
-	.resource	= mmc0_resources,
-	.num_resources	= ARRAY_SIZE(mmc0_resources),
-};
-
-static struct resource mmc1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_MCI1,
-		.end	= AT91SAM9263_BASE_MCI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_MCI1,
-		.end	= AT91SAM9263_ID_MCI1,
-		.flags	= IORESOURCE_IRQ,
+	.slot[1]	= {
+		 .cmd_pin	= {AT91_PIN_PA21, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA22, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA23, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA24, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA25, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
 };
 
-static struct platform_device at91sam9263_mmc1_device = {
-	.name		= "at91_mci",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc1_data,
-	},
-	.resource	= mmc1_resources,
-	.num_resources	= ARRAY_SIZE(mmc1_resources),
-};
-
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
-{
-	if (!data)
-		return;
-
-	/* input/irq */
-	if (data->det_pin) {
-		at91_set_gpio_input(data->det_pin, 1);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-	if (data->wp_pin)
-		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
-		at91_set_gpio_output(data->vcc_pin, 0);
-
-	if (mmc_id == 0) {		/* MCI0 */
-		/* CLK */
-		at91_set_A_periph(AT91_PIN_PA12, 0);
-
-		if (data->slot_b) {
-			/* CMD */
-			at91_set_A_periph(AT91_PIN_PA16, 1);
-
-			/* DAT0, maybe DAT1..DAT3 */
-			at91_set_A_periph(AT91_PIN_PA17, 1);
-			if (data->wire4) {
-				at91_set_A_periph(AT91_PIN_PA18, 1);
-				at91_set_A_periph(AT91_PIN_PA19, 1);
-				at91_set_A_periph(AT91_PIN_PA20, 1);
-			}
-		} else {
-			/* CMD */
-			at91_set_A_periph(AT91_PIN_PA1, 1);
-
-			/* DAT0, maybe DAT1..DAT3 */
-			at91_set_A_periph(AT91_PIN_PA0, 1);
-			if (data->wire4) {
-				at91_set_A_periph(AT91_PIN_PA3, 1);
-				at91_set_A_periph(AT91_PIN_PA4, 1);
-				at91_set_A_periph(AT91_PIN_PA5, 1);
-			}
-		}
-
-		mmc0_data = *data;
-		at91_clock_associate("mci0_clk", &at91sam9263_mmc0_device.dev, "mci_clk");
-		platform_device_register(&at91sam9263_mmc0_device);
-	} else {			/* MCI1 */
-		/* CLK */
-		at91_set_A_periph(AT91_PIN_PA6, 0);
-
-		if (data->slot_b) {
-			/* CMD */
-			at91_set_A_periph(AT91_PIN_PA21, 1);
-
-			/* DAT0, maybe DAT1..DAT3 */
-			at91_set_A_periph(AT91_PIN_PA22, 1);
-			if (data->wire4) {
-				at91_set_A_periph(AT91_PIN_PA23, 1);
-				at91_set_A_periph(AT91_PIN_PA24, 1);
-				at91_set_A_periph(AT91_PIN_PA25, 1);
-			}
-		} else {
-			/* CMD */
-			at91_set_A_periph(AT91_PIN_PA7, 1);
-
-			/* DAT0, maybe DAT1..DAT3 */
-			at91_set_A_periph(AT91_PIN_PA8, 1);
-			if (data->wire4) {
-				at91_set_A_periph(AT91_PIN_PA9, 1);
-				at91_set_A_periph(AT91_PIN_PA10, 1);
-				at91_set_A_periph(AT91_PIN_PA11, 1);
-			}
-		}
-
-		mmc1_data = *data;
-		at91_clock_associate("mci1_clk", &at91sam9263_mmc1_device.dev, "mci_clk");
-		platform_device_register(&at91sam9263_mmc1_device);
-	}
-}
-#else
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
-#endif
-
 /* --------------------------------------------------------------------
  *  Compact Flash (PCMCIA or IDE)
  * -------------------------------------------------------------------- */
@@ -1307,6 +1220,8 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
+	.mmc[0]		= &device_mmc0,
+	.mmc[1]		= &device_mmc1,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index e49a873..745b1a2 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -228,165 +228,46 @@ static struct at91_dev_table_ethernet device_eth __initdata = {
  *  MMC / SD
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct mci_platform_data mmc0_data, mmc1_data;
-
-static struct resource mmc0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_MCI0,
-		.end	= AT91SAM9G45_BASE_MCI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_MCI0,
-		.end	= AT91SAM9G45_ID_MCI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9g45_mmc0_device = {
-	.name		= "atmel_mci",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc0_data,
+static struct at91_dev_table_mmc device_mmc0 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_MCI0,
+	.irq		= AT91SAM9G45_ID_MCI0,
+	.clock_asc	= "mci0_clk",
+	.clock_pin	= {AT91_PIN_PA0, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA1, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA2, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA3, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA4, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA5, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA6, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA7, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA8, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA9, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
-	.resource	= mmc0_resources,
-	.num_resources	= ARRAY_SIZE(mmc0_resources),
 };
 
-static struct resource mmc1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_MCI1,
-		.end	= AT91SAM9G45_BASE_MCI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_MCI1,
-		.end	= AT91SAM9G45_ID_MCI1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9g45_mmc1_device = {
-	.name		= "atmel_mci",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc1_data,
+static struct at91_dev_table_mmc device_mmc1 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_MCI1,
+	.irq		= AT91SAM9G45_ID_MCI1,
+	.clock_asc	= "mci1_clk",
+	.clock_pin	= {AT91_PIN_PA31, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA22, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA23, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA24, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA25, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA26, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA27, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA28, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA29, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA30, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
-	.resource	= mmc1_resources,
-	.num_resources	= ARRAY_SIZE(mmc1_resources),
 };
 
-/* Consider only one slot : slot 0 */
-void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
-{
-
-	if (!data)
-		return;
-
-	/* Must have at least one usable slot */
-	if (!data->slot[0].bus_width)
-		return;
-
-#if defined(CONFIG_AT_HDMAC) || defined(CONFIG_AT_HDMAC_MODULE)
-	{
-	struct at_dma_slave	*atslave;
-	struct mci_dma_data	*alt_atslave;
-
-	alt_atslave = kzalloc(sizeof(struct mci_dma_data), GFP_KERNEL);
-	atslave = &alt_atslave->sdata;
-
-	/* DMA slave channel configuration */
-	atslave->dma_dev = &at_hdmac_device.dev;
-	atslave->reg_width = AT_DMA_SLAVE_WIDTH_32BIT;
-	atslave->cfg = ATC_FIFOCFG_HALFFIFO
-			| ATC_SRC_H2SEL_HW | ATC_DST_H2SEL_HW;
-	atslave->ctrla = ATC_SCSIZE_16 | ATC_DCSIZE_16;
-	if (mmc_id == 0)	/* MCI0 */
-		atslave->cfg |= ATC_SRC_PER(AT_DMA_ID_MCI0)
-			      | ATC_DST_PER(AT_DMA_ID_MCI0);
-
-	else			/* MCI1 */
-		atslave->cfg |= ATC_SRC_PER(AT_DMA_ID_MCI1)
-			      | ATC_DST_PER(AT_DMA_ID_MCI1);
-
-	data->dma_slave = alt_atslave;
-	}
-#endif
-
-
-	/* input/irq */
-	if (data->slot[0].detect_pin) {
-		at91_set_gpio_input(data->slot[0].detect_pin, 1);
-		at91_set_deglitch(data->slot[0].detect_pin, 1);
-	}
-	if (data->slot[0].wp_pin)
-		at91_set_gpio_input(data->slot[0].wp_pin, 1);
-
-	if (mmc_id == 0) {		/* MCI0 */
-
-		/* CLK */
-		at91_set_A_periph(AT91_PIN_PA0, 0);
-
-		/* CMD */
-		at91_set_A_periph(AT91_PIN_PA1, 1);
-
-		/* DAT0, maybe DAT1..DAT3 and maybe DAT4..DAT7 */
-		at91_set_A_periph(AT91_PIN_PA2, 1);
-		if (data->slot[0].bus_width == 4) {
-			at91_set_A_periph(AT91_PIN_PA3, 1);
-			at91_set_A_periph(AT91_PIN_PA4, 1);
-			at91_set_A_periph(AT91_PIN_PA5, 1);
-			if (data->slot[0].bus_width == 8) {
-				at91_set_A_periph(AT91_PIN_PA6, 1);
-				at91_set_A_periph(AT91_PIN_PA7, 1);
-				at91_set_A_periph(AT91_PIN_PA8, 1);
-				at91_set_A_periph(AT91_PIN_PA9, 1);
-			}
-		}
-
-		mmc0_data = *data;
-		at91_clock_associate("mci0_clk", &at91sam9g45_mmc0_device.dev, "mci_clk");
-		platform_device_register(&at91sam9g45_mmc0_device);
-
-	} else {			/* MCI1 */
-
-		/* CLK */
-		at91_set_A_periph(AT91_PIN_PA31, 0);
-
-		/* CMD */
-		at91_set_A_periph(AT91_PIN_PA22, 1);
-
-		/* DAT0, maybe DAT1..DAT3 and maybe DAT4..DAT7 */
-		at91_set_A_periph(AT91_PIN_PA23, 1);
-		if (data->slot[0].bus_width == 4) {
-			at91_set_A_periph(AT91_PIN_PA24, 1);
-			at91_set_A_periph(AT91_PIN_PA25, 1);
-			at91_set_A_periph(AT91_PIN_PA26, 1);
-			if (data->slot[0].bus_width == 8) {
-				at91_set_A_periph(AT91_PIN_PA27, 1);
-				at91_set_A_periph(AT91_PIN_PA28, 1);
-				at91_set_A_periph(AT91_PIN_PA29, 1);
-				at91_set_A_periph(AT91_PIN_PA30, 1);
-			}
-		}
-
-		mmc1_data = *data;
-		at91_clock_associate("mci1_clk", &at91sam9g45_mmc1_device.dev, "mci_clk");
-		platform_device_register(&at91sam9g45_mmc1_device);
-
-	}
-}
-#else
-void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
@@ -1464,6 +1345,8 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usb_ohci,
 	.usbh_ehci	= &device_usb_ehci,
+	.mmc[0]		= &device_mmc0,
+	.mmc[1]		= &device_mmc1,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 6a9d24e..9ca108a 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -24,6 +24,8 @@
 #include "generic.h"
 #include "clock.h"
 
+extern void __init at91sam9rl_init_devices(void);
+
 static struct map_desc at91sam9rl_io_desc[] __initdata = {
 	{
 		.virtual	= AT91_VA_BASE_SYS,
@@ -259,6 +261,8 @@ void __init at91sam9rl_initialize(unsigned long main_clock)
 	/* Map peripherals */
 	iotable_init(at91sam9rl_io_desc, ARRAY_SIZE(at91sam9rl_io_desc));
 
+	at91sam9rl_init_devices();
+
 	cidr = at91_sys_read(AT91_DBGU_CIDR);
 
 	switch (cidr & AT91_CIDR_SRAMSIZ) {
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 53aaa94..352e30c 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -24,7 +24,7 @@
 #include <mach/at_hdmac.h>
 
 #include "generic.h"
-
+#include "devices.h"
 
 /* --------------------------------------------------------------------
  *  HDMAC - AHB DMA Controller
@@ -170,72 +170,21 @@ void __init at91_add_device_usba(struct usba_platform_data *data) {}
  *  MMC / SD
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct at91_mmc_data mmc_data;
-
-static struct resource mmc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_MCI,
-		.end	= AT91SAM9RL_BASE_MCI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_MCI,
-		.end	= AT91SAM9RL_ID_MCI,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_mmc device_mmc __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_MCI,
+	.irq		= AT91SAM9RL_ID_MCI,
+	.clock_pin	= {AT91_PIN_PA2, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.slot[0]	= {
+		 .cmd_pin	= {AT91_PIN_PA1, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 .data_pins	= {
+			  {AT91_PIN_PA0, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA3, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA4, AT91_PIN_PERIPH_A, 1, 0, 0},
+			  {AT91_PIN_PA5, AT91_PIN_PERIPH_A, 1, 0, 0},
+		 },
 	},
 };
 
-static struct platform_device at91sam9rl_mmc_device = {
-	.name		= "at91_mci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc_data,
-	},
-	.resource	= mmc_resources,
-	.num_resources	= ARRAY_SIZE(mmc_resources),
-};
-
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
-{
-	if (!data)
-		return;
-
-	/* input/irq */
-	if (data->det_pin) {
-		at91_set_gpio_input(data->det_pin, 1);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-	if (data->wp_pin)
-		at91_set_gpio_input(data->wp_pin, 1);
-	if (data->vcc_pin)
-		at91_set_gpio_output(data->vcc_pin, 0);
-
-	/* CLK */
-	at91_set_A_periph(AT91_PIN_PA2, 0);
-
-	/* CMD */
-	at91_set_A_periph(AT91_PIN_PA1, 1);
-
-	/* DAT0, maybe DAT1..DAT3 */
-	at91_set_A_periph(AT91_PIN_PA0, 1);
-	if (data->wire4) {
-		at91_set_A_periph(AT91_PIN_PA3, 1);
-		at91_set_A_periph(AT91_PIN_PA4, 1);
-		at91_set_A_periph(AT91_PIN_PA5, 1);
-	}
-
-	mmc_data = *data;
-	platform_device_register(&at91sam9rl_mmc_device);
-}
-#else
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
@@ -1201,6 +1150,14 @@ void __init at91_set_serial_console(unsigned portnr) {}
 void __init at91_add_device_serial(void) {}
 #endif
 
+static struct at91_device_table at91sam9rl_device_table __initdata = {
+	.mmc[0]		= &device_mmc,
+};
+
+void __init at91sam9rl_init_devices(void)
+{
+	at91_init_devices(&at91sam9rl_device_table);
+}
 
 /* -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 4e1288c..bf98964 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -288,6 +288,168 @@ void __init at91_add_device_eth(struct at91_eth_data *data)
 void __init at91_add_device_eth(struct at91_eth_data *data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  MMC / SD
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
+static u64 mmc_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_mmc_devices[] = {
+	[0] = {
+		.name	= "at91_mci",
+		.id	= 0,
+		.dev	= {
+			.dma_mask		= &mmc_dmamask,
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},
+	[1] = {
+		.name	= "at91_mci",
+		.id	= 1,
+		.dev	= {
+			.dma_mask		= &mmc_dmamask,
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},
+};
+
+void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
+{
+	struct at91_dev_table_mmc *info = devices->mmc[mmc_id];
+	struct resource resources[2] = {{0}};
+	int slot;
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_16K);
+	init_resource_irq(&resources[1], info->irq);
+
+	if (!data)
+		return;
+
+	/* input/irq */
+	if (data->det_pin) {
+		at91_set_gpio_input(data->det_pin, 1);
+		at91_set_deglitch(data->det_pin, 1);
+	}
+	if (data->wp_pin)
+		at91_set_gpio_input(data->wp_pin, 1);
+	if (data->vcc_pin)
+		at91_set_gpio_output(data->vcc_pin, 0);
+
+	slot = !!data->slot_b;
+
+	/* CLK */
+	at91_config_pins(&info->clock_pin, 1);
+
+	/* CMD */
+	at91_config_pins(&info->slot[slot].cmd_pin, 1);
+
+	/* DAT0, maybe DAT1..DAT3 */
+	at91_config_pins(info->slot[slot].data_pins, data->wire4 ? 4 : 1);
+
+	if (info->clock_asc)
+		at91_clock_associate(info->clock_asc,
+				     &at91_mmc_devices[mmc_id].dev, "mci_clk");
+	at91_add_platform_device(&at91_mmc_devices[mmc_id], resources,
+				 ARRAY_SIZE(resources), data, sizeof(*data));
+}
+#else
+void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
+#endif
+
+/* --------------------------------------------------------------------
+ *  MMC / SD Slot for Atmel MCI Driver
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static u64 mmc_dmamask[2];
+
+static struct platform_device at91_mmc_devices[] = {
+	[0] = {
+		.name	= "atmel_mci",
+		.id	= 0,
+		.dev	= {
+			.dma_mask		= &mmc_dmamask[0],
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},
+	[1] = {
+		.name	= "atmel_mci",
+		.id	= 1,
+		.dev	= {
+			.dma_mask		= &mmc_dmamask[1],
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},	
+};
+
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
+{
+	struct at91_dev_table_mmc *info = devices->mmc[mmc_id];
+	struct resource resources[2] = {{0}};
+	int i;
+
+	BUG_ON(!mmc_id);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_16K);
+	init_resource_irq(&resources[1], info->irq);
+
+#if defined(CONFIG_AT_HDMAC) || defined(CONFIG_AT_HDMAC_MODULE)
+	{
+	struct at_dma_slave	*atslave;
+	struct mci_dma_data	*alt_atslave;
+
+	alt_atslave = kzalloc(sizeof(struct mci_dma_data), GFP_KERNEL);
+	atslave = &alt_atslave->sdata;
+
+	/* DMA slave channel configuration */
+	atslave->dma_dev = &at_hdmac_device.dev;
+	atslave->reg_width = AT_DMA_SLAVE_WIDTH_32BIT;
+	atslave->cfg = ATC_FIFOCFG_HALFFIFO
+			| ATC_SRC_H2SEL_HW | ATC_DST_H2SEL_HW;
+	atslave->ctrla = ATC_SCSIZE_16 | ATC_DCSIZE_16;
+	if (mmc_id == 0)	/* MCI0 */
+		atslave->cfg |= ATC_SRC_PER(AT_DMA_ID_MCI0)
+			      | ATC_DST_PER(AT_DMA_ID_MCI0);
+
+	else			/* MCI1 */
+		atslave->cfg |= ATC_SRC_PER(AT_DMA_ID_MCI1)
+			      | ATC_DST_PER(AT_DMA_ID_MCI1);
+
+	data->dma_slave = alt_atslave;
+	}
+#endif
+
+	/* CLK */
+	at91_config_pins(&info->clock_pin, 1);
+
+	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+		if (data->slot[i].bus_width) {
+			/* input/irq */
+			if (data->slot[i].detect_pin) {
+				at91_set_gpio_input(data->slot[i].detect_pin, 1);
+				at91_set_deglitch(data->slot[i].detect_pin, 1);
+			}
+			if (data->slot[i].wp_pin)
+				at91_set_gpio_input(data->slot[i].wp_pin, 1);
+
+			/* CMD */
+			at91_config_pins(&info->slot[i].cmd_pin, 1);
+
+			/* DAT0, maybe DAT1..DAT7 */
+			at91_config_pins(info->slot[i].data_pins,
+					 info->slot[i].bus_width);
+		}
+	}
+
+	mmc_dmamask[mmc_id] = DMA_BIT_MASK(32);
+	at91_add_platform_device(&at91_mmc_devices[mmc_id], resources,
+				 ARRAY_SIZE(resources), data, sizeof(*data));
+}
+#else
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
+#endif
+
 void __init at91_init_devices(struct at91_device_table *device_table)
 {
 	devices = device_table;
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 9203f58..eab2f54 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -48,11 +48,26 @@ struct at91_dev_table_usb_ohci {
 	void			(*device_init)(void);
 };
 
+struct at91_mmc_pins {
+	struct at91_pin_config	cmd_pin;
+	struct at91_pin_config	data_pins[8];
+	int			bus_width;
+};
+
+struct at91_dev_table_mmc {
+	unsigned 		mmio_base;
+	int			irq;
+	const char		*clock_asc;
+	struct at91_pin_config	clock_pin;
+	struct at91_mmc_pins	slot[2];
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
 	struct at91_dev_table_basic_device	*usbh_ehci;
 	struct at91_dev_table_basic_device	*udc;
+	struct at91_dev_table_mmc		*mmc[2];
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
