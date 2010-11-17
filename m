From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:50 +0100
Subject: [PATCH 22/51] ARM: imx: dynamically allocate mxc-ehci devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-22-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                       |    4 +
 arch/arm/mach-imx/devices-imx27.h               |    7 ++
 arch/arm/mach-imx/devices.c                     |   73 +---------------------
 arch/arm/mach-imx/devices.h                     |    3 -
 arch/arm/mach-imx/mach-cpuimx27.c               |    9 +--
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |    6 +-
 arch/arm/mach-imx/mach-pca100.c                 |    9 +--
 arch/arm/mach-imx/mach-pcm038.c                 |    5 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c   |   46 ++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 +++
 arch/arm/plat-mxc/include/mach/mx27.h           |   12 ++--
 13 files changed, 95 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc-ehci.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8e9297b..025e969 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -102,6 +102,7 @@ config MACH_PCM038
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select IMX_HAVE_PLATFORM_SPI_IMX
@@ -130,6 +131,7 @@ config MACH_CPUIMX27
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select MXC_ULPI if USB_ULPI
@@ -183,6 +185,7 @@ config MACH_IMX27_VISSTRIM_M10
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	help
 	  Include support for Visstrim_m10 platform and its different variants.
 	  This includes specific configurations for the board and its
@@ -202,6 +205,7 @@ config MACH_PCA100
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 6466744..51b9155 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -43,6 +43,13 @@ extern const struct imx_mx2_camera_data imx27_mx2_camera_data __initconst;
 #define imx27_add_mx2_camera(pdata)	\
 	imx_add_mx2_camera(&imx27_mx2_camera_data, pdata)
 
