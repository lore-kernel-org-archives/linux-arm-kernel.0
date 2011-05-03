From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:16 +1200
Subject: [PATCH V4 02/23] at91: Make Ethernet device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-3-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual Ethernet device code for each at91 variant with
a single implementation in devices.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf.c         |    4 +
 arch/arm/mach-at91/at572d940hf_devices.c |   83 +++++++----------------
 arch/arm/mach-at91/at91cap9.c            |    4 +
 arch/arm/mach-at91/at91cap9_devices.c    |  103 ++++++++++------------------
 arch/arm/mach-at91/at91rm9200.c          |    4 +
 arch/arm/mach-at91/at91rm9200_devices.c  |  103 ++++++++++------------------
 arch/arm/mach-at91/at91sam9260.c         |    4 +
 arch/arm/mach-at91/at91sam9260_devices.c |  104 +++++++++++------------------
 arch/arm/mach-at91/at91sam9263.c         |    4 +
 arch/arm/mach-at91/at91sam9263_devices.c |  102 ++++++++++------------------
 arch/arm/mach-at91/at91sam9g45.c         |    4 +
 arch/arm/mach-at91/at91sam9g45_devices.c |  108 +++++++++++-------------------
 arch/arm/mach-at91/devices.c             |   48 +++++++++++++
 arch/arm/mach-at91/devices.h             |   10 +++
 14 files changed, 296 insertions(+), 389 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index a6b9c68..48c1ec2 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -34,6 +34,8 @@
 #include "generic.h"
 #include "clock.h"
 
