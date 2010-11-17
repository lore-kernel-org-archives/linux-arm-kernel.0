From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:16 +0100
Subject: [PATCH 48/51] ARM: mx3: dynamically allocate mxc-ehci devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-48-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                     |    8 ++
 arch/arm/mach-mx3/devices-imx31.h             |    7 ++
 arch/arm/mach-mx3/devices-imx35.h             |    7 ++
 arch/arm/mach-mx3/devices.c                   |   89 -------------------------
 arch/arm/mach-mx3/devices.h                   |    3 -
 arch/arm/mach-mx3/mach-armadillo5x0.c         |    9 +--
 arch/arm/mach-mx3/mach-cpuimx35.c             |    9 +--
 arch/arm/mach-mx3/mach-mx31lilly.c            |    9 +--
 arch/arm/mach-mx3/mach-mx31lite.c             |    5 +-
 arch/arm/mach-mx3/mach-mx31moboard.c          |   11 ++-
 arch/arm/mach-mx3/mach-mx35_3ds.c             |    5 +-
 arch/arm/mach-mx3/mach-pcm037.c               |    9 +--
 arch/arm/mach-mx3/mach-pcm043.c               |    9 +--
 arch/arm/mach-mx3/mx31moboard-devboard.c      |   10 ++-
 arch/arm/mach-mx3/mx31moboard-marxbot.c       |   10 ++-
 arch/arm/mach-mx3/mx31moboard-smartbot.c      |   11 ++-
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c |   16 +++++
 17 files changed, 92 insertions(+), 135 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 120add4..1573483 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -53,6 +53,7 @@ config MACH_PCM037
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
@@ -75,6 +76,7 @@ config MACH_MX31LITE
 	select SOC_IMX31
 	select MXC_ULPI if USB_ULPI
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
@@ -109,6 +111,7 @@ config MACH_MX31MOBOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
@@ -120,6 +123,7 @@ config MACH_MX31LILLY
 	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
@@ -142,6 +146,7 @@ config MACH_PCM043
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_ESDHC
@@ -155,6 +160,7 @@ config MACH_ARMADILLO5X0
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
@@ -169,6 +175,7 @@ config MACH_MX35_3DS
 	select IMX_HAVE_PLATFORM_ESDHC
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for MX35PDK platform. This includes specific
@@ -188,6 +195,7 @@ config MACH_EUKREA_CPUIMX35
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_ESDHC
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 0cefaca..6571dd7 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -33,6 +33,13 @@ extern const struct imx_imx_uart_1irq_data imx31_imx_uart_data[] __initconst;
 #define imx31_add_imx_uart3(pdata)	imx31_add_imx_uart(3, pdata)
 #define imx31_add_imx_uart4(pdata)	imx31_add_imx_uart(4, pdata)
 
+extern const struct imx_mxc_ehci_data imx31_mxc_ehci_otg_data __initconst;
+#define imx31_add_mxc_ehci_otg(pdata)	\
+	imx_add_mxc_ehci(&imx31_mxc_ehci_otg_data, pdata)
+extern const struct imx_mxc_ehci_data imx31_mxc_ehci_hs_data[] __initconst;
+#define imx31_add_mxc_ehci_hs(id, pdata)	\
+	imx_add_mxc_ehci(&imx31_mxc_ehci_hs_data[id - 1], pdata)
+
 extern const struct imx_mxc_mmc_data imx31_mxc_mmc_data[] __initconst;
 #define imx31_add_mxc_mmc(id, pdata)	\
 	imx_add_mxc_mmc(&imx31_mxc_mmc_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 36561cc..849c48a 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -41,6 +41,13 @@ extern const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst;
 #define imx35_add_imx_uart1(pdata)	imx35_add_imx_uart(1, pdata)
 #define imx35_add_imx_uart2(pdata)	imx35_add_imx_uart(2, pdata)
 
+extern const struct imx_mxc_ehci_data imx35_mxc_ehci_otg_data __initconst;
+#define imx35_add_mxc_ehci_otg(pdata)	\
+	imx_add_mxc_ehci(&imx35_mxc_ehci_otg_data, pdata)
+extern const struct imx_mxc_ehci_data imx35_mxc_ehci_hs_data __initconst;
+#define imx35_add_mxc_ehci_hs(pdata)	\
+	imx_add_mxc_ehci(&imx35_mxc_ehci_hs_data, pdata)
+
 extern const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst;
 #define imx35_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx35_mxc_nand_data, pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 3f859ae..c122c0f 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -95,87 +95,6 @@ struct platform_device mx3_camera = {
 	},
 };
 
