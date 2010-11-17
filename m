From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:15 +0100
Subject: [PATCH 47/51] ARM: mx3: dynamically allocate fsl-usb2-udc devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-47-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While adapting the #defines for this I noticed that the offset
used for USB HS on i.MX35 differs from the documented offset.
I kept the working offset and commented that the documentation
differs.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                         |    9 +++-
 arch/arm/mach-mx3/devices-imx31.h                 |    4 ++
 arch/arm/mach-mx3/devices-imx35.h                 |    4 ++
 arch/arm/mach-mx3/devices.c                       |   52 ++++++++-------------
 arch/arm/mach-mx3/devices.h                       |    1 -
 arch/arm/mach-mx3/mach-cpuimx35.c                 |    5 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c                 |    5 +-
 arch/arm/mach-mx3/mach-mx35_3ds.c                 |    5 +-
 arch/arm/mach-mx3/mach-pcm037.c                   |    5 +-
 arch/arm/mach-mx3/mach-pcm043.c                   |    5 +-
 arch/arm/mach-mx3/mx31moboard-devboard.c          |    5 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c           |    5 +-
 arch/arm/mach-mx3/mx31moboard-smartbot.c          |    5 +-
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c |   10 ++++
 arch/arm/plat-mxc/include/mach/mx31.h             |   12 +++--
 arch/arm/plat-mxc/include/mach/mx35.h             |   14 ++++--
 16 files changed, 78 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 17ae7d3..120add4 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -50,6 +50,7 @@ config MACH_MX31ADS_WM1133_EV1
 config MACH_PCM037
 	bool "Support Phytec pcm037 (i.MX31) platforms"
 	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -85,6 +86,7 @@ config MACH_MX31_3DS
 	bool "Support MX31PDK (3DS)"
 	select SOC_IMX31
 	select MXC_DEBUG_BOARD
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
@@ -104,6 +106,7 @@ config MACH_MX31_3DS_MXC_NAND_USE_BBT
 config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
 	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -135,6 +138,7 @@ config MACH_QONG
 config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select SOC_IMX35
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -162,10 +166,10 @@ config MACH_MX35_3DS
 	bool "Support MX35PDK platform"
 	select SOC_IMX35
 	select MXC_DEBUG_BOARD
+	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_ESDHC
-	default n
 	help
 	  Include support for MX35PDK platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -181,6 +185,7 @@ config MACH_KZM_ARM11_01
 config MACH_EUKREA_CPUIMX35
 	bool "Support Eukrea CPUIMX35 Platform"
 	select SOC_IMX35
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 875e26f..0cefaca 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -9,6 +9,10 @@
 #include <mach/mx31.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data __initconst;
+#define imx31_add_fsl_usb2_udc(pdata)	\
+	imx_add_fsl_usb2_udc(&imx31_fsl_usb2_udc_data, pdata)
+
 extern const struct imx_imx_i2c_data imx31_imx_i2c_data[] __initconst;
 #define imx31_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx31_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index a71ce68..36561cc 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -13,6 +13,10 @@ extern const struct imx_fec_data imx35_fec_data __initconst;
 #define imx35_add_fec(pdata)	\
 	imx_add_fec(&imx35_fec_data, pdata)
 
