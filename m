From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:17 +1200
Subject: [PATCH V4 03/23] at91: Make USB OHCI/EHCI devices common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-4-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual USB OHCI and EHCI (AT91SAM9G45 only) device code for
each at91 variant with a single implementation in devices.c. Rename
at91_add_device_usbh to at91_add_device_usbh_ohci (as it is on AT91SAM9G45)
to make the API consistent for all variants.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c  |   45 +-----------
 arch/arm/mach-at91/at91cap9_devices.c     |   54 ++-------------
 arch/arm/mach-at91/at91rm9200_devices.c   |   44 +-----------
 arch/arm/mach-at91/at91sam9260_devices.c  |   44 +-----------
 arch/arm/mach-at91/at91sam9261.c          |    4 +
 arch/arm/mach-at91/at91sam9261_devices.c  |   53 +++-----------
 arch/arm/mach-at91/at91sam9263_devices.c  |   52 +-------------
 arch/arm/mach-at91/at91sam9g45_devices.c  |  105 ++--------------------------
 arch/arm/mach-at91/board-1arm.c           |    2 +-
 arch/arm/mach-at91/board-afeb-9260v1.c    |    2 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c |    2 +-
 arch/arm/mach-at91/board-cam60.c          |    2 +-
 arch/arm/mach-at91/board-cap9adk.c        |    2 +-
 arch/arm/mach-at91/board-carmeva.c        |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c       |    2 +-
 arch/arm/mach-at91/board-cpuat91.c        |    2 +-
 arch/arm/mach-at91/board-csb337.c         |    2 +-
 arch/arm/mach-at91/board-csb637.c         |    2 +-
 arch/arm/mach-at91/board-eb9200.c         |    2 +-
 arch/arm/mach-at91/board-ecbat91.c        |    2 +-
 arch/arm/mach-at91/board-eco920.c         |    2 +-
 arch/arm/mach-at91/board-flexibity.c      |    2 +-
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
 arch/arm/mach-at91/board-snapper9260.c    |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c      |    4 +-
 arch/arm/mach-at91/board-usb-a9260.c      |    2 +-
 arch/arm/mach-at91/board-usb-a9263.c      |    2 +-
 arch/arm/mach-at91/board-yl-9200.c        |    2 +-
 arch/arm/mach-at91/devices.c              |   90 ++++++++++++++++++++++++
 arch/arm/mach-at91/devices.h              |   13 ++++
 arch/arm/mach-at91/include/mach/board.h   |    1 -
 45 files changed, 185 insertions(+), 390 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 203802a..07aff96 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -42,49 +42,11 @@
  *  USB Host
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-static struct at91_usbh_data usbh_data;
-
-static struct resource usbh_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_UHP_BASE,
-		.end	= AT572D940HF_UHP_BASE + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_UHP,
-		.end	= AT572D940HF_ID_UHP,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
+	.mmio_base	= AT572D940HF_UHP_BASE,
+	.irq		= AT572D940HF_ID_UHP,
 };
 
-static struct platform_device at572d940hf_usbh_device = {
-	.name		= "at91_ohci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &ohci_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &usbh_data,
-	},
-	.resource	= usbh_resources,
-	.num_resources	= ARRAY_SIZE(usbh_resources),
-};
-
-void __init at91_add_device_usbh(struct at91_usbh_data *data)
-{
-	if (!data)
-		return;
-
-	usbh_data = *data;
-	platform_device_register(&at572d940hf_usbh_device);
-
-}
-#else
-void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
@@ -913,6 +875,7 @@ void __init at91_add_device_mAgic(void) {}
 
 static struct at91_device_table at572d940hf_device_table __initdata = {
 	.ethernet	= &device_eth,
+	.usbh_ohci	= &device_usbh_ohci,
 };
 
 void __init at572d940hf_init_devices(void)
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 732c914..1b213b0 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -35,58 +35,17 @@
  *  USB Host
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-static struct at91_usbh_data usbh_data;
-
-static struct resource usbh_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_UHP_BASE,
-		.end	= AT91CAP9_UHP_BASE + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_UHP,
-		.end	= AT91CAP9_ID_UHP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_usbh_device = {
-	.name		= "at91_ohci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &ohci_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &usbh_data,
-	},
-	.resource	= usbh_resources,
-	.num_resources	= ARRAY_SIZE(usbh_resources),
-};
-
-void __init at91_add_device_usbh(struct at91_usbh_data *data)
+static void __init at91cap9_usb_ohci_init(void)
 {
-	int i;
-
-	if (!data)
-		return;
-
 	if (cpu_is_at91cap9_revB())
 		irq_set_irq_type(AT91CAP9_ID_UHP, IRQ_TYPE_LEVEL_HIGH);
-
-	/* Enable VBus control for UHP ports */
-	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
-			at91_set_gpio_output(data->vbus_pin[i], 0);
-	}
-
-	usbh_data = *data;
-	platform_device_register(&at91_usbh_device);
 }
