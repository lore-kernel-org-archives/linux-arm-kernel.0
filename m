From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:18 +1200
Subject: [PATCH V4 04/23] at91: Make UDC device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-5-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual UDC device code for each at91 variant with a
single implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c |   48 ++---------------------------
 arch/arm/mach-at91/at91rm9200_devices.c  |   48 ++---------------------------
 arch/arm/mach-at91/at91sam9260_devices.c |   48 ++---------------------------
 arch/arm/mach-at91/at91sam9261_devices.c |   47 ++--------------------------
 arch/arm/mach-at91/at91sam9263_devices.c |   48 ++---------------------------
 arch/arm/mach-at91/devices.c             |   36 ++++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |    1 +
 7 files changed, 57 insertions(+), 219 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 07aff96..da27bdb 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -51,52 +51,11 @@ static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_GADGET_AT91
-static struct at91_udc_data udc_data;
-
-static struct resource udc_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_UDP,
-		.end	= AT572D940HF_BASE_UDP + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_UDP,
-		.end	= AT572D940HF_ID_UDP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at572d940hf_udc_device = {
-	.name		= "at91_udc",
-	.id		= -1,
-	.dev		= {
-				.platform_data		= &udc_data,
-	},
-	.resource	= udc_resources,
-	.num_resources	= ARRAY_SIZE(udc_resources),
+static struct at91_dev_table_basic_device device_udc __initdata = {
+	.mmio_base	= AT572D940HF_BASE_UDP,
+	.irq		= AT572D940HF_ID_UDP,
 };
 
-void __init at91_add_device_udc(struct at91_udc_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->vbus_pin) {
-		at91_set_gpio_input(data->vbus_pin, 0);
-		at91_set_deglitch(data->vbus_pin, 1);
-	}
-
-	/* Pullup pin is handled internally */
-
-	udc_data = *data;
-	platform_device_register(&at572d940hf_udc_device);
-}
-#else
-void __init at91_add_device_udc(struct at91_udc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Ethernet
  * -------------------------------------------------------------------- */
@@ -876,6 +835,7 @@ void __init at91_add_device_mAgic(void) {}
 static struct at91_device_table at572d940hf_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
+	.udc		= &device_udc,
 };
 
 void __init at572d940hf_init_devices(void)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index e6fa6a4..09e771c 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -38,52 +38,11 @@ static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_GADGET_AT91
-static struct at91_udc_data udc_data;
-
-static struct resource udc_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_BASE_UDP,
-		.end	= AT91RM9200_BASE_UDP + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_UDP,
-		.end	= AT91RM9200_ID_UDP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91rm9200_udc_device = {
-	.name		= "at91_udc",
-	.id		= -1,
-	.dev		= {
-				.platform_data		= &udc_data,
-	},
-	.resource	= udc_resources,
-	.num_resources	= ARRAY_SIZE(udc_resources),
+static struct at91_dev_table_basic_device device_udc __initdata = {
+	.mmio_base	= AT91RM9200_BASE_UDP,
+	.irq		= AT91RM9200_ID_UDP,
 };
 
-void __init at91_add_device_udc(struct at91_udc_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->vbus_pin) {
-		at91_set_gpio_input(data->vbus_pin, 0);
-		at91_set_deglitch(data->vbus_pin, 1);
-	}
-	if (data->pullup_pin)
-		at91_set_gpio_output(data->pullup_pin, 0);
-
-	udc_data = *data;
-	platform_device_register(&at91rm9200_udc_device);
-}
-#else
-void __init at91_add_device_udc(struct at91_udc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Ethernet
  * -------------------------------------------------------------------- */
@@ -1099,6 +1058,7 @@ void __init at91_add_device_serial(void) {}
 static struct at91_device_table at91rm9200_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
+	.udc		= &device_udc,
 };
 
 void __init at91rm9200_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 03848b8..16ec548 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -39,52 +39,11 @@ static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_GADGET_AT91
-static struct at91_udc_data udc_data;
-
-static struct resource udc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_UDP,
-		.end	= AT91SAM9260_BASE_UDP + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_UDP,
-		.end	= AT91SAM9260_ID_UDP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_udc_device = {
-	.name		= "at91_udc",
-	.id		= -1,
-	.dev		= {
-				.platform_data		= &udc_data,
-	},
-	.resource	= udc_resources,
-	.num_resources	= ARRAY_SIZE(udc_resources),
+static struct at91_dev_table_basic_device device_udc __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_UDP,
+	.irq		= AT91SAM9260_ID_UDP,
 };
 
-void __init at91_add_device_udc(struct at91_udc_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->vbus_pin) {
-		at91_set_gpio_input(data->vbus_pin, 0);
-		at91_set_deglitch(data->vbus_pin, 1);
-	}
-
-	/* Pullup pin is handled internally by USB device peripheral */
-
-	udc_data = *data;
-	platform_device_register(&at91_udc_device);
-}
-#else
-void __init at91_add_device_udc(struct at91_udc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Ethernet
  * -------------------------------------------------------------------- */
@@ -1255,6 +1214,7 @@ void __init at91_add_device_cf(struct at91_cf_data * data) {}
 static struct at91_device_table at91sam9260_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
+	.udc		= &device_udc,
 };
 
 void __init at91sam9260_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index c7c2403..8fe0fd3 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -42,51 +42,11 @@ static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_GADGET_AT91
