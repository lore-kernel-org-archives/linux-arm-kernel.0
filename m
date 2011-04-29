From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:29 +1200
Subject: [PATCH v3 20/23] at91: Make high speed USB gadget device common
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-21-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual high-speed UDC code for each at91 variant with
a single implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |  114 ++++++------------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |   94 ++++---------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |  100 ++++----------------------
 arch/arm/mach-at91/devices.c             |   79 +++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |   20 +++++
 5 files changed, 150 insertions(+), 257 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index e6adc98..cb12e0c 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -51,105 +51,36 @@ static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
  *  USB HS Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_GADGET_ATMEL_USBA) || defined(CONFIG_USB_GADGET_ATMEL_USBA_MODULE)
-
-static struct resource usba_udc_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_UDPHS_FIFO,
-		.end	= AT91CAP9_UDPHS_FIFO + SZ_512K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_BASE_UDPHS,
-		.end	= AT91CAP9_BASE_UDPHS + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= AT91CAP9_ID_UDPHS,
-		.end	= AT91CAP9_ID_UDPHS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-#define EP(nam, idx, maxpkt, maxbk, dma, isoc)			\
-	[idx] = {						\
-		.name		= nam,				\
-		.index		= idx,				\
-		.fifo_size	= maxpkt,			\
-		.nr_banks	= maxbk,			\
-		.can_dma	= dma,				\
-		.can_isoc	= isoc,				\
-	}
-
-static struct usba_ep_data usba_udc_ep[] = {
-	EP("ep0", 0,   64, 1, 0, 0),
-	EP("ep1", 1, 1024, 3, 1, 1),
-	EP("ep2", 2, 1024, 3, 1, 1),
-	EP("ep3", 3, 1024, 2, 1, 1),
-	EP("ep4", 4, 1024, 2, 1, 1),
-	EP("ep5", 5, 1024, 2, 1, 0),
-	EP("ep6", 6, 1024, 2, 1, 0),
-	EP("ep7", 7, 1024, 2, 0, 0),
-};
-
-#undef EP
-
-/*
- * pdata doesn't have room for any endpoints, so we need to
- * append room for the ones we need right after it.
- */
-static struct {
-	struct usba_platform_data pdata;
-	struct usba_ep_data ep[8];
-} usba_udc_data;
-
-static struct platform_device at91_usba_udc_device = {
-	.name		= "atmel_usba_udc",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &usba_udc_data.pdata,
-	},
-	.resource	= usba_udc_resources,
-	.num_resources	= ARRAY_SIZE(usba_udc_resources),
-};
-
-void __init at91_add_device_usba(struct usba_platform_data *data)
+static void at91cap9_usba_init(void)
 {
 	if (cpu_is_at91cap9_revB()) {
 		irq_set_irq_type(AT91CAP9_ID_UDPHS, IRQ_TYPE_LEVEL_HIGH);
 		at91_sys_write(AT91_MATRIX_UDPHS, AT91_MATRIX_SELECT_UDPHS |
-						  AT91_MATRIX_UDPHS_BYPASS_LOCK);
-	}
-	else
+			       AT91_MATRIX_UDPHS_BYPASS_LOCK);
+	} else {
 		at91_sys_write(AT91_MATRIX_UDPHS, AT91_MATRIX_SELECT_UDPHS);
-
-	/*
-	 * Invalid pins are 0 on AT91, but the usba driver is shared
-	 * with AVR32, which use negative values instead. Once/if
-	 * gpio_is_valid() is ported to AT91, revisit this code.
-	 */
-	usba_udc_data.pdata.vbus_pin = -EINVAL;
-	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
-	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));;
-
-	if (data && data->vbus_pin > 0) {
-		at91_set_gpio_input(data->vbus_pin, 0);
-		at91_set_deglitch(data->vbus_pin, 1);
-		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
 	}
-
-	/* Pullup pin is handled internally by USB device peripheral */
-
-	/* Clocks */
-	at91_clock_associate("utmi_clk", &at91_usba_udc_device.dev, "hclk");
-	at91_clock_associate("udphs_clk", &at91_usba_udc_device.dev, "pclk");
-
-	platform_device_register(&at91_usba_udc_device);
 }
-#else
-void __init at91_add_device_usba(struct usba_platform_data *data) {}
-#endif
 
