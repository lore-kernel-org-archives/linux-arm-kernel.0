From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:30 +1200
Subject: [PATCH v3 21/23] at91: Make compact flash device common
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-22-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual compact flash device code for each at91 variant with
a single implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91rm9200_devices.c  |   74 ++++++--------------
 arch/arm/mach-at91/at91sam9260_devices.c |  114 +++++++-----------------------
 arch/arm/mach-at91/at91sam9263_devices.c |  102 +++++++--------------------
 arch/arm/mach-at91/devices.c             |  105 +++++++++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |   14 ++++
 5 files changed, 193 insertions(+), 216 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index f251ed1..5ffa946 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -84,38 +84,12 @@ static struct at91_dev_table_ethernet device_eth __initdata = {
  *  Compact Flash / PCMCIA
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE)
-static struct at91_cf_data cf_data;
-
-#define CF_BASE		AT91_CHIPSELECT_4
-
-static struct resource cf_resources[] = {
-	[0] = {
-		.start	= CF_BASE,
-		/* ties up CS4, CS5 and CS6 */
-		.end	= CF_BASE + (0x30000000 - 1),
-		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT,
-	},
-};
-
-static struct platform_device at91rm9200_cf_device = {
-	.name		= "at91_cf",
-	.id		= -1,
-	.dev		= {
-				.platform_data		= &cf_data,
-	},
-	.resource	= cf_resources,
-	.num_resources	= ARRAY_SIZE(cf_resources),
-};
-
-void __init at91_add_device_cf(struct at91_cf_data *data)
+static int __init at91rm9200_cf_init(struct at91_cf_data *data, int *slot)
 {
 	unsigned int csa;
 
-	if (!data)
-		return;
-
 	data->chipselect = 4;		/* can only use EBI ChipSelect 4 */
+	*slot = 0;			/* only one CF slot */
 
 	/* CF takes over CS4, CS5, CS6 */
 	csa = at91_sys_read(AT91_EBI_CSA);
@@ -136,35 +110,30 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 				| AT91_SMC_RWHOLD_(4)	/* hold time */
 	);
 
-	/* input/irq */
-	if (data->irq_pin) {
-		at91_set_gpio_input(data->irq_pin, 1);
-		at91_set_deglitch(data->irq_pin, 1);
-	}
-	at91_set_gpio_input(data->det_pin, 1);
-	at91_set_deglitch(data->det_pin, 1);
-
-	/* outputs, initially off */
-	if (data->vcc_pin)
-		at91_set_gpio_output(data->vcc_pin, 0);
-	at91_set_gpio_output(data->rst_pin, 0);
+	return 0;
+}
 
+static struct at91_pin_config cf_pins[] __initdata = {
 	/* force poweron defaults for these pins ... */
-	at91_set_A_periph(AT91_PIN_PC9, 0);	/* A25/CFRNW */
-	at91_set_A_periph(AT91_PIN_PC10, 0);	/* NCS4/CFCS */
-	at91_set_A_periph(AT91_PIN_PC11, 0);	/* NCS5/CFCE1 */
-	at91_set_A_periph(AT91_PIN_PC12, 0);	/* NCS6/CFCE2 */
+	{AT91_PIN_PC9,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* A25/CFRNW */
+	{AT91_PIN_PC10, AT91_PIN_PERIPH_A, 0, 0, 0},	/* NCS4/CFCS */
+	{AT91_PIN_PC11, AT91_PIN_PERIPH_A, 0, 0, 0},	/* NCS5/CFCE1 */
+	{AT91_PIN_PC12, AT91_PIN_PERIPH_A, 0, 0, 0},	/* NCS6/CFCE2 */
 
 	/* nWAIT is _not_ a default setting */
-	at91_set_A_periph(AT91_PIN_PC6, 1);	/* nWAIT */
-
-	cf_data = *data;
-	platform_device_register(&at91rm9200_cf_device);
-}
-#else
-void __init at91_add_device_cf(struct at91_cf_data *data) {}
-#endif
+	{AT91_PIN_PC6,  AT91_PIN_PERIPH_A, 1, 0, 0},	/* nWAIT */
+};
 