-#else
-void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
-#endif
 
+static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
+	.mmio_base	= AT91CAP9_UHP_BASE,
+	.irq		= AT91CAP9_ID_UHP,
+	.device_init	= at91cap9_usb_ohci_init,
+};
 
 /* --------------------------------------------------------------------
  *  USB HS Device (Gadget)
@@ -1219,6 +1178,7 @@ void __init at91_add_device_serial(void) {}
 
 static struct at91_device_table at91cap9_device_table __initdata = {
 	.ethernet	= &device_eth,
+	.usbh_ohci	= &device_usbh_ohci,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 6365929..e6fa6a4 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -29,48 +29,11 @@
  *  USB Host
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-static struct at91_usbh_data usbh_data;
-
-static struct resource usbh_resources[] = {
-	[0] = {
-		.start	= AT91RM9200_UHP_BASE,
-		.end	= AT91RM9200_UHP_BASE + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_UHP,
-		.end	= AT91RM9200_ID_UHP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91rm9200_usbh_device = {
-	.name		= "at91_ohci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &ohci_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &usbh_data,
-	},
-	.resource	= usbh_resources,
-	.num_resources	= ARRAY_SIZE(usbh_resources),
+static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
+	.mmio_base	= AT91RM9200_UHP_BASE,
+	.irq		= AT91RM9200_ID_UHP,
 };
 
-void __init at91_add_device_usbh(struct at91_usbh_data *data)
-{
-	if (!data)
-		return;
-
-	usbh_data = *data;
-	platform_device_register(&at91rm9200_usbh_device);
-}
-#else
-void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
@@ -1135,6 +1098,7 @@ void __init at91_add_device_serial(void) {}
 
 static struct at91_device_table at91rm9200_device_table __initdata = {
 	.ethernet	= &device_eth,
+	.usbh_ohci	= &device_usbh_ohci,
 };
 
 void __init at91rm9200_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index c19f79a..03848b8 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -30,48 +30,11 @@
  *  USB Host
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-static struct at91_usbh_data usbh_data;
-
-static struct resource usbh_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_UHP_BASE,
-		.end	= AT91SAM9260_UHP_BASE + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_UHP,
-		.end	= AT91SAM9260_ID_UHP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_usbh_device = {
-	.name		= "at91_ohci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &ohci_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &usbh_data,
-	},
-	.resource	= usbh_resources,
-	.num_resources	= ARRAY_SIZE(usbh_resources),
+static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
+	.mmio_base	= AT91SAM9260_UHP_BASE,
+	.irq		= AT91SAM9260_ID_UHP,
 };
 
-void __init at91_add_device_usbh(struct at91_usbh_data *data)
-{
-	if (!data)
-		return;
-
-	usbh_data = *data;
-	platform_device_register(&at91_usbh_device);
-}
-#else
-void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
@@ -1291,6 +1254,7 @@ void __init at91_add_device_cf(struct at91_cf_data * data) {}
 
 static struct at91_device_table at91sam9260_device_table __initdata = {
 	.ethernet	= &device_eth,
+	.usbh_ohci	= &device_usbh_ohci,
 };
 
 void __init at91sam9260_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index fcad886..dd0a96d 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -25,6 +25,8 @@
 #include "generic.h"
 #include "clock.h"
 
+extern void at91sam9261_init_devices(void);
+
 static struct map_desc at91sam9261_io_desc[] __initdata = {
 	{
 		.virtual	= AT91_VA_BASE_SYS,
@@ -272,6 +274,8 @@ void __init at91sam9261_initialize(unsigned long main_clock)
 	/* Map peripherals */
 	iotable_init(at91sam9261_io_desc, ARRAY_SIZE(at91sam9261_io_desc));
 