+extern void at572d940hf_init_devices(void);
+
 static struct map_desc at572d940hf_io_desc[] __initdata = {
 	{
 		.virtual	= AT91_VA_BASE_SYS,
@@ -307,6 +309,8 @@ void __init at572d940hf_initialize(unsigned long main_clock)
 	/* Map peripherals */
 	iotable_init(at572d940hf_io_desc, ARRAY_SIZE(at572d940hf_io_desc));
 
+	at572d940hf_init_devices();
+
 	at91_arch_reset = at572d940hf_reset;
 	at91_extern_irq = (1 << AT572D940HF_ID_IRQ0) | (1 << AT572D940HF_ID_IRQ1)
 			| (1 << AT572D940HF_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 0fc20a2..203802a 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -35,6 +35,7 @@
 
 #include "generic.h"
 #include "sam9_smc.h"
+#include "devices.h"
 
 
 /* --------------------------------------------------------------------
@@ -138,68 +139,26 @@ void __init at91_add_device_udc(struct at91_udc_data *data) {}
  *  Ethernet
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
-static u64 eth_dmamask = DMA_BIT_MASK(32);
-static struct at91_eth_data eth_data;
-
-static struct resource eth_resources[] = {
-	[0] = {
-		.start	= AT572D940HF_BASE_EMAC,
-		.end	= AT572D940HF_BASE_EMAC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT572D940HF_ID_EMAC,
-		.end	= AT572D940HF_ID_EMAC,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_pin_config eth_rmii_pins[] __initdata = {
+	{AT91_PIN_PA16, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXCK_EREFCK */
+	{AT91_PIN_PA17, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXDV */
+	{AT91_PIN_PA18, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX0 */
+	{AT91_PIN_PA19, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX1 */
+	{AT91_PIN_PA20, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXER */
+	{AT91_PIN_PA23, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXEN */
+	{AT91_PIN_PA21, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX0 */
+	{AT91_PIN_PA22, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX1 */
+	{AT91_PIN_PA13, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDIO */
+	{AT91_PIN_PA14, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDC */
 };
 
-static struct platform_device at572d940hf_eth_device = {
-	.name		= "macb",
-	.id		= -1,
-	.dev		= {
-			.dma_mask		= &eth_dmamask,
-			.coherent_dma_mask	= DMA_BIT_MASK(32),
-			.platform_data		= &eth_data,
-	},
-	.resource	= eth_resources,
-	.num_resources	= ARRAY_SIZE(eth_resources),
+static struct at91_dev_table_ethernet device_eth __initdata = {
+	.mmio_base	= AT572D940HF_BASE_EMAC,
+	.irq		= AT572D940HF_ID_EMAC,
+	.rmii_pins	= eth_rmii_pins,
+	.nr_rmii_pins	= ARRAY_SIZE(eth_rmii_pins),
 };
 
-void __init at91_add_device_eth(struct at91_eth_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->phy_irq_pin) {
-		at91_set_gpio_input(data->phy_irq_pin, 0);
-		at91_set_deglitch(data->phy_irq_pin, 1);
-	}
-
-	/* Only RMII is supported */
-	data->is_rmii = 1;
-
-	/* Pins used for RMII */
-	at91_set_A_periph(AT91_PIN_PA16, 0);	/* ETXCK_EREFCK */
-	at91_set_A_periph(AT91_PIN_PA17, 0);	/* ERXDV */
-	at91_set_A_periph(AT91_PIN_PA18, 0);	/* ERX0 */
-	at91_set_A_periph(AT91_PIN_PA19, 0);	/* ERX1 */
-	at91_set_A_periph(AT91_PIN_PA20, 0);	/* ERXER */
-	at91_set_A_periph(AT91_PIN_PA23, 0);	/* ETXEN */
-	at91_set_A_periph(AT91_PIN_PA21, 0);	/* ETX0 */
-	at91_set_A_periph(AT91_PIN_PA22, 0);	/* ETX1 */
-	at91_set_A_periph(AT91_PIN_PA13, 0);	/* EMDIO */
-	at91_set_A_periph(AT91_PIN_PA14, 0);	/* EMDC */
-
-	eth_data = *data;
-	platform_device_register(&at572d940hf_eth_device);
-}
-#else
-void __init at91_add_device_eth(struct at91_eth_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  MMC / SD
  * -------------------------------------------------------------------- */
@@ -952,6 +911,14 @@ void __init at91_add_device_mAgic(void)
 void __init at91_add_device_mAgic(void) {}
 #endif
 
+static struct at91_device_table at572d940hf_device_table __initdata = {
+	.ethernet	= &device_eth,
+};
+
+void __init at572d940hf_init_devices(void)
+{
+	at91_init_devices(&at572d940hf_device_table);
+}
 
 /* -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 7337617..6413530 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -28,6 +28,8 @@
 #include "generic.h"
 #include "clock.h"
 
+extern void at91cap9_init_devices(void);
+
 static struct map_desc at91cap9_io_desc[] __initdata = {
 	{
 		.virtual	= AT91_VA_BASE_SYS,
@@ -308,6 +310,8 @@ void __init at91cap9_initialize(unsigned long main_clock)
 	/* Map peripherals */
 	iotable_init(at91cap9_io_desc, ARRAY_SIZE(at91cap9_io_desc));
 
+	at91cap9_init_devices();
+
 	at91_arch_reset = at91cap9_reset;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 9ffbf3a..732c914 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -29,7 +29,7 @@
 #include <mach/at91sam9_smc.h>
 
 #include "generic.h"
-
+#include "devices.h"
 
 /* --------------------------------------------------------------------
  *  USB Host
@@ -196,75 +196,38 @@ void __init at91_add_device_usba(struct usba_platform_data *data) {}
  *  Ethernet
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
-static u64 eth_dmamask = DMA_BIT_MASK(32);
-static struct at91_eth_data eth_data;
-
-static struct resource eth_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_EMAC,
-		.end	= AT91CAP9_BASE_EMAC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_EMAC,
-		.end	= AT91CAP9_ID_EMAC,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_pin_config eth_rmii_pins[] __initdata = {
+	{AT91_PIN_PB21, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXCK_EREFCK */
+	{AT91_PIN_PB22, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXDV */
+	{AT91_PIN_PB25, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX0 */
+	{AT91_PIN_PB26, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX1 */
+	{AT91_PIN_PB27, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXER */
+	{AT91_PIN_PB28, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXEN */
+	{AT91_PIN_PB23, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX0 */
+	{AT91_PIN_PB24, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX1 */
+	{AT91_PIN_PB30, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDIO */
+	{AT91_PIN_PB29, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDC */
 };
 
-static struct platform_device at91cap9_eth_device = {
-	.name		= "macb",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &eth_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &eth_data,
-	},
-	.resource	= eth_resources,
-	.num_resources	= ARRAY_SIZE(eth_resources),
+static struct at91_pin_config eth_mii_pins[] __initdata = {
+	{AT91_PIN_PC25, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ECRS */
+	{AT91_PIN_PC26, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ECOL */
+	{AT91_PIN_PC22, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX2 */
+	{AT91_PIN_PC23, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX3 */
+	{AT91_PIN_PC27, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERXCK */
+	{AT91_PIN_PC20, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX2 */
+	{AT91_PIN_PC21, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX3 */
+	{AT91_PIN_PC24, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETXER */
 };
 
-void __init at91_add_device_eth(struct at91_eth_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->phy_irq_pin) {
-		at91_set_gpio_input(data->phy_irq_pin, 0);
-		at91_set_deglitch(data->phy_irq_pin, 1);
-	}
-
-	/* Pins used for MII and RMII */
-	at91_set_A_periph(AT91_PIN_PB21, 0);	/* ETXCK_EREFCK */
-	at91_set_A_periph(AT91_PIN_PB22, 0);	/* ERXDV */
-	at91_set_A_periph(AT91_PIN_PB25, 0);	/* ERX0 */
-	at91_set_A_periph(AT91_PIN_PB26, 0);	/* ERX1 */
-	at91_set_A_periph(AT91_PIN_PB27, 0);	/* ERXER */
-	at91_set_A_periph(AT91_PIN_PB28, 0);	/* ETXEN */
-	at91_set_A_periph(AT91_PIN_PB23, 0);	/* ETX0 */
-	at91_set_A_periph(AT91_PIN_PB24, 0);	/* ETX1 */
-	at91_set_A_periph(AT91_PIN_PB30, 0);	/* EMDIO */
-	at91_set_A_periph(AT91_PIN_PB29, 0);	/* EMDC */
-
-	if (!data->is_rmii) {
-		at91_set_B_periph(AT91_PIN_PC25, 0);	/* ECRS */
-		at91_set_B_periph(AT91_PIN_PC26, 0);	/* ECOL */
-		at91_set_B_periph(AT91_PIN_PC22, 0);	/* ERX2 */
-		at91_set_B_periph(AT91_PIN_PC23, 0);	/* ERX3 */
-		at91_set_B_periph(AT91_PIN_PC27, 0);	/* ERXCK */
-		at91_set_B_periph(AT91_PIN_PC20, 0);	/* ETX2 */
-		at91_set_B_periph(AT91_PIN_PC21, 0);	/* ETX3 */
-		at91_set_B_periph(AT91_PIN_PC24, 0);	/* ETXER */
-	}
-
-	eth_data = *data;
-	platform_device_register(&at91cap9_eth_device);
-}
-#else
-void __init at91_add_device_eth(struct at91_eth_data *data) {}
-#endif
-
+static struct at91_dev_table_ethernet device_eth __initdata = {
+	.mmio_base	= AT91CAP9_BASE_EMAC,
+	.irq		= AT91CAP9_ID_EMAC,
+	.rmii_pins	= eth_rmii_pins,
+	.nr_rmii_pins	= ARRAY_SIZE(eth_rmii_pins),
+	.mii_pins	= eth_mii_pins,
+	.nr_mii_pins	= ARRAY_SIZE(eth_mii_pins),
+};
 
 /* --------------------------------------------------------------------
  *  MMC / SD
@@ -1254,6 +1217,14 @@ void __init at91_set_serial_console(unsigned portnr) {}
 void __init at91_add_device_serial(void) {}
 #endif
 
+static struct at91_device_table at91cap9_device_table __initdata = {
+	.ethernet	= &device_eth,
+};
+
+void __init at91cap9_init_devices(void)
+{
+	at91_init_devices(&at91cap9_device_table);
+}
 
 /* -------------------------------------------------------------------- */
 /*
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 2e9ecad..dea90df 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -22,6 +22,8 @@
 #include "generic.h"
 #include "clock.h"
 
+extern void at91rm9200_init_devices(void);
+
 static struct map_desc at91rm9200_io_desc[] __initdata = {
 	{
 		.virtual	= AT91_VA_BASE_SYS,
@@ -275,6 +277,8 @@ void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks
 	/* Map peripherals */
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
 
+	at91rm9200_init_devices();
+
 	at91_arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 7b53922..6365929 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -23,7 +23,7 @@
 #include <mach/at91rm9200_mc.h>
 
 #include "generic.h"
-
+#include "devices.h"
 
 /* --------------------------------------------------------------------
  *  USB Host
@@ -125,75 +125,38 @@ void __init at91_add_device_udc(struct at91_udc_data *data) {}
  *  Ethernet
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_ARM_AT91_ETHER) || defined(CONFIG_ARM_AT91_ETHER_MODULE)
-static u64 eth_dmamask = DMA_BIT_MASK(32);
-static struct at91_eth_data eth_data;
-
-static struct resource eth_resources[] = {
-	[0] = {
-		.start	= AT91_VA_BASE_EMAC,
-		.end	= AT91_VA_BASE_EMAC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91RM9200_ID_EMAC,
-		.end	= AT91RM9200_ID_EMAC,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_pin_config eth_rmii_pins[] __initdata = {
+	{AT91_PIN_PA16, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDIO */
+	{AT91_PIN_PA15, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDC */
+	{AT91_PIN_PA14, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXER */
+	{AT91_PIN_PA13, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX1 */
+	{AT91_PIN_PA12, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX0 */
+	{AT91_PIN_PA11, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ECRS_ECRSDV */
+	{AT91_PIN_PA10, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX1 */
+	{AT91_PIN_PA9,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX0 */
+	{AT91_PIN_PA8,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXEN */
+	{AT91_PIN_PA7,  AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXCK_EREFCK */
 };
 
-static struct platform_device at91rm9200_eth_device = {
-	.name		= "at91_ether",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &eth_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &eth_data,
-	},
-	.resource	= eth_resources,
-	.num_resources	= ARRAY_SIZE(eth_resources),
+static struct at91_pin_config eth_mii_pins[] __initdata = {
+	{AT91_PIN_PB19, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERXCK */
+	{AT91_PIN_PB18, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ECOL */
+	{AT91_PIN_PB17, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERXDV */
+	{AT91_PIN_PB16, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX3 */
+	{AT91_PIN_PB15, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX2 */
+	{AT91_PIN_PB14, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETXER */
+	{AT91_PIN_PB13, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX3 */
+	{AT91_PIN_PB12, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX2 */
 };
 
-void __init at91_add_device_eth(struct at91_eth_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->phy_irq_pin) {
-		at91_set_gpio_input(data->phy_irq_pin, 0);
-		at91_set_deglitch(data->phy_irq_pin, 1);
-	}
-
-	/* Pins used for MII and RMII */
-	at91_set_A_periph(AT91_PIN_PA16, 0);	/* EMDIO */
-	at91_set_A_periph(AT91_PIN_PA15, 0);	/* EMDC */
-	at91_set_A_periph(AT91_PIN_PA14, 0);	/* ERXER */
-	at91_set_A_periph(AT91_PIN_PA13, 0);	/* ERX1 */
-	at91_set_A_periph(AT91_PIN_PA12, 0);	/* ERX0 */
-	at91_set_A_periph(AT91_PIN_PA11, 0);	/* ECRS_ECRSDV */
-	at91_set_A_periph(AT91_PIN_PA10, 0);	/* ETX1 */
-	at91_set_A_periph(AT91_PIN_PA9, 0);	/* ETX0 */
-	at91_set_A_periph(AT91_PIN_PA8, 0);	/* ETXEN */
-	at91_set_A_periph(AT91_PIN_PA7, 0);	/* ETXCK_EREFCK */
-
-	if (!data->is_rmii) {
-		at91_set_B_periph(AT91_PIN_PB19, 0);	/* ERXCK */
-		at91_set_B_periph(AT91_PIN_PB18, 0);	/* ECOL */
-		at91_set_B_periph(AT91_PIN_PB17, 0);	/* ERXDV */
-		at91_set_B_periph(AT91_PIN_PB16, 0);	/* ERX3 */
-		at91_set_B_periph(AT91_PIN_PB15, 0);	/* ERX2 */
-		at91_set_B_periph(AT91_PIN_PB14, 0);	/* ETXER */
-		at91_set_B_periph(AT91_PIN_PB13, 0);	/* ETX3 */
-		at91_set_B_periph(AT91_PIN_PB12, 0);	/* ETX2 */
-	}
-
-	eth_data = *data;
-	platform_device_register(&at91rm9200_eth_device);
-}
-#else
-void __init at91_add_device_eth(struct at91_eth_data *data) {}
-#endif
-
+static struct at91_dev_table_ethernet device_eth __initdata = {
+	.mmio_base	= AT91_VA_BASE_EMAC,
+	.irq		= AT91RM9200_ID_EMAC,
+	.rmii_pins	= eth_rmii_pins,
+	.nr_rmii_pins	= ARRAY_SIZE(eth_rmii_pins),
+	.mii_pins	= eth_mii_pins,
+	.nr_mii_pins	= ARRAY_SIZE(eth_mii_pins),
+};
 
 /* --------------------------------------------------------------------
  *  Compact Flash / PCMCIA
@@ -1170,6 +1133,14 @@ void __init at91_set_serial_console(unsigned portnr) {}
 void __init at91_add_device_serial(void) {}
 #endif
 
+static struct at91_device_table at91rm9200_device_table __initdata = {
+	.ethernet	= &device_eth,
+};
+
+void __init at91rm9200_init_devices(void)
+{
+	at91_init_devices(&at91rm9200_device_table);
+}
 
 /* -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 195208b..7445f48 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -25,6 +25,8 @@
 #include "generic.h"
 #include "clock.h"
 
+extern void at91sam9260_init_devices(void);
+
 static struct map_desc at91sam9260_io_desc[] __initdata = {
 	{
 		.virtual	= AT91_VA_BASE_SYS,
@@ -315,6 +317,8 @@ void __init at91sam9260_initialize(unsigned long main_clock)
 	/* Map peripherals */
 	iotable_init(at91sam9260_io_desc, ARRAY_SIZE(at91sam9260_io_desc));
 
+	at91sam9260_init_devices();
+
 	if (cpu_is_at91sam9xe())
 		at91sam9xe_initialize();
 	else if (cpu_is_at91sam9g20())
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 07eb7b0..c19f79a 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -24,7 +24,7 @@
 #include <mach/at91sam9_smc.h>
 
 #include "generic.h"
-
+#include "devices.h"
 
 /* --------------------------------------------------------------------
  *  USB Host
@@ -126,75 +126,38 @@ void __init at91_add_device_udc(struct at91_udc_data *data) {}
  *  Ethernet
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
-static u64 eth_dmamask = DMA_BIT_MASK(32);
-static struct at91_eth_data eth_data;
-
-static struct resource eth_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_EMAC,
-		.end	= AT91SAM9260_BASE_EMAC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9260_ID_EMAC,
-		.end	= AT91SAM9260_ID_EMAC,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_pin_config eth_rmii_pins[] __initdata = {
+	{AT91_PIN_PA19, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXCK_EREFCK */
+	{AT91_PIN_PA17, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXDV */
+	{AT91_PIN_PA14, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX0 */
+	{AT91_PIN_PA15, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX1 */
+	{AT91_PIN_PA18, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXER */
+	{AT91_PIN_PA16, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXEN */
+	{AT91_PIN_PA12, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX0 */
+	{AT91_PIN_PA13, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX1 */
+	{AT91_PIN_PA21, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDIO */
+	{AT91_PIN_PA20, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDC */
 };
 
-static struct platform_device at91sam9260_eth_device = {
-	.name		= "macb",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &eth_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &eth_data,
-	},
-	.resource	= eth_resources,
-	.num_resources	= ARRAY_SIZE(eth_resources),
+static struct at91_pin_config eth_mii_pins[] __initdata = {
+	{AT91_PIN_PA28, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ECRS */
+	{AT91_PIN_PA29, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ECOL */
+	{AT91_PIN_PA25, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX2 */
+	{AT91_PIN_PA26, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX3 */
+	{AT91_PIN_PA27, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERXCK */
+	{AT91_PIN_PA23, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX2 */
+	{AT91_PIN_PA24, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX3 */
+	{AT91_PIN_PA22, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETXER */
 };
 
-void __init at91_add_device_eth(struct at91_eth_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->phy_irq_pin) {
-		at91_set_gpio_input(data->phy_irq_pin, 0);
-		at91_set_deglitch(data->phy_irq_pin, 1);
-	}
-
-	/* Pins used for MII and RMII */
-	at91_set_A_periph(AT91_PIN_PA19, 0);	/* ETXCK_EREFCK */
-	at91_set_A_periph(AT91_PIN_PA17, 0);	/* ERXDV */
-	at91_set_A_periph(AT91_PIN_PA14, 0);	/* ERX0 */
-	at91_set_A_periph(AT91_PIN_PA15, 0);	/* ERX1 */
-	at91_set_A_periph(AT91_PIN_PA18, 0);	/* ERXER */
-	at91_set_A_periph(AT91_PIN_PA16, 0);	/* ETXEN */
-	at91_set_A_periph(AT91_PIN_PA12, 0);	/* ETX0 */
-	at91_set_A_periph(AT91_PIN_PA13, 0);	/* ETX1 */
-	at91_set_A_periph(AT91_PIN_PA21, 0);	/* EMDIO */
-	at91_set_A_periph(AT91_PIN_PA20, 0);	/* EMDC */
-
-	if (!data->is_rmii) {
-		at91_set_B_periph(AT91_PIN_PA28, 0);	/* ECRS */
-		at91_set_B_periph(AT91_PIN_PA29, 0);	/* ECOL */
-		at91_set_B_periph(AT91_PIN_PA25, 0);	/* ERX2 */
-		at91_set_B_periph(AT91_PIN_PA26, 0);	/* ERX3 */
-		at91_set_B_periph(AT91_PIN_PA27, 0);	/* ERXCK */
-		at91_set_B_periph(AT91_PIN_PA23, 0);	/* ETX2 */
-		at91_set_B_periph(AT91_PIN_PA24, 0);	/* ETX3 */
-		at91_set_B_periph(AT91_PIN_PA22, 0);	/* ETXER */
-	}
-
-	eth_data = *data;
-	platform_device_register(&at91sam9260_eth_device);
-}
-#else
-void __init at91_add_device_eth(struct at91_eth_data *data) {}
-#endif
-
+static struct at91_dev_table_ethernet device_eth __initdata = {
+	.mmio_base	= AT91SAM9260_BASE_EMAC,
+	.irq		= AT91SAM9260_ID_EMAC,
+	.rmii_pins	= eth_rmii_pins,
+	.nr_rmii_pins	= ARRAY_SIZE(eth_rmii_pins),
+	.mii_pins	= eth_mii_pins,
+	.nr_mii_pins	= ARRAY_SIZE(eth_mii_pins),
+};
 
 /* --------------------------------------------------------------------
  *  MMC / SD
@@ -1326,6 +1289,15 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 void __init at91_add_device_cf(struct at91_cf_data * data) {}
 #endif
 
+static struct at91_device_table at91sam9260_device_table __initdata = {
+	.ethernet	= &device_eth,
+};
+
+void __init at91sam9260_init_devices(void)
+{
+	at91_init_devices(&at91sam9260_device_table);
+}
+
 /* -------------------------------------------------------------------- */
 /*
  * These devices are always present and don't need any board-specific
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 249f900..739fc1f 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -24,6 +24,8 @@
 #include "generic.h"
 #include "clock.h"
 
+extern void at91sam9263_init_devices(void);
+
 static struct map_desc at91sam9263_io_desc[] __initdata = {
 	{
 		.virtual	= AT91_VA_BASE_SYS,
@@ -284,6 +286,8 @@ void __init at91sam9263_initialize(unsigned long main_clock)
 	/* Map peripherals */
 	iotable_init(at91sam9263_io_desc, ARRAY_SIZE(at91sam9263_io_desc));
 
+	at91sam9263_init_devices();
+
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index fb5c23a..ea49dc0 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -26,6 +26,7 @@
 #include <mach/at91sam9_smc.h>
 
 #include "generic.h"
+#include "devices.h"
 
 
 /* --------------------------------------------------------------------
@@ -136,75 +137,38 @@ void __init at91_add_device_udc(struct at91_udc_data *data) {}
  *  Ethernet
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
-static u64 eth_dmamask = DMA_BIT_MASK(32);
-static struct at91_eth_data eth_data;
-
-static struct resource eth_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_EMAC,
-		.end	= AT91SAM9263_BASE_EMAC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_EMAC,
-		.end	= AT91SAM9263_ID_EMAC,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_pin_config eth_rmii_pins[] __initdata = {
+	{AT91_PIN_PE21, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXCK_EREFCK */
+	{AT91_PIN_PC25, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXDV */
+	{AT91_PIN_PE25, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX0 */
+	{AT91_PIN_PE26, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX1 */
+	{AT91_PIN_PE27, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXER */
+	{AT91_PIN_PE28, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXEN */
+	{AT91_PIN_PE23, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX0 */
+	{AT91_PIN_PE24, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX1 */
+	{AT91_PIN_PE30, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDIO */
+	{AT91_PIN_PE29, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDC */
 };
 
-static struct platform_device at91sam9263_eth_device = {
-	.name		= "macb",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &eth_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &eth_data,
-	},
-	.resource	= eth_resources,
-	.num_resources	= ARRAY_SIZE(eth_resources),
+static struct at91_pin_config eth_mii_pins[] __initdata = {
+	{AT91_PIN_PE22, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ECRS */
+	{AT91_PIN_PC26, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ECOL */
+	{AT91_PIN_PC22, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX2 */
+	{AT91_PIN_PC23, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX3 */
+	{AT91_PIN_PC27, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERXCK */
+	{AT91_PIN_PC20, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX2 */
+	{AT91_PIN_PC21, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX3 */
+	{AT91_PIN_PC24, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETXER */
 };
 
-void __init at91_add_device_eth(struct at91_eth_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->phy_irq_pin) {
-		at91_set_gpio_input(data->phy_irq_pin, 0);
-		at91_set_deglitch(data->phy_irq_pin, 1);
-	}
-
-	/* Pins used for MII and RMII */
-	at91_set_A_periph(AT91_PIN_PE21, 0);	/* ETXCK_EREFCK */
-	at91_set_B_periph(AT91_PIN_PC25, 0);	/* ERXDV */
-	at91_set_A_periph(AT91_PIN_PE25, 0);	/* ERX0 */
-	at91_set_A_periph(AT91_PIN_PE26, 0);	/* ERX1 */
-	at91_set_A_periph(AT91_PIN_PE27, 0);	/* ERXER */
-	at91_set_A_periph(AT91_PIN_PE28, 0);	/* ETXEN */
-	at91_set_A_periph(AT91_PIN_PE23, 0);	/* ETX0 */
-	at91_set_A_periph(AT91_PIN_PE24, 0);	/* ETX1 */
-	at91_set_A_periph(AT91_PIN_PE30, 0);	/* EMDIO */
-	at91_set_A_periph(AT91_PIN_PE29, 0);	/* EMDC */
-
-	if (!data->is_rmii) {
-		at91_set_A_periph(AT91_PIN_PE22, 0);	/* ECRS */
-		at91_set_B_periph(AT91_PIN_PC26, 0);	/* ECOL */
-		at91_set_B_periph(AT91_PIN_PC22, 0);	/* ERX2 */
-		at91_set_B_periph(AT91_PIN_PC23, 0);	/* ERX3 */
-		at91_set_B_periph(AT91_PIN_PC27, 0);	/* ERXCK */
-		at91_set_B_periph(AT91_PIN_PC20, 0);	/* ETX2 */
-		at91_set_B_periph(AT91_PIN_PC21, 0);	/* ETX3 */
-		at91_set_B_periph(AT91_PIN_PC24, 0);	/* ETXER */
-	}
-
-	eth_data = *data;
-	platform_device_register(&at91sam9263_eth_device);
-}
-#else
-void __init at91_add_device_eth(struct at91_eth_data *data) {}
-#endif
-
+static struct at91_dev_table_ethernet device_eth __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_EMAC,
+	.irq		= AT91SAM9263_ID_EMAC,
+	.rmii_pins	= eth_rmii_pins,
+	.nr_rmii_pins	= ARRAY_SIZE(eth_rmii_pins),
+	.mii_pins	= eth_mii_pins,
+	.nr_mii_pins	= ARRAY_SIZE(eth_mii_pins),
+};
 
 /* --------------------------------------------------------------------
  *  MMC / SD
@@ -1425,6 +1389,14 @@ void __init at91_set_serial_console(unsigned portnr) {}
 void __init at91_add_device_serial(void) {}
 #endif
 
+static struct at91_device_table at91sam9263_device_table __initdata = {
+	.ethernet	= &device_eth,
+};
+
+void __init at91sam9263_init_devices(void)
+{
+	at91_init_devices(&at91sam9263_device_table);
+}
 
 /* -------------------------------------------------------------------- */
 /*
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index c67b47f..357e5d7 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -25,6 +25,8 @@
 #include "generic.h"
 #include "clock.h"
 
+extern void at91sam9g45_init_devices(void);
+
 static struct map_desc at91sam9g45_io_desc[] __initdata = {
 	{
 		.virtual	= AT91_VA_BASE_SYS,
@@ -311,6 +313,8 @@ void __init at91sam9g45_initialize(unsigned long main_clock)
 	/* Map peripherals */
 	iotable_init(at91sam9g45_io_desc, ARRAY_SIZE(at91sam9g45_io_desc));
 
+	at91sam9g45_init_devices();
+
 	at91_arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 1e8f275..5e25700 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -29,6 +29,7 @@
 #include <mach/atmel-mci.h>
 
 #include "generic.h"
+#include "devices.h"
 
 
 /* --------------------------------------------------------------------
@@ -281,76 +282,39 @@ void __init at91_add_device_usba(struct usba_platform_data *data) {}
  *  Ethernet
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
-static u64 eth_dmamask = DMA_BIT_MASK(32);
-static struct at91_eth_data eth_data;
-
-static struct resource eth_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_EMAC,
-		.end	= AT91SAM9G45_BASE_EMAC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_EMAC,
-		.end	= AT91SAM9G45_ID_EMAC,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct at91_pin_config eth_rmii_pins[] __initdata = {
+	{AT91_PIN_PA17, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXCK_EREFCK */
+	{AT91_PIN_PA15, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXDV */
+	{AT91_PIN_PA12, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX0 */
+	{AT91_PIN_PA13, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERX1 */
+	{AT91_PIN_PA16, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ERXER */
+	{AT91_PIN_PA14, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETXEN */
+	{AT91_PIN_PA10, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX0 */
+	{AT91_PIN_PA11, AT91_PIN_PERIPH_A, 0, 0, 0},	/* ETX1 */
+	{AT91_PIN_PA19, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDIO */
+	{AT91_PIN_PA18, AT91_PIN_PERIPH_A, 0, 0, 0},	/* EMDC */
+};
+
+static struct at91_pin_config eth_mii_pins[] __initdata = {
+	{AT91_PIN_PA29, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ECRS */
+	{AT91_PIN_PA30, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ECOL */
+	{AT91_PIN_PA8,  AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX2 */
+	{AT91_PIN_PA9,  AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERX3 */
+	{AT91_PIN_PA28, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ERXCK */
+	{AT91_PIN_PA6,  AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX2 */
+	{AT91_PIN_PA7,  AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETX3 */
+	{AT91_PIN_PA27, AT91_PIN_PERIPH_B, 0, 0, 0},	/* ETXER */
+};
+
+static struct at91_dev_table_ethernet device_eth __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_EMAC,
+	.irq		= AT91SAM9G45_ID_EMAC,
+	.rmii_pins	= eth_rmii_pins,
+	.nr_rmii_pins	= ARRAY_SIZE(eth_rmii_pins),
+	.mii_pins	= eth_mii_pins,
+	.nr_mii_pins	= ARRAY_SIZE(eth_mii_pins),
 };
 
-static struct platform_device at91sam9g45_eth_device = {
-	.name		= "macb",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &eth_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &eth_data,
-	},
-	.resource	= eth_resources,
-	.num_resources	= ARRAY_SIZE(eth_resources),
-};
-
-void __init at91_add_device_eth(struct at91_eth_data *data)
-{
-	if (!data)
-		return;
-
-	if (data->phy_irq_pin) {
-		at91_set_gpio_input(data->phy_irq_pin, 0);
-		at91_set_deglitch(data->phy_irq_pin, 1);
-	}
-
-	/* Pins used for MII and RMII */
-	at91_set_A_periph(AT91_PIN_PA17, 0);	/* ETXCK_EREFCK */
-	at91_set_A_periph(AT91_PIN_PA15, 0);	/* ERXDV */
-	at91_set_A_periph(AT91_PIN_PA12, 0);	/* ERX0 */
-	at91_set_A_periph(AT91_PIN_PA13, 0);	/* ERX1 */
-	at91_set_A_periph(AT91_PIN_PA16, 0);	/* ERXER */
-	at91_set_A_periph(AT91_PIN_PA14, 0);	/* ETXEN */
-	at91_set_A_periph(AT91_PIN_PA10, 0);	/* ETX0 */
-	at91_set_A_periph(AT91_PIN_PA11, 0);	/* ETX1 */
-	at91_set_A_periph(AT91_PIN_PA19, 0);	/* EMDIO */
-	at91_set_A_periph(AT91_PIN_PA18, 0);	/* EMDC */
-
-	if (!data->is_rmii) {
-		at91_set_B_periph(AT91_PIN_PA29, 0);	/* ECRS */
-		at91_set_B_periph(AT91_PIN_PA30, 0);	/* ECOL */
-		at91_set_B_periph(AT91_PIN_PA8,  0);	/* ERX2 */
-		at91_set_B_periph(AT91_PIN_PA9,  0);	/* ERX3 */
-		at91_set_B_periph(AT91_PIN_PA28, 0);	/* ERXCK */
-		at91_set_B_periph(AT91_PIN_PA6,  0);	/* ETX2 */
-		at91_set_B_periph(AT91_PIN_PA7,  0);	/* ETX3 */
-		at91_set_B_periph(AT91_PIN_PA27, 0);	/* ETXER */
-	}
-
-	eth_data = *data;
-	platform_device_register(&at91sam9g45_eth_device);
-}
-#else
-void __init at91_add_device_eth(struct at91_eth_data *data) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  MMC / SD
  * -------------------------------------------------------------------- */
@@ -1587,6 +1551,14 @@ void __init at91_set_serial_console(unsigned portnr) {}
 void __init at91_add_device_serial(void) {}
 #endif
 
+static struct at91_device_table at91sam9g45_device_table __initdata = {
+	.ethernet	= &device_eth,
+};
+
+void __init at91sam9g45_init_devices(void)
+{
+	at91_init_devices(&at91sam9g45_device_table);
+}
 
 /* -------------------------------------------------------------------- */
 /*
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 89d0fa9..484884a 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -14,8 +14,11 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 
+#include <mach/board.h>
+
 #include "devices.h"
 
 static struct at91_device_table *devices __initdata;
@@ -114,6 +117,51 @@ fail:
 	return err;
 }
 
+/* --------------------------------------------------------------------
+ *  Ethernet
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
+static u64 eth_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91_eth_device = {
+	.name	= "macb",
+	.id	= -1,
+	.dev	= {
+		.dma_mask		= &eth_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init at91_add_device_eth(struct at91_eth_data *data)
+{
+	struct at91_dev_table_ethernet *info = devices->ethernet;
+	struct resource resources[2] = {{0}};
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_16K);
+	init_resource_irq(&resources[1], info->irq);
+
+	if (!data)
+		return;
+
+	if (data->phy_irq_pin) {
+		at91_set_gpio_input(data->phy_irq_pin, 0);
+		at91_set_deglitch(data->phy_irq_pin, 1);
+	}
+
+	/* Pins used for MII and RMII */
+	at91_config_pins(info->rmii_pins, info->nr_rmii_pins);
+	if (!data->is_rmii && info->mii_pins)
+		at91_config_pins(info->mii_pins, info->nr_mii_pins);
+
+	at91_add_platform_device(&at91_eth_device, resources,
+				 ARRAY_SIZE(resources), data, sizeof(*data));
+}
+#else
+void __init at91_add_device_eth(struct at91_eth_data *data) {}
+#endif
+
 void __init at91_init_devices(struct at91_device_table *device_table)
 {
 	devices = device_table;
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 738f736..7bed3e7 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -28,7 +28,17 @@ struct at91_pin_config {
 	int value;
 };
 
+struct at91_dev_table_ethernet {
+	unsigned 		mmio_base;
+	int 			irq;
+	struct at91_pin_config	*rmii_pins;
+	int 			nr_rmii_pins;
+	struct at91_pin_config	*mii_pins;
+	int 			nr_mii_pins;
+};
+
 struct at91_device_table {
+	struct at91_dev_table_ethernet		*ethernet;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