+static struct at91_dev_table_cf device_cf __initdata = {
+	.slot[0]	= {
+		/* ties up CS4, CS5 and CS6 */
+		.mmio_base	= AT91_CHIPSELECT_4,
+		.mmio_size	= 0x30000000,
+	},
+	.device_init	= at91rm9200_cf_init,
+	.pins		= cf_pins,
+	.nr_pins	= ARRAY_SIZE(cf_pins),
+};
 
 /* --------------------------------------------------------------------
  *  MMC / SD
@@ -419,6 +388,7 @@ static struct at91_device_table at91rm9200_device_table __initdata = {
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
 	.ssc[2]		= &device_ssc2,
+	.cf		= &device_cf,
 };
 
 void __init at91rm9200_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 891e8bf..21c541b 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -318,56 +318,10 @@ static struct at91_dev_table_uart device_uart5 __initdata = {
  *  CF/IDE
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE) || \
-	defined(CONFIG_PATA_AT91) || defined(CONFIG_PATA_AT91_MODULE) || \
-	defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE)
-
-static struct at91_cf_data cf0_data;
-
-static struct resource cf0_resources[] = {
-	[0] = {
-		.start	= AT91_CHIPSELECT_4,
-		.end	= AT91_CHIPSELECT_4 + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device cf0_device = {
-	.id		= 0,
-	.dev		= {
-				.platform_data	= &cf0_data,
-	},
-	.resource	= cf0_resources,
-	.num_resources	= ARRAY_SIZE(cf0_resources),
-};
-
-static struct at91_cf_data cf1_data;
-
-static struct resource cf1_resources[] = {
-	[0] = {
-		.start	= AT91_CHIPSELECT_5,
-		.end	= AT91_CHIPSELECT_5 + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device cf1_device = {
-	.id		= 1,
-	.dev		= {
-				.platform_data	= &cf1_data,
-	},
-	.resource	= cf1_resources,
-	.num_resources	= ARRAY_SIZE(cf1_resources),
-};
-
-void __init at91_add_device_cf(struct at91_cf_data *data)
+static int __init at91sam9260_cf_init(struct at91_cf_data *data, int *slot)
 {
-	struct platform_device *pdev;
 	unsigned long csa;
 
-	if (!data)
-		return;
-
 	csa = at91_sys_read(AT91_MATRIX_EBICSA);
 
 	switch (data->chipselect) {
@@ -375,61 +329,44 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 		at91_set_multi_drive(AT91_PIN_PC8, 0);
 		at91_set_A_periph(AT91_PIN_PC8, 0);
 		csa |= AT91_MATRIX_CS4A_SMC_CF1;
-		cf0_data = *data;
-		pdev = &cf0_device;
+		*slot = 0;
 		break;
 	case 5:
 		at91_set_multi_drive(AT91_PIN_PC9, 0);
 		at91_set_A_periph(AT91_PIN_PC9, 0);
 		csa |= AT91_MATRIX_CS5A_SMC_CF2;
-		cf1_data = *data;
-		pdev = &cf1_device;
+		*slot = 1;
 		break;
 	default:
 		printk(KERN_ERR "AT91 CF: bad chip-select requested (%u)\n",
 		       data->chipselect);
-		return;
+		return -EINVAL;
 	}
 
 	at91_sys_write(AT91_MATRIX_EBICSA, csa);
-
-	if (data->rst_pin) {
-		at91_set_multi_drive(data->rst_pin, 0);
-		at91_set_gpio_output(data->rst_pin, 1);
-	}
-
-	if (data->irq_pin) {
-		at91_set_gpio_input(data->irq_pin, 0);
-		at91_set_deglitch(data->irq_pin, 1);
-	}
-
-	if (data->det_pin) {
-		at91_set_gpio_input(data->det_pin, 0);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-
-	at91_set_B_periph(AT91_PIN_PC6, 0);     /* CFCE1 */
-	at91_set_B_periph(AT91_PIN_PC7, 0);     /* CFCE2 */
-	at91_set_A_periph(AT91_PIN_PC10, 0);    /* CFRNW */
-	at91_set_A_periph(AT91_PIN_PC15, 1);    /* NWAIT */
-
-	if (data->flags & AT91_CF_TRUE_IDE)
-#if defined(CONFIG_PATA_AT91) || defined(CONFIG_PATA_AT91_MODULE)
-		pdev->name = "pata_at91";
-#elif defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
-		pdev->name = "at91_ide";
-#else
-#warning "board requires AT91_CF_TRUE_IDE: enable either at91_ide or pata_at91"
-#endif
-	else
-		pdev->name = "at91_cf";
-
-	platform_device_register(pdev);
+	return 0;
 }
 