+	at91sam9261_init_devices();
+
 	if (cpu_is_at91sam9g10())
 		iotable_init(at91sam9g10_sram_desc, ARRAY_SIZE(at91sam9g10_sram_desc));
 	else
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 59fc483..c7c2403 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -27,54 +27,17 @@
 #include <mach/at91sam9_smc.h>
 
 #include "generic.h"
-
+#include "devices.h"
 
 /* --------------------------------------------------------------------
  *  USB Host
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-static struct at91_usbh_data usbh_data;
-
-static struct resource usbh_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_UHP_BASE,
-		.end	= AT91SAM9261_UHP_BASE + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9261_ID_UHP,
-		.end	= AT91SAM9261_ID_UHP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91sam9261_usbh_device = {
-	.name		= "at91_ohci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &ohci_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &usbh_data,
-	},
-	.resource	= usbh_resources,
-	.num_resources	= ARRAY_SIZE(usbh_resources),
+static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
+	.mmio_base	= AT91SAM9261_UHP_BASE,
+	.irq		= AT91SAM9261_ID_UHP,
 };
 
-void __init at91_add_device_usbh(struct at91_usbh_data *data)
-{
-	if (!data)
-		return;
-
-	usbh_data = *data;
-	platform_device_register(&at91sam9261_usbh_device);
-}
-#else
-void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
@@ -1044,6 +1007,14 @@ void __init at91_set_serial_console(unsigned portnr) {}
 void __init at91_add_device_serial(void) {}
 #endif
 
+static struct at91_device_table at91sam9261_device_table __initdata = {
+	.usbh_ohci	= &device_usbh_ohci,
+};
+
+void __init at91sam9261_init_devices(void)
+{
+	at91_init_devices(&at91sam9261_device_table);
+}
 
 /* -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index ea49dc0..9252c48 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -33,56 +33,11 @@
  *  USB Host
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-static struct at91_usbh_data usbh_data;
-
-static struct resource usbh_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_UHP_BASE,
-		.end	= AT91SAM9263_UHP_BASE + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_UHP,
-		.end	= AT91SAM9263_ID_UHP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_usbh_device = {
-	.name		= "at91_ohci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &ohci_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &usbh_data,
-	},
-	.resource	= usbh_resources,
-	.num_resources	= ARRAY_SIZE(usbh_resources),
+static struct at91_dev_table_usb_ohci device_usbh_ohci __initdata = {
+	.mmio_base	= AT91SAM9263_UHP_BASE,
+	.irq		= AT91SAM9263_ID_UHP,
 };
 
-void __init at91_add_device_usbh(struct at91_usbh_data *data)
-{
-	int i;
-
-	if (!data)
-		return;
-
-	/* Enable VBus control for UHP ports */
-	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
-			at91_set_gpio_output(data->vbus_pin[i], 0);
-	}
-
-	usbh_data = *data;
-	platform_device_register(&at91_usbh_device);
-}
-#else
-void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
@@ -1391,6 +1346,7 @@ void __init at91_add_device_serial(void) {}
 
 static struct at91_device_table at91sam9263_device_table __initdata = {
 	.ethernet	= &device_eth,
+	.usbh_ohci	= &device_usbh_ohci,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 5e25700..e49a873 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -83,112 +83,21 @@ void __init at91_add_device_hdmac(void) {}
  *  USB Host (OHCI)
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-static struct at91_usbh_data usbh_ohci_data;
-
-static struct resource usbh_ohci_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_OHCI_BASE,
-		.end	= AT91SAM9G45_OHCI_BASE + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_UHPHS,
-		.end	= AT91SAM9G45_ID_UHPHS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_usbh_ohci_device = {
-	.name		= "at91_ohci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &ohci_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &usbh_ohci_data,
-	},
-	.resource	= usbh_ohci_resources,
-	.num_resources	= ARRAY_SIZE(usbh_ohci_resources),
+static struct at91_dev_table_usb_ohci device_usb_ohci __initdata = {
+	.mmio_base	= AT91SAM9G45_OHCI_BASE,
+	.irq		= AT91SAM9G45_ID_UHPHS,
 };
 
-void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data)
-{
-	int i;
-
-	if (!data)
-		return;
-
-	/* Enable VBus control for UHP ports */
-	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
-			at91_set_gpio_output(data->vbus_pin[i], 0);
-	}
-
-	usbh_ohci_data = *data;
-	platform_device_register(&at91_usbh_ohci_device);
-}
-#else
-void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  USB Host HS (EHCI)
  *  Needs an OHCI host for low and full speed management
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
-static u64 ehci_dmamask = DMA_BIT_MASK(32);
-static struct at91_usbh_data usbh_ehci_data;
-
-static struct resource usbh_ehci_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_EHCI_BASE,
-		.end	= AT91SAM9G45_EHCI_BASE + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_UHPHS,
-		.end	= AT91SAM9G45_ID_UHPHS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_usbh_ehci_device = {
-	.name		= "atmel-ehci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &ehci_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &usbh_ehci_data,
-	},
-	.resource	= usbh_ehci_resources,
-	.num_resources	= ARRAY_SIZE(usbh_ehci_resources),
+static struct at91_dev_table_basic_device device_usb_ehci __initdata = {
+	.mmio_base	= AT91SAM9G45_EHCI_BASE,
+	.irq		= AT91SAM9G45_ID_UHPHS,
 };
 