-static struct resource otg_resources[] = {
-	{
-		.start	= MX31_USB_OTG_BASE_ADDR,
-		.end	= MX31_USB_OTG_BASE_ADDR + 0x1ff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MX31_INT_USB_OTG,
-		.end	= MX31_INT_USB_OTG,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 otg_dmamask = DMA_BIT_MASK(32);
-
-/* OTG host */
-struct platform_device mxc_otg_host = {
-	.name = "mxc-ehci",
-	.id = 0,
-	.dev = {
-		.coherent_dma_mask = 0xffffffff,
-		.dma_mask = &otg_dmamask,
-	},
-	.resource = otg_resources,
-	.num_resources = ARRAY_SIZE(otg_resources),
-};
-
-/* USB host 1 */
-
-static u64 usbh1_dmamask = ~(u32)0;
-
-static struct resource mxc_usbh1_resources[] = {
-	{
-		.start = MX31_USB_HS1_BASE_ADDR,
-		.end = MX31_USB_HS1_BASE_ADDR + 0x1ff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX31_INT_USB_HS1,
-		.end = MX31_INT_USB_HS1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_usbh1 = {
-	.name = "mxc-ehci",
-	.id = 1,
-	.dev = {
-		.coherent_dma_mask = 0xffffffff,
-		.dma_mask = &usbh1_dmamask,
-	},
-	.resource = mxc_usbh1_resources,
-	.num_resources = ARRAY_SIZE(mxc_usbh1_resources),
-};
-
-#ifdef CONFIG_ARCH_MX31
-/* USB host 2 */
-static u64 usbh2_dmamask = ~(u32)0;
-
-static struct resource mxc_usbh2_resources[] = {
-	{
-		.start = MX31_USB_HS2_BASE_ADDR,
-		.end = MX31_USB_HS2_BASE_ADDR + 0x1ff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX31_INT_USB_HS2,
-		.end = MX31_INT_USB_HS2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_usbh2 = {
-	.name = "mxc-ehci",
-	.id = 2,
-	.dev = {
-		.coherent_dma_mask = 0xffffffff,
-		.dma_mask = &usbh2_dmamask,
-	},
-	.resource = mxc_usbh2_resources,
-	.num_resources = ARRAY_SIZE(mxc_usbh2_resources),
-};
-#endif
-
 static struct resource imx_wdt_resources[] = {
 	{
 		.flags = IORESOURCE_MEM,
@@ -237,14 +156,6 @@ static int __init mx3_devices_init(void)
 #endif
 #if defined(CONFIG_ARCH_MX35)
 	if (cpu_is_mx35()) {
-		otg_resources[0].start = MX35_USB_OTG_BASE_ADDR;
-		otg_resources[0].end = MX35_USB_OTG_BASE_ADDR + 0x1ff;
-		otg_resources[1].start = MX35_INT_USB_OTG;
-		otg_resources[1].end = MX35_INT_USB_OTG;
-		mxc_usbh1_resources[0].start = MX35_USB_HS_BASE_ADDR;
-		mxc_usbh1_resources[0].end = MX35_USB_HS_BASE_ADDR + 0x1ff;
-		mxc_usbh1_resources[1].start = MX35_INT_USB_HS;
-		mxc_usbh1_resources[1].end = MX35_INT_USB_HS;
 		imx_wdt_resources[0].start = MX35_WDOG_BASE_ADDR;
 		imx_wdt_resources[0].end = MX35_WDOG_BASE_ADDR + 0x3fff;
 	}
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index eb3b990f..1bc2918 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -1,9 +1,6 @@
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
-extern struct platform_device mxc_otg_host;
-extern struct platform_device mxc_usbh1;
-extern struct platform_device mxc_usbh2;
 extern struct platform_device imx_wdt_device0;
 extern struct platform_device imx_rtc_device0;
 extern struct platform_device imx_kpp_device;
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index e48072c..28b6f41 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -51,7 +51,6 @@
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
@@ -244,13 +243,13 @@ h2_free_cs:
 	return err;
 }
 
-static struct mxc_usbh_platform_data usbotg_pdata = {
+static struct mxc_usbh_platform_data usbotg_pdata __initdata = {
 	.init	= usbotg_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
-static struct mxc_usbh_platform_data usbh2_pdata = {
+static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_DIFF_UNI,
@@ -554,8 +553,8 @@ static void __init armadillo5x0_init(void)
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-	mxc_register_device(&mxc_otg_host, &usbotg_pdata);
-	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	imx31_add_mxc_ehci_otg(&usbotg_pdata);
+	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 #endif
 }
 
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index b8b619a..0af1e84 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -42,7 +42,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
 #include <mach/mxc_nand.h>
-#include <mach/mxc_ehci.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -116,12 +115,12 @@ static const struct mxc_nand_platform_data
 	.flash_bbt	= 1,
 };
 
-static struct mxc_usbh_platform_data __maybe_unused otg_pdata = {
+static const struct mxc_usbh_platform_data otg_pdata __initconst = {
 	.portsc	= MXC_EHCI_MODE_UTMI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
-static struct mxc_usbh_platform_data __maybe_unused usbh1_pdata = {
+static const struct mxc_usbh_platform_data usbh1_pdata __initconst = {
 	.portsc	= MXC_EHCI_MODE_SERIAL,
 	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
 		  MXC_EHCI_IPPUE_DOWN,
@@ -167,11 +166,11 @@ static void __init mxc_board_init(void)
 	imx35_add_imx_i2c0(&eukrea_cpuimx35_i2c0_data);
 
 	if (otg_mode_host)
-		mxc_register_device(&mxc_otg_host, &otg_pdata);
+		imx35_add_mxc_ehci_otg(&otg_pdata);
 	else
 		imx35_add_fsl_usb2_udc(&otg_device_pdata);
 
-	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+	imx35_add_mxc_ehci_hs(&usbh1_pdata);
 
 #ifdef CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD
 	eukrea_mbimxsd35_baseboard_init();
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index 42f47fa..2c59548 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -42,7 +42,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lilly.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
@@ -230,13 +229,13 @@ static struct mxc_usbh_platform_data usbotg_pdata = {
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
-static struct mxc_usbh_platform_data usbh1_pdata = {
+static const struct mxc_usbh_platform_data usbh1_pdata __initconst = {
 	.init	= usbh1_init,
 	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
 };
 
-static struct mxc_usbh_platform_data usbh2_pdata = {
+static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= usbh2_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
@@ -249,8 +248,8 @@ static void lilly1131_usb_init(void)
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
-	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	imx31_add_mxc_ehci_hs(1, &usbh1_pdata);
+	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 }
 
 #else
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index b938958..9e64c66 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -40,7 +40,6 @@
 #include <mach/board-mx31lite.h>
 #include <mach/iomux-mx3.h>
 #include <mach/irqs.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
@@ -171,7 +170,7 @@ static int usbh2_init(struct platform_device *pdev)
 	return 0;
 }
 
-static struct mxc_usbh_platform_data usbh2_pdata = {
+static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init   = usbh2_init,
 	.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 	.flags  = MXC_EHCI_POWER_PINS_ENABLED,
@@ -258,7 +257,7 @@ static void __init mxc_board_init(void)
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 #endif
 
 	/* SMSC9117 IRQ pin */
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 5e2ee85..203d21a 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -40,7 +40,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
-#include <mach/mxc_ehci.h>
 #include <mach/mx3_camera.h>
 #include <mach/spi.h>
 #include <mach/ulpi.h>
@@ -403,17 +402,23 @@ static void usb_xcvr_reset(void)
 
 #if defined(CONFIG_USB_ULPI)
 
-static struct mxc_usbh_platform_data usbh2_pdata = {
+static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
 static int __init moboard_usbh2_init(void)
 {
+	struct platform_device *pdev;
+
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-	return mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	pdev = imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
 }
 #else
 static inline int moboard_usbh2_init(void) { return 0; }
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 6dfdf17..73fb115 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -39,7 +39,6 @@
 #include <mach/iomux-mx35.h>
 #include <mach/irqs.h>
 #include <mach/3ds_debugboard.h>
-#include <mach/mxc_ehci.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -127,7 +126,7 @@ static const struct fsl_usb2_platform_data usb_otg_pdata __initconst = {
 };
 
 /* USB HOST config */
-static struct mxc_usbh_platform_data usb_host_pdata = {
+static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
 	.portsc		= MXC_EHCI_MODE_SERIAL,
 	.flags		= MXC_EHCI_INTERFACE_SINGLE_UNI |
 			  MXC_EHCI_INTERNAL_PHY,
@@ -147,7 +146,7 @@ static void __init mxc_board_init(void)
 
 	imx35_add_fsl_usb2_udc(&usb_otg_pdata);
 
-	mxc_register_device(&mxc_usbh1, &usb_host_pdata);
+	imx35_add_mxc_ehci_hs(&usb_host_pdata);
 
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
 	imx35_add_esdhc(0, NULL);
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 20f7f94..2d29743 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -44,7 +44,6 @@
 #include <mach/ipu.h>
 #include <mach/mx3_camera.h>
 #include <mach/mx3fb.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
@@ -538,12 +537,12 @@ static struct platform_device pcm970_sja1000 = {
 };
 
 #if defined(CONFIG_USB_ULPI)
-static struct mxc_usbh_platform_data otg_pdata = {
+static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
-static struct mxc_usbh_platform_data usbh2_pdata = {
+static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
@@ -654,13 +653,13 @@ static void __init mxc_board_init(void)
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-		mxc_register_device(&mxc_otg_host, &otg_pdata);
+		imx31_add_mxc_ehci_otg(&otg_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 #endif
 	if (!otg_mode_host)
 		imx31_add_fsl_usb2_udc(&otg_device_pdata);
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 78159f0..f9e7da9 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -38,7 +38,6 @@
 #include <mach/iomux-mx35.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 #include <mach/audmux.h>
 
@@ -310,12 +309,12 @@ pcm037_nand_board_info __initconst = {
 };
 
 #if defined(CONFIG_USB_ULPI)
-static struct mxc_usbh_platform_data otg_pdata = {
+static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.portsc	= MXC_EHCI_MODE_UTMI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
-static struct mxc_usbh_platform_data usbh1_pdata = {
+static const struct mxc_usbh_platform_data usbh1_pdata __initconst = {
 	.portsc	= MXC_EHCI_MODE_SERIAL,
 	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
 		  MXC_EHCI_IPPUE_DOWN,
@@ -385,10 +384,10 @@ static void __init mxc_board_init(void)
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-		mxc_register_device(&mxc_otg_host, &otg_pdata);
+		imx35_add_mxc_ehci_otg(&otg_pdata);
 	}
 
-	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+	imx35_add_mxc_ehci_hs(&usbh1_pdata);
 #endif
 	if (!otg_mode_host)
 		imx35_add_fsl_usb2_udc(&otg_device_pdata);
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
index 331b595..94a0b9e 100644
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
@@ -24,7 +24,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
 #include <mach/hardware.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
@@ -185,7 +184,7 @@ static int devboard_isp1105_set_vbus(struct otg_transceiver *otg, bool on)
 	return 0;
 }
 
-static struct mxc_usbh_platform_data usbh1_pdata = {
+static struct mxc_usbh_platform_data usbh1_pdata __initdata = {
 	.init	= devboard_usbh1_hw_init,
 	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
@@ -194,6 +193,7 @@ static struct mxc_usbh_platform_data usbh1_pdata = {
 static int __init devboard_usbh1_init(void)
 {
 	struct otg_transceiver *otg;
+	struct platform_device *pdev;
 
 	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
 	if (!otg)
@@ -205,7 +205,11 @@ static int __init devboard_usbh1_init(void)
 
 	usbh1_pdata.otg = otg;
 
-	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+	pdev = imx31_add_mxc_ehci_hs(1, &usbh1_pdata);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
 }
 
 
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index db79f74..a35e8c9 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -28,7 +28,6 @@
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include <media/soc_camera.h>
@@ -302,7 +301,7 @@ static int marxbot_isp1105_set_vbus(struct otg_transceiver *otg, bool on)
 	return 0;
 }
 
-static struct mxc_usbh_platform_data usbh1_pdata = {
+static struct mxc_usbh_platform_data usbh1_pdata __initdata = {
 	.init	= marxbot_usbh1_hw_init,
 	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
@@ -311,6 +310,7 @@ static struct mxc_usbh_platform_data usbh1_pdata = {
 static int __init marxbot_usbh1_init(void)
 {
 	struct otg_transceiver *otg;
+	struct platform_device *pdev;
 
 	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
 	if (!otg)
@@ -322,7 +322,11 @@ static int __init marxbot_usbh1_init(void)
 
 	usbh1_pdata.otg = otg;
 
-	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+	pdev = imx31_add_mxc_ehci_hs(1, &usbh1_pdata);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
 }
 
 static const struct fsl_usb2_platform_data usb_pdata __initconst = {
diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
index 68e8ab5..8e989e5 100644
--- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
@@ -27,7 +27,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31moboard.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include <media/soc_camera.h>
@@ -125,17 +124,23 @@ static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 
 #if defined(CONFIG_USB_ULPI)
 
-static struct mxc_usbh_platform_data otg_host_pdata = {
+static struct mxc_usbh_platform_data otg_host_pdata __initdata = {
 	.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
 static int __init smartbot_otg_host_init(void)
 {
+	struct platform_device *pdev;
+
 	otg_host_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-	return mxc_register_device(&mxc_otg_host, &otg_host_pdata);
+	pdev = imx31_add_mxc_ehci_otg(&otg_host_pdata);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
 }
 #else
 static inline int smartbot_otg_host_init(void) { return 0; }
diff --git a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
index 9bec63f..cc488f4 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
@@ -32,6 +32,22 @@ const struct imx_mxc_ehci_data imx27_mxc_ehci_hs_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
+#ifdef CONFIG_SOC_IMX31
+const struct imx_mxc_ehci_data imx31_mxc_ehci_otg_data __initconst =
+	imx_mxc_ehci_data_entry_single(MX31, 0, OTG);
+const struct imx_mxc_ehci_data imx31_mxc_ehci_hs_data[] __initconst = {
+	imx_mxc_ehci_data_entry_single(MX31, 1, HS1),
+	imx_mxc_ehci_data_entry_single(MX31, 2, HS2),
+};
+#endif /* ifdef CONFIG_SOC_IMX31 */
+
+#ifdef CONFIG_SOC_IMX35
+const struct imx_mxc_ehci_data imx35_mxc_ehci_otg_data __initconst =
+	imx_mxc_ehci_data_entry_single(MX35, 0, OTG);
+const struct imx_mxc_ehci_data imx35_mxc_ehci_hs_data __initconst =
+	imx_mxc_ehci_data_entry_single(MX35, 1, HS);
+#endif /* ifdef CONFIG_SOC_IMX35 */
+
 struct platform_device *__init imx_add_mxc_ehci(
 		const struct imx_mxc_ehci_data *data,
 		const struct mxc_usbh_platform_data *pdata)
-- 
1.7.2.3