-#else
-void __init at91_add_device_cf(struct at91_cf_data * data) {}
-#endif
+static struct at91_pin_config cf_pins[] __initdata = {
+	{AT91_PIN_PC6,  AT91_PIN_PERIPH_B, 0, 0, 0}, /* CFCE1 */
+	{AT91_PIN_PC7,  AT91_PIN_PERIPH_B, 0, 0, 0}, /* CFCE2 */
+	{AT91_PIN_PC10, AT91_PIN_PERIPH_A, 0, 0, 0}, /* CFRNW */
+	{AT91_PIN_PC15, AT91_PIN_PERIPH_A, 1, 0, 0}, /* NWAIT */
+};
+
+static struct at91_dev_table_cf device_cf __initdata = {
+	.slot[0]	= {
+		.mmio_base	= AT91_CHIPSELECT_4,
+		.mmio_size	= SZ_256M,
+	},
+	.slot[1] 	= {
+		.mmio_base	= AT91_CHIPSELECT_5,
+		.mmio_size	= SZ_256M,
+	},
+	.device_init	= at91sam9260_cf_init,
+	.pins		= cf_pins,
+	.nr_pins	= ARRAY_SIZE(cf_pins),
+};
 
 static struct at91_device_table at91sam9260_device_table __initdata = {
 	.ethernet	= &device_eth,
@@ -451,6 +388,7 @@ static struct at91_device_table at91sam9260_device_table __initdata = {
 	.uart[4]	= &device_uart4,
 	.uart[5]	= &device_uart5,
 	.ssc[0]		= &device_ssc,
+	.cf		= &device_cf,
 };
 
 void __init at91sam9260_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index d858ac6..70cf41a 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -142,54 +142,9 @@ static struct at91_dev_table_mmc device_mmc1 __initdata = {
  *  Compact Flash (PCMCIA or IDE)
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE) || \
-    defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
-
-static struct at91_cf_data cf0_data;
-
-static struct resource cf0_resources[] = {
-	[0] = {
-		.start	= AT91_CHIPSELECT_4,
-		.end	= AT91_CHIPSELECT_4 + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT,
-	}
-};
-
-static struct platform_device cf0_device = {
-	.id		= 0,
-	.dev		= {
-				.platform_data	= &cf0_data,
-	},
-	.resource	= cf0_resources,
-	.num_resources	= ARRAY_SIZE(cf0_resources),
-};
-
-static struct at91_cf_data cf1_data;
-
-static struct resource cf1_resources[] = {
-	[0] = {
-		.start	= AT91_CHIPSELECT_5,
-		.end	= AT91_CHIPSELECT_5 + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT,
-	}
-};
-
-static struct platform_device cf1_device = {
-	.id		= 1,
-	.dev		= {
-				.platform_data	= &cf1_data,
-	},
-	.resource	= cf1_resources,
-	.num_resources	= ARRAY_SIZE(cf1_resources),
-};
-
-void __init at91_add_device_cf(struct at91_cf_data *data)
+static int __init at91sam9263_cf_init(struct at91_cf_data *data, int *slot)
 {
 	unsigned long ebi0_csa;
-	struct platform_device *pdev;
-
-	if (!data)
-		return;
 
 	/*
 	 * assign CS4 or CS5 to SMC with Compact Flash logic support,
@@ -201,48 +156,42 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 	case 4:
 		at91_set_A_periph(AT91_PIN_PD6, 0);  /* EBI0_NCS4/CFCS0 */
 		ebi0_csa |= AT91_MATRIX_EBI0_CS4A_SMC_CF1;
-		cf0_data = *data;
-		pdev = &cf0_device;
+		*slot = 0;
 		break;
 	case 5:
 		at91_set_A_periph(AT91_PIN_PD7, 0);  /* EBI0_NCS5/CFCS1 */
 		ebi0_csa |= AT91_MATRIX_EBI0_CS5A_SMC_CF2;
-		cf1_data = *data;
-		pdev = &cf1_device;
+		*slot = 1;
 		break;
 	default:
 		printk(KERN_ERR "AT91 CF: bad chip-select requested (%u)\n",
 		       data->chipselect);
-		return;
+		return -EINVAL;
 	}
 	at91_sys_write(AT91_MATRIX_EBI0CSA, ebi0_csa);
+	return 0;
+}
 
