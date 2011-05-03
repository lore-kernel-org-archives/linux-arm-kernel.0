From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:31 +1200
Subject: [PATCH V4 17/23] at91: Make touchscreen device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-18-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual touchscreen code for each at91 variant with a
single implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91sam9g45_devices.c |   53 +++++------------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   53 +++++------------------------
 arch/arm/mach-at91/devices.c             |   36 ++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |    7 ++++
 4 files changed, 61 insertions(+), 88 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 7d84fb7..783f600 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -436,53 +436,17 @@ static void __init at91_add_device_rtc(void) {}
  *  Touchscreen
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC) || defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC_MODULE)
-static u64 tsadcc_dmamask = DMA_BIT_MASK(32);
-static struct at91_tsadcc_data tsadcc_data;
-
-static struct resource tsadcc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_TSC,
-		.end	= AT91SAM9G45_BASE_TSC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_TSC,
-		.end	= AT91SAM9G45_ID_TSC,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device at91sam9g45_tsadcc_device = {
-	.name		= "atmel_tsadcc",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &tsadcc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &tsadcc_data,
+static struct at91_dev_table_tsadcc device_tsadcc __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_TSC,
+	.irq		= AT91SAM9G45_ID_TSC,
+	.pins		= {
+		{AT91_PIN_PD20, AT91_PIN_GPIO, 0, GPIOF_DIR_IN, 0}, /* AD0_XR */
+		{AT91_PIN_PD21, AT91_PIN_GPIO, 0, GPIOF_DIR_IN, 0}, /* AD0_XL */
+		{AT91_PIN_PD22, AT91_PIN_GPIO, 0, GPIOF_DIR_IN, 0}, /* AD0_YT */
+		{AT91_PIN_PD23, AT91_PIN_GPIO, 0, GPIOF_DIR_IN, 0}, /* AD0_TB */
 	},
-	.resource	= tsadcc_resources,
-	.num_resources	= ARRAY_SIZE(tsadcc_resources),
 };
 
-void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data)
-{
-	if (!data)
-		return;
-
-	at91_set_gpio_input(AT91_PIN_PD20, 0);	/* AD0_XR */
-	at91_set_gpio_input(AT91_PIN_PD21, 0);	/* AD1_XL */
-	at91_set_gpio_input(AT91_PIN_PD22, 0);	/* AD2_YT */
-	at91_set_gpio_input(AT91_PIN_PD23, 0);	/* AD3_TB */
-
-	tsadcc_data = *data;
-	platform_device_register(&at91sam9g45_tsadcc_device);
-}
-#else
-void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  RTT
  * -------------------------------------------------------------------- */
@@ -633,6 +597,7 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.ssc[1]		= &device_ssc1,
 	.ac97		= &device_ac97,
 	.lcdc		= &device_lcdc,
+	.tsadcc		= &device_tsadcc,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 50b2b8a..cbc49d0 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -294,53 +294,17 @@ static struct at91_dev_table_tcb device_tcb __initdata = {
  *  Touchscreen
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC) || defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC_MODULE)
-static u64 tsadcc_dmamask = DMA_BIT_MASK(32);
-static struct at91_tsadcc_data tsadcc_data;
-
-static struct resource tsadcc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_TSC,
-		.end	= AT91SAM9RL_BASE_TSC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_TSC,
-		.end	= AT91SAM9RL_ID_TSC,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device at91sam9rl_tsadcc_device = {
-	.name		= "atmel_tsadcc",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &tsadcc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &tsadcc_data,
+static struct at91_dev_table_tsadcc device_tsadcc __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_TSC,
+	.irq		= AT91SAM9RL_ID_TSC,
+	.pins		= {
+		{AT91_PIN_PA17, AT91_PIN_PERIPH_A, 0, 0, 0}, /* AD0_XR */
+		{AT91_PIN_PA18, AT91_PIN_PERIPH_A, 0, 0, 0}, /* AD0_XL */
+		{AT91_PIN_PA19, AT91_PIN_PERIPH_A, 0, 0, 0}, /* AD0_YT */
+		{AT91_PIN_PA20, AT91_PIN_PERIPH_A, 0, 0, 0}, /* AD0_TB */
 	},
-	.resource	= tsadcc_resources,
-	.num_resources	= ARRAY_SIZE(tsadcc_resources),
 };
 
-void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data)
-{
-	if (!data)
-		return;
-
-	at91_set_A_periph(AT91_PIN_PA17, 0);	/* AD0_XR */
-	at91_set_A_periph(AT91_PIN_PA18, 0);	/* AD1_XL */
-	at91_set_A_periph(AT91_PIN_PA19, 0);	/* AD2_YT */
-	at91_set_A_periph(AT91_PIN_PA20, 0);	/* AD3_TB */
-
-	tsadcc_data = *data;
-	platform_device_register(&at91sam9rl_tsadcc_device);
-}
-#else
-void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  RTC
  * -------------------------------------------------------------------- */
@@ -508,6 +472,7 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.ssc[1]		= &device_ssc1,
 	.ac97		= &device_ac97,
 	.lcdc		= &device_lcdc,
+	.tsadcc		= &device_tsadcc,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index f330f72..597a81d 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -1165,6 +1165,42 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  Touchscreen
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC) || defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC_MODULE)
+static u64 tsadcc_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_tsadcc_device = {
+	.name	= "atmel_tsadcc",
+	.id	= -1,
+	.dev	= {
+		.dma_mask		= &tsadcc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data)
+{
+	struct at91_dev_table_tsadcc *info = devices->tsadcc;
+	struct resource resources[2] = {{0}};
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_16K);
+	init_resource_irq(&resources[1], info->irq);
+
+	if (!data)
+		return;
+
+	at91_config_pins(info->pins, ARRAY_SIZE(info->pins));
+	at91_add_platform_device(&at91_tsadcc_device, resources,
+				 ARRAY_SIZE(resources), data, sizeof(*data));
+}
+#else
+void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 65a036c..4b68228 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -157,6 +157,12 @@ struct at91_dev_table_lcdc {
 	int			nr_pins;
 };
 
+struct at91_dev_table_tsadcc {
+	unsigned		mmio_base;
+	int			irq;
+	struct at91_pin_config	pins[4];	/* XR, XL, YT, TB */
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -174,6 +180,7 @@ struct at91_device_table {
 	struct at91_dev_table_ssc		*ssc[4];
 	struct at91_dev_table_ac97		*ac97;
 	struct at91_dev_table_lcdc		*lcdc;
+	struct at91_dev_table_tsadcc		*tsadcc;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