-void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data)
-{
-	int i;
-
-	if (!data)
-		return;
-
-	/* Enable VBus control for UHP ports */
-	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
-			at91_set_gpio_output(data->vbus_pin[i], 0);
-	}
-
-	usbh_ehci_data = *data;
-	at91_clock_associate("uhphs_clk", &at91_usbh_ehci_device.dev, "ehci_clk");
-	platform_device_register(&at91_usbh_ehci_device);
-}
-#else
-void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  USB HS Device (Gadget)
  * -------------------------------------------------------------------- */
@@ -1553,6 +1462,8 @@ void __init at91_add_device_serial(void) {}
 
 static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.ethernet	= &device_eth,
+	.usbh_ohci	= &device_usb_ohci,
+	.usbh_ehci	= &device_usb_ehci,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 8a3fc84..244e8bb 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -85,7 +85,7 @@ static void __init onearm_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&onearm_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&onearm_usbh_data);
+	at91_add_device_usbh_ohci(&onearm_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&onearm_udc_data);
 }
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index cba7f77..88d08ae 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -189,7 +189,7 @@ static void __init afeb9260_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&afeb9260_usbh_data);
+	at91_add_device_usbh_ohci(&afeb9260_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&afeb9260_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index 3929f1c..c9ab05d 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -297,7 +297,7 @@ static void __init eb_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&eb_usbh_data);
+	at91_add_device_usbh_ohci(&eb_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&eb_udc_data);
 	/* I2C */
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index b54e3e6..014271d 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -191,7 +191,7 @@ static void __init cam60_board_init(void)
 	/* USB Host */
 	/* enable USB power supply circuit */
 	at91_set_gpio_output(AT91_PIN_PB18, 1);
-	at91_add_device_usbh(&cam60_usbh_data);
+	at91_add_device_usbh_ohci(&cam60_usbh_data);
 	/* NAND */
 	cam60_add_device_nand();
 }
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index e727444..0d60378 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -374,7 +374,7 @@ static void __init cap9adk_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&cap9adk_usbh_data);
+	at91_add_device_usbh_ohci(&cap9adk_usbh_data);
 	/* USB HS */
 	at91_add_device_usba(&cap9adk_usba_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 2e74a19..9d007a8 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -145,7 +145,7 @@ static void __init carmeva_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&carmeva_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&carmeva_usbh_data);
