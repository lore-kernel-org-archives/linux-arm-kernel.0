From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Oct 2010 10:49:50 +0200
Subject: [PATCH 1/7] mx3: fix the last users of IMX_NEEDS_DEPRECATED_SYMBOLS
In-Reply-To: <20101022175702.GI19834@pengutronix.de>
References: <20101022175702.GI19834@pengutronix.de>
Message-ID: <1288082996-21981-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Makefile        |    3 --
 arch/arm/mach-mx3/devices.c       |   72 ++++++++++++++++++++-----------------
 arch/arm/mach-mx3/mach-mx31_3ds.c |    2 +-
 arch/arm/mach-mx3/mm.c            |   48 ++++++++++++------------
 4 files changed, 64 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 8a182d0a..7feb6c4 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -5,8 +5,6 @@
 # Object file lists.
 
 obj-y				:= mm.o devices.o cpu.o
-CFLAGS_mm.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
-CFLAGS_devices.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 obj-$(CONFIG_ARCH_MX31)		+= clock-imx31.o iomux-imx31.o
 obj-$(CONFIG_ARCH_MX35)		+= clock-imx35.o
 obj-$(CONFIG_MACH_MX31ADS)	+= mach-mx31ads.o
@@ -15,7 +13,6 @@ obj-$(CONFIG_MACH_MX31LITE)	+= mach-mx31lite.o mx31lite-db.o
 obj-$(CONFIG_MACH_PCM037)	+= mach-pcm037.o
 obj-$(CONFIG_MACH_PCM037_EET)	+= mach-pcm037_eet.o
 obj-$(CONFIG_MACH_MX31_3DS)	+= mach-mx31_3ds.o
-CFLAGS_mach-mx31_3ds.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 obj-$(CONFIG_MACH_MX31MOBOARD)	+= mach-mx31moboard.o mx31moboard-devboard.o \
 				   mx31moboard-marxbot.o mx31moboard-smartbot.o
 obj-$(CONFIG_MACH_QONG)		+= mach-qong.o
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index d4da949..1e737ad 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -33,18 +33,18 @@
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
-		.base = IO_ADDRESS(GPIO1_BASE_ADDR),
-		.irq = MXC_INT_GPIO1,
+		.base = MX31_IO_ADDRESS(MX31_GPIO1_BASE_ADDR),
+		.irq = MX3x_INT_GPIO1,
 		.virtual_irq_start = MXC_GPIO_IRQ_START,
 	}, {
 		.chip.label = "gpio-1",
-		.base = IO_ADDRESS(GPIO2_BASE_ADDR),
-		.irq = MXC_INT_GPIO2,
+		.base = MX31_IO_ADDRESS(MX31_GPIO2_BASE_ADDR),
+		.irq = MX3x_INT_GPIO2,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
 	}, {
 		.chip.label = "gpio-2",
-		.base = IO_ADDRESS(GPIO3_BASE_ADDR),
-		.irq = MXC_INT_GPIO3,
+		.base = MX31_IO_ADDRESS(MX31_GPIO3_BASE_ADDR),
+		.irq = MX3x_INT_GPIO3,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
 	}
 };
