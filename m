From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:22 +1200
Subject: [PATCH V4 08/23] at91: Make SPI device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-9-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual SPI code for each at91 variant with a single
implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c |  122 +++++-------------------------
 arch/arm/mach-at91/at91cap9_devices.c    |  122 +++++-------------------------
 arch/arm/mach-at91/at91rm9200_devices.c  |   69 ++---------------
 arch/arm/mach-at91/at91sam9260_devices.c |  122 +++++-------------------------
 arch/arm/mach-at91/at91sam9261_devices.c |  122 +++++-------------------------
 arch/arm/mach-at91/at91sam9263_devices.c |  122 +++++-------------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |  122 +++++-------------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   67 ++--------------
 arch/arm/mach-at91/devices.c             |   83 ++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |   11 +++
 10 files changed, 232 insertions(+), 730 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 482de24..5f497c6 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -142,114 +142,30 @@ static struct at91_dev_table_twi device_twi1 __initdata = {
  *  SPI
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct resource spi0_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_SPI0,
-		.end	= AT572D940HF_BASE_SPI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_SPI0,
-		.end	= AT572D940HF_ID_SPI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at572d940hf_spi0_device = {
-	.name		= "atmel_spi",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
+static struct at91_dev_table_spi device_spi0 __initdata = {
+	.mmio_base		= AT572D940HF_BASE_SPI0,
+	.irq			= AT572D940HF_ID_SPI0,
+	.clk_asc		= "spi0_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PA3, AT91_PIN_PA4, AT91_PIN_PA5, AT91_PIN_PA6,
 	},
-	.resource	= spi0_resources,
-	.num_resources	= ARRAY_SIZE(spi0_resources),
+	.pin_miso		= {AT91_PIN_PA0, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PA1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PA2, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static const unsigned spi0_standard_cs[4] = { AT91_PIN_PA3, AT91_PIN_PA4, AT91_PIN_PA5, AT91_PIN_PA6 };
-
-static struct resource spi1_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_SPI1,
-		.end	= AT572D940HF_BASE_SPI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_SPI1,
-		.end	= AT572D940HF_ID_SPI1,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_spi device_spi1 __initdata = {
+	.mmio_base		= AT572D940HF_BASE_SPI1,
+	.irq			= AT572D940HF_ID_SPI1,
+	.clk_asc		= "spi1_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PC3, AT91_PIN_PC4, AT91_PIN_PC5, AT91_PIN_PC6,
 	},
+	.pin_miso		= {AT91_PIN_PC0, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PC1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PC2, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static struct platform_device at572d940hf_spi1_device = {
-	.name		= "atmel_spi",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= spi1_resources,
-	.num_resources	= ARRAY_SIZE(spi1_resources),
-};
-
-static const unsigned spi1_standard_cs[4] = { AT91_PIN_PC3, AT91_PIN_PC4, AT91_PIN_PC5, AT91_PIN_PC6 };
-
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
-{
-	int i;
-	unsigned long cs_pin;
-	short enable_spi0 = 0;
-	short enable_spi1 = 0;
-
-	/* Choose SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else if (devices[i].bus_num == 0)
-			cs_pin = spi0_standard_cs[devices[i].chip_select];
-		else
-			cs_pin = spi1_standard_cs[devices[i].chip_select];
-
-		if (devices[i].bus_num == 0)
-			enable_spi0 = 1;
-		else
-			enable_spi1 = 1;
-
-		/* enable chip-select pin */
-		at91_set_gpio_output(cs_pin, 1);
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
-
-	spi_register_board_info(devices, nr_devices);
-
-	/* Configure SPI bus(es) */
-	if (enable_spi0) {
-		at91_set_A_periph(AT91_PIN_PA0, 0);	/* SPI0_MISO */
-		at91_set_A_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
-		at91_set_A_periph(AT91_PIN_PA2, 0);	/* SPI0_SPCK */
-
-		at91_clock_associate("spi0_clk", &at572d940hf_spi0_device.dev, "spi_clk");
-		platform_device_register(&at572d940hf_spi0_device);
-	}
-	if (enable_spi1) {
-		at91_set_A_periph(AT91_PIN_PC0, 0);	/* SPI1_MISO */
-		at91_set_A_periph(AT91_PIN_PC1, 0);	/* SPI1_MOSI */
-		at91_set_A_periph(AT91_PIN_PC2, 0);	/* SPI1_SPCK */
-
-		at91_clock_associate("spi1_clk", &at572d940hf_spi1_device.dev, "spi_clk");
-		platform_device_register(&at572d940hf_spi1_device);
-	}
-}
-#else
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Timer/Counter blocks
  * -------------------------------------------------------------------- */
@@ -661,6 +577,8 @@ static struct at91_device_table at572d940hf_device_table __initdata = {
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi0,
 	.twi[1]		= &device_twi1,
+	.spi[0]		= &device_spi0,
+	.spi[1]		= &device_spi1,
 };
 
 void __init at572d940hf_init_devices(void)
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index a647963..a54b6a5 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -251,114 +251,30 @@ static struct at91_dev_table_twi device_twi __initdata = {
  *  SPI
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct resource spi0_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_SPI0,
-		.end	= AT91CAP9_BASE_SPI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_SPI0,
-		.end	= AT91CAP9_ID_SPI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_spi0_device = {
-	.name		= "atmel_spi",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
+static struct at91_dev_table_spi device_spi0 __initdata = {
+	.mmio_base		= AT91CAP9_BASE_SPI0,
+	.irq			= AT91CAP9_ID_SPI0,
+	.clk_asc		= "spi0_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PA5, AT91_PIN_PA3, AT91_PIN_PD0, AT91_PIN_PD1,
 	},
-	.resource	= spi0_resources,
-	.num_resources	= ARRAY_SIZE(spi0_resources),
+	.pin_miso		= {AT91_PIN_PA0, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PA1, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PA2, AT91_PIN_PERIPH_B, 0, 0, 0},
 };
 
-static const unsigned spi0_standard_cs[4] = { AT91_PIN_PA5, AT91_PIN_PA3, AT91_PIN_PD0, AT91_PIN_PD1 };
-
-static struct resource spi1_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_SPI1,
-		.end	= AT91CAP9_BASE_SPI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_SPI1,
-		.end	= AT91CAP9_ID_SPI1,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_spi device_spi1 __initdata = {
+	.mmio_base		= AT91CAP9_BASE_SPI1,
+	.irq			= AT91CAP9_ID_SPI1,
+	.clk_asc		= "spi1_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PB15, AT91_PIN_PB16, AT91_PIN_PB17, AT91_PIN_PB18,
 	},
+	.pin_miso		= {AT91_PIN_PB12, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PC13, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PC14, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static struct platform_device at91cap9_spi1_device = {
-	.name		= "atmel_spi",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= spi1_resources,
-	.num_resources	= ARRAY_SIZE(spi1_resources),
-};
-
-static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB15, AT91_PIN_PB16, AT91_PIN_PB17, AT91_PIN_PB18 };
-
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
-{
-	int i;
-	unsigned long cs_pin;
-	short enable_spi0 = 0;
-	short enable_spi1 = 0;
-
-	/* Choose SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else if (devices[i].bus_num == 0)
-			cs_pin = spi0_standard_cs[devices[i].chip_select];
-		else
-			cs_pin = spi1_standard_cs[devices[i].chip_select];
-
-		if (devices[i].bus_num == 0)
-			enable_spi0 = 1;
-		else
-			enable_spi1 = 1;
-
-		/* enable chip-select pin */
-		at91_set_gpio_output(cs_pin, 1);
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
-
-	spi_register_board_info(devices, nr_devices);
-
-	/* Configure SPI bus(es) */
-	if (enable_spi0) {
-		at91_set_B_periph(AT91_PIN_PA0, 0);	/* SPI0_MISO */
-		at91_set_B_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
-		at91_set_B_periph(AT91_PIN_PA2, 0);	/* SPI0_SPCK */
-
-		at91_clock_associate("spi0_clk", &at91cap9_spi0_device.dev, "spi_clk");
-		platform_device_register(&at91cap9_spi0_device);
-	}
-	if (enable_spi1) {
-		at91_set_A_periph(AT91_PIN_PB12, 0);	/* SPI1_MISO */
-		at91_set_A_periph(AT91_PIN_PB13, 0);	/* SPI1_MOSI */
-		at91_set_A_periph(AT91_PIN_PB14, 0);	/* SPI1_SPCK */
-
-		at91_clock_associate("spi1_clk", &at91cap9_spi1_device.dev, "spi_clk");
-		platform_device_register(&at91cap9_spi1_device);
-	}
-}
-#else
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Timer/Counter block
  * -------------------------------------------------------------------- */
@@ -989,6 +905,8 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.mmc[1]		= &device_mmc1,
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi,
+	.spi[0]		= &device_spi0,
+	.spi[1]		= &device_spi1,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index a889114..6567e3c 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -235,69 +235,17 @@ static struct at91_dev_table_twi device_twi __initdata = {
  *  SPI
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct resource spi_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_SPI,
-		.end	= AT91RM9200_BASE_SPI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_SPI,
-		.end	= AT91RM9200_ID_SPI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91rm9200_spi_device = {
-	.name		= "atmel_spi",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
+static struct at91_dev_table_spi device_spi __initdata = {
+	.mmio_base		= AT91RM9200_BASE_SPI,
+	.irq			= AT91RM9200_ID_SPI,
+	.standard_cs_pins	= {
+		AT91_PIN_PA3, AT91_PIN_PA4, AT91_PIN_PA5, AT91_PIN_PA6,
 	},
-	.resource	= spi_resources,
-	.num_resources	= ARRAY_SIZE(spi_resources),
+	.pin_miso		= {AT91_PIN_PA0, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PA1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PA2, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static const unsigned spi_standard_cs[4] = { AT91_PIN_PA3, AT91_PIN_PA4, AT91_PIN_PA5, AT91_PIN_PA6 };
-
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
-{
-	int i;
-	unsigned long cs_pin;
-
-	at91_set_A_periph(AT91_PIN_PA0, 0);	/* MISO */
-	at91_set_A_periph(AT91_PIN_PA1, 0);	/* MOSI */
-	at91_set_A_periph(AT91_PIN_PA2, 0);	/* SPCK */
-
-	/* Enable SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else
-			cs_pin = spi_standard_cs[devices[i].chip_select];
-
-		if (devices[i].chip_select == 0)	/* for CS0 errata */
-			at91_set_A_periph(cs_pin, 0);
-		else
-			at91_set_gpio_output(cs_pin, 1);
-
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
-
-	spi_register_board_info(devices, nr_devices);
-	platform_device_register(&at91rm9200_spi_device);
-}
-#else
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Timer/Counter blocks
  * -------------------------------------------------------------------- */
@@ -899,6 +847,7 @@ static struct at91_device_table at91rm9200_device_table __initdata = {
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi,
+	.spi[0]		= &device_spi,
 };
 
 void __init at91rm9200_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index ed2e071..9ccb731 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -136,114 +136,30 @@ static struct at91_dev_table_twi device_twi __initdata = {
  *  SPI
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct resource spi0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_SPI0,
-		.end	= AT91SAM9260_BASE_SPI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_SPI0,
-		.end	= AT91SAM9260_ID_SPI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9260_spi0_device = {
-	.name		= "atmel_spi",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
+static struct at91_dev_table_spi device_spi0 __initdata = {
+	.mmio_base		= AT91SAM9260_BASE_SPI0,
+	.irq			= AT91SAM9260_ID_SPI0,
+	.clk_asc		= "spi0_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PA3, AT91_PIN_PC11, AT91_PIN_PC16, AT91_PIN_PC17,
 	},
-	.resource	= spi0_resources,
-	.num_resources	= ARRAY_SIZE(spi0_resources),
+	.pin_miso		= {AT91_PIN_PA0, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PA1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PA2, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static const unsigned spi0_standard_cs[4] = { AT91_PIN_PA3, AT91_PIN_PC11, AT91_PIN_PC16, AT91_PIN_PC17 };
-
-static struct resource spi1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_SPI1,
-		.end	= AT91SAM9260_BASE_SPI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_SPI1,
-		.end	= AT91SAM9260_ID_SPI1,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_spi device_spi1 __initdata = {
+	.mmio_base		= AT91SAM9260_BASE_SPI1,
+	.irq			= AT91SAM9260_ID_SPI1,
+	.clk_asc		= "spi1_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PB3, AT91_PIN_PC5, AT91_PIN_PC4, AT91_PIN_PC3,
 	},
+	.pin_miso		= {AT91_PIN_PB0, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PB1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PB2, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static struct platform_device at91sam9260_spi1_device = {
-	.name		= "atmel_spi",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= spi1_resources,
-	.num_resources	= ARRAY_SIZE(spi1_resources),
-};
-
-static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB3, AT91_PIN_PC5, AT91_PIN_PC4, AT91_PIN_PC3 };
-
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
-{
-	int i;
-	unsigned long cs_pin;
-	short enable_spi0 = 0;
-	short enable_spi1 = 0;
-
-	/* Choose SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else if (devices[i].bus_num == 0)
-			cs_pin = spi0_standard_cs[devices[i].chip_select];
-		else
-			cs_pin = spi1_standard_cs[devices[i].chip_select];
-
-		if (devices[i].bus_num == 0)
-			enable_spi0 = 1;
-		else
-			enable_spi1 = 1;
-
-		/* enable chip-select pin */
-		at91_set_gpio_output(cs_pin, 1);
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
-
-	spi_register_board_info(devices, nr_devices);
-
-	/* Configure SPI bus(es) */
-	if (enable_spi0) {
-		at91_set_A_periph(AT91_PIN_PA0, 0);	/* SPI0_MISO */
-		at91_set_A_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
-		at91_set_A_periph(AT91_PIN_PA2, 0);	/* SPI1_SPCK */
-
-		at91_clock_associate("spi0_clk", &at91sam9260_spi0_device.dev, "spi_clk");
-		platform_device_register(&at91sam9260_spi0_device);
-	}
-	if (enable_spi1) {
-		at91_set_A_periph(AT91_PIN_PB0, 0);	/* SPI1_MISO */
-		at91_set_A_periph(AT91_PIN_PB1, 0);	/* SPI1_MOSI */
-		at91_set_A_periph(AT91_PIN_PB2, 0);	/* SPI1_SPCK */
-
-		at91_clock_associate("spi1_clk", &at91sam9260_spi1_device.dev, "spi_clk");
-		platform_device_register(&at91sam9260_spi1_device);
-	}
-}
-#else
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Timer/Counter blocks
  * -------------------------------------------------------------------- */
@@ -951,6 +867,8 @@ static struct at91_device_table at91sam9260_device_table __initdata = {
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi,
+	.spi[0]		= &device_spi0,
+	.spi[1]		= &device_spi1,
 };
 
 void __init at91sam9260_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 15c701b..dd19119 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -99,114 +99,30 @@ static struct at91_dev_table_twi device_twi __initdata = {
  *  SPI
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct resource spi0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_SPI0,
-		.end	= AT91SAM9261_BASE_SPI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_SPI0,
-		.end	= AT91SAM9261_ID_SPI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9261_spi0_device = {
-	.name		= "atmel_spi",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
+static struct at91_dev_table_spi device_spi0 __initdata = {
+	.mmio_base		= AT91SAM9261_BASE_SPI0,
+	.irq			= AT91SAM9261_ID_SPI0,
+	.clk_asc		= "spi0_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PA3, AT91_PIN_PA4, AT91_PIN_PA5, AT91_PIN_PA6,
 	},
-	.resource	= spi0_resources,
-	.num_resources	= ARRAY_SIZE(spi0_resources),
+	.pin_miso		= {AT91_PIN_PA0, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PA1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PA2, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static const unsigned spi0_standard_cs[4] = { AT91_PIN_PA3, AT91_PIN_PA4, AT91_PIN_PA5, AT91_PIN_PA6 };
-
-static struct resource spi1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_SPI1,
-		.end	= AT91SAM9261_BASE_SPI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_SPI1,
-		.end	= AT91SAM9261_ID_SPI1,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_spi device_spi1 __initdata = {
+	.mmio_base		= AT91SAM9261_BASE_SPI1,
+	.irq			= AT91SAM9261_ID_SPI1,
+	.clk_asc		= "spi1_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PB28, AT91_PIN_PA24, AT91_PIN_PA25, AT91_PIN_PA26,
 	},
+	.pin_miso		= {AT91_PIN_PB30, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PB31, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PB29, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static struct platform_device at91sam9261_spi1_device = {
-	.name		= "atmel_spi",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= spi1_resources,
-	.num_resources	= ARRAY_SIZE(spi1_resources),
-};
-
-static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB28, AT91_PIN_PA24, AT91_PIN_PA25, AT91_PIN_PA26 };
-
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
-{
-	int i;
-	unsigned long cs_pin;
-	short enable_spi0 = 0;
-	short enable_spi1 = 0;
-
-	/* Choose SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else if (devices[i].bus_num == 0)
-			cs_pin = spi0_standard_cs[devices[i].chip_select];
-		else
-			cs_pin = spi1_standard_cs[devices[i].chip_select];
-
-		if (devices[i].bus_num == 0)
-			enable_spi0 = 1;
-		else
-			enable_spi1 = 1;
-
-		/* enable chip-select pin */
-		at91_set_gpio_output(cs_pin, 1);
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
-
-	spi_register_board_info(devices, nr_devices);
-
-	/* Configure SPI bus(es) */
-	if (enable_spi0) {
-		at91_set_A_periph(AT91_PIN_PA0, 0);	/* SPI0_MISO */
-		at91_set_A_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
-		at91_set_A_periph(AT91_PIN_PA2, 0);	/* SPI0_SPCK */
-
-		at91_clock_associate("spi0_clk", &at91sam9261_spi0_device.dev, "spi_clk");
-		platform_device_register(&at91sam9261_spi0_device);
-	}
-	if (enable_spi1) {
-		at91_set_A_periph(AT91_PIN_PB30, 0);	/* SPI1_MISO */
-		at91_set_A_periph(AT91_PIN_PB31, 0);	/* SPI1_MOSI */
-		at91_set_A_periph(AT91_PIN_PB29, 0);	/* SPI1_SPCK */
-
-		at91_clock_associate("spi1_clk", &at91sam9261_spi1_device.dev, "spi_clk");
-		platform_device_register(&at91sam9261_spi1_device);
-	}
-}
-#else
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  LCD Controller
  * -------------------------------------------------------------------- */
@@ -814,6 +730,8 @@ static struct at91_device_table at91sam9261_device_table __initdata = {
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi,
+	.spi[0]		= &device_spi0,
+	.spi[1]		= &device_spi1,
 };
 
 void __init at91sam9261_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index d0580ef..b049f93 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -271,114 +271,30 @@ static struct at91_dev_table_twi device_twi __initdata = {
  *  SPI
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct resource spi0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_SPI0,
-		.end	= AT91SAM9263_BASE_SPI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_SPI0,
-		.end	= AT91SAM9263_ID_SPI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9263_spi0_device = {
-	.name		= "atmel_spi",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
+static struct at91_dev_table_spi device_spi0 __initdata = {
+	.mmio_base		= AT91SAM9263_BASE_SPI0,
+	.irq			= AT91SAM9263_ID_SPI0,
+	.clk_asc		= "spi0_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PA5, AT91_PIN_PA3, AT91_PIN_PA4, AT91_PIN_PB11,
 	},
-	.resource	= spi0_resources,
-	.num_resources	= ARRAY_SIZE(spi0_resources),
+	.pin_miso		= {AT91_PIN_PA0, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PA1, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PA2, AT91_PIN_PERIPH_B, 0, 0, 0},
 };
 
-static const unsigned spi0_standard_cs[4] = { AT91_PIN_PA5, AT91_PIN_PA3, AT91_PIN_PA4, AT91_PIN_PB11 };
-
-static struct resource spi1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_SPI1,
-		.end	= AT91SAM9263_BASE_SPI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_SPI1,
-		.end	= AT91SAM9263_ID_SPI1,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_spi device_spi1 __initdata = {
+	.mmio_base		= AT91SAM9263_BASE_SPI1,
+	.irq			= AT91SAM9263_ID_SPI1,
+	.clk_asc		= "spi1_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PB15, AT91_PIN_PB16, AT91_PIN_PB17, AT91_PIN_PB18,
 	},
+	.pin_miso		= {AT91_PIN_PB12, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PB13, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PB14, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static struct platform_device at91sam9263_spi1_device = {
-	.name		= "atmel_spi",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= spi1_resources,
-	.num_resources	= ARRAY_SIZE(spi1_resources),
-};
-
-static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB15, AT91_PIN_PB16, AT91_PIN_PB17, AT91_PIN_PB18 };
-
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
-{
-	int i;
-	unsigned long cs_pin;
-	short enable_spi0 = 0;
-	short enable_spi1 = 0;
-
-	/* Choose SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else if (devices[i].bus_num == 0)
-			cs_pin = spi0_standard_cs[devices[i].chip_select];
-		else
-			cs_pin = spi1_standard_cs[devices[i].chip_select];
-
-		if (devices[i].bus_num == 0)
-			enable_spi0 = 1;
-		else
-			enable_spi1 = 1;
-
-		/* enable chip-select pin */
-		at91_set_gpio_output(cs_pin, 1);
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
-
-	spi_register_board_info(devices, nr_devices);
-
-	/* Configure SPI bus(es) */
-	if (enable_spi0) {
-		at91_set_B_periph(AT91_PIN_PA0, 0);	/* SPI0_MISO */
-		at91_set_B_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
-		at91_set_B_periph(AT91_PIN_PA2, 0);	/* SPI0_SPCK */
-
-		at91_clock_associate("spi0_clk", &at91sam9263_spi0_device.dev, "spi_clk");
-		platform_device_register(&at91sam9263_spi0_device);
-	}
-	if (enable_spi1) {
-		at91_set_A_periph(AT91_PIN_PB12, 0);	/* SPI1_MISO */
-		at91_set_A_periph(AT91_PIN_PB13, 0);	/* SPI1_MOSI */
-		at91_set_A_periph(AT91_PIN_PB14, 0);	/* SPI1_SPCK */
-
-		at91_clock_associate("spi1_clk", &at91sam9263_spi1_device.dev, "spi_clk");
-		platform_device_register(&at91sam9263_spi1_device);
-	}
-}
-#else
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  AC97
  * -------------------------------------------------------------------- */
@@ -1109,6 +1025,8 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.mmc[1]		= &device_mmc1,
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi,
+	.spi[0]		= &device_spi0,
+	.spi[1]		= &device_spi1,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 7b83b0b..b25c0cc 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -303,114 +303,30 @@ static struct at91_dev_table_twi device_twi1 __initdata = {
  *  SPI
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct resource spi0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_SPI0,
-		.end	= AT91SAM9G45_BASE_SPI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_SPI0,
-		.end	= AT91SAM9G45_ID_SPI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9g45_spi0_device = {
-	.name		= "atmel_spi",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
+static struct at91_dev_table_spi device_spi0 __initdata = {
+	.mmio_base		= AT91SAM9G45_BASE_SPI0,
+	.irq			= AT91SAM9G45_ID_SPI0,
+	.clk_asc		= "spi0_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PB3, AT91_PIN_PB18, AT91_PIN_PB19, AT91_PIN_PD27,
 	},
-	.resource	= spi0_resources,
-	.num_resources	= ARRAY_SIZE(spi0_resources),
+	.pin_miso		= {AT91_PIN_PB0, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PB1, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PB2, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static const unsigned spi0_standard_cs[4] = { AT91_PIN_PB3, AT91_PIN_PB18, AT91_PIN_PB19, AT91_PIN_PD27 };
-
-static struct resource spi1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_SPI1,
-		.end	= AT91SAM9G45_BASE_SPI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_SPI1,
-		.end	= AT91SAM9G45_ID_SPI1,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_spi device_spi1 __initdata = {
+	.mmio_base		= AT91SAM9G45_BASE_SPI1,
+	.irq			= AT91SAM9G45_ID_SPI1,
+	.clk_asc		= "spi1_clk",
+	.standard_cs_pins	= {
+		AT91_PIN_PB17, AT91_PIN_PD28, AT91_PIN_PD18, AT91_PIN_PD19,
 	},
+	.pin_miso		= {AT91_PIN_PB14, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PB15, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PB16, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static struct platform_device at91sam9g45_spi1_device = {
-	.name		= "atmel_spi",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= spi1_resources,
-	.num_resources	= ARRAY_SIZE(spi1_resources),
-};
-
-static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB17, AT91_PIN_PD28, AT91_PIN_PD18, AT91_PIN_PD19 };
-
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
-{
-	int i;
-	unsigned long cs_pin;
-	short enable_spi0 = 0;
-	short enable_spi1 = 0;
-
-	/* Choose SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else if (devices[i].bus_num == 0)
-			cs_pin = spi0_standard_cs[devices[i].chip_select];
-		else
-			cs_pin = spi1_standard_cs[devices[i].chip_select];
-
-		if (devices[i].bus_num == 0)
-			enable_spi0 = 1;
-		else
-			enable_spi1 = 1;
-
-		/* enable chip-select pin */
-		at91_set_gpio_output(cs_pin, 1);
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
-
-	spi_register_board_info(devices, nr_devices);
-
-	/* Configure SPI bus(es) */
-	if (enable_spi0) {
-		at91_set_A_periph(AT91_PIN_PB0, 0);	/* SPI0_MISO */
-		at91_set_A_periph(AT91_PIN_PB1, 0);	/* SPI0_MOSI */
-		at91_set_A_periph(AT91_PIN_PB2, 0);	/* SPI0_SPCK */
-
-		at91_clock_associate("spi0_clk", &at91sam9g45_spi0_device.dev, "spi_clk");
-		platform_device_register(&at91sam9g45_spi0_device);
-	}
-	if (enable_spi1) {
-		at91_set_A_periph(AT91_PIN_PB14, 0);	/* SPI1_MISO */
-		at91_set_A_periph(AT91_PIN_PB15, 0);	/* SPI1_MOSI */
-		at91_set_A_periph(AT91_PIN_PB16, 0);	/* SPI1_SPCK */
-
-		at91_clock_associate("spi1_clk", &at91sam9g45_spi1_device.dev, "spi_clk");
-		platform_device_register(&at91sam9g45_spi1_device);
-	}
-}
-#else
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  AC97
  * -------------------------------------------------------------------- */
@@ -1189,6 +1105,8 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi0,
 	.twi[1]		= &device_twi1,
+	.spi[0]		= &device_spi0,
+	.spi[1]		= &device_spi1,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 2b24e7d..55a0918 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -212,67 +212,17 @@ static struct at91_dev_table_twi device_twi __initdata = {
  *  SPI
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct resource spi_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_SPI,
-		.end	= AT91SAM9RL_BASE_SPI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_SPI,
-		.end	= AT91SAM9RL_ID_SPI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9rl_spi_device = {
-	.name		= "atmel_spi",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
+static struct at91_dev_table_spi device_spi __initdata = {
+	.mmio_base		= AT91SAM9RL_BASE_SPI,
+	.irq			= AT91SAM9RL_ID_SPI,
+	.standard_cs_pins	= {
+		AT91_PIN_PA28, AT91_PIN_PB7, AT91_PIN_PD8, AT91_PIN_PD9,
 	},
-	.resource	= spi_resources,
-	.num_resources	= ARRAY_SIZE(spi_resources),
+	.pin_miso		= {AT91_PIN_PA25, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_mosi		= {AT91_PIN_PA26, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.pin_spck		= {AT91_PIN_PA27, AT91_PIN_PERIPH_A, 0, 0, 0},
 };
 
-static const unsigned spi_standard_cs[4] = { AT91_PIN_PA28, AT91_PIN_PB7, AT91_PIN_PD8, AT91_PIN_PD9 };
-
-
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
-{
-	int i;
-	unsigned long cs_pin;
-
-	at91_set_A_periph(AT91_PIN_PA25, 0);	/* MISO */
-	at91_set_A_periph(AT91_PIN_PA26, 0);	/* MOSI */
-	at91_set_A_periph(AT91_PIN_PA27, 0);	/* SPCK */
-
-	/* Enable SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else
-			cs_pin = spi_standard_cs[devices[i].chip_select];
-
-		/* enable chip-select pin */
-		at91_set_gpio_output(cs_pin, 1);
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
-
-	spi_register_board_info(devices, nr_devices);
-	platform_device_register(&at91sam9rl_spi_device);
-}
-#else
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  AC97
  * -------------------------------------------------------------------- */
@@ -1035,6 +985,7 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
 	.twi[0]		= &device_twi,
+	.spi[0]		= &device_spi,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 3e26082..9ba2508 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -595,6 +595,89 @@ void __init at91_add_device_i2c(short i2c_id,
 				int nr_devices) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  SPI
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_spi_devices[] = {
+	[0] = {
+		.name	= "atmel_spi",
+		.id	= 0,
+		.dev	= {
+			.dma_mask		= &spi_dmamask,
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},
+	[1] = {
+		.name	= "atmel_spi",
+		.id	= 1,
+		.dev	= {
+			.dma_mask		= &spi_dmamask,
+			.coherent_dma_mask	= DMA_BIT_MASK(32),
+		},
+	},
+};
+
+static int spi_bus_enabled[2] __initdata = {0};
+
+void __init at91_add_device_spi(struct spi_board_info *spi_devices,
+				int nr_devices)
+{
+	struct at91_dev_table_spi *info;
+	struct resource resources[2] = {{0}};
+	unsigned long cs_pin;	
+	int spi_bus, i;
+
+	/* Choose SPI chip-selects */
+	for (i = 0; i < nr_devices; i++) {
+		info = devices->spi[spi_devices[i].bus_num];
+		BUG_ON(!info);
+		spi_bus = spi_devices[i].bus_num;
+
+		if (spi_devices[i].controller_data)
+			cs_pin = (unsigned long)spi_devices[i].controller_data;
+		else
+			cs_pin = info->standard_cs_pins[spi_devices[i].chip_select];
+
+		/* enable chip-select pin */
+		at91_set_gpio_output(cs_pin, 1);
+
+		/* pass chip-select pin to driver */
+		spi_devices[i].controller_data = (void *)cs_pin;
+
+		at91_config_pins(&info->pin_miso, 1);
+		at91_config_pins(&info->pin_mosi, 1);
+		at91_config_pins(&info->pin_spck, 1);
+
+
+		if (!spi_bus_enabled[spi_bus]) {
+			init_resource_mem(&resources[0], info->mmio_base, 
+					  SZ_16K);
+			init_resource_irq(&resources[1], info->irq);
+			
+			if (info->clk_asc)
+				at91_clock_associate(info->clk_asc,
+						     &at91_spi_devices[spi_bus].dev,
+						     "spi_clk");
+			at91_add_platform_device(&at91_spi_devices[spi_bus],
+						 resources, 
+						 ARRAY_SIZE(resources),
+						 NULL, 0);
+
+			spi_bus_enabled[spi_bus] = 1;
+		}
+
+	}
+
+	spi_register_board_info(spi_devices, nr_devices);
+}
+#else
+void __init at91_add_device_spi(struct spi_board_info *spi_devices, int nr_devices) {}
+#endif
+
 void __init at91_init_devices(struct at91_device_table *device_table)
 {
 	devices = device_table;
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 9b99be2..ba85523 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -81,6 +81,16 @@ struct at91_dev_table_twi {
 	int			udelay;		/* For i2c-gpio */
 };
 
+struct at91_dev_table_spi {
+	unsigned		mmio_base;
+	int			irq;
+	const char		*clk_asc;
+	int			standard_cs_pins[4];
+	struct at91_pin_config	pin_miso;
+	struct at91_pin_config	pin_mosi;
+	struct at91_pin_config	pin_spck;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -89,6 +99,7 @@ struct at91_device_table {
 	struct at91_dev_table_mmc		*mmc[2];
 	struct at91_dev_table_nand		*nand;
 	struct at91_dev_table_twi		*twi[2];
+	struct at91_dev_table_spi		*spi[2];
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