-static struct at91_udc_data udc_data;
-
-static struct resource udc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_UDP,
-		.end	= AT91SAM9261_BASE_UDP + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_UDP,
-		.end	= AT91SAM9261_ID_UDP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9261_udc_device = {
-	.name		= "at91_udc",
-	.id		= -1,
-	.dev		= {
-				.platform_data		= &udc_data,
-	},
-	.resource	= udc_resources,
-	.num_resources	= ARRAY_SIZE(udc_resources),
+static struct at91_dev_table_basic_device device_udc __initdata = {
+	.mmio_base	= AT91SAM9261_BASE_UDP,
+	.irq		= AT91SAM9261_ID_UDP,
 };
 
-void __init at91_add_device_udc(struct at91_udc_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->vbus_pin) {
-		at91_set_gpio_input(data->vbus_pin, 0);
-		at91_set_deglitch(data->vbus_pin, 1);
-	}
-
-	/* Pullup pin is handled internally by USB device peripheral */
-
-	udc_data = *data;
-	platform_device_register(&at91sam9261_udc_device);
-}
-#else
-void __init at91_add_device_udc(struct at91_udc_data *data) {}
-#endif
-
 /* --------------------------------------------------------------------
  *  MMC / SD
  * -------------------------------------------------------------------- */
@@ -1009,6 +969,7 @@ void __init at91_add_device_serial(void) {}
 
 static struct at91_device_table at91sam9261_device_table __initdata = {
 	.usbh_ohci	= &device_usbh_ohci,
+	.udc		= &device_udc,
 };
 
 void __init at91sam9261_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 9252c48..2f9b0d2 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -42,52 +42,11 @@ static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_GADGET_AT91
-static struct at91_udc_data udc_data;
-
-static struct resource udc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_UDP,
-		.end	= AT91SAM9263_BASE_UDP + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_UDP,
-		.end	= AT91SAM9263_ID_UDP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_udc_device = {
-	.name		= "at91_udc",
-	.id		= -1,
-	.dev		= {
-				.platform_data		= &udc_data,
-	},
-	.resource	= udc_resources,
-	.num_resources	= ARRAY_SIZE(udc_resources),
+static struct at91_dev_table_basic_device device_udc __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_UDP,
+	.irq		= AT91SAM9263_ID_UDP,
 };
 
-void __init at91_add_device_udc(struct at91_udc_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->vbus_pin) {
-		at91_set_gpio_input(data->vbus_pin, 0);
-		at91_set_deglitch(data->vbus_pin, 1);
-	}
-
-	/* Pullup pin is handled internally by USB device peripheral */
-
-	udc_data = *data;
-	platform_device_register(&at91_udc_device);
-}
-#else
-void __init at91_add_device_udc(struct at91_udc_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Ethernet
  * -------------------------------------------------------------------- */
@@ -1347,6 +1306,7 @@ void __init at91_add_device_serial(void) {}
 static struct at91_device_table at91sam9263_device_table __initdata = {
 	.ethernet	= &device_eth,
 	.usbh_ohci	= &device_usbh_ohci,
+	.udc		= &device_udc,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 759ae0c..4e1288c 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -208,6 +208,42 @@ void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data) {}
 #endif
 
 /* --------------------------------------------------------------------
+ *  USB Device (Gadget)
+ * -------------------------------------------------------------------- */
+#ifdef CONFIG_USB_GADGET_AT91
+
+static struct platform_device at91_udc_device = {
+	.name	= "at91_udc",
+	.id	= -1,
+};
+
+void __init at91_add_device_udc(struct at91_udc_data *data)
+{
+	struct at91_dev_table_basic_device *info = devices->udc;
+	struct resource resources[2] = {{0}};
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_16K);
+	init_resource_irq(&resources[1], info->irq);
+
+	if (!data)
+		return;
+
+	if (data->vbus_pin) {
+		at91_set_gpio_input(data->vbus_pin, 0);
+		at91_set_deglitch(data->vbus_pin, 1);
+	}
+	if (data->pullup_pin)
+		at91_set_gpio_output(data->pullup_pin, 0);
+
+	at91_add_platform_device(&at91_udc_device, resources,
+				 ARRAY_SIZE(resources), data, sizeof(*data));
+}
+#else
+void __init at91_add_device_udc(struct at91_udc_data *data) {}
+#endif
+
+/* --------------------------------------------------------------------
  *  Ethernet
  * -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index eb4de05..9203f58 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -52,6 +52,7 @@ struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
 	struct at91_dev_table_basic_device	*usbh_ehci;
+	struct at91_dev_table_basic_device	*udc;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