+extern const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data __initconst;
+#define imx27_add_mxc_ehci_otg(pdata)	\
+	imx_add_mxc_ehci(&imx27_mxc_ehci_otg_data, pdata)
+extern const struct imx_mxc_ehci_data imx27_mxc_ehci_hs_data[] __initconst;
+#define imx27_add_mxc_ehci_hs(id, pdata)	\
+	imx_add_mxc_ehci(&imx27_mxc_ehci_hs_data[id - 1], pdata)
+
 extern const struct imx_mxc_mmc_data imx27_mxc_mmc_data[] __initconst;
 #define imx27_add_mxc_mmc(id, pdata)	\
 	imx_add_mxc_mmc(&imx27_mxc_mmc_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 7609e8a..2a6d707 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -79,12 +79,12 @@ int __init imx1_register_gpios(void)
 #ifdef CONFIG_MACH_MX27
 static struct resource otg_resources[] = {
 	{
-		.start = MX27_USBOTG_BASE_ADDR,
-		.end = MX27_USBOTG_BASE_ADDR + 0x1ff,
+		.start = MX27_USB_OTG_BASE_ADDR,
+		.end = MX27_USB_OTG_BASE_ADDR + 0x1ff,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MX27_INT_USB3,
-		.end = MX27_INT_USB3,
+		.start = MX27_INT_USB_OTG,
+		.end = MX27_INT_USB_OTG,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -102,71 +102,6 @@ struct platform_device mxc_otg_udc_device = {
 	.resource	= otg_resources,
 	.num_resources	= ARRAY_SIZE(otg_resources),
 };
-
-/* OTG host */
-struct platform_device mxc_otg_host = {
-	.name = "mxc-ehci",
-	.id = 0,
-	.dev = {
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.dma_mask = &otg_dmamask,
-	},
-	.resource = otg_resources,
-	.num_resources = ARRAY_SIZE(otg_resources),
-};
-
-/* USB host 1 */
-
-static u64 usbh1_dmamask = DMA_BIT_MASK(32);
-
-static struct resource mxc_usbh1_resources[] = {
-	{
-		.start = MX27_USBOTG_BASE_ADDR + 0x200,
-		.end = MX27_USBOTG_BASE_ADDR + 0x3ff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX27_INT_USB1,
-		.end = MX27_INT_USB1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_usbh1 = {
-	.name = "mxc-ehci",
-	.id = 1,
-	.dev = {
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.dma_mask = &usbh1_dmamask,
-	},
-	.resource = mxc_usbh1_resources,
-	.num_resources = ARRAY_SIZE(mxc_usbh1_resources),
-};
-
-/* USB host 2 */
-static u64 usbh2_dmamask = DMA_BIT_MASK(32);
-
-static struct resource mxc_usbh2_resources[] = {
-	{
-		.start = MX27_USBOTG_BASE_ADDR + 0x400,
-		.end = MX27_USBOTG_BASE_ADDR + 0x5ff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX27_INT_USB2,
-		.end = MX27_INT_USB2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_usbh2 = {
-	.name = "mxc-ehci",
-	.id = 2,
-	.dev = {
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.dma_mask = &usbh2_dmamask,
-	},
-	.resource = mxc_usbh2_resources,
-	.num_resources = ARRAY_SIZE(mxc_usbh2_resources),
-};
 #endif
 
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index a45d760..7a00bba 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,8 +1,5 @@
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
 extern struct platform_device mxc_otg_udc_device;
-extern struct platform_device mxc_otg_host;
-extern struct platform_device mxc_usbh1;
-extern struct platform_device mxc_usbh2;
 extern struct platform_device mx21_usbhc_device;
 extern struct platform_device imx_kpp_device;
 #endif
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 06ff79a..c70b038 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -40,7 +40,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
@@ -213,12 +212,12 @@ static struct platform_device serial_device = {
 #endif
 
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
@@ -281,13 +280,13 @@ static void __init eukrea_cpuimx27_init(void)
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-		mxc_register_device(&mxc_otg_host, &otg_pdata);
+		imx27_add_mxc_ehci_otg(&otg_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
 #endif
 	if (!otg_mode_host)
 		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index deef1fa..c9f12e4 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -35,7 +35,6 @@
 #include <asm/mach/time.h>
 #include <mach/common.h>
 #include <mach/iomux.h>
-#include <mach/mxc_ehci.h>
 
 #include "devices-imx27.h"
 #include "devices.h"
@@ -215,7 +214,8 @@ static int otg_phy_init(struct platform_device *pdev)
 	return 0;
 }
 
-static struct mxc_usbh_platform_data visstrim_m10_usbotg_pdata = {
+static const struct mxc_usbh_platform_data
+visstrim_m10_usbotg_pdata __initconst = {
 	.init = otg_phy_init,
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
@@ -237,7 +237,7 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_imx_i2c(0, &visstrim_m10_i2c_data);
 	imx27_add_imx_i2c(1, &visstrim_m10_i2c_data);
 	imx27_add_mxc_mmc(0, &visstrim_m10_sdhc_pdata);
-	mxc_register_device(&mxc_otg_host, &visstrim_m10_usbotg_pdata);
+	imx27_add_mxc_ehci_otg(&visstrim_m10_usbotg_pdata);
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index b05f528..683374d 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -40,7 +40,6 @@
 #include <mach/audmux.h>
 #include <mach/mxc_nand.h>
 #include <mach/irqs.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
@@ -279,7 +278,7 @@ static int otg_phy_init(struct platform_device *pdev)
 	return 0;
 }
 
-static struct mxc_usbh_platform_data otg_pdata = {
+static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.init	= otg_phy_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
@@ -291,7 +290,7 @@ static int usbh2_phy_init(struct platform_device *pdev)
 	return 0;
 }
 
-static struct mxc_usbh_platform_data usbh2_pdata = {
+static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= usbh2_phy_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
@@ -410,13 +409,13 @@ static void __init pca100_init(void)
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-		mxc_register_device(&mxc_otg_host, &otg_pdata);
+		imx27_add_mxc_ehci_otg(&otg_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
 #endif
 	if (!otg_mode_host) {
 		gpio_set_value(OTG_PHY_CS_GPIO, 0);
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index b3340cd..e209b28 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -37,7 +37,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
-#include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx27.h"
@@ -283,7 +282,7 @@ static struct spi_board_info pcm038_spi_board_info[] __initdata = {
 	}
 };
 
-static struct mxc_usbh_platform_data usbh2_pdata = {
+static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_DIFF_UNI,
 };
@@ -320,7 +319,7 @@ static void __init pcm038_init(void)
 	spi_register_board_info(pcm038_spi_board_info,
 				ARRAY_SIZE(pcm038_spi_board_info));
 
-	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 6560cf5..d2d096c 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -37,6 +37,9 @@ config IMX_HAVE_PLATFORM_MX1_CAMERA
 config IMX_HAVE_PLATFORM_MX2_CAMERA
 	bool
 
+config IMX_HAVE_PLATFORM_MXC_EHCI
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_MMC
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index d2b7a91..c8734bd 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX1_CAMERA) += platform-mx1-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX2_CAMERA) += platform-mx2-camera.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_EHCI) += platform-mxc-ehci.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_MMC) += platform-mxc-mmc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_PWM) += platform-mxc_pwm.o
diff --git a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
new file mode 100644
index 0000000..0cb67bb
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_mxc_ehci_data_entry_single(soc, _id, hs)			\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _USB_ ## hs ## _BASE_ADDR,		\
+		.irq = soc ## _INT_USB_ ## hs,				\
+	}
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data __initconst =
+	imx_mxc_ehci_data_entry_single(MX27, 0, OTG);
+const struct imx_mxc_ehci_data imx27_mxc_ehci_hs_data[] __initconst = {
+	imx_mxc_ehci_data_entry_single(MX27, 1, HS1),
+	imx_mxc_ehci_data_entry_single(MX27, 2, HS2),
+};
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+struct platform_device *__init imx_add_mxc_ehci(
+		const struct imx_mxc_ehci_data *data,
+		const struct mxc_usbh_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_512 - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	return imx_add_platform_device_dmamask("mxc-ehci", data->id,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index bb3b29c..7df7a9f 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -151,6 +151,16 @@ struct platform_device *__init imx_add_mx2_camera(
 		const struct imx_mx2_camera_data *data,
 		const struct mx2_camera_platform_data *pdata);
 
+#include <mach/mxc_ehci.h>
+struct imx_mxc_ehci_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_mxc_ehci(
+		const struct imx_mxc_ehci_data *data,
+		const struct mxc_usbh_platform_data *pdata);
+
 #include <mach/mmc.h>
 struct imx_mxc_mmc_data {
 	int id;
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index 2734d24..45419b3 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -64,8 +64,10 @@
 #define MX27_LCDC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x21000)
 #define MX27_SLCDC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x22000)
 #define MX27_VPU_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x23000)
-#define MX27_USBOTG_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x24000)
-#define MX27_OTG_BASE_ADDR			MX27_USBOTG_BASE_ADDR
+#define MX27_USB_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x24000)
+#define MX27_USB_OTG_BASE_ADDR			(MX27_USB_BASE_ADDR + 0x0000)
+#define MX27_USB_HS1_BASE_ADDR			(MX27_USB_BASE_ADDR + 0x0200)
+#define MX27_USB_HS2_BASE_ADDR			(MX27_USB_BASE_ADDR + 0x0400)
 #define MX27_SAHARA_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x25000)
 #define MX27_EMMAPP_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x26000)
 #define MX27_EMMAPRP_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x26400)
@@ -187,9 +189,9 @@ static inline void mx27_setup_weimcs(size_t cs,
 #define MX27_INT_EMMAPRP	51
 #define MX27_INT_EMMAPP		52
 #define MX27_INT_VPU		53
-#define MX27_INT_USB1		54
-#define MX27_INT_USB2		55
-#define MX27_INT_USB3		56
+#define MX27_INT_USB_HS1	54
+#define MX27_INT_USB_HS2	55
+#define MX27_INT_USB_OTG	56
 #define MX27_INT_SCC_SMN	57
 #define MX27_INT_SCC_SCM	58
 #define MX27_INT_SAHARA		59
-- 
1.7.2.3
