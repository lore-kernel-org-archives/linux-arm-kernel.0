From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  4 Mar 2011 21:51:21 +0100
Subject: [PATCH 5/6] [RFC] ARM: mx3: dynamically allocate "ipu-core" devices
In-Reply-To: <20110304205008.GX22310@pengutronix.de>
References: <20110304205008.GX22310@pengutronix.de>
Message-ID: <1299271882-2130-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... together with the related devices "mx3_camera" and "mx3_sdc_fb".

"mx3_camera" doesn't fit the scheme of the other devices that just are
allocated and registered in a single function because it needs additional
care to get some dmaable memory. So currently imx31_alloc_mx3_camera
duplicates most of imx_add_platform_device_dmamask, but I'm not sure it's
worth to split the latter to be able to reuse more code.

This gets rid of mach-mx3/devices.[ch] and so several files need to be
adapted not to #include devices.h anymore.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                       |    7 ++
 arch/arm/mach-mx3/Makefile                      |    2 +-
 arch/arm/mach-mx3/devices-imx31.h               |    8 ++
 arch/arm/mach-mx3/devices-imx35.h               |    8 ++
 arch/arm/mach-mx3/devices.c                     |   96 -----------------
 arch/arm/mach-mx3/devices.h                     |    3 -
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c    |   10 +-
 arch/arm/mach-mx3/mach-armadillo5x0.c           |   12 +--
 arch/arm/mach-mx3/mach-cpuimx35.c               |    1 -
 arch/arm/mach-mx3/mach-kzm_arm11_01.c           |    1 -
 arch/arm/mach-mx3/mach-mx31_3ds.c               |    1 -
 arch/arm/mach-mx3/mach-mx31ads.c                |    1 -
 arch/arm/mach-mx3/mach-mx31lilly.c              |    1 -
 arch/arm/mach-mx3/mach-mx31lite.c               |    1 -
 arch/arm/mach-mx3/mach-mx31moboard.c            |   39 ++++---
 arch/arm/mach-mx3/mach-mx35_3ds.c               |    1 -
 arch/arm/mach-mx3/mach-pcm037.c                 |   37 ++++---
 arch/arm/mach-mx3/mach-pcm037_eet.c             |    1 -
 arch/arm/mach-mx3/mach-pcm043.c                 |   12 +--
 arch/arm/mach-mx3/mach-qong.c                   |    1 -
 arch/arm/mach-mx3/mach-vpr200.c                 |   12 +--
 arch/arm/mach-mx3/mx31lilly-db.c                |    8 +-
 arch/arm/mach-mx3/mx31lite-db.c                 |    1 -
 arch/arm/mach-mx3/mx31moboard-devboard.c        |    1 -
 arch/arm/mach-mx3/mx31moboard-marxbot.c         |    1 -
 arch/arm/mach-mx3/mx31moboard-smartbot.c        |    1 -
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-ipu-core.c   |  129 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   18 +++
 30 files changed, 237 insertions(+), 181 deletions(-)
 delete mode 100644 arch/arm/mach-mx3/devices.c
 delete mode 100644 arch/arm/mach-mx3/devices.h
 create mode 100644 arch/arm/plat-mxc/devices/platform-ipu-core.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 5e82d30..df2e9da 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -56,6 +56,7 @@ config MACH_PCM037
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -121,6 +122,7 @@ config MACH_MX31MOBOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
@@ -133,6 +135,7 @@ config MACH_MX31LILLY
 	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
@@ -158,6 +161,7 @@ config MACH_PCM043
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
@@ -171,6 +175,7 @@ config MACH_ARMADILLO5X0
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -235,6 +240,7 @@ choice
 config MACH_EUKREA_MBIMXSD35_BASEBOARD
 	bool "Eukrea MBIMXSD development board"
 	select IMX_HAVE_PLATFORM_IMX_SSI
