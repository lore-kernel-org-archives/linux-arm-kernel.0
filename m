From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:29 +1200
Subject: [PATCH V4 15/23] at91: Make AC97 device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-16-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual AC97 code for each at91 variant with a single
implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |   57 +++++-------------------------
 arch/arm/mach-at91/at91sam9263_devices.c |   56 +++++------------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |   57 +++++-------------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   57 +++++-------------------------
 arch/arm/mach-at91/devices.c             |   41 +++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |    7 ++++
 6 files changed, 84 insertions(+), 191 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 0a2272b..b2392f0 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -317,57 +317,17 @@ static struct at91_dev_table_pwm device_pwm __initdata = {
  *  AC97
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SND_ATMEL_AC97C) || defined(CONFIG_SND_ATMEL_AC97C_MODULE)
-static u64 ac97_dmamask = DMA_BIT_MASK(32);
-static struct ac97c_platform_data ac97_data;
-
-static struct resource ac97_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_AC97C,
-		.end	= AT91CAP9_BASE_AC97C + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_AC97C,
-		.end	= AT91CAP9_ID_AC97C,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_ac97_device = {
-	.name		= "atmel_ac97c",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &ac97_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &ac97_data,
+static struct at91_dev_table_ac97 device_ac97 __initdata = {
+	.mmio_base	= AT91CAP9_BASE_AC97C,
+	.irq		= AT91CAP9_ID_AC97C,
+	.pins		= {
+		{AT91_PIN_PA6, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97FS */
+		{AT91_PIN_PA7, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97CK */
+		{AT91_PIN_PA8, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97TX */
+		{AT91_PIN_PA9, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97RX */
 	},
-	.resource	= ac97_resources,
-	.num_resources	= ARRAY_SIZE(ac97_resources),
 };
 
-void __init at91_add_device_ac97(struct ac97c_platform_data *data)
-{
-	if (!data)
-		return;
-
-	at91_set_A_periph(AT91_PIN_PA6, 0);	/* AC97FS */
-	at91_set_A_periph(AT91_PIN_PA7, 0);	/* AC97CK */
-	at91_set_A_periph(AT91_PIN_PA8, 0);	/* AC97TX */
-	at91_set_A_periph(AT91_PIN_PA9, 0);	/* AC97RX */
-
-	/* reset */
-	if (data->reset_pin)
-		at91_set_gpio_output(data->reset_pin, 0);
-
-	ac97_data = *data;
-	platform_device_register(&at91cap9_ac97_device);
-}
-#else
-void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  LCD Controller
  * -------------------------------------------------------------------- */
@@ -547,6 +507,7 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.pwm		= &device_pwm,
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
+	.ac97		= &device_ac97,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index cfac78b..1375776 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -299,56 +299,17 @@ static struct at91_dev_table_spi device_spi1 __initdata = {
  *  AC97
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SND_ATMEL_AC97C) || defined(CONFIG_SND_ATMEL_AC97C_MODULE)
-static u64 ac97_dmamask = DMA_BIT_MASK(32);
-static struct ac97c_platform_data ac97_data;
-
-static struct resource ac97_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_AC97C,
-		.end	= AT91SAM9263_BASE_AC97C + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_AC97C,
-		.end	= AT91SAM9263_ID_AC97C,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9263_ac97_device = {
-	.name		= "atmel_ac97c",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &ac97_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &ac97_data,
+static struct at91_dev_table_ac97 device_ac97 __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_AC97C,
+	.irq		= AT91SAM9263_ID_AC97C,
+	.pins		= {
+		{AT91_PIN_PB0, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97FS */
+		{AT91_PIN_PB1, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97CK */
+		{AT91_PIN_PB2, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97TX */
+		{AT91_PIN_PB3, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97RX */
 	},
-	.resource	= ac97_resources,
-	.num_resources	= ARRAY_SIZE(ac97_resources),
 };
 
-void __init at91_add_device_ac97(struct ac97c_platform_data *data)
-{
-	if (!data)
-		return;
-
-	at91_set_A_periph(AT91_PIN_PB0, 0);	/* AC97FS */
-	at91_set_A_periph(AT91_PIN_PB1, 0);	/* AC97CK */
-	at91_set_A_periph(AT91_PIN_PB2, 0);	/* AC97TX */
-	at91_set_A_periph(AT91_PIN_PB3, 0);	/* AC97RX */
-
-	/* reset */
-	if (data->reset_pin)
-		at91_set_gpio_output(data->reset_pin, 0);
-
-	ac97_data = *data;
-	platform_device_register(&at91sam9263_ac97_device);
-}
-#else
-void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
-#endif
-
 /* --------------------------------------------------------------------
  *  CAN Controller
  * -------------------------------------------------------------------- */
@@ -656,6 +617,7 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.pwm		= &device_pwm,
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
+	.ac97		= &device_ac97,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 8ad9c12..431bc98 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -331,57 +331,17 @@ static struct at91_dev_table_spi device_spi1 __initdata = {
  *  AC97
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SND_ATMEL_AC97C) || defined(CONFIG_SND_ATMEL_AC97C_MODULE)
-static u64 ac97_dmamask = DMA_BIT_MASK(32);
-static struct ac97c_platform_data ac97_data;
-
-static struct resource ac97_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_AC97C,
-		.end	= AT91SAM9G45_BASE_AC97C + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_AC97C,
-		.end	= AT91SAM9G45_ID_AC97C,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9g45_ac97_device = {
-	.name		= "atmel_ac97c",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &ac97_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &ac97_data,
+static struct at91_dev_table_ac97 device_ac97 __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_AC97C,
+	.irq		= AT91SAM9G45_ID_AC97C,
+	.pins		= {
+		{AT91_PIN_PD8, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97FS */
+		{AT91_PIN_PD9, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97CK */
+		{AT91_PIN_PD7, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97TX */
+		{AT91_PIN_PD6, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97RX */
 	},
-	.resource	= ac97_resources,
-	.num_resources	= ARRAY_SIZE(ac97_resources),
 };
 
-void __init at91_add_device_ac97(struct ac97c_platform_data *data)
-{
-	if (!data)
-		return;
-
-	at91_set_A_periph(AT91_PIN_PD8, 0);	/* AC97FS */
-	at91_set_A_periph(AT91_PIN_PD9, 0);	/* AC97CK */
-	at91_set_A_periph(AT91_PIN_PD7, 0);	/* AC97TX */
-	at91_set_A_periph(AT91_PIN_PD6, 0);	/* AC97RX */
-
-	/* reset */
-	if (data->reset_pin)
-		at91_set_gpio_output(data->reset_pin, 0);
-
-	ac97_data = *data;
-	platform_device_register(&at91sam9g45_ac97_device);
-}
-#else
-void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  LCD Controller
  * -------------------------------------------------------------------- */
@@ -705,6 +665,7 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.pwm		= &device_pwm,
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
+	.ac97		= &device_ac97,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 20f516d..63d7fcd 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -227,57 +227,17 @@ static struct at91_dev_table_spi device_spi __initdata = {
  *  AC97
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SND_ATMEL_AC97C) || defined(CONFIG_SND_ATMEL_AC97C_MODULE)
-static u64 ac97_dmamask = DMA_BIT_MASK(32);
-static struct ac97c_platform_data ac97_data;
-
-static struct resource ac97_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_AC97C,
-		.end	= AT91SAM9RL_BASE_AC97C + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_AC97C,
-		.end	= AT91SAM9RL_ID_AC97C,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9rl_ac97_device = {
-	.name		= "atmel_ac97c",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &ac97_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &ac97_data,
+static struct at91_dev_table_ac97 device_ac97 __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_AC97C,
+	.irq		= AT91SAM9RL_ID_AC97C,
+	.pins		= {
+		{AT91_PIN_PD1, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97FS */
+		{AT91_PIN_PD2, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97CK */
+		{AT91_PIN_PD3, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97TX */
+		{AT91_PIN_PD4, AT91_PIN_PERIPH_A, 0, 0, 0},	/* AC97RX */
 	},
-	.resource	= ac97_resources,
-	.num_resources	= ARRAY_SIZE(ac97_resources),
 };
 
-void __init at91_add_device_ac97(struct ac97c_platform_data *data)
-{
-	if (!data)
-		return;
-
-	at91_set_A_periph(AT91_PIN_PD1, 0);	/* AC97FS */
-	at91_set_A_periph(AT91_PIN_PD2, 0);	/* AC97CK */
-	at91_set_A_periph(AT91_PIN_PD3, 0);	/* AC97TX */
-	at91_set_A_periph(AT91_PIN_PD4, 0);	/* AC97RX */
-
-	/* reset */
-	if (data->reset_pin)
-		at91_set_gpio_output(data->reset_pin, 0);
-
-	ac97_data = *data;
-	platform_device_register(&at91sam9rl_ac97_device);
-}
-#else
-void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  LCD Controller
  * -------------------------------------------------------------------- */
@@ -580,6 +540,7 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.pwm		= &device_pwm,
 	.ssc[0]		= &device_ssc0,
 	.ssc[1]		= &device_ssc1,
+	.ac97		= &device_ac97,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 3671e9e..e0ab172 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -1065,6 +1065,47 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  AC97
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_SND_ATMEL_AC97C) || defined(CONFIG_SND_ATMEL_AC97C_MODULE)
+static u64 ac97_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_ac97_device = {
+	.name	= "atmel_ac97c",
+	.id	= 0,
+	.dev	= {
+		.dma_mask		= &ac97_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init at91_add_device_ac97(struct ac97c_platform_data *data)
+{
+	struct at91_dev_table_ac97 *info = devices->ac97;
+	struct resource resources[2] = {{0}};
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_16K);
+	init_resource_irq(&resources[0], info->irq);
+
+	if (!data)
+		return;
+
+	at91_config_pins(info->pins, ARRAY_SIZE(info->pins));
+
+	/* reset */
+	if (data->reset_pin)
+		at91_set_gpio_output(data->reset_pin, 0);
+
+	at91_add_platform_device(&at91_ac97_device, resources,
+				 ARRAY_SIZE(resources), data, sizeof(*data));
+}
+#else
+void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 177fc3d..3d6ca83 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -141,6 +141,12 @@ struct at91_dev_table_ssc {
 	struct at91_pin_config	rk_pin;
 };
 
+struct at91_dev_table_ac97 {
+	unsigned		mmio_base;
+	int			irq;
+	struct at91_pin_config	pins[4];	/* FS, CK, TX, RX */
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -156,6 +162,7 @@ struct at91_device_table {
 	struct at91_dev_table_uart		*uart[6];
 	struct at91_dev_table_pwm		*pwm;
 	struct at91_dev_table_ssc		*ssc[4];
+	struct at91_dev_table_ac97		*ac97;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