+static struct usba_ep_data usba_udc_ep[] = {
+	AT91_UDC_HS_EP("ep0", 0,   64, 1, 0, 0),
+	AT91_UDC_HS_EP("ep1", 1, 1024, 3, 1, 1),
+	AT91_UDC_HS_EP("ep2", 2, 1024, 3, 1, 1),
+	AT91_UDC_HS_EP("ep3", 3, 1024, 2, 1, 1),
+	AT91_UDC_HS_EP("ep4", 4, 1024, 2, 1, 1),
+	AT91_UDC_HS_EP("ep5", 5, 1024, 2, 1, 0),
+	AT91_UDC_HS_EP("ep6", 6, 1024, 2, 1, 0),
+	AT91_UDC_HS_EP("ep7", 7, 1024, 2, 0, 0),
+};
+
+static struct at91_dev_table_udc_hs device_udc_hs __initdata = {
+	.fifo_base	= AT91CAP9_UDPHS_FIFO,
+	.mmio_base	= AT91CAP9_BASE_UDPHS,
+	.irq		= AT91CAP9_ID_UDPHS,
+	.device_init	= at91cap9_usba_init,
+	.endpoints	= usba_udc_ep,
+	.nr_endpoints	= ARRAY_SIZE(usba_udc_ep),
+};
 
 /* --------------------------------------------------------------------
  *  Ethernet
@@ -480,6 +411,7 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.ssc[1]		= &device_ssc1,
 	.ac97		= &device_ac97,
 	.lcdc		= &device_lcdc,
+	.udc_hs		= &device_udc_hs,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 3627c2e..0d6b2b0 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -66,91 +66,24 @@ static struct at91_dev_table_basic_device device_usb_ehci __initdata = {
  *  USB HS Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_GADGET_ATMEL_USBA) || defined(CONFIG_USB_GADGET_ATMEL_USBA_MODULE)
-static struct resource usba_udc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_UDPHS_FIFO,
-		.end	= AT91SAM9G45_UDPHS_FIFO + SZ_512K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_BASE_UDPHS,
-		.end	= AT91SAM9G45_BASE_UDPHS + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= AT91SAM9G45_ID_UDPHS,
-		.end	= AT91SAM9G45_ID_UDPHS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-#define EP(nam, idx, maxpkt, maxbk, dma, isoc)			\
-	[idx] = {						\
-		.name		= nam,				\
-		.index		= idx,				\
-		.fifo_size	= maxpkt,			\
-		.nr_banks	= maxbk,			\
-		.can_dma	= dma,				\
-		.can_isoc	= isoc,				\
-	}
-
 static struct usba_ep_data usba_udc_ep[] __initdata = {
-	EP("ep0", 0, 64, 1, 0, 0),
-	EP("ep1", 1, 1024, 2, 1, 1),
-	EP("ep2", 2, 1024, 2, 1, 1),
-	EP("ep3", 3, 1024, 3, 1, 0),
-	EP("ep4", 4, 1024, 3, 1, 0),
-	EP("ep5", 5, 1024, 3, 1, 1),
-	EP("ep6", 6, 1024, 3, 1, 1),
+	AT91_UDC_HS_EP("ep0", 0, 64, 1, 0, 0),
+	AT91_UDC_HS_EP("ep1", 1, 1024, 2, 1, 1),
+	AT91_UDC_HS_EP("ep2", 2, 1024, 2, 1, 1),
+	AT91_UDC_HS_EP("ep3", 3, 1024, 3, 1, 0),
+	AT91_UDC_HS_EP("ep4", 4, 1024, 3, 1, 0),
+	AT91_UDC_HS_EP("ep5", 5, 1024, 3, 1, 1),
+	AT91_UDC_HS_EP("ep6", 6, 1024, 3, 1, 1),
 };
 
-#undef EP
-
-/*
- * pdata doesn't have room for any endpoints, so we need to
- * append room for the ones we need right after it.
- */
-static struct {
-	struct usba_platform_data pdata;
-	struct usba_ep_data ep[7];
-} usba_udc_data;
-
-static struct platform_device at91_usba_udc_device = {
-	.name		= "atmel_usba_udc",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &usba_udc_data.pdata,
-	},
-	.resource	= usba_udc_resources,
-	.num_resources	= ARRAY_SIZE(usba_udc_resources),
+static struct at91_dev_table_udc_hs device_udc_hs __initdata = {
+	.fifo_base	= AT91SAM9G45_UDPHS_FIFO,
+	.mmio_base	= AT91SAM9G45_BASE_UDPHS,
+	.irq		= AT91SAM9G45_ID_UDPHS,
+	.endpoints	= usba_udc_ep,
+	.nr_endpoints	= ARRAY_SIZE(usba_udc_ep),
 };
 