+	select IMX_HAVE_PLATFORM_IPU_CORE
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
@@ -248,6 +254,7 @@ config MACH_VPR200
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index a54faf2..15a7ff8 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y				:= mm.o devices.o cpu.o
+obj-y				:= mm.o cpu.o
 obj-$(CONFIG_SOC_IMX31)		+= clock-imx31.o iomux-imx31.o ehci-imx31.o
 obj-$(CONFIG_SOC_IMX35)		+= clock-imx35.o ehci-imx35.o
 obj-$(CONFIG_MACH_MX31ADS)	+= mach-mx31ads.o
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index b6da93c..2c550c7 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -41,6 +41,14 @@ extern const struct imx_imx_uart_1irq_data imx31_imx_uart_data[] __initconst;
 #define imx31_add_imx_uart3(pdata)	imx31_add_imx_uart(3, pdata)
 #define imx31_add_imx_uart4(pdata)	imx31_add_imx_uart(4, pdata)
 
+extern const struct imx_ipu_core_data imx31_ipu_core_data __initconst;
+#define imx31_add_ipu_core(pdata)	\
+	imx_add_ipu_core(&imx31_ipu_core_data, pdata)
+#define imx31_alloc_mx3_camera(pdata)	\
+	imx_alloc_mx3_camera(&imx31_ipu_core_data, pdata)
+#define imx31_add_mx3_sdc_fb(pdata)	\
+	imx_add_mx3_sdc_fb(&imx31_ipu_core_data, pdata)
+
 extern const struct imx_mxc_ehci_data imx31_mxc_ehci_otg_data __initconst;
 #define imx31_add_mxc_ehci_otg(pdata)	\
 	imx_add_mxc_ehci(&imx31_mxc_ehci_otg_data, pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index d545d86..b5546b6 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -49,6 +49,14 @@ extern const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst;
 #define imx35_add_imx_uart1(pdata)	imx35_add_imx_uart(1, pdata)
 #define imx35_add_imx_uart2(pdata)	imx35_add_imx_uart(2, pdata)
 
+extern const struct imx_ipu_core_data imx35_ipu_core_data __initconst;
+#define imx35_add_ipu_core(pdata)	\
+	imx_add_ipu_core(&imx35_ipu_core_data, pdata)
+#define imx35_alloc_mx3_camera(pdata)	\
+	imx_alloc_mx3_camera(&imx35_ipu_core_data, pdata)
+#define imx35_add_mx3_sdc_fb(pdata)	\
+	imx_add_mx3_sdc_fb(&imx35_ipu_core_data, pdata)
+
 extern const struct imx_mxc_ehci_data imx35_mxc_ehci_otg_data __initconst;
 #define imx35_add_mxc_ehci_otg(pdata)	\
 	imx_add_mxc_ehci(&imx35_mxc_ehci_otg_data, pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
deleted file mode 100644
index 0701ee4..0000000
--- a/arch/arm/mach-mx3/devices.c
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Sascha Hauer, kernel at pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor,
- * Boston, MA  02110-1301, USA.
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/serial.h>
-#include <linux/gpio.h>
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <mach/common.h>
-#include <mach/mx3_camera.h>
-
-#include "devices.h"
-
-/* i.MX31 Image Processing Unit */
-
-/* The resource order is important! */
-static struct resource mx3_ipu_rsrc[] = {
-	{
-		.start = MX3x_IPU_CTRL_BASE_ADDR,
-		.end = MX3x_IPU_CTRL_BASE_ADDR + 0x5F,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX3x_IPU_CTRL_BASE_ADDR + 0x88,
-		.end = MX3x_IPU_CTRL_BASE_ADDR + 0xB3,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX3x_INT_IPU_SYN,
-		.end = MX3x_INT_IPU_SYN,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MX3x_INT_IPU_ERR,
-		.end = MX3x_INT_IPU_ERR,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mx3_ipu = {
-	.name = "ipu-core",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(mx3_ipu_rsrc),
-	.resource = mx3_ipu_rsrc,
-};
-
-static struct resource fb_resources[] = {
-	{
-		.start	= MX3x_IPU_CTRL_BASE_ADDR + 0xB4,
-		.end	= MX3x_IPU_CTRL_BASE_ADDR + 0x1BF,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mx3_fb = {
-	.name		= "mx3_sdc_fb",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(fb_resources),
-	.resource	= fb_resources,
-	.dev		= {
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-       },
-};
-
-static struct resource camera_resources[] = {
-	{
-		.start	= MX3x_IPU_CTRL_BASE_ADDR + 0x60,
-		.end	= MX3x_IPU_CTRL_BASE_ADDR + 0x87,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mx3_camera = {
-	.name		= "mx3-camera",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(camera_resources),
-	.resource	= camera_resources,
-	.dev		= {
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
deleted file mode 100644
index d23f853..0000000
--- a/arch/arm/mach-mx3/devices.h
+++ /dev/null
@@ -1,3 +0,0 @@
-extern struct platform_device mx3_ipu;
-extern struct platform_device mx3_fb;
-extern struct platform_device mx3_camera;
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 8076147..76828c8 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -45,7 +45,6 @@
 #include <mach/audmux.h>
 
 #include "devices-imx35.h"
-#include "devices.h"
 
 static const struct fb_videomode fb_modedb[] = {
 	{
@@ -100,12 +99,11 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static struct ipu_platform_data mx3_ipu_data = {
+static const struct ipu_platform_data mx3_ipu_data __initconst = {
 	.irq_base = MXC_IPU_IRQ_START,
 };
 
-static struct mx3fb_platform_data mx3fb_pdata = {
-	.dma_dev	= &mx3_ipu.dev,
+static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "CMO-QVGA",
 	.mode		= fb_modedb,
 	.num_modes	= ARRAY_SIZE(fb_modedb),
@@ -283,8 +281,8 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 #endif
 
 	imx35_add_imx_uart1(&uart_pdata);
-	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
-	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	imx35_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 226829b..9f4543f 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -49,12 +49,9 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
-#include <mach/ipu.h>
-#include <mach/mx3fb.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 #include "crm_regs.h"
 
 static int armadillo5x0_pins[] = {
@@ -383,12 +380,11 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static struct ipu_platform_data mx3_ipu_data = {
+static const struct ipu_platform_data mx3_ipu_data __initconst = {
 	.irq_base = MXC_IPU_IRQ_START,
 };
 
-static struct mx3fb_platform_data mx3fb_pdata = {
-	.dma_dev	= &mx3_ipu.dev,
+static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "CRT-VGA",
 	.mode		= fb_modedb,
 	.num_modes	= ARRAY_SIZE(fb_modedb),
@@ -521,8 +517,8 @@ static void __init armadillo5x0_init(void)
 	imx31_add_mxc_mmc(0, &sdhc_pdata);
 
 	/* Register FB */
-	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
-	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* Register NOR Flash */
 	mxc_register_device(&armadillo5x0_nor_flash,
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index ec63d99..593e27f 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -44,7 +44,6 @@
 #include <mach/mxc_nand.h>
 
 #include "devices-imx35.h"
-#include "devices.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index d3cc739..f5fdfe6 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -39,7 +39,6 @@
 #include <mach/memory.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 #define KZM_ARM11_IO_ADDRESS(x) (IOMEM(					\
 	IMX_IO_P2V_MODULE(x, MX31_CS4) ?:				\
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index f1dbb9d..8443a1a 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -37,7 +37,6 @@
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 /* CPLD IRQ line for external uart, external ethernet etc */
 #define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)
diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index 4e4b780..9def0ec 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -38,7 +38,6 @@
 #endif
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 /* PBC Board interrupt status register */
 #define PBC_INTSTATUS           0x000016
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index ed95745..410e676 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -46,7 +46,6 @@
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 /*
  * This file contains module-specific initialization routines for LILLY-1131.
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 24a21a3..ac9b4ca 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -44,7 +44,6 @@
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 /*
  * This file contains the module-specific initialization routines.
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 5dca8b4..9967cf3 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -40,13 +40,10 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
-#include <mach/ipu.h>
-#include <mach/mx3_camera.h>
 #include <mach/spi.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 static unsigned int moboard_pins[] = {
 	/* UART0 */
@@ -195,8 +192,8 @@ static struct regulator_init_data sdhc_vreg_data = {
 
 static struct regulator_consumer_supply cam_consumers[] = {
 	{
-		.dev	= &mx3_camera.dev,
-		.supply	= "cam_vcc",
+		.dev_name = "mx3_camera.0",
+		.supply = "cam_vcc",
 	},
 };
 
@@ -457,7 +454,7 @@ static struct platform_device mx31moboard_leds_device = {
 	},
 };
 
-static struct ipu_platform_data mx3_ipu_data = {
+static const struct ipu_platform_data mx3_ipu_data __initconst = {
 	.irq_base = MXC_IPU_IRQ_START,
 };
 
@@ -466,8 +463,7 @@ static struct platform_device *devices[] __initdata = {
 	&mx31moboard_leds_device,
 };
 
-static struct mx3_camera_pdata camera_pdata = {
-	.dma_dev	= &mx3_ipu.dev,
+static struct mx3_camera_pdata camera_pdata __initdata = {
 	.flags		= MX3_CAMERA_DATAWIDTH_8 | MX3_CAMERA_DATAWIDTH_10,
 	.mclk_10khz	= 4800,
 };
@@ -475,18 +471,31 @@ static struct mx3_camera_pdata camera_pdata = {
 static phys_addr_t mx3_camera_base __initdata;
 #define MX3_CAMERA_BUF_SIZE SZ_4M
 
-static int __init mx31moboard_cam_alloc_dma(void)
+static int __init mx31moboard_init_cam(void)
 {
-	int dma;
+	int dma, ret = -ENOMEM;
+	struct platform_device *pdev;
+
+	imx31_add_ipu_core(&mx3_ipu_data);
 
+	pdev = imx31_alloc_mx3_camera(&camera_pdata);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
 
-	dma = dma_declare_coherent_memory(&mx3_camera.dev,
+	dma = dma_declare_coherent_memory(&pdev->dev,
 					mx3_camera_base, mx3_camera_base,
 					MX3_CAMERA_BUF_SIZE,
 					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+	if (!(dma & DMA_MEMORY_MAP))
+		goto err;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+err:
+		platform_device_put(pdev);
+
+	return ret;
 
-	/* The way we call dma_declare_coherent_memory only a malloc can fail */
-	return dma & DMA_MEMORY_MAP ? 0 : -ENOMEM;
 }
 
 static int mx31moboard_baseboard;
@@ -518,9 +527,7 @@ static void __init mx31moboard_init(void)
 
 	imx31_add_mxc_mmc(0, &sdhc1_pdata);
 
-	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
-	if (!mx31moboard_cam_alloc_dma())
-		mxc_register_device(&mx3_camera, &camera_pdata);
+	mx31moboard_init_cam();
 
 	usb_xcvr_reset();
 
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index ff5fe23..882880a 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -42,7 +42,6 @@
 #include <mach/3ds_debugboard.h>
 
 #include "devices-imx35.h"
-#include "devices.h"
 
 #define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 1)
 
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 497b39b..89c213b 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -42,13 +42,9 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
-#include <mach/ipu.h>
-#include <mach/mx3_camera.h>
-#include <mach/mx3fb.h>
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 #include "pcm037.h"
 
 static enum pcm037_board_variant pcm037_instance = PCM037_PCM970;
@@ -405,8 +401,7 @@ static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 	.exit = pcm970_sdhc1_exit,
 };
 
-struct mx3_camera_pdata camera_pdata = {
-	.dma_dev	= &mx3_ipu.dev,
+struct mx3_camera_pdata camera_pdata __initdata = {
 	.flags		= MX3_CAMERA_DATAWIDTH_8 | MX3_CAMERA_DATAWIDTH_10,
 	.mclk_10khz	= 2000,
 };
@@ -414,17 +409,27 @@ struct mx3_camera_pdata camera_pdata = {
 static phys_addr_t mx3_camera_base __initdata;
 #define MX3_CAMERA_BUF_SIZE SZ_4M
 
-static int __init pcm037_camera_alloc_dma(void)
+static int __init pcm037_init_camera(void)
 {
-	int dma;
+	int dma, ret = -ENOMEM;
+	struct platform_device *pdev = imx31_alloc_mx3_camera(&camera_pdata);
 
-	dma = dma_declare_coherent_memory(&mx3_camera.dev,
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	dma = dma_declare_coherent_memory(&pdev->dev,
 					mx3_camera_base, mx3_camera_base,
 					MX3_CAMERA_BUF_SIZE,
 					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+	if (!(dma & DMA_MEMORY_MAP))
+		goto err;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+err:
+		platform_device_put(pdev);
 
-	/* The way we call dma_declare_coherent_memory only a malloc can fail */
-	return dma & DMA_MEMORY_MAP ? 0 : -ENOMEM;
+	return ret;
 }
 
 static struct platform_device *devices[] __initdata = {
@@ -434,7 +439,7 @@ static struct platform_device *devices[] __initdata = {
 	&pcm037_mt9v022,
 };
 
-static struct ipu_platform_data mx3_ipu_data = {
+static const struct ipu_platform_data mx3_ipu_data __initconst = {
 	.irq_base = MXC_IPU_IRQ_START,
 };
 
@@ -492,7 +497,6 @@ static const struct fb_videomode fb_modedb[] = {
 };
 
 static struct mx3fb_platform_data mx3fb_pdata = {
-	.dma_dev	= &mx3_ipu.dev,
 	.name		= "Sharp-LQ035Q7DH06-QVGA",
 	.mode		= fb_modedb,
 	.num_modes	= ARRAY_SIZE(fb_modedb),
@@ -630,8 +634,8 @@ static void __init pcm037_init(void)
 
 	imx31_add_mxc_nand(&pcm037_nand_board_info);
 	imx31_add_mxc_mmc(0, &sdhc_pdata);
-	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
-	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* CSI */
 	/* Camera power: default - off */
@@ -641,8 +645,7 @@ static void __init pcm037_init(void)
 	else
 		iclink_mt9t031.power = NULL;
 
-	if (!pcm037_camera_alloc_dma())
-		mxc_register_device(&mx3_camera, &camera_pdata);
+	pcm037_init_camera();
 
 	platform_device_register(&pcm970_sja1000);
 
diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
index df6fb07..398a051 100644
--- a/arch/arm/mach-mx3/mach-pcm037_eet.c
+++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
@@ -19,7 +19,6 @@
 #include <asm/mach-types.h>
 
 #include "pcm037.h"
-#include "devices.h"
 #include "devices-imx31.h"
 
 static unsigned int pcm037_eet_pins[] = {
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index b3ecfb2..11590e2 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -36,13 +36,10 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
-#include <mach/ipu.h>
-#include <mach/mx3fb.h>
 #include <mach/ulpi.h>
 #include <mach/audmux.h>
 
 #include "devices-imx35.h"
-#include "devices.h"
 
 static const struct fb_videomode fb_modedb[] = {
 	{
@@ -80,12 +77,11 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static struct ipu_platform_data mx3_ipu_data = {
+static const struct ipu_platform_data mx3_ipu_data __initconst = {
 	.irq_base = MXC_IPU_IRQ_START,
 };
 
-static struct mx3fb_platform_data mx3fb_pdata = {
-	.dma_dev	= &mx3_ipu.dev,
+static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "Sharp-LQ035Q7",
 	.mode		= fb_modedb,
 	.num_modes	= ARRAY_SIZE(fb_modedb),
@@ -380,8 +376,8 @@ static void __init pcm043_init(void)
 
 	imx35_add_imx_i2c0(&pcm043_i2c0_data);
 
-	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
-	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	if (otg_mode_host) {
 		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index 17f758b..a605287 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -33,7 +33,6 @@
 #include <mach/iomux-mx3.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 /* FPGA defines */
 #define QONG_FPGA_VERSION(major, minor, rev)	\
diff --git a/arch/arm/mach-mx3/mach-vpr200.c b/arch/arm/mach-mx3/mach-vpr200.c
index 2cf390f..0a750fd 100644
--- a/arch/arm/mach-mx3/mach-vpr200.c
+++ b/arch/arm/mach-mx3/mach-vpr200.c
@@ -32,8 +32,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
 #include <mach/irqs.h>
-#include <mach/ipu.h>
-#include <mach/mx3fb.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
@@ -41,7 +39,6 @@
 #include <linux/gpio_keys.h>
 
 #include "devices-imx35.h"
-#include "devices.h"
 
 #define GPIO_LCDPWR	IMX_GPIO_NR(1, 2)
 #define GPIO_PMIC_INT	IMX_GPIO_NR(2, 0)
@@ -91,12 +88,11 @@ static const struct fb_videomode fb_modedb[] = {
 	}
 };
 
-static struct ipu_platform_data mx3_ipu_data = {
+static const struct ipu_platform_data mx3_ipu_data __initconst = {
 	.irq_base = MXC_IPU_IRQ_START,
 };
 
-static struct mx3fb_platform_data mx3fb_pdata = {
-	.dma_dev	= &mx3_ipu.dev,
+static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "PT0708048",
 	.mode		= fb_modedb,
 	.num_modes	= ARRAY_SIZE(fb_modedb),
@@ -294,8 +290,8 @@ static void __init vpr200_board_init(void)
 	imx35_add_imx_uart0(NULL);
 	imx35_add_imx_uart2(NULL);
 
-	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
-	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	imx35_add_fsl_usb2_udc(&otg_device_pdata);
 	imx35_add_mxc_ehci_hs(&usb_host_pdata);
diff --git a/arch/arm/mach-mx3/mx31lilly-db.c b/arch/arm/mach-mx3/mx31lilly-db.c
index 8f1a38e..64698c9 100644
--- a/arch/arm/mach-mx3/mx31lilly-db.c
+++ b/arch/arm/mach-mx3/mx31lilly-db.c
@@ -38,7 +38,6 @@
 #include <mach/ipu.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 /*
  * This file contains board-specific initialization routines for the
@@ -164,7 +163,7 @@ static const struct imxmmc_platform_data mmc_pdata __initconst = {
 };
 
 /* Framebuffer support */
-static struct ipu_platform_data ipu_data __initdata = {
+static const struct ipu_platform_data ipu_data __initconst = {
 	.irq_base = MXC_IPU_IRQ_START,
 };
 
@@ -187,7 +186,6 @@ static const struct fb_videomode fb_modedb = {
 };
 
 static struct mx3fb_platform_data fb_pdata __initdata = {
-	.dma_dev	= &mx3_ipu.dev,
 	.name		= "CRT-VGA",
 	.mode		= &fb_modedb,
 	.num_modes	= 1,
@@ -202,8 +200,8 @@ static void __init mx31lilly_init_fb(void)
 		return;
 	}
 
-	mxc_register_device(&mx3_ipu, &ipu_data);
-	mxc_register_device(&mx3_fb, &fb_pdata);
+	imx31_add_ipu_core(&ipu_data);
+	imx31_add_mx3_sdc_fb(&fb_pdata);
 	gpio_direction_output(LCD_VCC_EN_GPIO, 1);
 }
 
diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 04fab65..5aa053e 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -37,7 +37,6 @@
 #include <mach/board-mx31lite.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 /*
  * This file contains board-specific initialization routines for the
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
index 6410b9c..0aa2536 100644
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
@@ -28,7 +28,6 @@
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 static unsigned int devboard_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 57f7b00..cf60dae 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -33,7 +33,6 @@
 #include <media/soc_camera.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 static unsigned int marxbot_pins[] = {
 	/* SDHC2 */
diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
index 35f806e..fabb801 100644
--- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
@@ -32,7 +32,6 @@
 #include <media/soc_camera.h>
 
 #include "devices-imx31.h"
-#include "devices.h"
 
 static unsigned int smartbot_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 0e8d7ab..a860b16 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -41,6 +41,9 @@ config IMX_HAVE_PLATFORM_IMX_UART
 config IMX_HAVE_PLATFORM_IMX_UDC
 	bool
 
+config IMX_HAVE_PLATFORM_IPU_CORE
+	bool
+
 config IMX_HAVE_PLATFORM_MX1_CAMERA
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index ca227ea..ad2922a 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_KEYPAD) += platform-imx-keypad.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IPU_CORE) += platform-ipu-core.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX1_CAMERA) += platform-mx1-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX2_CAMERA) += platform-mx2-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_EHCI) += platform-mxc-ehci.o
diff --git a/arch/arm/plat-mxc/devices/platform-ipu-core.c b/arch/arm/plat-mxc/devices/platform-ipu-core.c
new file mode 100644
index 0000000..edf6503
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-ipu-core.c
@@ -0,0 +1,129 @@
+/*
+ * Copyright (C) 2011 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_ipu_core_entry_single(soc)					\
+{									\
+	.iobase = soc ## _IPU_CTRL_BASE_ADDR,				\
+	.synirq = soc ## _INT_IPU_SYN,					\
+	.errirq = soc ## _INT_IPU_ERR,					\
+}
+
+#ifdef CONFIG_SOC_IMX31
+const struct imx_ipu_core_data imx31_ipu_core_data __initconst =
+	imx_ipu_core_entry_single(MX31);
+#endif
+
+#ifdef CONFIG_SOC_IMX35
+const struct imx_ipu_core_data imx35_ipu_core_data __initconst =
+	imx_ipu_core_entry_single(MX35);
+#endif
+
+static struct platform_device *imx_ipu_coredev __initdata;
+
+struct platform_device *__init imx_add_ipu_core(
+		const struct imx_ipu_core_data *data,
+		const struct ipu_platform_data *pdata)
+{
+	/* The resource order is important! */
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + 0x5f,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->iobase + 0x88,
+			.end = data->iobase + 0xb3,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->synirq,
+			.end = data->synirq,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->errirq,
+			.end = data->errirq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_ipu_coredev = imx_add_platform_device("ipu-core", -1,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
+
+struct platform_device *__init imx_alloc_mx3_camera(
+		const struct imx_ipu_core_data *data,
+		const struct mx3_camera_pdata *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase + 0x60,
+			.end = data->iobase + 0x87,
+			.flags = IORESOURCE_MEM,
+		},
+	};
+	int ret = -ENOMEM;
+	struct platform_device *pdev;
+
+	if (IS_ERR_OR_NULL(imx_ipu_coredev))
+		return ERR_PTR(-ENODEV);
+
+	pdev = platform_device_alloc("mx3-camera", 0);
+	if (!pdev)
+		goto err;
+
+	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
+	if (!pdev->dev.dma_mask)
+		goto err;
+
+	*pdev->dev.dma_mask = DMA_BIT_MASK(32);
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret)
+		goto err;
+
+	if (pdata) {
+		struct mx3_camera_pdata *copied_pdata;
+
+		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
+		if (ret) {
+err:
+			kfree(pdev->dev.dma_mask);
+			platform_device_put(pdev);
+			return ERR_PTR(-ENODEV);
+		}
+		copied_pdata = dev_get_platdata(&pdev->dev);
+		copied_pdata->dma_dev = &imx_ipu_coredev->dev;
+	}
+
+	return pdev;
+}
+
+struct platform_device *__init imx_add_mx3_sdc_fb(
+		const struct imx_ipu_core_data *data,
+		struct mx3fb_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase + 0xb4,
+			.end = data->iobase + 0x1bf,
+			.flags = IORESOURCE_MEM,
+		},
+	};
+
+	if (IS_ERR_OR_NULL(imx_ipu_coredev))
+		return ERR_PTR(-ENODEV);
+
+	pdata->dma_dev = &imx_ipu_coredev->dev;
+
+	return imx_add_platform_device_dmamask("mx3_sdc_fb", -1,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata),
+			DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index b0bc198..fa84773 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -166,6 +166,24 @@ struct platform_device *__init imx_add_imx_udc(
 		const struct imx_imx_udc_data *data,
 		const struct imxusb_platform_data *pdata);
 
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
+#include <mach/mx3_camera.h>
+struct imx_ipu_core_data {
+	resource_size_t iobase;
+	resource_size_t synirq;
+	resource_size_t errirq;
+};
+struct platform_device *__init imx_add_ipu_core(
+		const struct imx_ipu_core_data *data,
+		const struct ipu_platform_data *pdata);
+struct platform_device *__init imx_alloc_mx3_camera(
+		const struct imx_ipu_core_data *data,
+		const struct mx3_camera_pdata *pdata);
+struct platform_device *__init imx_add_mx3_sdc_fb(
+		const struct imx_ipu_core_data *data,
+		struct mx3fb_platform_data *pdata);
+
 #include <mach/mx1_camera.h>
 struct imx_mx1_camera_data {
 	resource_size_t iobase;
-- 
1.7.2.3