+extern const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data __initconst;
+#define imx35_add_fsl_usb2_udc(pdata)	\
+	imx_add_fsl_usb2_udc(&imx35_fsl_usb2_udc_data, pdata)
+
 extern const struct imx_flexcan_data imx35_flexcan_data[] __initconst;
 #define imx35_add_flexcan(id, pdata)	\
 	imx_add_flexcan(&imx35_flexcan_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 202c06c..3f859ae 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -97,30 +97,18 @@ struct platform_device mx3_camera = {
 
 static struct resource otg_resources[] = {
 	{
-		.start	= MX31_OTG_BASE_ADDR,
-		.end	= MX31_OTG_BASE_ADDR + 0x1ff,
+		.start	= MX31_USB_OTG_BASE_ADDR,
+		.end	= MX31_USB_OTG_BASE_ADDR + 0x1ff,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= MX31_INT_USB3,
-		.end	= MX31_INT_USB3,
+		.start	= MX31_INT_USB_OTG,
+		.end	= MX31_INT_USB_OTG,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
 
 static u64 otg_dmamask = DMA_BIT_MASK(32);
 
-/* OTG gadget device */
-struct platform_device mxc_otg_udc_device = {
-	.name		= "fsl-usb2-udc",
-	.id		= -1,
-	.dev		= {
-		.dma_mask		= &otg_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= otg_resources,
-	.num_resources	= ARRAY_SIZE(otg_resources),
-};
-
 /* OTG host */
 struct platform_device mxc_otg_host = {
 	.name = "mxc-ehci",
@@ -139,12 +127,12 @@ static u64 usbh1_dmamask = ~(u32)0;
 
 static struct resource mxc_usbh1_resources[] = {
 	{
-		.start = MX31_OTG_BASE_ADDR + 0x200,
-		.end = MX31_OTG_BASE_ADDR + 0x3ff,
+		.start = MX31_USB_HS1_BASE_ADDR,
+		.end = MX31_USB_HS1_BASE_ADDR + 0x1ff,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MX31_INT_USB1,
-		.end = MX31_INT_USB1,
+		.start = MX31_INT_USB_HS1,
+		.end = MX31_INT_USB_HS1,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -166,12 +154,12 @@ static u64 usbh2_dmamask = ~(u32)0;
 
 static struct resource mxc_usbh2_resources[] = {
 	{
-		.start = MX31_OTG_BASE_ADDR + 0x400,
-		.end = MX31_OTG_BASE_ADDR + 0x5ff,
+		.start = MX31_USB_HS2_BASE_ADDR,
+		.end = MX31_USB_HS2_BASE_ADDR + 0x1ff,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MX31_INT_USB2,
-		.end = MX31_INT_USB2,
+		.start = MX31_INT_USB_HS2,
+		.end = MX31_INT_USB_HS2,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -249,14 +237,14 @@ static int __init mx3_devices_init(void)
 #endif
 #if defined(CONFIG_ARCH_MX35)
 	if (cpu_is_mx35()) {
-		otg_resources[0].start = MX35_OTG_BASE_ADDR;
-		otg_resources[0].end = MX35_OTG_BASE_ADDR + 0x1ff;
-		otg_resources[1].start = MX35_INT_USBOTG;
-		otg_resources[1].end = MX35_INT_USBOTG;
-		mxc_usbh1_resources[0].start = MX35_OTG_BASE_ADDR + 0x400;
-		mxc_usbh1_resources[0].end = MX35_OTG_BASE_ADDR + 0x5ff;
-		mxc_usbh1_resources[1].start = MX35_INT_USBHS;
-		mxc_usbh1_resources[1].end = MX35_INT_USBHS;
+		otg_resources[0].start = MX35_USB_OTG_BASE_ADDR;
+		otg_resources[0].end = MX35_USB_OTG_BASE_ADDR + 0x1ff;
+		otg_resources[1].start = MX35_INT_USB_OTG;
+		otg_resources[1].end = MX35_INT_USB_OTG;
+		mxc_usbh1_resources[0].start = MX35_USB_HS_BASE_ADDR;
+		mxc_usbh1_resources[0].end = MX35_USB_HS_BASE_ADDR + 0x1ff;
+		mxc_usbh1_resources[1].start = MX35_INT_USB_HS;
+		mxc_usbh1_resources[1].end = MX35_INT_USB_HS;
 		imx_wdt_resources[0].start = MX35_WDOG_BASE_ADDR;
 		imx_wdt_resources[0].end = MX35_WDOG_BASE_ADDR + 0x3fff;
 	}
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index d472c45..eb3b990f 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -1,7 +1,6 @@
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
-extern struct platform_device mxc_otg_udc_device;
 extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 9fde873..b8b619a 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -30,7 +30,6 @@
 #include <linux/i2c/tsc2007.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
-#include <linux/fsl_devices.h>
 #include <linux/i2c-gpio.h>
 
 #include <asm/mach-types.h>
@@ -128,7 +127,7 @@ static struct mxc_usbh_platform_data __maybe_unused usbh1_pdata = {
 		  MXC_EHCI_IPPUE_DOWN,
 };
 
-static struct fsl_usb2_platform_data otg_device_pdata = {
+static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_UTMI,
 	.workaround	= FLS_USB2_WORKAROUND_ENGCM09152,
@@ -170,7 +169,7 @@ static void __init mxc_board_init(void)
 	if (otg_mode_host)
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	else
-		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+		imx35_add_fsl_usb2_udc(&otg_device_pdata);
 
 	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
 
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 0ad9e78..1b46f73 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -22,7 +22,6 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
-#include <linux/fsl_devices.h>
 #include <linux/input/matrix_keypad.h>
 
 #include <mach/hardware.h>
@@ -214,7 +213,7 @@ usbotg_free_reset:
 	return err;
 }
 
-static struct fsl_usb2_platform_data usbotg_pdata = {
+static const struct fsl_usb2_platform_data usbotg_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_ULPI,
 };
@@ -249,7 +248,7 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&imx_kpp_device, &mx31_3ds_keymap_data);
 
 	mx31_3ds_usbotg_init();
-	mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
+	imx31_add_fsl_usb2_udc(&usbotg_pdata);
 
 	if (mxc_expio_init(MX31_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debug board failed, all "
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index b66a75a..6dfdf17 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -26,7 +26,6 @@
 #include <linux/platform_device.h>
 #include <linux/memory.h>
 #include <linux/gpio.h>
-#include <linux/fsl_devices.h>
 
 #include <linux/mtd/physmap.h>
 
@@ -122,7 +121,7 @@ static struct pad_desc mx35pdk_pads[] = {
 };
 
 /* OTG config */
-static struct fsl_usb2_platform_data usb_otg_pdata = {
+static const struct fsl_usb2_platform_data usb_otg_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
@@ -146,7 +145,7 @@ static void __init mxc_board_init(void)
 
 	imx35_add_imx_uart0(&uart_pdata);
 
-	mxc_register_device(&mxc_otg_udc_device, &usb_otg_pdata);
+	imx35_add_fsl_usb2_udc(&usb_otg_pdata);
 
 	mxc_register_device(&mxc_usbh1, &usb_host_pdata);
 
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 2ba4f2b..20f7f94 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -27,7 +27,6 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/irq.h>
-#include <linux/fsl_devices.h>
 #include <linux/can/platform/sja1000.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -550,7 +549,7 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 };
 #endif
 
-static struct fsl_usb2_platform_data otg_device_pdata = {
+static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
 	.phy_mode       = FSL_USB2_PHY_ULPI,
 };
@@ -664,7 +663,7 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 #endif
 	if (!otg_mode_host)
-		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+		imx31_add_fsl_usb2_udc(&otg_device_pdata);
 
 }
 
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 4e1de87..78159f0 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -27,7 +27,6 @@
 #include <linux/i2c/at24.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
-#include <linux/fsl_devices.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -323,7 +322,7 @@ static struct mxc_usbh_platform_data usbh1_pdata = {
 };
 #endif
 
-static struct fsl_usb2_platform_data otg_device_pdata = {
+static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
 	.phy_mode       = FSL_USB2_PHY_UTMI,
 };
@@ -392,7 +391,7 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
 #endif
 	if (!otg_mode_host)
-		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+		imx35_add_fsl_usb2_udc(&otg_device_pdata);
 
 	imx35_add_flexcan1(NULL);
 	imx35_add_esdhc(0, NULL);
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
index 3b75929..331b595 100644
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/fsl_devices.h>
 
 #include <linux/usb/otg.h>
 
@@ -210,7 +209,7 @@ static int __init devboard_usbh1_init(void)
 }
 
 
-static struct fsl_usb2_platform_data usb_pdata = {
+static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_ULPI,
 };
@@ -231,7 +230,7 @@ void __init mx31moboard_devboard_init(void)
 
 	devboard_init_sel_gpios();
 
-	mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+	imx31_add_fsl_usb2_udc(&usb_pdata);
 
 	devboard_usbh1_init();
 }
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 075c4fb..db79f74 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <linux/fsl_devices.h>
 
 #include <linux/usb/otg.h>
 
@@ -326,7 +325,7 @@ static int __init marxbot_usbh1_init(void)
 	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
 }
 
-static struct fsl_usb2_platform_data usb_pdata = {
+static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_ULPI,
 };
@@ -358,7 +357,7 @@ void __init mx31moboard_marxbot_init(void)
 	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_LCS0));
 	gpio_export(IOMUX_TO_GPIO(MX31_PIN_LCS0), false);
 
-	mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+	imx31_add_fsl_usb2_udc(&usb_pdata);
 
 	marxbot_usbh1_init();
 }
diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
index 417757e..68e8ab5 100644
--- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
@@ -19,7 +19,6 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <linux/fsl_devices.h>
 
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -119,7 +118,7 @@ static int __init smartbot_cam_init(void)
 	return 0;
 }
 
-static struct fsl_usb2_platform_data usb_pdata = {
+static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_ULPI,
 };
@@ -183,7 +182,7 @@ void __init mx31moboard_smartbot_init(int board)
 
 	switch (board) {
 	case MX31SMARTBOT:
-		mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+		imx31_add_fsl_usb2_udc(&usb_pdata);
 		break;
 	case MX31EYEBOT:
 		smartbot_otg_host_init();
diff --git a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
index 42c3923..59c33f6 100644
--- a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
+++ b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
@@ -25,6 +25,16 @@ const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst =
 	imx_fsl_usb2_udc_data_entry_single(MX27);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
+#ifdef CONFIG_SOC_IMX31
+const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data __initconst =
+	imx_fsl_usb2_udc_data_entry_single(MX31);
+#endif /* ifdef CONFIG_SOC_IMX31 */
+
+#ifdef CONFIG_SOC_IMX35
+const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data __initconst =
+	imx_fsl_usb2_udc_data_entry_single(MX35);
+#endif /* ifdef CONFIG_SOC_IMX35 */
+
 struct platform_device *__init imx_add_fsl_usb2_udc(
 		const struct imx_fsl_usb2_udc_data *data,
 		const struct fsl_usb2_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index d024c9c..0923231 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -24,7 +24,10 @@
 #define MX31_ECT_CTIO_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x18000)
 #define MX31_I2C1_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x80000)
 #define MX31_I2C3_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x84000)
-#define MX31_OTG_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x88000)
+#define MX31_USB_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x88000)
+#define MX31_USB_OTG_BASE_ADDR			(MX31_USB_BASE_ADDR + 0x0000)
+#define MX31_USB_HS1_BASE_ADDR			(MX31_USB_BASE_ADDR + 0x0200)
+#define MX31_USB_HS2_BASE_ADDR			(MX31_USB_BASE_ADDR + 0x0400)
 #define MX31_ATA_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x8c000)
 #define MX31_UART1_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x90000)
 #define MX31_UART2_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x94000)
@@ -161,10 +164,9 @@ static inline void mx31_setup_weimcs(size_t cs,
 #define MX31_INT_UART2		32
 #define MX31_INT_NFC		33
 #define MX31_INT_SDMA		34
-#define MX31_INT_USB1		35
-#define MX31_INT_USB2		36
-#define MX31_INT_USB3		37
-#define MX31_INT_USB4		38
+#define MX31_INT_USB_HS1	35
+#define MX31_INT_USB_HS2	36
+#define MX31_INT_USB_OTG	37
 #define MX31_INT_MSHC1		39
 #define MX31_INT_MSHC2		40
 #define MX31_INT_IPU_ERR	41
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index 9067225..0fa3f68 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -65,8 +65,14 @@
 #define MX35_CAN2_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xe8000)
 #define MX35_RTIC_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xec000)
 #define MX35_IIM_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xf0000)
-
-#define MX35_OTG_BASE_ADDR		0x53ff4000
+#define MX35_USB_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xf4000)
+#define MX35_USB_OTG_BASE_ADDR			(MX35_USB_BASE_ADDR + 0x0000)
+/*
+ * The Reference Manual (IMX35RM, Rev. 2, 3/2009) claims an offset of 0x200 for
+ * HS.  When host support was implemented only a preliminary document was
+ * available, which told 0x400.  This works fine.
+ */
+#define MX35_USB_HS_BASE_ADDR			(MX35_USB_BASE_ADDR + 0x0400)
 
 #define MX35_ROMP_BASE_ADDR		0x60000000
 #define MX35_ROMP_SIZE			SZ_1M
@@ -143,8 +149,8 @@
 #define MX35_INT_UART2		32
 #define MX35_INT_NFC		33
 #define MX35_INT_SDMA		34
-#define MX35_INT_USBHS		35
-#define MX35_INT_USBOTG		37
+#define MX35_INT_USB_HS		35
+#define MX35_INT_USB_OTG	37
 #define MX35_INT_MSHC1		39
 #define MX35_INT_ESAI		40
 #define MX35_INT_IPU_ERR	41
-- 
1.7.2.3