-void __init at91_add_device_usba(struct usba_platform_data *data)
-{
-	usba_udc_data.pdata.vbus_pin = -EINVAL;
-	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
-	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));;
-
-	if (data && data->vbus_pin > 0) {
-		at91_set_gpio_input(data->vbus_pin, 0);
-		at91_set_deglitch(data->vbus_pin, 1);
-		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
-	}
-
-	/* Pullup pin is handled internally by USB device peripheral */
-
-	/* Clocks */
-	at91_clock_associate("utmi_clk", &at91_usba_udc_device.dev, "hclk");
-	at91_clock_associate("udphs_clk", &at91_usba_udc_device.dev, "pclk");
-
-	platform_device_register(&at91_usba_udc_device);
-}
-#else
-void __init at91_add_device_usba(struct usba_platform_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  Ethernet
  * -------------------------------------------------------------------- */
@@ -543,6 +476,7 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.lcdc		= &device_lcdc,
 	.tsadcc		= &device_tsadcc,
 	.hdmac		= &device_hdmac,
+	.udc_hs		= &device_udc_hs,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 2aa465b..74d4363 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -40,97 +40,24 @@ static struct at91_dev_table_hdmac device_hdmac __initdata = {
  *  USB HS Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_GADGET_ATMEL_USBA) || defined(CONFIG_USB_GADGET_ATMEL_USBA_MODULE)
-
-static struct resource usba_udc_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_UDPHS_FIFO,
-		.end	= AT91SAM9RL_UDPHS_FIFO + SZ_512K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_BASE_UDPHS,
-		.end	= AT91SAM9RL_BASE_UDPHS + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= AT91SAM9RL_ID_UDPHS,
-		.end	= AT91SAM9RL_ID_UDPHS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-#define EP(nam, idx, maxpkt, maxbk, dma, isoc)			\
-	[idx] = {						\
-		.name		= nam,				\
-		.index		= idx,				\
-		.fifo_size	= maxpkt,			\
-		.nr_banks	= maxbk,			\
-		.can_dma	= dma,				\
-		.can_isoc	= isoc,				\
-	}
-
 static struct usba_ep_data usba_udc_ep[] __initdata = {
-	EP("ep0", 0, 64, 1, 0, 0),
-	EP("ep1", 1, 1024, 2, 1, 1),
-	EP("ep2", 2, 1024, 2, 1, 1),
-	EP("ep3", 3, 1024, 3, 1, 0),
-	EP("ep4", 4, 1024, 3, 1, 0),
-	EP("ep5", 5, 1024, 3, 1, 1),
-	EP("ep6", 6, 1024, 3, 1, 1),
+	AT91_UDC_HS_EP("ep0", 0, 64, 1, 0, 0),
+	AT91_UDC_HS_EP("ep1", 1, 1024, 2, 1, 1),
+	AT91_UDC_HS_EP("ep2", 2, 1024, 2, 1, 1),
+	AT91_UDC_HS_EP("ep3", 3, 1024, 3, 1, 0),
+	AT91_UDC_HS_EP("ep4", 4, 1024, 3, 1, 0),
+	AT91_UDC_HS_EP("ep5", 5, 1024, 3, 1, 1),
+	AT91_UDC_HS_EP("ep6", 6, 1024, 3, 1, 1),
 };
 
-#undef EP
-
-/*
- * pdata doesn't have room for any endpoints, so we need to
- * append room for the ones we need right after it.
- */
-static struct {
-	struct usba_platform_data pdata;
-	struct usba_ep_data ep[7];
-} usba_udc_data;
-
-static struct platform_device at91_usba_udc_device = {
-	.name		= "atmel_usba_udc",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &usba_udc_data.pdata,
-	},
-	.resource	= usba_udc_resources,
-	.num_resources	= ARRAY_SIZE(usba_udc_resources),
+static struct at91_dev_table_udc_hs device_udc_hs __initdata = {
+	.fifo_base	= AT91SAM9RL_UDPHS_FIFO,
+	.mmio_base	= AT91SAM9RL_BASE_UDPHS,
+	.irq		= AT91SAM9RL_ID_UDPHS,
+	.endpoints	= usba_udc_ep,
+	.nr_endpoints	= ARRAY_SIZE(usba_udc_ep),
 };
 
-void __init at91_add_device_usba(struct usba_platform_data *data)
-{
-	/*
-	 * Invalid pins are 0 on AT91, but the usba driver is shared
-	 * with AVR32, which use negative values instead. Once/if
-	 * gpio_is_valid() is ported to AT91, revisit this code.
-	 */
-	usba_udc_data.pdata.vbus_pin = -EINVAL;
-	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
-	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));;
-
-	if (data && data->vbus_pin > 0) {
-		at91_set_gpio_input(data->vbus_pin, 0);
-		at91_set_deglitch(data->vbus_pin, 1);
-		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
-	}
-
-	/* Pullup pin is handled internally by USB device peripheral */
-
-	/* Clocks */
-	at91_clock_associate("utmi_clk", &at91_usba_udc_device.dev, "hclk");
-	at91_clock_associate("udphs_clk", &at91_usba_udc_device.dev, "pclk");
-
-	platform_device_register(&at91_usba_udc_device);
-}
-#else
-void __init at91_add_device_usba(struct usba_platform_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  MMC / SD
  * -------------------------------------------------------------------- */
@@ -419,6 +346,7 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.lcdc		= &device_lcdc,
 	.tsadcc		= &device_tsadcc,
 	.hdmac		= &device_hdmac,
+	.udc_hs		= &device_udc_hs,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index b867663..a281651 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -1764,6 +1764,85 @@ static void __init at91_add_device_rtc(void)
 static void __init at91_add_device_rtc(void) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  USB HS Device (Gadget)
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_USB_GADGET_ATMEL_USBA) || defined(CONFIG_USB_GADGET_ATMEL_USBA_MODULE)
+static struct resource usba_udc_resources[] = {
+	[0] = {
+		.end	= SZ_512K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.end	= SZ_1K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+/*
+ * pdata doesn't have room for any endpoints, so we need to
+ * append room for the ones we need right after it.
+ */
+static struct {
+	struct usba_platform_data pdata;
+	struct usba_ep_data ep[8];
+} usba_udc_data;
+
+static struct platform_device at91_usba_udc_device = {
+	.name		= "atmel_usba_udc",
+	.id		= -1,
+	.dev		= {
+				.platform_data	= &usba_udc_data.pdata,
+	},
+	.resource	= usba_udc_resources,
+	.num_resources	= ARRAY_SIZE(usba_udc_resources),
+};
+
+void __init at91_add_device_usba(struct usba_platform_data *data)
+{
+	struct at91_dev_table_udc_hs *info = devices->udc_hs;
+
+	BUG_ON(!info);
+	init_resource_mem(&usba_udc_resources[0], info->fifo_base);
+	init_resource_mem(&usba_udc_resources[1], info->mmio_base);
+	init_resource_irq(&usba_udc_resources[2], info->irq);
+
+	/* Custom platform initialisation */
+	if (info->device_init)
+		info->device_init();
+
+	/*
+	 * Invalid pins are 0 on AT91, but the usba driver is shared
+	 * with AVR32, which use negative values instead. Once/if
+	 * gpio_is_valid() is ported to AT91, revisit this code.
+	 */
+	usba_udc_data.pdata.vbus_pin = -EINVAL;
+	usba_udc_data.pdata.num_ep = info->nr_endpoints;
+	memcpy(usba_udc_data.ep, info->endpoints,
+	       info->nr_endpoints * sizeof(struct usba_ep_data));
+
+	if (data && data->vbus_pin > 0) {
+		at91_set_gpio_input(data->vbus_pin, 0);
+		at91_set_deglitch(data->vbus_pin, 1);
+		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
+	}
+
+	/* Pullup pin is handled internally by USB device peripheral */
+
+	/* Clocks */
+	at91_clock_associate("utmi_clk", &at91_usba_udc_device.dev, "hclk");
+	at91_clock_associate("udphs_clk", &at91_usba_udc_device.dev, "pclk");
+
+	platform_device_register(&at91_usba_udc_device);
+}
+#else
+void __init at91_add_device_usba(struct usba_platform_data *data) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 417c959..a1374fa 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -170,6 +170,25 @@ struct at91_dev_table_hdmac {
 	int			have_slave;
 };
 
+#define AT91_UDC_HS_EP(nam, idx, maxpkt, maxbk, dma, isoc)	\
+	[idx] = {						\
+		.name		= nam,				\
+		.index		= idx,				\
+		.fifo_size	= maxpkt,			\
+		.nr_banks	= maxbk,			\
+		.can_dma	= dma,				\
+		.can_isoc	= isoc,				\
+	}
+
+struct at91_dev_table_udc_hs {
+	unsigned		fifo_base;
+	unsigned		mmio_base;
+	int			irq;
+	void			(*device_init)(void);
+	struct usba_ep_data	*endpoints;
+	int			nr_endpoints;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -189,6 +208,7 @@ struct at91_device_table {
 	struct at91_dev_table_lcdc		*lcdc;
 	struct at91_dev_table_tsadcc		*tsadcc;
 	struct at91_dev_table_hdmac		*hdmac;
+	struct at91_dev_table_udc_hs		*udc_hs;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