@@ -56,8 +56,8 @@ int __init imx3x_register_gpios(void)
 
 static struct resource mxc_w1_master_resources[] = {
 	{
-		.start = OWIRE_BASE_ADDR,
-		.end   = OWIRE_BASE_ADDR + SZ_4K - 1,
+		.start = MX3x_OWIRE_BASE_ADDR,
+		.end = MX3x_OWIRE_BASE_ADDR + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 };
@@ -110,8 +110,8 @@ struct platform_device mxcsdhc_device1 = {
 
 static struct resource rnga_resources[] = {
 	{
-		.start = RNGA_BASE_ADDR,
-		.end = RNGA_BASE_ADDR + 0x28,
+		.start = MX3x_RNGA_BASE_ADDR,
+		.end = MX3x_RNGA_BASE_ADDR + 0x28,
 		.flags = IORESOURCE_MEM,
 	},
 };
@@ -129,20 +129,20 @@ struct platform_device mxc_rnga_device = {
 /* The resource order is important! */
 static struct resource mx3_ipu_rsrc[] = {
 	{
-		.start = IPU_CTRL_BASE_ADDR,
-		.end = IPU_CTRL_BASE_ADDR + 0x5F,
+		.start = MX3x_IPU_CTRL_BASE_ADDR,
+		.end = MX3x_IPU_CTRL_BASE_ADDR + 0x5F,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = IPU_CTRL_BASE_ADDR + 0x88,
-		.end = IPU_CTRL_BASE_ADDR + 0xB3,
+		.start = MX3x_IPU_CTRL_BASE_ADDR + 0x88,
+		.end = MX3x_IPU_CTRL_BASE_ADDR + 0xB3,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_IPU_SYN,
-		.end = MXC_INT_IPU_SYN,
+		.start = MX3x_INT_IPU_SYN,
+		.end = MX3x_INT_IPU_SYN,
 		.flags = IORESOURCE_IRQ,
 	}, {
-		.start = MXC_INT_IPU_ERR,
-		.end = MXC_INT_IPU_ERR,
+		.start = MX3x_INT_IPU_ERR,
+		.end = MX3x_INT_IPU_ERR,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -156,8 +156,8 @@ struct platform_device mx3_ipu = {
 
 static struct resource fb_resources[] = {
 	{
-		.start	= IPU_CTRL_BASE_ADDR + 0xB4,
-		.end	= IPU_CTRL_BASE_ADDR + 0x1BF,
+		.start	= MX3x_IPU_CTRL_BASE_ADDR + 0xB4,
+		.end	= MX3x_IPU_CTRL_BASE_ADDR + 0x1BF,
 		.flags	= IORESOURCE_MEM,
 	},
 };
@@ -174,8 +174,8 @@ struct platform_device mx3_fb = {
 
 static struct resource camera_resources[] = {
 	{
-		.start	= IPU_CTRL_BASE_ADDR + 0x60,
-		.end	= IPU_CTRL_BASE_ADDR + 0x87,
+		.start	= MX3x_IPU_CTRL_BASE_ADDR + 0x60,
+		.end	= MX3x_IPU_CTRL_BASE_ADDR + 0x87,
 		.flags	= IORESOURCE_MEM,
 	},
 };
@@ -190,14 +190,15 @@ struct platform_device mx3_camera = {
 	},
 };
 
+#ifdef CONFIG_ARCH_MX31
 static struct resource otg_resources[] = {
 	{
 		.start	= MX31_OTG_BASE_ADDR,
 		.end	= MX31_OTG_BASE_ADDR + 0x1ff,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= MXC_INT_USB3,
-		.end	= MXC_INT_USB3,
+		.start	= MX31_INT_USB3,
+		.end	= MX31_INT_USB3,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -215,6 +216,7 @@ struct platform_device mxc_otg_udc_device = {
 	.resource	= otg_resources,
 	.num_resources	= ARRAY_SIZE(otg_resources),
 };
+#endif
 
 /* OTG host */
 struct platform_device mxc_otg_host = {
@@ -228,8 +230,8 @@ struct platform_device mxc_otg_host = {
 	.num_resources = ARRAY_SIZE(otg_resources),
 };
 
+#ifdef CONFIG_ARCH_MX31
 /* USB host 1 */
-
 static u64 usbh1_dmamask = ~(u32)0;
 
 static struct resource mxc_usbh1_resources[] = {
@@ -238,8 +240,8 @@ static struct resource mxc_usbh1_resources[] = {
 		.end = MX31_OTG_BASE_ADDR + 0x3ff,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_USB1,
-		.end = MXC_INT_USB1,
+		.start = MX31_INT_USB1,
+		.end = MX31_INT_USB1,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -264,8 +266,8 @@ static struct resource mxc_usbh2_resources[] = {
 		.end = MX31_OTG_BASE_ADDR + 0x5ff,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_USB2,
-		.end = MXC_INT_USB2,
+		.start = MX31_INT_USB2,
+		.end = MX31_INT_USB2,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -280,6 +282,7 @@ struct platform_device mxc_usbh2 = {
 	.resource = mxc_usbh2_resources,
 	.num_resources = ARRAY_SIZE(mxc_usbh2_resources),
 };
+#endif
 
 static struct resource imx_wdt_resources[] = {
 	{
@@ -343,14 +346,17 @@ static int __init mx3_devices_init(void)
 #endif
 #if defined(CONFIG_ARCH_MX35)
 	if (cpu_is_mx35()) {
+		imx_gpio_ports[0].base = MX35_IO_ADDRESS(MX35_GPIO1_BASE_ADDR),
+		imx_gpio_ports[1].base = MX35_IO_ADDRESS(MX35_GPIO2_BASE_ADDR),
+		imx_gpio_ports[2].base = MX35_IO_ADDRESS(MX35_GPIO3_BASE_ADDR),
 		otg_resources[0].start = MX35_OTG_BASE_ADDR;
 		otg_resources[0].end = MX35_OTG_BASE_ADDR + 0x1ff;
-		otg_resources[1].start = MXC_INT_USBOTG;
-		otg_resources[1].end = MXC_INT_USBOTG;
+		otg_resources[1].start = MX35_INT_USBOTG;
+		otg_resources[1].end = MX35_INT_USBOTG;
 		mxc_usbh1_resources[0].start = MX35_OTG_BASE_ADDR + 0x400;
 		mxc_usbh1_resources[0].end = MX35_OTG_BASE_ADDR + 0x5ff;
-		mxc_usbh1_resources[1].start = MXC_INT_USBHS;
-		mxc_usbh1_resources[1].end = MXC_INT_USBHS;
+		mxc_usbh1_resources[1].start = MX35_INT_USBHS;
+		mxc_usbh1_resources[1].end = MX35_INT_ESAI;
 		imx_wdt_resources[0].start = MX35_WDOG_BASE_ADDR;
 		imx_wdt_resources[0].end = MX35_WDOG_BASE_ADDR + 0x3fff;
 	}
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 6fe69e1..1d24617 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -281,7 +281,7 @@ static void __init mxc_board_init(void)
 	mx31_3ds_usbotg_init();
 	mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
 
-	if (!mxc_expio_init(CS5_BASE_ADDR, EXPIO_PARENT_INT))
+	if (!mxc_expio_init(MX31_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debugboard failed, all "
 				    "devices on the board are unusable.\n");
 }
diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index b4ffc53..809ee40 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -42,29 +42,29 @@
  */
 static struct map_desc mxc_io_desc[] __initdata = {
 	{
-		.virtual	= X_MEMC_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(X_MEMC_BASE_ADDR),
-		.length		= X_MEMC_SIZE,
-		.type		= MT_DEVICE
+		.virtual = MX3x_X_MEMC_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX3x_X_MEMC_BASE_ADDR),
+		.length = MX3x_X_MEMC_SIZE,
+		.type = MT_DEVICE
 	}, {
-		.virtual	= AVIC_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(AVIC_BASE_ADDR),
-		.length		= AVIC_SIZE,
-		.type		= MT_DEVICE_NONSHARED
+		.virtual = MX3x_AVIC_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX3x_AVIC_BASE_ADDR),
+		.length = MX3x_AVIC_SIZE,
+		.type = MT_DEVICE_NONSHARED
 	}, {
-		.virtual	= AIPS1_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(AIPS1_BASE_ADDR),
-		.length		= AIPS1_SIZE,
-		.type		= MT_DEVICE_NONSHARED
+		.virtual = MX3x_AIPS1_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX3x_AIPS1_BASE_ADDR),
+		.length = MX3x_AIPS1_SIZE,
+		.type = MT_DEVICE_NONSHARED
 	}, {
-		.virtual	= AIPS2_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(AIPS2_BASE_ADDR),
-		.length		= AIPS2_SIZE,
-		.type		= MT_DEVICE_NONSHARED
+		.virtual = MX3x_AIPS2_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX3x_AIPS2_BASE_ADDR),
+		.length = MX3x_AIPS2_SIZE,
+		.type = MT_DEVICE_NONSHARED
 	}, {
-		.virtual = SPBA0_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(SPBA0_BASE_ADDR),
-		.length = SPBA0_SIZE,
+		.virtual = MX3x_SPBA0_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX3x_SPBA0_BASE_ADDR),
+		.length = MX3x_SPBA0_SIZE,
 		.type = MT_DEVICE_NONSHARED
 	},
 };
@@ -77,7 +77,7 @@ static struct map_desc mxc_io_desc[] __initdata = {
 void __init mx31_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX31);
-	mxc_arch_reset_init(IO_ADDRESS(WDOG_BASE_ADDR));
+	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
 
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
@@ -86,8 +86,8 @@ void __init mx31_map_io(void)
 void __init mx35_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX35);
-	mxc_iomux_v3_init(IO_ADDRESS(IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(IO_ADDRESS(WDOG_BASE_ADDR));
+	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
+	mxc_arch_reset_init(MX35_IO_ADDRESS(MX3x_WDOG_BASE_ADDR));
 
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
@@ -97,7 +97,7 @@ int imx3x_register_gpios(void);
 
 void __init mx31_init_irq(void)
 {
-	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
+	mxc_init_irq(MX31_IO_ADDRESS(MX3x_AVIC_BASE_ADDR));
 	imx3x_register_gpios();
 }
 
@@ -129,7 +129,7 @@ static int mxc_init_l2x0(void)
 		pr_err("L2 cache: Cannot fix timing. Trying to continue without\n");
 	}
 
-	l2x0_base = ioremap(L2CC_BASE_ADDR, 4096);
+	l2x0_base = ioremap(MX3x_L2CC_BASE_ADDR, 4096);
 	if (IS_ERR(l2x0_base)) {
 		printk(KERN_ERR "remapping L2 cache area failed with %ld\n",
 				PTR_ERR(l2x0_base));
-- 
1.7.2.3