+	at91_add_device_usbh_ohci(&carmeva_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&carmeva_udc_data);
 	/* I2C */
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 3838594..65c6513 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -351,7 +351,7 @@ static void __init cpu9krea_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&cpu9krea_usbh_data);
+	at91_add_device_usbh_ohci(&cpu9krea_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&cpu9krea_udc_data);
 	/* NAND */
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 2f4dd8c..ce3525d 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -162,7 +162,7 @@ static void __init cpuat91_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&cpuat91_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&cpuat91_usbh_data);
+	at91_add_device_usbh_ohci(&cpuat91_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&cpuat91_udc_data);
 	/* MMC */
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 464839d..ff7b8c0 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -235,7 +235,7 @@ static void __init csb337_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&csb337_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&csb337_usbh_data);
+	at91_add_device_usbh_ohci(&csb337_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&csb337_udc_data);
 	/* I2C */
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 431688c..74d5b7e 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -125,7 +125,7 @@ static void __init csb637_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&csb637_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&csb637_usbh_data);
+	at91_add_device_usbh_ohci(&csb637_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&csb637_udc_data);
 	/* I2C */
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 6cf6566..3705082 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -105,7 +105,7 @@ static void __init eb9200_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&eb9200_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&eb9200_usbh_data);
+	at91_add_device_usbh_ohci(&eb9200_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&eb9200_udc_data);
 	/* I2C */
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index de2fd04..df4a07f 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -154,7 +154,7 @@ static void __init ecb_at91board_init(void)
 	at91_add_device_eth(&ecb_at91eth_data);
 
 	/* USB Host */
-	at91_add_device_usbh(&ecb_at91usbh_data);
+	at91_add_device_usbh_ohci(&ecb_at91usbh_data);
 
 	/* I2C */
 	at91_add_device_i2c(NULL, 0);
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index a158a0c..7988b58 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -114,7 +114,7 @@ static void __init eco920_board_init(void)
 {
 	at91_add_device_serial();
 	at91_add_device_eth(&eco920_eth_data);
-	at91_add_device_usbh(&eco920_usbh_data);
+	at91_add_device_usbh_ohci(&eco920_usbh_data);
 	at91_add_device_udc(&eco920_udc_data);
 
 	at91_add_device_mmc(0, &eco920_mmc_data);
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index c8a62dc..096d5d2 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -140,7 +140,7 @@ static void __init flexibity_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&flexibity_usbh_data);
+	at91_add_device_usbh_ohci(&flexibity_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&flexibity_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index dfc7dfe..6688ec2 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -244,7 +244,7 @@ static void __init foxg20_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&foxg20_usbh_data);
+	at91_add_device_usbh_ohci(&foxg20_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&foxg20_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index bc28136..8b1d498 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -561,7 +561,7 @@ static int __init gsia18s_power_off_init(void)
 static void __init gsia18s_board_init(void)
 {
 	stamp9g20_board_init();
-	at91_add_device_usbh(&usbh_data);
+	at91_add_device_usbh_ohci(&usbh_data);
 	at91_add_device_udc(&udc_data);
 	at91_add_device_eth(&macb_data);
 	gsia18s_leds_init();
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index d2e1f4e..a0cac24 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -83,7 +83,7 @@ static void __init kafa_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&kafa_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&kafa_usbh_data);
+	at91_add_device_usbh_ohci(&kafa_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&kafa_udc_data);
 	/* I2C */
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index a13d206..59eafa2 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -121,7 +121,7 @@ static void __init kb9202_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&kb9202_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&kb9202_usbh_data);
+	at91_add_device_usbh_ohci(&kb9202_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&kb9202_udc_data);
 	/* MMC */
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index fe5f1d4..bffbbdf 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -351,7 +351,7 @@ static void __init neocore926_board_init(void)
 	at91_add_device_serial();
 
 	/* USB Host */