-	if (data->det_pin) {
-		at91_set_gpio_input(data->det_pin, 1);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-
-	if (data->irq_pin) {
-		at91_set_gpio_input(data->irq_pin, 1);
-		at91_set_deglitch(data->irq_pin, 1);
-	}
-
-	if (data->vcc_pin)
-		/* initially off */
-		at91_set_gpio_output(data->vcc_pin, 0);
-
-	/* enable EBI controlled pins */
-	at91_set_A_periph(AT91_PIN_PD5, 1);  /* NWAIT */
-	at91_set_A_periph(AT91_PIN_PD8, 0);  /* CFCE1 */
-	at91_set_A_periph(AT91_PIN_PD9, 0);  /* CFCE2 */
-	at91_set_A_periph(AT91_PIN_PD14, 0); /* CFNRW */
+static struct at91_pin_config cf_pins[] __initdata = {
+	{AT91_PIN_PD5,  AT91_PIN_PERIPH_A, 1, 0, 0}, /* NWAIT */
+	{AT91_PIN_PD8,  AT91_PIN_PERIPH_A, 0, 0, 0}, /* CFCE1 */
+	{AT91_PIN_PD9,  AT91_PIN_PERIPH_A, 0, 0, 0}, /* CFCE2 */
+	{AT91_PIN_PD14, AT91_PIN_PERIPH_A, 0, 0, 0}, /* CFNRW */
+};
 
-	pdev->name = (data->flags & AT91_CF_TRUE_IDE) ? "at91_ide" : "at91_cf";
-	platform_device_register(pdev);
-}
-#else
-void __init at91_add_device_cf(struct at91_cf_data *data) {}
-#endif
+static struct at91_dev_table_cf device_cf __initdata = {
+	.slot[0]	= {
+		.mmio_base	= AT91_CHIPSELECT_4,
+		.mmio_size	= SZ_256M,
+	},
+	.slot[1] 	= {
+		.mmio_base	= AT91_CHIPSELECT_5,
+		.mmio_size	= SZ_256M,
+	},
+	.device_init	= at91sam9263_cf_init,
+	.pins		= cf_pins,
+	.nr_pins	= ARRAY_SIZE(cf_pins),
+};
 
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
@@ -586,6 +535,7 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.ssc[1]		= &device_ssc1,
 	.ac97		= &device_ac97,
 	.lcdc		= &device_lcdc,
