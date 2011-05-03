From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:32 +1200
Subject: [PATCH V4 18/23] at91: Make HDMAC device common
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-19-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual HDMAC code for each at91 variant with a single
implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91sam9g45_devices.c |   46 +++--------------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   43 ++-------------------------
 arch/arm/mach-at91/devices.c             |   35 ++++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |    8 +++++
 4 files changed, 52 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 783f600..f67a675 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -36,49 +36,13 @@
  *  HDMAC - AHB DMA Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_AT_HDMAC) || defined(CONFIG_AT_HDMAC_MODULE)
-static u64 hdmac_dmamask = DMA_BIT_MASK(32);
-
-static struct at_dma_platform_data atdma_pdata = {
+static struct at91_dev_table_hdmac device_hdmac __initdata = {
+	.mmio_base	= AT91_BASE_SYS + AT91_DMA,
+	.irq		= AT91SAM9G45_ID_DMA,
 	.nr_channels	= 8,
+	.have_slave	= 1,
 };
 
-static struct resource hdmac_resources[] = {
-	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DMA,
-		.end	= AT91_BASE_SYS + AT91_DMA + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_DMA,
-		.end	= AT91SAM9G45_ID_DMA,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at_hdmac_device = {
-	.name		= "at_hdmac",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &hdmac_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &atdma_pdata,
-	},
-	.resource	= hdmac_resources,
-	.num_resources	= ARRAY_SIZE(hdmac_resources),
-};
-
-void __init at91_add_device_hdmac(void)
-{
-	dma_cap_set(DMA_MEMCPY, atdma_pdata.cap_mask);
-	dma_cap_set(DMA_SLAVE, atdma_pdata.cap_mask);
-	platform_device_register(&at_hdmac_device);
-}
-#else
-void __init at91_add_device_hdmac(void) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  USB Host (OHCI)
  * -------------------------------------------------------------------- */
@@ -598,6 +562,7 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.ac97		= &device_ac97,
 	.lcdc		= &device_lcdc,
 	.tsadcc		= &device_tsadcc,
+	.hdmac		= &device_hdmac,
 };
 
 void __init at91sam9g45_init_devices(void)
@@ -612,7 +577,6 @@ void __init at91sam9g45_init_devices(void)
  */
 static int __init at91_add_standard_devices(void)
 {
-	at91_add_device_hdmac();
 	at91_add_device_rtc();
 	return 0;
 }
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index cbc49d0..3dac87f 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -30,47 +30,12 @@
  *  HDMAC - AHB DMA Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_AT_HDMAC) || defined(CONFIG_AT_HDMAC_MODULE)
-static u64 hdmac_dmamask = DMA_BIT_MASK(32);
-
-static struct at_dma_platform_data atdma_pdata = {
+static struct at91_dev_table_hdmac device_hdmac __initdata = {
+	.mmio_base	= AT91_BASE_SYS + AT91_DMA,
+	.irq		= AT91SAM9RL_ID_DMA,
 	.nr_channels	= 2,
 };
 
-static struct resource hdmac_resources[] = {
-	[0] = {
-		.start	= AT91_BASE_SYS + AT91_DMA,
-		.end	= AT91_BASE_SYS + AT91_DMA + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= AT91SAM9RL_ID_DMA,
-		.end	= AT91SAM9RL_ID_DMA,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at_hdmac_device = {
-	.name		= "at_hdmac",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &hdmac_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &atdma_pdata,
-	},
-	.resource	= hdmac_resources,
-	.num_resources	= ARRAY_SIZE(hdmac_resources),
-};
-
-void __init at91_add_device_hdmac(void)
-{
-	dma_cap_set(DMA_MEMCPY, atdma_pdata.cap_mask);
-	platform_device_register(&at_hdmac_device);
-}
-#else
-void __init at91_add_device_hdmac(void) {}
-#endif
-
 /* --------------------------------------------------------------------
  *  USB HS Device (Gadget)
  * -------------------------------------------------------------------- */
@@ -473,6 +438,7 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.ac97		= &device_ac97,
 	.lcdc		= &device_lcdc,
 	.tsadcc		= &device_tsadcc,
+	.hdmac		= &device_hdmac,
 };
 
 void __init at91sam9rl_init_devices(void)
@@ -488,7 +454,6 @@ void __init at91sam9rl_init_devices(void)
  */
 static int __init at91_add_standard_devices(void)
 {
-	at91_add_device_hdmac();
 	at91_add_device_rtc();
 	return 0;
 }
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 597a81d..d86d299 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -1201,11 +1201,46 @@ void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data)
 void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
 #endif
 
+#if defined(CONFIG_AT_HDMAC) || defined(CONFIG_AT_HDMAC_MODULE)
+static u64 hdmac_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at_hdmac_device = {
+	.name	= "at_hdmac",
+	.id	= -1,
+	.dev	= {
+		.dma_mask		= &hdmac_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init at91_add_device_hdmac(void)
+{
+	struct at91_dev_table_hdmac *info = devices->hdmac;
+	struct at_dma_platform_data pdata;
+	struct resource resources[2] = {{0}};
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_512);
+	init_resource_irq(&resources[1], info->irq);
+
+	pdata.nr_channels = info->nr_channels;
+	dma_cap_set(DMA_MEMCPY, pdata.cap_mask);
+	if (info->have_slave)
+		dma_cap_set(DMA_SLAVE, pdata.cap_mask);
+
+	at91_add_platform_device(&at_hdmac_device, resources,
+				 ARRAY_SIZE(resources), pdata, sizeof(*pdata));
+}
+#else
+void __init at91_add_device_hdmac(void) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
+	at91_add_device_hdmac();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 4b68228..417c959 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -163,6 +163,13 @@ struct at91_dev_table_tsadcc {
 	struct at91_pin_config	pins[4];	/* XR, XL, YT, TB */
 };
 
+struct at91_dev_table_hdmac {
+	unsigned		mmio_base;
+	int			irq;
+	int			nr_channels;
+	int			have_slave;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -181,6 +188,7 @@ struct at91_device_table {
 	struct at91_dev_table_ac97		*ac97;
 	struct at91_dev_table_lcdc		*lcdc;
 	struct at91_dev_table_tsadcc		*tsadcc;
+	struct at91_dev_table_hdmac		*hdmac;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