-	at91_add_device_usbh(&neocore926_usbh_data);
+	at91_add_device_usbh_ohci(&neocore926_usbh_data);
 
 	/* USB Device */
 	at91_add_device_udc(&neocore926_udc_data);
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index feb6578..4c5848d 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -205,7 +205,7 @@ static struct spi_board_info pcontrol_g20_spi_devices[] = {
 static void __init pcontrol_g20_board_init(void)
 {
 	stamp9g20_board_init();
-	at91_add_device_usbh(&usbh_data);
+	at91_add_device_usbh_ohci(&usbh_data);
 	at91_add_device_eth(&macb_data);
 	at91_add_device_i2c(pcontrol_g20_i2c_devices,
 		ARRAY_SIZE(pcontrol_g20_i2c_devices));
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 55dad3a..419456d 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -111,7 +111,7 @@ static void __init picotux200_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&picotux200_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&picotux200_usbh_data);
+	at91_add_device_usbh_ohci(&picotux200_usbh_data);
 	/* I2C */
 	at91_add_device_i2c(NULL, 0);
 	/* MMC */
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 69d15a8..255a984 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -244,7 +244,7 @@ static void __init ek_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
+	at91_add_device_usbh_ohci(&ek_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 4c1047c..3d54963 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -197,7 +197,7 @@ static void __init dk_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&dk_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&dk_usbh_data);
+	at91_add_device_usbh_ohci(&dk_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&dk_udc_data);
 	at91_set_multi_drive(dk_udc_data.pullup_pin, 1);	/* pullup_pin is connected to reset */
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 9df1be8..25fe19f 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -167,7 +167,7 @@ static void __init ek_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&ek_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
+	at91_add_device_usbh_ohci(&ek_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	at91_set_multi_drive(ek_udc_data.pullup_pin, 1);	/* pullup_pin is connected to reset */
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 25a26be..589e2f4 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -195,7 +195,7 @@ static void __init ek_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
+	at91_add_device_usbh_ohci(&ek_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index de1816e..b98e766 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -332,7 +332,7 @@ static void __init ek_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
+	at91_add_device_usbh_ohci(&ek_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 14acc90..e631172 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -586,7 +586,7 @@ static void __init ek_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
+	at91_add_device_usbh_ohci(&ek_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	/* I2C */
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index bfe490d..fae6ebf 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -423,7 +423,7 @@ static void __init ek_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
+	at91_add_device_usbh_ohci(&ek_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index ca8198b..c25e44c 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -379,7 +379,7 @@ static void __init ek_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
+	at91_add_device_usbh_ohci(&ek_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index 17f7d9b..ca14290 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -169,7 +169,7 @@ static void __init snapper9260_board_init(void)
 	at91_add_device_i2c(snapper9260_i2c_devices,
 			    ARRAY_SIZE(snapper9260_i2c_devices));
 	at91_add_device_serial();
-	at91_add_device_usbh(&snapper9260_usbh_data);
+	at91_add_device_usbh_ohci(&snapper9260_usbh_data);
 	at91_add_device_udc(&snapper9260_udc_data);
 	at91_add_device_eth(&snapper9260_macb_data);
 	at91_add_device_ssc(AT91SAM9260_ID_SSC, (ATMEL_SSC_TF | ATMEL_SSC_TK |
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index f8902b1..1e7a73a 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -268,7 +268,7 @@ static void __init portuxg20_board_init(void)
 {
 	stamp9g20_board_init();
 	/* USB Host */
-	at91_add_device_usbh(&usbh_data);
+	at91_add_device_usbh_ohci(&usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&portuxg20_udc_data);
 	/* Ethernet */
@@ -285,7 +285,7 @@ static void __init stamp9g20evb_board_init(void)
 {
 	stamp9g20_board_init();
 	/* USB Host */
-	at91_add_device_usbh(&usbh_data);
+	at91_add_device_usbh_ohci(&usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&stamp9g20evb_udc_data);
 	/* Ethernet */
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index 07784ba..9b5cbf5 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -208,7 +208,7 @@ static void __init ek_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
+	at91_add_device_usbh_ohci(&ek_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	/* NAND */
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index b614508..535af00 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -222,7 +222,7 @@ static void __init ek_board_init(void)
 	/* Serial */
 	at91_add_device_serial();
 	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
+	at91_add_device_usbh_ohci(&ek_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&ek_udc_data);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index e0f0080..bd5ebfd 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -567,7 +567,7 @@ static void __init yl9200_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&yl9200_eth_data);
 	/* USB Host */
-	at91_add_device_usbh(&yl9200_usbh_data);
+	at91_add_device_usbh_ohci(&yl9200_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&yl9200_udc_data);
 	/* I2C */
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 484884a..759ae0c 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -15,8 +15,10 @@
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
 #include <linux/gpio.h>
 
+#include <mach/cpu.h>
 #include <mach/board.h>
 
 #include "devices.h"
@@ -118,6 +120,94 @@ fail:
 }
 
 /* --------------------------------------------------------------------
+ *  USB Host
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+static u64 ohci_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_usbh_device = {
+	.name	= "at91_ohci",
+	.id	= -1,
+	.dev	= {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data)
+{
+	struct at91_dev_table_usb_ohci *info = devices->usbh_ohci;
+	struct resource resources[2] = {{0}};
+	int i;
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_1M);
+	init_resource_irq(&resources[1], info->irq);
+
+	if (!data)
+		return;
+
+	if (info->device_init)
+		info->device_init();
+
+	/* Enable VBus control for UHP ports */
+	for (i = 0; i < data->ports; i++)
+		if (data->vbus_pin[i])
+			at91_set_gpio_output(data->vbus_pin[i], 0);
+
+	at91_add_platform_device(&at91_usbh_device, resources,
+				 ARRAY_SIZE(resources), data, sizeof(*data));
+}
+#else
+void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data) {}
+#endif
+
+/* --------------------------------------------------------------------
+ *  USB Host HS (EHCI)
+ *  Needs an OHCI host for low and full speed management
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
+static u64 ehci_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_usbh_ehci_device = {
+	.name	= "atmel-ehci",
+	.id	= -1,
+	.dev	= {
+		.dma_mask		= &ehci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data)
+{
+	struct at91_dev_table_basic_device *info = devices->usb_ehci;
+	struct resource resources[2] = {{0}};
+	int i;
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_1M);
+	init_resource_irq(&resources[1], info->irq);
+
+	if (!data)
+		return;
+
+	/* Enable VBus control for UHP ports */
+	for (i = 0; i < data->ports; i++) {
+		if (data->vbus_pin[i])
+			at91_set_gpio_output(data->vbus_pin[i], 0);
+	}
+
+	at91_clock_associate("uhphs_clk", &at91_usbh_ehci_device.dev, "ehci_clk");
+	at91_add_platform_device(&at91_usbh_ehci_device, resources,
+				 ARRAY_SIZE(resources), data, sizeof(*data));
+}
+#else
+void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data) {}
+#endif
+
+/* --------------------------------------------------------------------
  *  Ethernet
  * -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 7bed3e7..eb4de05 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -28,6 +28,11 @@ struct at91_pin_config {
 	int value;
 };
 
+struct at91_dev_table_basic_device {
+	unsigned 		mmio_base;
+	int 			irq;
+};
+
 struct at91_dev_table_ethernet {
 	unsigned 		mmio_base;
 	int 			irq;
@@ -37,8 +42,16 @@ struct at91_dev_table_ethernet {
 	int 			nr_mii_pins;
 };
 
+struct at91_dev_table_usb_ohci {
+	unsigned 		mmio_base;
+	int 			irq;
+	void			(*device_init)(void);
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
+	struct at91_dev_table_usb_ohci		*usbh_ohci;
+	struct at91_dev_table_basic_device	*usbh_ehci;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 2b499eb..dd0855d 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -99,7 +99,6 @@ struct at91_usbh_data {
 	u8		ports;		/* number of ports on root hub */
 	u8		vbus_pin[2];	/* port power-control pin */
 };
-extern void __init at91_add_device_usbh(struct at91_usbh_data *data);
 extern void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data);
 extern void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data);
 
-- 
1.7.0.4