+	.cf		= &device_cf,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index a281651..0273b82 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -1843,6 +1843,111 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 void __init at91_add_device_usba(struct usba_platform_data *data) {}
 #endif
 
+
+/* --------------------------------------------------------------------
+ *  Compact Flash (PCMCIA or IDE)
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE) || \
+    defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
+
+static struct at91_cf_data cf0_data;
+
+static struct resource cf0_resources[] = {
+	[0] = {
+		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT,
+	}
+};
+
+static struct platform_device cf0_device = {
+	.id		= 0,
+	.dev		= {
+				.platform_data	= &cf0_data,
+	},
+	.resource	= cf0_resources,
+	.num_resources	= ARRAY_SIZE(cf0_resources),
+};
+
+static struct at91_cf_data cf1_data;
+
+static struct resource cf1_resources[] = {
+	[0] = {
+		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT,
+	}
+};
+
+static struct platform_device cf1_device = {
+	.id		= 1,
+	.dev		= {
+				.platform_data	= &cf1_data,
+	},
+	.resource	= cf1_resources,
+	.num_resources	= ARRAY_SIZE(cf1_resources),
+};
+
+void __init at91_add_device_cf(struct at91_cf_data *data)
+{
+	struct at91_dev_table_cf *info = devices->cf;
+	struct platform_device *pdev;
+	int err, slot;
+
+	BUG_ON(!info);
+	if (!data)
+		return;
+
+	/* Platform specific device initialisation */
+	if (info->device_init) {
+		err = info->device_init(data, &slot);
+		if (err)
+			return;
+	}
+
+	cf0_resources[0].end = info->slot[slot].mmio_size;
+	init_resource_mem(&cf0_resources[0], info->slot[slot].mmio_base);
+
+	if (slot == 0) {
+		pdev = &cf0_device;
+		cf0_data = *data;
+	} else {
+		pdev = &cf1_device;
+		cf1_data = *data;
+	}
+
+	if (data->det_pin) {
+		at91_set_gpio_input(data->det_pin, 1);
+		at91_set_deglitch(data->det_pin, 1);
+	}
+
+	if (data->irq_pin) {
+		at91_set_gpio_input(data->irq_pin, 1);
+		at91_set_deglitch(data->irq_pin, 1);
+	}
+
+	/* outputs, initially off */
+	if (data->vcc_pin)
+		at91_set_gpio_output(data->vcc_pin, 0);
+	if (data->rst_pin)
+		at91_set_gpio_output(data->rst_pin, 0);
+
+	at91_config_pins(info->pins, info->nr_pins);
+
+	if (data->flags & AT91_CF_TRUE_IDE)
+#if defined(CONFIG_PATA_AT91) || defined(CONFIG_PATA_AT91_MODULE)
+		pdev->name = "pata_at91";
+#elif defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
+		pdev->name = "at91_ide";
+#else
+#warning "board requires AT91_CF_TRUE_IDE: enable either at91_ide or pata_at91"
+#endif
+	else
+		pdev->name = "at91_cf";
+
+	platform_device_register(pdev);
+}
+#else
+void __init at91_add_device_cf(struct at91_cf_data *data) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index a1374fa..74f1b9a 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -189,6 +189,19 @@ struct at91_dev_table_udc_hs {
 	int			nr_endpoints;
 };
 
+struct at91_cf_slot {
+	unsigned		mmio_base;
+	unsigned		mmio_size;
+};
+
+struct at91_dev_table_cf {
+	struct at91_cf_slot	slot[2];
+	int			(*device_init)(struct at91_cf_data *data,
+					       int *slot);
+	struct at91_pin_config	*pins;
+	int			nr_pins;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -209,6 +222,7 @@ struct at91_device_table {
 	struct at91_dev_table_tsadcc		*tsadcc;
 	struct at91_dev_table_hdmac		*hdmac;
 	struct at91_dev_table_udc_hs		*udc_hs;
+	struct at91_dev_table_cf		*cf;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
