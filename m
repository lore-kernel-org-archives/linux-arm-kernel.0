From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:15 +1200
Subject: [PATCH v3 06/23] at91: Make NAND device common
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-7-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual NAND code for each at91 variant with a single
implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c |   65 ++++--------------------
 arch/arm/mach-at91/at91cap9_devices.c    |   62 ++--------------------
 arch/arm/mach-at91/at91rm9200_devices.c  |   81 +++++++-----------------------
 arch/arm/mach-at91/at91sam9260_devices.c |   62 ++--------------------
 arch/arm/mach-at91/at91sam9261_devices.c |   63 ++++-------------------
 arch/arm/mach-at91/at91sam9263_devices.c |   62 ++--------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |   62 ++--------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   66 ++----------------------
 arch/arm/mach-at91/devices.c             |   76 ++++++++++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |   12 ++++
 10 files changed, 158 insertions(+), 453 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 2d029a7..771e1bf 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -104,64 +104,20 @@ static struct at91_dev_table_mmc device_mmc __initdata = {
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
-static struct atmel_nand_data nand_data;
-
-#define NAND_BASE	AT91_CHIPSELECT_3
-
-static struct resource nand_resources[] = {
-	{
-		.start	= NAND_BASE,
-		.end	= NAND_BASE + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+static struct at91_pin_config nand_pins[] __initdata = {
+	{AT91_PIN_PB28, AT91_PIN_PERIPH_A, 0, 0, 0},	/* A[22] */
+	{AT91_PIN_PA28, AT91_PIN_PERIPH_B, 0, 0, 0},	/* NANDOE */
+	{AT91_PIN_PA29, AT91_PIN_PERIPH_B, 0, 0, 0},	/* NANDWE */
 };
 
-static struct platform_device at572d940hf_nand_device = {
-	.name		= "atmel_nand",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &nand_data,
-	},
-	.resource	= nand_resources,
-	.num_resources	= ARRAY_SIZE(nand_resources),
+static struct at91_dev_table_nand device_nand __initdata = {
+	.chip_select	= 3,
+	.enable_reg	= AT91_MATRIX_EBICSA,
+	.enable		= AT91_MATRIX_CS3A_SMC_SMARTMEDIA,
+	.pins		= nand_pins,
+	.nr_pins	= ARRAY_SIZE(nand_pins),
 };
 
-void __init at91_add_device_nand(struct atmel_nand_data *data)
-{
-	unsigned long csa;
-
-	if (!data)
-		return;
-
-	csa = at91_sys_read(AT91_MATRIX_EBICSA);
-	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_CS3A_SMC_SMARTMEDIA);
-
-	/* enable pin */
-	if (data->enable_pin)
-		at91_set_gpio_output(data->enable_pin, 1);
-
-	/* ready/busy pin */
-	if (data->rdy_pin)
-		at91_set_gpio_input(data->rdy_pin, 1);
-
-	/* card detect pin */
-	if (data->det_pin)
-		at91_set_gpio_input(data->det_pin, 1);
-
-	at91_set_A_periph(AT91_PIN_PB28, 0);		/* A[22] */
-	at91_set_B_periph(AT91_PIN_PA28, 0);		/* NANDOE */
-	at91_set_B_periph(AT91_PIN_PA29, 0);		/* NANDWE */
-
-	nand_data = *data;
-	platform_device_register(&at572d940hf_nand_device);
-}
-
-#else
-void __init at91_add_device_nand(struct atmel_nand_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
@@ -787,6 +743,7 @@ static struct at91_device_table at572d940hf_device_table __initdata = {
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
 	.mmc[0]		= &device_mmc,
+	.nand		= &device_nand,
 };
 
 void __init at572d940hf_init_devices(void)
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 9a5c59c..773eb95 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -228,64 +228,13 @@ static struct at91_dev_table_mmc device_mmc1 __initdata = {
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
-static struct atmel_nand_data nand_data;
-
-#define NAND_BASE	AT91_CHIPSELECT_3
-
-static struct resource nand_resources[] = {
-	[0] = {
-		.start	= NAND_BASE,
-		.end	= NAND_BASE + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC,
-		.end	= AT91_BASE_SYS + AT91_ECC + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+static struct at91_dev_table_nand device_nand __initdata = {
+	.chip_select	= 3,
+	.enable_reg	= AT91_MATRIX_EBICSA,
+	.enable		= AT91_MATRIX_EBI_CS3A_SMC_SMARTMEDIA,
+	.ecc_mmio_base	= AT91_BASE_SYS + AT91_ECC,
 };
 
-static struct platform_device at91cap9_nand_device = {
-	.name		= "atmel_nand",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &nand_data,
-	},
-	.resource	= nand_resources,
-	.num_resources	= ARRAY_SIZE(nand_resources),
-};
-
-void __init at91_add_device_nand(struct atmel_nand_data *data)
-{
-	unsigned long csa;
-
-	if (!data)
-		return;
-
-	csa = at91_sys_read(AT91_MATRIX_EBICSA);
-	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_EBI_CS3A_SMC_SMARTMEDIA);
-
-	/* enable pin */
-	if (data->enable_pin)
-		at91_set_gpio_output(data->enable_pin, 1);
-
-	/* ready/busy pin */
-	if (data->rdy_pin)
-		at91_set_gpio_input(data->rdy_pin, 1);
-
-	/* card detect pin */
-	if (data->det_pin)
-		at91_set_gpio_input(data->det_pin, 1);
-
-	nand_data = *data;
-	platform_device_register(&at91cap9_nand_device);
-}
-#else
-void __init at91_add_device_nand(struct atmel_nand_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
@@ -1101,6 +1050,7 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.usbh_ohci	= &device_usbh_ohci,
 	.mmc[0]		= &device_mmc0,
 	.mmc[1]		= &device_mmc1,
+	.nand		= &device_nand,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 4763662..90ca534 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -198,70 +198,26 @@ static struct at91_dev_table_mmc device_mmc __initdata = {
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
-static struct atmel_nand_data nand_data;
-
-#define NAND_BASE	AT91_CHIPSELECT_3
-
-static struct resource nand_resources[] = {
-	{
-		.start	= NAND_BASE,
-		.end	= NAND_BASE + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91rm9200_nand_device = {
-	.name		= "atmel_nand",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &nand_data,
-	},
-	.resource	= nand_resources,
-	.num_resources	= ARRAY_SIZE(nand_resources),
-};
-
-void __init at91_add_device_nand(struct atmel_nand_data *data)
-{
-	unsigned int csa;
-
-	if (!data)
-		return;
-
-	/* enable the address range of CS3 */
-	csa = at91_sys_read(AT91_EBI_CSA);
-	at91_sys_write(AT91_EBI_CSA, csa | AT91_EBI_CS3A_SMC_SMARTMEDIA);
-
-	/* set the bus interface characteristics */
-	at91_sys_write(AT91_SMC_CSR(3), AT91_SMC_ACSS_STD | AT91_SMC_DBW_8 | AT91_SMC_WSEN
+static struct at91_pin_config nand_pins[] __initdata = {
+	{AT91_PIN_PC1, AT91_PIN_PERIPH_A, 0, 0, 0},	/* SMOE */
+	{AT91_PIN_PC3, AT91_PIN_PERIPH_A, 0, 0, 0},	/* SMWE */
+};
+
+static struct at91_dev_table_nand device_nand __initdata = {
+	.chip_select	= 3,
+	.enable_reg	= AT91_EBI_CSA,
+	.enable		= AT91_EBI_CS3A_SMC_SMARTMEDIA,
+	.flags_reg	= AT91_SMC_CSR(3),
+	.flags		= (
+		  AT91_SMC_ACSS_STD | AT91_SMC_DBW_8 | AT91_SMC_WSEN
 		| AT91_SMC_NWS_(5)
 		| AT91_SMC_TDF_(1)
-		| AT91_SMC_RWSETUP_(0)	/* tDS Data Set up Time 30 - ns */
-		| AT91_SMC_RWHOLD_(1)	/* tDH Data Hold Time 20 - ns */
-	);
-
-	/* enable pin */
-	if (data->enable_pin)
-		at91_set_gpio_output(data->enable_pin, 1);
-
-	/* ready/busy pin */
-	if (data->rdy_pin)
-		at91_set_gpio_input(data->rdy_pin, 1);
-
-	/* card detect pin */
-	if (data->det_pin)
-		at91_set_gpio_input(data->det_pin, 1);
-
-	at91_set_A_periph(AT91_PIN_PC1, 0);		/* SMOE */
-	at91_set_A_periph(AT91_PIN_PC3, 0);		/* SMWE */
-
-	nand_data = *data;
-	platform_device_register(&at91rm9200_nand_device);
-}
-#else
-void __init at91_add_device_nand(struct atmel_nand_data *data) {}
-#endif
-
+		| AT91_SMC_RWSETUP_(0)	 /* tDS Data Set up Time 30 - ns */
+		| AT91_SMC_RWHOLD_(1)	 /* tDH Data Hold Time 20 - ns */
+		),
+	.pins		= nand_pins,
+	.nr_pins	= ARRAY_SIZE(nand_pins),
+};
 
 /* --------------------------------------------------------------------
  *  TWI (i2c)
@@ -1005,6 +961,7 @@ static struct at91_device_table at91rm9200_device_table __initdata = {
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
 	.mmc[0]		= &device_mmc,
+	.nand		= &device_nand,
 };
 
 void __init at91rm9200_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 5f1aaca..f48ad70 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -113,64 +113,13 @@ static struct at91_dev_table_mmc device_mmc __initdata = {
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
-static struct atmel_nand_data nand_data;
-
-#define NAND_BASE	AT91_CHIPSELECT_3
-
-static struct resource nand_resources[] = {
-	[0] = {
-		.start	= NAND_BASE,
-		.end	= NAND_BASE + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC,
-		.end	= AT91_BASE_SYS + AT91_ECC + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+static struct at91_dev_table_nand device_nand __initdata = {
+	.chip_select	= 3,
+	.enable_reg	= AT91_MATRIX_EBICSA,
+	.enable		= AT91_MATRIX_CS3A_SMC_SMARTMEDIA,
+	.ecc_mmio_base	= AT91_BASE_SYS + AT91_ECC,
 };
 
-static struct platform_device at91sam9260_nand_device = {
-	.name		= "atmel_nand",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &nand_data,
-	},
-	.resource	= nand_resources,
-	.num_resources	= ARRAY_SIZE(nand_resources),
-};
-
-void __init at91_add_device_nand(struct atmel_nand_data *data)
-{
-	unsigned long csa;
-
-	if (!data)
-		return;
-
-	csa = at91_sys_read(AT91_MATRIX_EBICSA);
-	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_CS3A_SMC_SMARTMEDIA);
-
-	/* enable pin */
-	if (data->enable_pin)
-		at91_set_gpio_output(data->enable_pin, 1);
-
-	/* ready/busy pin */
-	if (data->rdy_pin)
-		at91_set_gpio_input(data->rdy_pin, 1);
-
-	/* card detect pin */
-	if (data->det_pin)
-		at91_set_gpio_input(data->det_pin, 1);
-
-	nand_data = *data;
-	platform_device_register(&at91sam9260_nand_device);
-}
-#else
-void __init at91_add_device_nand(struct atmel_nand_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
@@ -1065,6 +1014,7 @@ static struct at91_device_table at91sam9260_device_table __initdata = {
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
 	.mmc[0]		= &device_mmc,
+	.nand		= &device_nand,
 };
 
 void __init at91sam9260_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 4bf9a09..9505ae3 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -70,63 +70,19 @@ static struct at91_dev_table_mmc device_mmc __initdata = {
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
-static struct atmel_nand_data nand_data;
-
-#define NAND_BASE	AT91_CHIPSELECT_3
-
-static struct resource nand_resources[] = {
-	{
-		.start	= NAND_BASE,
-		.end	= NAND_BASE + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+static struct at91_pin_config nand_pins[] __initdata = {
+	{AT91_PIN_PC0, AT91_PIN_PERIPH_A, 0, 0, 0},	/* NANDOE */
+	{AT91_PIN_PC1, AT91_PIN_PERIPH_A, 0, 0, 0},	/* NANDWE */
 };
 
-static struct platform_device atmel_nand_device = {
-	.name		= "atmel_nand",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &nand_data,
-	},
-	.resource	= nand_resources,
-	.num_resources	= ARRAY_SIZE(nand_resources),
+static struct at91_dev_table_nand device_nand __initdata = {
+	.chip_select	= 3,
+	.enable_reg	= AT91_MATRIX_EBICSA,
+	.enable		= AT91_MATRIX_CS3A_SMC_SMARTMEDIA,
+	.pins		= nand_pins,
+	.nr_pins	= ARRAY_SIZE(nand_pins),
 };
 
-void __init at91_add_device_nand(struct atmel_nand_data *data)
-{
-	unsigned long csa;
-
-	if (!data)
-		return;
-
-	csa = at91_sys_read(AT91_MATRIX_EBICSA);
-	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_CS3A_SMC_SMARTMEDIA);
-
-	/* enable pin */
-	if (data->enable_pin)
-		at91_set_gpio_output(data->enable_pin, 1);
-
-	/* ready/busy pin */
-	if (data->rdy_pin)
-		at91_set_gpio_input(data->rdy_pin, 1);
-
-	/* card detect pin */
-	if (data->det_pin)
-		at91_set_gpio_input(data->det_pin, 1);
-
-	at91_set_A_periph(AT91_PIN_PC0, 0);		/* NANDOE */
-	at91_set_A_periph(AT91_PIN_PC1, 0);		/* NANDWE */
-
-	nand_data = *data;
-	platform_device_register(&atmel_nand_device);
-}
-
-#else
-void __init at91_add_device_nand(struct atmel_nand_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
@@ -920,6 +876,7 @@ static struct at91_device_table at91sam9261_device_table __initdata = {
 	.usbh_ohci	= &device_usbh_ohci,
 	.udc		= &device_udc,
 	.mmc[0]		= &device_mmc,
+	.nand		= &device_nand,
 };
 
 void __init at91sam9261_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 708d24a..37b06f7 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -248,64 +248,13 @@ void __init at91_add_device_cf(struct at91_cf_data *data) {}
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
-static struct atmel_nand_data nand_data;
-
-#define NAND_BASE	AT91_CHIPSELECT_3
-
-static struct resource nand_resources[] = {
-	[0] = {
-		.start	= NAND_BASE,
-		.end	= NAND_BASE + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC0,
-		.end	= AT91_BASE_SYS + AT91_ECC0 + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+static struct at91_dev_table_nand device_nand __initdata = {
+	.chip_select	= 3,
+	.enable_reg	= AT91_MATRIX_EBI0CSA,
+	.enable		= AT91_MATRIX_EBI0_CS3A_SMC_SMARTMEDIA,
+	.ecc_mmio_base	= AT91_BASE_SYS + AT91_ECC0,
 };
 
-static struct platform_device at91sam9263_nand_device = {
-	.name		= "atmel_nand",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &nand_data,
-	},
-	.resource	= nand_resources,
-	.num_resources	= ARRAY_SIZE(nand_resources),
-};
-
-void __init at91_add_device_nand(struct atmel_nand_data *data)
-{
-	unsigned long csa;
-
-	if (!data)
-		return;
-
-	csa = at91_sys_read(AT91_MATRIX_EBI0CSA);
-	at91_sys_write(AT91_MATRIX_EBI0CSA, csa | AT91_MATRIX_EBI0_CS3A_SMC_SMARTMEDIA);
-
-	/* enable pin */
-	if (data->enable_pin)
-		at91_set_gpio_output(data->enable_pin, 1);
-
-	/* ready/busy pin */
-	if (data->rdy_pin)
-		at91_set_gpio_input(data->rdy_pin, 1);
-
-	/* card detect pin */
-	if (data->det_pin)
-		at91_set_gpio_input(data->det_pin, 1);
-
-	nand_data = *data;
-	platform_device_register(&at91sam9263_nand_device);
-}
-#else
-void __init at91_add_device_nand(struct atmel_nand_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
@@ -1222,6 +1171,7 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.udc		= &device_udc,
 	.mmc[0]		= &device_mmc0,
 	.mmc[1]		= &device_mmc1,
+	.nand		= &device_nand,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 745b1a2..9650547 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -272,64 +272,13 @@ static struct at91_dev_table_mmc device_mmc1 __initdata = {
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
-static struct atmel_nand_data nand_data;
-
-#define NAND_BASE	AT91_CHIPSELECT_3
-
-static struct resource nand_resources[] = {
-	[0] = {
-		.start	= NAND_BASE,
-		.end	= NAND_BASE + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC,
-		.end	= AT91_BASE_SYS + AT91_ECC + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+static struct at91_dev_table_nand device_nand __initdata = {
+	.chip_select	= 3,
+	.enable_reg	= AT91_MATRIX_EBICSA,
+	.enable		= AT91_MATRIX_EBI_CS3A_SMC_SMARTMEDIA,
+	.ecc_mmio_base	= AT91_BASE_SYS + AT91_ECC,
 };
 
-static struct platform_device at91sam9g45_nand_device = {
-	.name		= "atmel_nand",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &nand_data,
-	},
-	.resource	= nand_resources,
-	.num_resources	= ARRAY_SIZE(nand_resources),
-};
-
-void __init at91_add_device_nand(struct atmel_nand_data *data)
-{
-	unsigned long csa;
-
-	if (!data)
-		return;
-
-	csa = at91_sys_read(AT91_MATRIX_EBICSA);
-	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_EBI_CS3A_SMC_SMARTMEDIA);
-
-	/* enable pin */
-	if (data->enable_pin)
-		at91_set_gpio_output(data->enable_pin, 1);
-
-	/* ready/busy pin */
-	if (data->rdy_pin)
-		at91_set_gpio_input(data->rdy_pin, 1);
-
-	/* card detect pin */
-	if (data->det_pin)
-		at91_set_gpio_input(data->det_pin, 1);
-
-	nand_data = *data;
-	platform_device_register(&at91sam9g45_nand_device);
-}
-#else
-void __init at91_add_device_nand(struct atmel_nand_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
@@ -1347,6 +1296,7 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.usbh_ehci	= &device_usb_ehci,
 	.mmc[0]		= &device_mmc0,
 	.mmc[1]		= &device_mmc1,
+	.nand		= &device_nand,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 352e30c..e0b7302 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -189,68 +189,13 @@ static struct at91_dev_table_mmc device_mmc __initdata = {
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
-static struct atmel_nand_data nand_data;
-
-#define NAND_BASE	AT91_CHIPSELECT_3
-
-static struct resource nand_resources[] = {
-	[0] = {
-		.start	= NAND_BASE,
-		.end	= NAND_BASE + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_BASE_SYS + AT91_ECC,
-		.end	= AT91_BASE_SYS + AT91_ECC + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+static struct at91_dev_table_nand device_nand __initdata = {
+	.chip_select	= 3,
+	.enable_reg	= AT91_MATRIX_EBICSA,
+	.enable		= AT91_MATRIX_CS3A_SMC_SMARTMEDIA,
+	.ecc_mmio_base	= AT91_BASE_SYS + AT91_ECC,
 };
 
-static struct platform_device atmel_nand_device = {
-	.name		= "atmel_nand",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &nand_data,
-	},
-	.resource	= nand_resources,
-	.num_resources	= ARRAY_SIZE(nand_resources),
-};
-
-void __init at91_add_device_nand(struct atmel_nand_data *data)
-{
-	unsigned long csa;
-
-	if (!data)
-		return;
-
-	csa = at91_sys_read(AT91_MATRIX_EBICSA);
-	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_CS3A_SMC_SMARTMEDIA);
-
-	/* enable pin */
-	if (data->enable_pin)
-		at91_set_gpio_output(data->enable_pin, 1);
-
-	/* ready/busy pin */
-	if (data->rdy_pin)
-		at91_set_gpio_input(data->rdy_pin, 1);
-
-	/* card detect pin */
-	if (data->det_pin)
-		at91_set_gpio_input(data->det_pin, 1);
-
-	at91_set_A_periph(AT91_PIN_PB4, 0);		/* NANDOE */
-	at91_set_A_periph(AT91_PIN_PB5, 0);		/* NANDWE */
-
-	nand_data = *data;
-	platform_device_register(&atmel_nand_device);
-}
-
-#else
-void __init at91_add_device_nand(struct atmel_nand_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  TWI (i2c)
  * -------------------------------------------------------------------- */
@@ -1152,6 +1097,7 @@ void __init at91_add_device_serial(void) {}
 
 static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.mmc[0]		= &device_mmc,
+	.nand		= &device_nand,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 3d9708f..8c70529 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -529,6 +529,82 @@ void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
 }
 #else
 void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
+#endif 
+
+/* --------------------------------------------------------------------
+ *  NAND / SmartMedia
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
+static struct atmel_nand_data nand_data;
+
+static struct resource nand_resources[] = {
+	[0] = {
+		.end	= SZ_256M,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* ECC resource, not all at91 variants have this */
+		.end	= SZ_512,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device at91_nand_device = {
+	.name		= "atmel_nand",
+	.id		= -1,
+	.dev		= {
+				.platform_data	= &nand_data,
+	},
+	.resource	= nand_resources,
+	/* We fill in num_resources in at91_add_device_nand */
+};
+
+void __init at91_add_device_nand(struct atmel_nand_data *data)
+{
+	struct at91_dev_table_nand *info = devices->nand;
+	unsigned long csa;
+
+	BUG_ON(!info);
+	init_resource_mem(&nand_resources[0],
+			  (info->chip_select + 1) * 0x10000000);
+	if (info->ecc_mmio_base) {
+		init_resource_mem(&nand_resources[1], info->ecc_mmio_base);
+		at91_nand_device.num_resources = 2;
+	} else {
+		at91_nand_device.num_resources = 1;
+	}
+
+	if (!data)
+		return;
+
+	/* enable the address range for the chip-select */
+	csa = at91_sys_read(info->enable_reg);
+	at91_sys_write(info->enable_reg, csa | info->enable);
+
+	if (info->flags_reg && info->flags)
+		at91_sys_write(info->flags_reg, info->flags);
+
+	/* enable pin */
+	if (data->enable_pin)
+		at91_set_gpio_output(data->enable_pin, 1);
+
+	/* ready/busy pin */
+	if (data->rdy_pin)
+		at91_set_gpio_input(data->rdy_pin, 1);
+
+	/* card detect pin */
+	if (data->det_pin)
+		at91_set_gpio_input(data->det_pin, 1);
+
+	if (info->pins)
+		at91_config_pins(info->pins, info->nr_pins);
+
+	nand_data = *data;
+	platform_device_register(&at91_nand_device);
+}
+#else
+void __init at91_add_device_nand(struct atmel_nand_data *data) {}
 #endif
 
 void __init at91_init_devices(struct at91_device_table *device_table)
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index eab2f54..3e9ec54 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -62,12 +62,24 @@ struct at91_dev_table_mmc {
 	struct at91_mmc_pins	slot[2];
 };
 
+struct at91_dev_table_nand {
+	unsigned		chip_select;
+	unsigned		enable_reg;
+	unsigned		enable;
+	unsigned		ecc_mmio_base;
+	unsigned		flags_reg;
+	unsigned		flags;
+	struct at91_pin_config	*pins;
+	int			nr_pins;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
 	struct at91_dev_table_basic_device	*usbh_ehci;
 	struct at91_dev_table_basic_device	*udc;
 	struct at91_dev_table_mmc		*mmc[2];
+	struct at91_dev_table_nand		*nand;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
