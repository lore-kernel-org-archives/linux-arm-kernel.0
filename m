From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:21 +1200
Subject: [PATCH V4 07/23] at91: Make TWI device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-8-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual TWI code for each at91 variant with a single
implementation in devices.c

The AT91SAM9G45 has an additional argument to at91_add_device_i2c for
the bus number. We change the other variants to use this API for
consistency.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c  |  111 +++--------------------
 arch/arm/mach-at91/at91cap9_devices.c     |   76 ++---------------
 arch/arm/mach-at91/at91rm9200_devices.c   |   77 ++---------------
 arch/arm/mach-at91/at91sam9260_devices.c  |   78 ++---------------
 arch/arm/mach-at91/at91sam9261_devices.c  |   77 ++---------------
 arch/arm/mach-at91/at91sam9263_devices.c  |   77 ++---------------
 arch/arm/mach-at91/at91sam9g45_devices.c  |  136 +++--------------------------
 arch/arm/mach-at91/at91sam9rl_devices.c   |   77 ++---------------
 arch/arm/mach-at91/board-afeb-9260v1.c    |    2 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c |    2 +-
 arch/arm/mach-at91/board-cap9adk.c        |    2 +-
 arch/arm/mach-at91/board-carmeva.c        |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c       |    2 +-
 arch/arm/mach-at91/board-cpuat91.c        |    2 +-
 arch/arm/mach-at91/board-csb337.c         |    2 +-
 arch/arm/mach-at91/board-csb637.c         |    2 +-
 arch/arm/mach-at91/board-eb9200.c         |    2 +-
 arch/arm/mach-at91/board-ecbat91.c        |    2 +-
 arch/arm/mach-at91/board-foxg20.c         |    2 +-
 arch/arm/mach-at91/board-gsia18s.c        |    2 +-
 arch/arm/mach-at91/board-kafa.c           |    2 +-
 arch/arm/mach-at91/board-kb9202.c         |    2 +-
 arch/arm/mach-at91/board-neocore926.c     |    2 +-
 arch/arm/mach-at91/board-pcontrol-g20.c   |    2 +-
 arch/arm/mach-at91/board-picotux200.c     |    2 +-
 arch/arm/mach-at91/board-qil-a9260.c      |    2 +-
 arch/arm/mach-at91/board-rm9200dk.c       |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c       |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c     |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c      |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c      |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c      |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c      |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c       |    2 +-
 arch/arm/mach-at91/board-snapper9260.c    |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c      |    4 +-
 arch/arm/mach-at91/board-usb-a9260.c      |    2 +-
 arch/arm/mach-at91/board-usb-a9263.c      |    2 +-
 arch/arm/mach-at91/board-yl-9200.c        |    2 +-
 arch/arm/mach-at91/devices.c              |   88 +++++++++++++++++++
 arch/arm/mach-at91/devices.h              |    9 ++
 arch/arm/mach-at91/include/mach/board.h   |    4 -
 42 files changed, 199 insertions(+), 675 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 771e1bf..482de24 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -122,107 +122,22 @@ static struct at91_dev_table_nand device_nand __initdata = {
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
 
-/*
- * Prefer the GPIO code since the TWI controller isn't robust
- * (gets overruns and underruns under load) and can only issue
- * repeated STARTs in one scenario (the driver doesn't yet handle them).
- */
-
-#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
-
-static struct i2c_gpio_platform_data pdata = {
-	.sda_pin		= AT91_PIN_PC7,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PC8,
-	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
-};
-
-static struct platform_device at572d940hf_twi_device {
-	.name			= "i2c-gpio",
-	.id			= -1,
-	.dev.platform_data	= &pdata,
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	at91_set_GPIO_periph(AT91_PIN_PC7, 1);		/* TWD (SDA) */
-	at91_set_multi_drive(AT91_PIN_PC7, 1);
-
-	at91_set_GPIO_periph(AT91_PIN_PA8, 1);		/* TWCK (SCL) */
-	at91_set_multi_drive(AT91_PIN_PC8, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at572d940hf_twi_device);
-}
-
-#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
-
-static struct resource twi0_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_TWI0,
-		.end	= AT572D940HF_BASE_TWI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_TWI0,
-		.end	= AT572D940HF_ID_TWI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at572d940hf_twi0_device = {
-	.name		= "at91_i2c",
-	.id		= 0,
-	.resource	= twi0_resources,
-	.num_resources	= ARRAY_SIZE(twi0_resources),
+static struct at91_dev_table_twi device_twi0 __initdata = {
+	.mmio_base	= AT572D940HF_BASE_TWI0,
+	.irq		= AT572D940HF_ID_TWI0,
+	.sda_pin 	= {AT91_PIN_PC7, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PC8, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.udelay		= 2,
 };
 
-static struct resource twi1_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_TWI1,
-		.end	= AT572D940HF_BASE_TWI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_TWI1,
-		.end	= AT572D940HF_ID_TWI1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at572d940hf_twi1_device = {
-	.name		= "at91_i2c",
-	.id		= 1,
-	.resource	= twi1_resources,
-	.num_resources	= ARRAY_SIZE(twi1_resources),
+static struct at91_dev_table_twi device_twi1 __initdata = {
+	.mmio_base	= AT572D940HF_BASE_TWI1,
+	.irq		= AT572D940HF_ID_TWI1,
+	.sda_pin 	= {AT91_PIN_PC7, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PC8, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.udelay		= 2,
 };
 
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	/* pins used for TWI0 interface */
-	at91_set_A_periph(AT91_PIN_PC7, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PC7, 1);
-
-	at91_set_A_periph(AT91_PIN_PC8, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PC8, 1);
-
-	/* pins used for TWI1 interface */
-	at91_set_A_periph(AT91_PIN_PC20, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PC20, 1);
-
-	at91_set_A_periph(AT91_PIN_PC21, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PC21, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at572d940hf_twi0_device);
-	platform_device_register(&at572d940hf_twi1_device);
-}
-#else
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SPI
  * -------------------------------------------------------------------- */
@@ -744,6 +659,8 @@ static struct at91_device_table at572d940hf_device_table __initdata = {
 	.udc		= &device_udc,
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
+	.twi[0]		= &device_twi0,
+	.twi[1]		= &device_twi1,
 };
 
 void __init at572d940hf_init_devices(void)
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 773eb95..a647963 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -239,77 +239,14 @@ static struct at91_dev_table_nand device_nand __initdata = {
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
 
-/*
- * Prefer the GPIO code since the TWI controller isn't robust
- * (gets overruns and underruns under load) and can only issue
- * repeated STARTs in one scenario (the driver doesn't yet handle them).
- */
-#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
-
-static struct i2c_gpio_platform_data pdata = {
-	.sda_pin		= AT91_PIN_PB4,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PB5,
-	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
-};
-
-static struct platform_device at91cap9_twi_device = {
-	.name			= "i2c-gpio",
-	.id			= -1,
-	.dev.platform_data	= &pdata,
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	at91_set_GPIO_periph(AT91_PIN_PB4, 1);		/* TWD (SDA) */
-	at91_set_multi_drive(AT91_PIN_PB4, 1);
-
-	at91_set_GPIO_periph(AT91_PIN_PB5, 1);		/* TWCK (SCL) */
-	at91_set_multi_drive(AT91_PIN_PB5, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91cap9_twi_device);
-}
-
-#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
-
-static struct resource twi_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_TWI,
-		.end	= AT91CAP9_BASE_TWI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_TWI,
-		.end	= AT91CAP9_ID_TWI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_twi_device = {
-	.name		= "at91_i2c",
-	.id		= -1,
-	.resource	= twi_resources,
-	.num_resources	= ARRAY_SIZE(twi_resources),
+static struct at91_dev_table_twi device_twi __initdata = {
+	.mmio_base	= AT91CAP9_BASE_TWI,
+	.irq		= AT91CAP9_ID_TWI,
+	.sda_pin 	= {AT91_PIN_PB4, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PB5, AT91_PIN_PERIPH_B, 0, 0, 0},
+	.udelay		= 2,
 };
 
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	/* pins used for TWI interface */
-	at91_set_B_periph(AT91_PIN_PB4, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PB4, 1);
-
-	at91_set_B_periph(AT91_PIN_PB5, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PB5, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91cap9_twi_device);
-}
-#else
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices) {}
-#endif
-
 /* --------------------------------------------------------------------
  *  SPI
  * -------------------------------------------------------------------- */
@@ -1051,6 +988,7 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.mmc[0]		= &device_mmc0,
 	.mmc[1]		= &device_mmc1,
 	.nand		= &device_nand,
+	.twi[0]		= &device_twi,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 90ca534..a889114 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -223,78 +223,14 @@ static struct at91_dev_table_nand device_nand __initdata = {
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
 
-/*
- * Prefer the GPIO code since the TWI controller isn't robust
- * (gets overruns and underruns under load) and can only issue
- * repeated STARTs in one scenario (the driver doesn't yet handle them).
- */
-#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
-
-static struct i2c_gpio_platform_data pdata = {
-	.sda_pin		= AT91_PIN_PA25,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PA26,
-	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
-};
-
-static struct platform_device at91rm9200_twi_device = {
-	.name			= "i2c-gpio",
-	.id			= -1,
-	.dev.platform_data	= &pdata,
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	at91_set_GPIO_periph(AT91_PIN_PA25, 1);		/* TWD (SDA) */
-	at91_set_multi_drive(AT91_PIN_PA25, 1);
-
-	at91_set_GPIO_periph(AT91_PIN_PA26, 1);		/* TWCK (SCL) */
-	at91_set_multi_drive(AT91_PIN_PA26, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91rm9200_twi_device);
-}
-
-#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
-
-static struct resource twi_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_TWI,
-		.end	= AT91RM9200_BASE_TWI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_TWI,
-		.end	= AT91RM9200_ID_TWI,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_dev_table_twi device_twi __initdata = {
+	.mmio_base	= AT91RM9200_BASE_TWI,
+	.irq		= AT91RM9200_ID_TWI,
+	.sda_pin 	= {AT91_PIN_PA25, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PA26, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.udelay		= 2,
 };
 
-static struct platform_device at91rm9200_twi_device = {
-	.name		= "at91_i2c",
-	.id		= -1,
-	.resource	= twi_resources,
-	.num_resources	= ARRAY_SIZE(twi_resources),
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	/* pins used for TWI interface */
-	at91_set_A_periph(AT91_PIN_PA25, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PA25, 1);
-
-	at91_set_A_periph(AT91_PIN_PA26, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PA26, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91rm9200_twi_device);
-}
-#else
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SPI
  * -------------------------------------------------------------------- */
@@ -962,6 +898,7 @@ static struct at91_device_table at91rm9200_device_table __initdata = {
 	.udc		= &device_udc,
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
+	.twi[0]		= &device_twi,
 };
 
 void __init at91rm9200_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index f48ad70..ed2e071 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -124,79 +124,14 @@ static struct at91_dev_table_nand device_nand __initdata = {
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
 
-/*
- * Prefer the GPIO code since the TWI controller isn't robust
- * (gets overruns and underruns under load) and can only issue
- * repeated STARTs in one scenario (the driver doesn't yet handle them).
- */
-
-#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
-
-static struct i2c_gpio_platform_data pdata = {
-	.sda_pin		= AT91_PIN_PA23,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PA24,
-	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
+static struct at91_dev_table_twi device_twi __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_TWI,
+	.irq		= AT91SAM9260_ID_TWI,
+	.sda_pin 	= {AT91_PIN_PA23, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PA24, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.udelay		= 2,
 };
 
-static struct platform_device at91sam9260_twi_device = {
-	.name			= "i2c-gpio",
-	.id			= -1,
-	.dev.platform_data	= &pdata,
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	at91_set_GPIO_periph(AT91_PIN_PA23, 1);		/* TWD (SDA) */
-	at91_set_multi_drive(AT91_PIN_PA23, 1);
-
-	at91_set_GPIO_periph(AT91_PIN_PA24, 1);		/* TWCK (SCL) */
-	at91_set_multi_drive(AT91_PIN_PA24, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91sam9260_twi_device);
-}
-
-#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
-
-static struct resource twi_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_TWI,
-		.end	= AT91SAM9260_BASE_TWI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_TWI,
-		.end	= AT91SAM9260_ID_TWI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9260_twi_device = {
-	.name		= "at91_i2c",
-	.id		= -1,
-	.resource	= twi_resources,
-	.num_resources	= ARRAY_SIZE(twi_resources),
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	/* pins used for TWI interface */
-	at91_set_A_periph(AT91_PIN_PA23, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PA23, 1);
-
-	at91_set_A_periph(AT91_PIN_PA24, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PA24, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91sam9260_twi_device);
-}
-#else
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SPI
  * -------------------------------------------------------------------- */
@@ -1015,6 +950,7 @@ static struct at91_device_table at91sam9260_device_table __initdata = {
 	.udc		= &device_udc,
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
+	.twi[0]		= &device_twi,
 };
 
 void __init at91sam9260_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 9505ae3..15c701b 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -87,78 +87,14 @@ static struct at91_dev_table_nand device_nand __initdata = {
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
 
-/*
- * Prefer the GPIO code since the TWI controller isn't robust
- * (gets overruns and underruns under load) and can only issue
- * repeated STARTs in one scenario (the driver doesn't yet handle them).
- */
-#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
-
-static struct i2c_gpio_platform_data pdata = {
-	.sda_pin		= AT91_PIN_PA7,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PA8,
-	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
-};
-
-static struct platform_device at91sam9261_twi_device = {
-	.name			= "i2c-gpio",
-	.id			= -1,
-	.dev.platform_data	= &pdata,
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	at91_set_GPIO_periph(AT91_PIN_PA7, 1);		/* TWD (SDA) */
-	at91_set_multi_drive(AT91_PIN_PA7, 1);
-
-	at91_set_GPIO_periph(AT91_PIN_PA8, 1);		/* TWCK (SCL) */
-	at91_set_multi_drive(AT91_PIN_PA8, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91sam9261_twi_device);
-}
-
-#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
-
-static struct resource twi_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_TWI,
-		.end	= AT91SAM9261_BASE_TWI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_TWI,
-		.end	= AT91SAM9261_ID_TWI,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_dev_table_twi device_twi __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_TWI,
+	.irq		= AT91SAM9261_ID_TWI,
+	.sda_pin 	= {AT91_PIN_PA7, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PA8, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.udelay		= 2,
 };
 
-static struct platform_device at91sam9261_twi_device = {
-	.name		= "at91_i2c",
-	.id		= -1,
-	.resource	= twi_resources,
-	.num_resources	= ARRAY_SIZE(twi_resources),
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	/* pins used for TWI interface */
-	at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PA7, 1);
-
-	at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PA8, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91sam9261_twi_device);
-}
-#else
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SPI
  * -------------------------------------------------------------------- */
@@ -877,6 +813,7 @@ static struct at91_device_table at91sam9261_device_table __initdata = {
 	.udc		= &device_udc,
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
+	.twi[0]		= &device_twi,
 };
 
 void __init at91sam9261_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 37b06f7..d0580ef 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -259,78 +259,14 @@ static struct at91_dev_table_nand device_nand __initdata = {
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
 
-/*
- * Prefer the GPIO code since the TWI controller isn't robust
- * (gets overruns and underruns under load) and can only issue
- * repeated STARTs in one scenario (the driver doesn't yet handle them).
- */
-#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
-
-static struct i2c_gpio_platform_data pdata = {
-	.sda_pin		= AT91_PIN_PB4,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PB5,
-	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
-};
-
-static struct platform_device at91sam9263_twi_device = {
-	.name			= "i2c-gpio",
-	.id			= -1,
-	.dev.platform_data	= &pdata,
+static struct at91_dev_table_twi device_twi __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_TWI,
+	.irq		= AT91SAM9263_ID_TWI,
+	.sda_pin 	= {AT91_PIN_PB4, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PB5, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.udelay		= 2,
 };
 
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	at91_set_GPIO_periph(AT91_PIN_PB4, 1);		/* TWD (SDA) */
-	at91_set_multi_drive(AT91_PIN_PB4, 1);
-
-	at91_set_GPIO_periph(AT91_PIN_PB5, 1);		/* TWCK (SCL) */
-	at91_set_multi_drive(AT91_PIN_PB5, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91sam9263_twi_device);
-}
-
-#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
-
-static struct resource twi_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_TWI,
-		.end	= AT91SAM9263_BASE_TWI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_TWI,
-		.end	= AT91SAM9263_ID_TWI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9263_twi_device = {
-	.name		= "at91_i2c",
-	.id		= -1,
-	.resource	= twi_resources,
-	.num_resources	= ARRAY_SIZE(twi_resources),
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	/* pins used for TWI interface */
-	at91_set_A_periph(AT91_PIN_PB4, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PB4, 1);
-
-	at91_set_A_periph(AT91_PIN_PB5, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PB5, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91sam9263_twi_device);
-}
-#else
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SPI
  * -------------------------------------------------------------------- */
@@ -1172,6 +1108,7 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.mmc[0]		= &device_mmc0,
 	.mmc[1]		= &device_mmc1,
 	.nand		= &device_nand,
+	.twi[0]		= &device_twi,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 9650547..7b83b0b 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -283,132 +283,22 @@ static struct at91_dev_table_nand device_nand __initdata = {
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
 
-/*
- * Prefer the GPIO code since the TWI controller isn't robust
- * (gets overruns and underruns under load) and can only issue
- * repeated STARTs in one scenario (the driver doesn't yet handle them).
- */
-#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
-static struct i2c_gpio_platform_data pdata_i2c0 = {
-	.sda_pin		= AT91_PIN_PA20,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PA21,
-	.scl_is_open_drain	= 1,
-	.udelay			= 5,		/* ~100 kHz */
-};
-
-static struct platform_device at91sam9g45_twi0_device = {
-	.name			= "i2c-gpio",
-	.id			= 0,
-	.dev.platform_data	= &pdata_i2c0,
+static struct at91_dev_table_twi device_twi0 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_TWI0,
+	.irq		= AT91SAM9G45_ID_TWI0,
+	.sda_pin 	= {AT91_PIN_PA20, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PA21, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.udelay		= 5,
 };
 
-static struct i2c_gpio_platform_data pdata_i2c1 = {
-	.sda_pin		= AT91_PIN_PB10,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PB11,
-	.scl_is_open_drain	= 1,
-	.udelay			= 5,		/* ~100 kHz */
+static struct at91_dev_table_twi device_twi1 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_TWI1,
+	.irq		= AT91SAM9G45_ID_TWI1,
+	.sda_pin 	= {AT91_PIN_PB20, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PB21, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.udelay		= 5,
 };
 
-static struct platform_device at91sam9g45_twi1_device = {
-	.name			= "i2c-gpio",
-	.id			= 1,
-	.dev.platform_data	= &pdata_i2c1,
-};
-
-void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, int nr_devices)
-{
-	i2c_register_board_info(i2c_id, devices, nr_devices);
-
-	if (i2c_id == 0) {
-		at91_set_GPIO_periph(AT91_PIN_PA20, 1);		/* TWD (SDA) */
-		at91_set_multi_drive(AT91_PIN_PA20, 1);
-
-		at91_set_GPIO_periph(AT91_PIN_PA21, 1);		/* TWCK (SCL) */
-		at91_set_multi_drive(AT91_PIN_PA21, 1);
-
-		platform_device_register(&at91sam9g45_twi0_device);
-	} else {
-		at91_set_GPIO_periph(AT91_PIN_PB10, 1);		/* TWD (SDA) */
-		at91_set_multi_drive(AT91_PIN_PB10, 1);
-
-		at91_set_GPIO_periph(AT91_PIN_PB11, 1);		/* TWCK (SCL) */
-		at91_set_multi_drive(AT91_PIN_PB11, 1);
-
-		platform_device_register(&at91sam9g45_twi1_device);
-	}
-}
-
-#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
-static struct resource twi0_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_TWI0,
-		.end	= AT91SAM9G45_BASE_TWI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_TWI0,
-		.end	= AT91SAM9G45_ID_TWI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9g45_twi0_device = {
-	.name		= "at91_i2c",
-	.id		= 0,
-	.resource	= twi0_resources,
-	.num_resources	= ARRAY_SIZE(twi0_resources),
-};
-
-static struct resource twi1_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_TWI1,
-		.end	= AT91SAM9G45_BASE_TWI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_TWI1,
-		.end	= AT91SAM9G45_ID_TWI1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9g45_twi1_device = {
-	.name		= "at91_i2c",
-	.id		= 1,
-	.resource	= twi1_resources,
-	.num_resources	= ARRAY_SIZE(twi1_resources),
-};
-
-void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, int nr_devices)
-{
-	i2c_register_board_info(i2c_id, devices, nr_devices);
-
-	/* pins used for TWI interface */
-	if (i2c_id == 0) {
-		at91_set_A_periph(AT91_PIN_PA20, 0);		/* TWD */
-		at91_set_multi_drive(AT91_PIN_PA20, 1);
-
-		at91_set_A_periph(AT91_PIN_PA21, 0);		/* TWCK */
-		at91_set_multi_drive(AT91_PIN_PA21, 1);
-
-		platform_device_register(&at91sam9g45_twi0_device);
-	} else {
-		at91_set_A_periph(AT91_PIN_PB10, 0);		/* TWD */
-		at91_set_multi_drive(AT91_PIN_PB10, 1);
-
-		at91_set_A_periph(AT91_PIN_PB11, 0);		/* TWCK */
-		at91_set_multi_drive(AT91_PIN_PB11, 1);
-
-		platform_device_register(&at91sam9g45_twi1_device);
-	}
-}
-#else
-void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SPI
  * -------------------------------------------------------------------- */
@@ -1297,6 +1187,8 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.mmc[0]		= &device_mmc0,
 	.mmc[1]		= &device_mmc1,
 	.nand		= &device_nand,
+	.twi[0]		= &device_twi0,
+	.twi[1]		= &device_twi1,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index e0b7302..2b24e7d 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -200,78 +200,14 @@ static struct at91_dev_table_nand device_nand __initdata = {
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
 
-/*
- * Prefer the GPIO code since the TWI controller isn't robust
- * (gets overruns and underruns under load) and can only issue
- * repeated STARTs in one scenario (the driver doesn't yet handle them).
- */
-#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
-
-static struct i2c_gpio_platform_data pdata = {
-	.sda_pin		= AT91_PIN_PA23,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PA24,
-	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
-};
-
-static struct platform_device at91sam9rl_twi_device = {
-	.name			= "i2c-gpio",
-	.id			= -1,
-	.dev.platform_data	= &pdata,
+static struct at91_dev_table_twi device_twi __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_TWI0,
+	.irq		= AT91SAM9RL_ID_TWI0,
+	.sda_pin 	= {AT91_PIN_PA23, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.scl_pin	= {AT91_PIN_PA24, AT91_PIN_PERIPH_A, 0, 0, 0},
+	.udelay		= 2,
 };
 
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	at91_set_GPIO_periph(AT91_PIN_PA23, 1);		/* TWD (SDA) */
-	at91_set_multi_drive(AT91_PIN_PA23, 1);
-
-	at91_set_GPIO_periph(AT91_PIN_PA24, 1);		/* TWCK (SCL) */
-	at91_set_multi_drive(AT91_PIN_PA24, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91sam9rl_twi_device);
-}
-
-#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
-
-static struct resource twi_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_TWI0,
-		.end	= AT91SAM9RL_BASE_TWI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_TWI0,
-		.end	= AT91SAM9RL_ID_TWI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9rl_twi_device = {
-	.name		= "at91_i2c",
-	.id		= -1,
-	.resource	= twi_resources,
-	.num_resources	= ARRAY_SIZE(twi_resources),
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	/* pins used for TWI interface */
-	at91_set_A_periph(AT91_PIN_PA23, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PA23, 1);
-
-	at91_set_A_periph(AT91_PIN_PA24, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PA24, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91sam9rl_twi_device);
-}
-#else
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SPI
  * -------------------------------------------------------------------- */
@@ -1098,6 +1034,7 @@ void __init at91_add_device_serial(void) {}
 static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.mmc[0]		= &device_mmc,
 	.nand		= &device_nand,
+	.twi[0]		= &device_twi,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 88d08ae..c64b7d6 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -208,7 +208,7 @@ static void __init afeb9260_board_init(void)
 	/* MMC */
 	at91_add_device_mmc(0, &afeb9260_mmc_data);
 	/* I2C */
-	at91_add_device_i2c(afeb9260_i2c_devices,
+	at91_add_device_i2c(0, afeb9260_i2c_devices,
 			ARRAY_SIZE(afeb9260_i2c_devices));
 	/* Audio */
 	at91_add_device_ssc(AT91SAM9260_ID_SSC, ATMEL_SSC_TX);
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index c9ab05d..edbbce4 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -301,7 +301,7 @@ static void __init eb_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&eb_udc_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* NOR */
 	eb_add_device_nor();
 	/* NAND */
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index 0d60378..4fe8c55 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -390,7 +390,7 @@ static void __init cap9adk_board_init(void)
 	/* NOR Flash */
 	cap9adk_add_device_nor();
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* LCD Controller */
 	at91_add_device_lcdc(&cap9adk_lcdc_data);
 	/* AC97 */
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 9d007a8..b9033cb 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -149,7 +149,7 @@ static void __init carmeva_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&carmeva_udc_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* SPI */
 	at91_add_device_spi(carmeva_spi_devices, ARRAY_SIZE(carmeva_spi_devices));
 	/* Compact Flash */
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 65c6513..9a88ca0 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -361,7 +361,7 @@ static void __init cpu9krea_board_init(void)
 	/* MMC */
 	at91_add_device_mmc(0, &cpu9krea_mmc_data);
 	/* I2C */
-	at91_add_device_i2c(cpu9krea_i2c_devices,
+	at91_add_device_i2c(0, cpu9krea_i2c_devices,
 		ARRAY_SIZE(cpu9krea_i2c_devices));
 	/* LEDs */
 	at91_gpio_leds(cpu9krea_leds, ARRAY_SIZE(cpu9krea_leds));
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index ce3525d..fbdd54b 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -168,7 +168,7 @@ static void __init cpuat91_board_init(void)
 	/* MMC */
 	at91_add_device_mmc(0, &cpuat91_mmc_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* Platform devices */
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index ff7b8c0..f611720 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -239,7 +239,7 @@ static void __init csb337_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&csb337_udc_data);
 	/* I2C */
-	at91_add_device_i2c(csb337_i2c_devices, ARRAY_SIZE(csb337_i2c_devices));
+	at91_add_device_i2c(0, csb337_i2c_devices, ARRAY_SIZE(csb337_i2c_devices));
 	/* Compact Flash */
 	at91_set_gpio_input(AT91_PIN_PB22, 1);		/* IOIS16 */
 	at91_add_device_cf(&csb337_cf_data);
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 74d5b7e..bc26bf7 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -129,7 +129,7 @@ static void __init csb637_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&csb637_udc_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* SPI */
 	at91_add_device_spi(NULL, 0);
 	/* NOR flash */
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 3705082..eed4d6c 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -109,7 +109,7 @@ static void __init eb9200_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&eb9200_udc_data);
 	/* I2C */
-	at91_add_device_i2c(eb9200_i2c_devices, ARRAY_SIZE(eb9200_i2c_devices));
+	at91_add_device_i2c(0, eb9200_i2c_devices, ARRAY_SIZE(eb9200_i2c_devices));
 	/* Compact Flash */
 	at91_add_device_cf(&eb9200_cf_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index df4a07f..b730b01 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -157,7 +157,7 @@ static void __init ecb_at91board_init(void)
 	at91_add_device_usbh_ohci(&ecb_at91usbh_data);
 
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 
 	/* MMC */
 	at91_add_device_mmc(0, &ecb_at91mmc_data);
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index 6688ec2..79c54fc 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -254,7 +254,7 @@ static void __init foxg20_board_init(void)
 	/* MMC */
 	at91_add_device_mmc(0, &foxg20_mmc_data);
 	/* I2C */
-	at91_add_device_i2c(foxg20_i2c_devices, ARRAY_SIZE(foxg20_i2c_devices));
+	at91_add_device_i2c(0, foxg20_i2c_devices, ARRAY_SIZE(foxg20_i2c_devices));
 	/* LEDs */
 	at91_gpio_leds(foxg20_leds, ARRAY_SIZE(foxg20_leds));
 	/* Push Buttons */
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 8b1d498..e32833d 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -567,7 +567,7 @@ static void __init gsia18s_board_init(void)
 	gsia18s_leds_init();
 	gsia18s_pcf_leds_init();
 	gsia18s_add_device_buttons();
-	at91_add_device_i2c(gsia18s_i2c_devices,
+	at91_add_device_i2c(0, gsia18s_i2c_devices,
 				ARRAY_SIZE(gsia18s_i2c_devices));
 	at91_add_device_cf(&gsia18s_cf1_data);
 	at91_add_device_spi(gsia18s_spi_devices,
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index a0cac24..1edff1b 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -87,7 +87,7 @@ static void __init kafa_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&kafa_udc_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* SPI */
 	at91_add_device_spi(NULL, 0);
 }
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 59eafa2..682e9f4 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -127,7 +127,7 @@ static void __init kb9202_board_init(void)
 	/* MMC */
 	at91_add_device_mmc(0, &kb9202_mmc_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* SPI */
 	at91_add_device_spi(NULL, 0);
 	/* NAND */
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index bffbbdf..f2c79fb 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -373,7 +373,7 @@ static void __init neocore926_board_init(void)
 	neocore926_add_device_nand();
 
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 
 	/* LCD Controller */
 	at91_add_device_lcdc(&neocore926_lcdc_data);
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 4c5848d..ad9cc28 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -207,7 +207,7 @@ static void __init pcontrol_g20_board_init(void)
 	stamp9g20_board_init();
 	at91_add_device_usbh_ohci(&usbh_data);
 	at91_add_device_eth(&macb_data);
-	at91_add_device_i2c(pcontrol_g20_i2c_devices,
+	at91_add_device_i2c(0, pcontrol_g20_i2c_devices,
 		ARRAY_SIZE(pcontrol_g20_i2c_devices));
 	add_device_pcontrol();
 	at91_add_device_spi(pcontrol_g20_spi_devices,
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 419456d..2b0958b 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -113,7 +113,7 @@ static void __init picotux200_board_init(void)
 	/* USB Host */
 	at91_add_device_usbh_ohci(&picotux200_usbh_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* MMC */
 	at91_set_gpio_output(AT91_PIN_PB22, 1);	/* this MMC card slot can optionally use SPI signaling (CS3). */
 	at91_add_device_mmc(0, &picotux200_mmc_data);
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 255a984..c00b292 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -252,7 +252,7 @@ static void __init ek_board_init(void)
 	/* NAND */
 	ek_add_device_nand();
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* Ethernet */
 	at91_add_device_eth(&ek_macb_data);
 	/* MMC */
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 3d54963..746b6ea 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -204,7 +204,7 @@ static void __init dk_board_init(void)
 	/* Compact Flash */
 	at91_add_device_cf(&dk_cf_data);
 	/* I2C */
-	at91_add_device_i2c(dk_i2c_devices, ARRAY_SIZE(dk_i2c_devices));
+	at91_add_device_i2c(0, dk_i2c_devices, ARRAY_SIZE(dk_i2c_devices));
 	/* SPI */
 	at91_add_device_spi(dk_spi_devices, ARRAY_SIZE(dk_spi_devices));
 #ifdef CONFIG_MTD_AT91_DATAFLASH_CARD
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 25fe19f..5e1dca0 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -172,7 +172,7 @@ static void __init ek_board_init(void)
 	at91_add_device_udc(&ek_udc_data);
 	at91_set_multi_drive(ek_udc_data.pullup_pin, 1);	/* pullup_pin is connected to reset */
 	/* I2C */
-	at91_add_device_i2c(ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
+	at91_add_device_i2c(0, ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
 	/* SPI */
 	at91_add_device_spi(ek_spi_devices, ARRAY_SIZE(ek_spi_devices));
 #ifdef CONFIG_MTD_AT91_DATAFLASH_CARD
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 589e2f4..bc62008 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -207,7 +207,7 @@ static void __init ek_board_init(void)
 	/* MMC */
 	at91_add_device_mmc(0, &ek_mmc_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 }
 
 MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index b98e766..c8c53ac 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -344,7 +344,7 @@ static void __init ek_board_init(void)
 	/* MMC */
 	at91_add_device_mmc(0, &ek_mmc_data);
 	/* I2C */
-	at91_add_device_i2c(ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
+	at91_add_device_i2c(0, ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
 	/* SSC (to AT73C213) */
 	at73c213_set_clk(&at73c213_data);
 	at91_add_device_ssc(AT91SAM9260_ID_SSC, ATMEL_SSC_TX);
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index e631172..3e848ba 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -590,7 +590,7 @@ static void __init ek_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* NAND */
 	ek_add_device_nand();
 	/* DM9000 ethernet */
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index fae6ebf..5e1aac1 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -438,7 +438,7 @@ static void __init ek_board_init(void)
 	/* NAND */
 	ek_add_device_nand();
 	/* I2C */
-	at91_add_device_i2c(ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
+	at91_add_device_i2c(0, ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
 	/* LCD Controller */
 	at91_add_device_lcdc(&ek_lcdc_data);
 	/* Push Buttons */
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index c25e44c..3dd5013 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -393,7 +393,7 @@ static void __init ek_board_init(void)
 	/* MMC */
 	ek_add_device_mmc();
 	/* I2C */
-	at91_add_device_i2c(ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
+	at91_add_device_i2c(0, ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
 	/* LEDs */
 	ek_add_device_gpio_leds();
 	/* Push Buttons */
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 3bf3408..475b485 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -308,7 +308,7 @@ static void __init ek_board_init(void)
 	/* USB HS */
 	at91_add_device_usba(&ek_usba_udc_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* NAND */
 	ek_add_device_nand();
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index ca14290..e93a11b 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -166,7 +166,7 @@ static void __init snapper9260_add_device_nand(void)
 
 static void __init snapper9260_board_init(void)
 {
-	at91_add_device_i2c(snapper9260_i2c_devices,
+	at91_add_device_i2c(0, snapper9260_i2c_devices,
 			    ARRAY_SIZE(snapper9260_i2c_devices));
 	at91_add_device_serial();
 	at91_add_device_usbh_ohci(&snapper9260_usbh_data);
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 1e7a73a..9b7f333 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -274,7 +274,7 @@ static void __init portuxg20_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&macb_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* SPI */
 	at91_add_device_spi(portuxg20_spi_devices, ARRAY_SIZE(portuxg20_spi_devices));
 	/* LEDs */
@@ -291,7 +291,7 @@ static void __init stamp9g20evb_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&macb_data);
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* LEDs */
 	at91_gpio_leds(stamp9g20evb_leds, ARRAY_SIZE(stamp9g20evb_leds));
 }
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index 9b5cbf5..8c3bbde 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -214,7 +214,7 @@ static void __init ek_board_init(void)
 	/* NAND */
 	ek_add_device_nand();
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* Ethernet */
 	at91_add_device_eth(&ek_macb_data);
 	/* Push Buttons */
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index 535af00..6e9f2ef 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -232,7 +232,7 @@ static void __init ek_board_init(void)
 	/* NAND */
 	ek_add_device_nand();
 	/* I2C */
-	at91_add_device_i2c(NULL, 0);
+	at91_add_device_i2c(0, NULL, 0);
 	/* Push Buttons */
 	ek_add_device_buttons();
 	/* LEDs */
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index bd5ebfd..ef80db1 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -571,7 +571,7 @@ static void __init yl9200_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&yl9200_udc_data);
 	/* I2C */
-	at91_add_device_i2c(yl9200_i2c_devices, ARRAY_SIZE(yl9200_i2c_devices));
+	at91_add_device_i2c(0, yl9200_i2c_devices, ARRAY_SIZE(yl9200_i2c_devices));
 	/* MMC */
 	at91_add_device_mmc(0, &yl9200_mmc_data);
 	/* NAND */
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 1292f51..3e26082 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -17,6 +17,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/i2c-gpio.h>
 
 #include <mach/cpu.h>
 #include <mach/board.h>
@@ -507,6 +508,93 @@ void __init at91_add_device_nand(struct atmel_nand_data *data)
 void __init at91_add_device_nand(struct atmel_nand_data *data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  TWI (i2c)
+ * -------------------------------------------------------------------- */
+
+/*
+ * Prefer the GPIO code since the TWI controller isn't robust
+ * (gets overruns and underruns under load) and can only issue
+ * repeated STARTs in one scenario (the driver doesn't yet handle them).
+ */
+
+#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
+static struct i2c_gpio_platform_data i2c_gpio_pdata __initdata = {
+	.sda_is_open_drain	= 1,
+	.scl_is_open_drain	= 1,
+};
+
+static struct platform_device at91_twi_device = {
+	.name			= "i2c-gpio",
+	.id			= -1,
+	.dev.platform_data	= &i2c_gpio_pdata,
+};
+
+void __init at91_add_device_i2c(short i2c_id,
+				struct i2c_board_info *i2c_devices,
+				int nr_devices)
+{
+	struct at91_dev_table_twi *info = devices->twi[i2c_id];
+
+	BUG_ON(!info);
+
+	/* TWD (SDA) */
+	i2c_gpio_pdata.sda_pin = info->sda_pin.pin;
+	at91_set_GPIO_periph(info->sda_pin.pin, 1);
+	at91_set_multi_drive(info->sda_pin.pin, 1);
+
+	/* TWCK (SCL) */
+	i2c_gpio_pdata.scl_pin = info->scl_pin.pin;
+	at91_set_GPIO_periph(info->scl_pin.pin, 1);
+	at91_set_multi_drive(info->scl_pin.pin, 1);
+
+	i2c_register_board_info(i2c_id, i2c_devices, nr_devices);
+	at91_add_platform_device(&at91_twi_device, NULL, 0, 
+				 &i2c_gpio_pdata, sizeof(i2c_gpio_pdata));
+}
+
+#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
+static struct platform_device at91_twi_devices[] = {
+	[0] = {
+		.name		= "at91_i2c",
+		.id		= 0,
+	},
+	[1] = {
+		.name		= "at91_i2c",
+		.id		= 1,
+	},
+};
+
+void __init at91_add_device_i2c(short i2c_id,
+				struct i2c_board_info *i2c_devices,
+				int nr_devices)
+{
+	struct at91_dev_table_twi *info = devices->twi[i2c_id];
+	struct resource resources[2] = {{0}};
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_16K);
+	init_resource_irq(&resources[1], info->irq);
+
+	/* TWD */
+	config_pins(&info->pin_sda, 1);
+	at91_set_multi_drive(info->pin_sda, 1);
+
+	/* TWCK */
+	config_pins(&info->pin_scl, 1);
+	at91_set_multi_drive(info->pin_scl, 1);
+
+	i2c_register_board_info(i2c_id, i2c_devices, nr_devices);
+	at91_add_platform_device(&at91_twi_devices[i2c_id], resources,
+				 ARRAY_SIZE(resources),
+				 data, sizeof(*data));
+}
+#else
+void __init at91_add_device_i2c(short i2c_id,
+				struct i2c_board_info *i2c_devices,
+				int nr_devices) {}
+#endif
+
 void __init at91_init_devices(struct at91_device_table *device_table)
 {
 	devices = device_table;
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 3e9ec54..9b99be2 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -73,6 +73,14 @@ struct at91_dev_table_nand {
 	int			nr_pins;
 };
 
+struct at91_dev_table_twi {
+	unsigned		mmio_base;
+	int			irq;
+	struct at91_pin_config	scl_pin;
+	struct at91_pin_config	sda_pin;
+	int			udelay;		/* For i2c-gpio */
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -80,6 +88,7 @@ struct at91_device_table {
 	struct at91_dev_table_basic_device	*udc;
 	struct at91_dev_table_mmc		*mmc[2];
 	struct at91_dev_table_nand		*nand;
+	struct at91_dev_table_twi		*twi[2];
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index dd0855d..94232a4 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -116,11 +116,7 @@ struct atmel_nand_data {
 extern void __init at91_add_device_nand(struct atmel_nand_data *data);
 
  /* I2C*/
-#if defined(CONFIG_ARCH_AT91SAM9G45)
 extern void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, int nr_devices);
-#else
-extern void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices);
-#endif
 
  /* SPI */
 extern void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices);
-- 
1.7.0.4
