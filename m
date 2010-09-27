From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:50 +0200
Subject: [PATCH 14/40] ARM: imx: dynamically allocate imx-ssi devices
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-14-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                       |    5 +-
 arch/arm/mach-imx/devices-imx21.h               |    4 +
 arch/arm/mach-imx/devices-imx27.h               |    4 +
 arch/arm/mach-imx/devices.c                     |   35 --------
 arch/arm/mach-imx/devices.h                     |    2 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c    |    6 +-
 arch/arm/mach-imx/mach-pca100.c                 |    5 +-
 arch/arm/mach-mx25/Kconfig                      |    4 +-
 arch/arm/mach-mx25/devices-imx25.h              |    4 +
 arch/arm/mach-mx25/devices.c                    |   38 ---------
 arch/arm/mach-mx25/devices.h                    |    2 -
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c   |    6 +-
 arch/arm/mach-mx3/Kconfig                       |    6 +-
 arch/arm/mach-mx3/devices-imx31.h               |    4 +
 arch/arm/mach-mx3/devices-imx35.h               |    4 +
 arch/arm/mach-mx3/devices.c                     |   42 ----------
 arch/arm/mach-mx3/devices.h                     |    3 -
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c    |    6 +-
 arch/arm/mach-mx3/mach-mx31ads.c                |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c                 |    5 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx-ssi.c    |   98 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   15 ++++
 arch/arm/plat-mxc/include/mach/mx25.h           |    9 ++
 arch/arm/plat-mxc/include/mach/mx31.h           |    9 ++
 arch/arm/plat-mxc/include/mach/mx35.h           |    9 ++
 27 files changed, 187 insertions(+), 144 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-ssi.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 19ed16d..9b45f1f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -146,8 +146,8 @@ choice
 	default MACH_EUKREA_MBIMX27_BASEBOARD
 
 config MACH_EUKREA_MBIMX27_BASEBOARD
-	prompt "Eukrea MBIMX27 development board"
-	bool
+	bool "Eukrea MBIMX27 development board"
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
@@ -182,6 +182,7 @@ config MACH_IMX27LITE
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index f75b5e4..24868c3 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -12,6 +12,10 @@
 #define imx21_add_i2c_imx(pdata)	\
 	imx_add_imx_i2c(0, MX2x_I2C_BASE_ADDR, SZ_4K, MX2x_INT_I2C, pdata)
 
+extern const struct imx_imx_ssi_data imx21_imx_ssi_data[] __initconst;
+#define imx21_add_imx_ssi(id, pdata)	\
+	imx_add_imx_ssi(&imx21_imx_ssi_data[id], pdata)
+
 extern const struct imx_imx_uart_1irq_data imx21_imx_uart_data[] __initconst;
 #define imx21_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx21_imx_uart_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index bf9dab3..2972e69 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -14,6 +14,10 @@
 #define imx27_add_i2c_imx1(pdata)	\
 	imx_add_imx_i2c(1, MX27_I2C2_BASE_ADDR, SZ_4K, MX27_INT_I2C2, pdata)
 
+extern const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst;
+#define imx27_add_imx_ssi(id, pdata)    \
+	imx_add_imx_ssi(&imx27_imx_ssi_data[id], pdata)
+
 extern const struct imx_imx_uart_1irq_data imx27_imx_uart_data[] __initconst;
 #define imx27_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx27_imx_uart_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 9c271a7..423fa05 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -480,41 +480,6 @@ struct platform_device mxc_usbh2 = {
 };
 #endif
 
-#define DEFINE_IMX_SSI_DMARES(_name, ssin, suffix)			\
-	{								\
-		.name = _name,						\
-		.start = MX2x_DMA_REQ_SSI ## ssin ## _ ## suffix,	\
-		.end = MX2x_DMA_REQ_SSI ## ssin ## _ ## suffix,		\
-		.flags = IORESOURCE_DMA,				\
-	}
-
-#define DEFINE_IMX_SSI_DEVICE(n, ssin, baseaddr, irq)			\
-	static struct resource imx_ssi_resources ## n[] = {		\
-		{							\
-			.start = MX2x_SSI ## ssin ## _BASE_ADDR,	\
-			.end = MX2x_SSI ## ssin ## _BASE_ADDR + 0x6f,	\
-			.flags = IORESOURCE_MEM,			\
-		}, {							\
-			.start = MX2x_INT_SSI1,				\
-			.end = MX2x_INT_SSI1,				\
-			.flags = IORESOURCE_IRQ,			\
-		},							\
-		DEFINE_IMX_SSI_DMARES("tx0", ssin, TX0),		\
-		DEFINE_IMX_SSI_DMARES("rx0", ssin, RX0),		\
-		DEFINE_IMX_SSI_DMARES("tx1", ssin, TX1),		\
-		DEFINE_IMX_SSI_DMARES("rx1", ssin, RX1),		\
-	};								\
-									\
-	struct platform_device imx_ssi_device ## n = {			\
-		.name = "imx-ssi",					\
-		.id = n,						\
-		.num_resources = ARRAY_SIZE(imx_ssi_resources ## n),	\
-		.resource = imx_ssi_resources ## n,			\
-	}
-
-DEFINE_IMX_SSI_DEVICE(0, 1, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
-DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
-
 /* GPIO port description */
 #define DEFINE_MXC_GPIO_PORT_IRQ(SOC, n, _irq)				\
 	{								\
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index efd4527..57d4b1c 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -26,7 +26,5 @@ extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
 extern struct platform_device mx21_usbhc_device;
-extern struct platform_device imx_ssi_device0;
-extern struct platform_device imx_ssi_device1;
 extern struct platform_device imx_kpp_device;
 #endif
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 4edc5f4..cb433ae 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -36,7 +36,6 @@
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/spi.h>
-#include <mach/ssi.h>
 #include <mach/audmux.h>
 
 #include "devices-imx27.h"
@@ -311,7 +310,8 @@ static struct imxmmc_platform_data sdhc_pdata = {
 	.dat3_card_detect = 1,
 };
 
-struct imx_ssi_platform_data eukrea_mbimx27_ssi_pdata = {
+static const
+struct imx_ssi_platform_data eukrea_mbimx27_ssi_pdata __initconst = {
 	.flags = IMX_SSI_DMA | IMX_SSI_USE_I2S_SLAVE,
 };
 
@@ -357,7 +357,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	i2c_register_board_info(0, eukrea_mbimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_mbimx27_i2c_devices));
 
-	mxc_register_device(&imx_ssi_device0, &eukrea_mbimx27_ssi_pdata);
+	imx27_add_imx_ssi(0, &eukrea_mbimx27_ssi_pdata);
 
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) \
 	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 23c9e1f..93e0d66 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -38,7 +38,6 @@
 #include <mach/iomux-mx27.h>
 #include <asm/mach/time.h>
 #include <mach/audmux.h>
-#include <mach/ssi.h>
 #include <mach/mxc_nand.h>
 #include <mach/irqs.h>
 #include <mach/mmc.h>
@@ -252,7 +251,7 @@ static void pca100_ac97_cold_reset(struct snd_ac97 *ac97)
 	msleep(2);
 }
 
-static struct imx_ssi_platform_data pca100_ssi_pdata = {
+static const struct imx_ssi_platform_data pca100_ssi_pdata __initconst = {
 	.ac97_reset		= pca100_ac97_cold_reset,
 	.ac97_warm_reset	= pca100_ac97_warm_reset,
 	.flags			= IMX_SSI_USE_AC97,
@@ -389,7 +388,7 @@ static void __init pca100_init(void)
 	if (ret)
 		printk(KERN_ERR "pca100: Failed to setup pins (%d)\n", ret);
 
-	mxc_register_device(&imx_ssi_device0, &pca100_ssi_pdata);
+	imx27_add_imx_ssi(0, &pca100_ssi_pdata);
 
 	imx27_add_imx_uart0(&uart_pdata);
 
diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index c71a7bc..326bb64 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -20,8 +20,8 @@ choice
 	default MACH_EUKREA_MBIMXSD25_BASEBOARD
 
 config MACH_EUKREA_MBIMXSD25_BASEBOARD
-	prompt "Eukrea MBIMXSD development board"
-	bool
+	bool "Eukrea MBIMXSD development board"
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index 439400b..bf93fac 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -21,6 +21,10 @@
 #define imx25_add_imx_i2c2(pdata)	\
 	imx_add_imx_i2c(2, MX25_I2C3_BASE_ADDR, SZ_16K, MX25_INT_I2C3, pdata)
 
+extern const struct imx_imx_ssi_data imx25_imx_ssi_data[] __initconst;
+#define imx25_add_imx_ssi(id, pdata)	\
+	imx_add_imx_ssi(&imx25_imx_ssi_data[id], pdata)
+
 extern const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst;
 #define imx25_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx25_imx_uart_data[id], pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 3468eb1..bc19e8c 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -305,44 +305,6 @@ struct platform_device mx25_kpp_device = {
 	.resource	= mx25_kpp_resources,
 };
 
-static struct resource imx_ssi_resources0[] = {
-	{
-		.start	= MX25_SSI1_BASE_ADDR,
-		.end	= MX25_SSI1_BASE_ADDR + 0x3fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MX25_INT_SSI1,
-		.end	= MX25_INT_SSI1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource imx_ssi_resources1[] = {
-	{
-		.start	= MX25_SSI2_BASE_ADDR,
-		.end	= MX25_SSI2_BASE_ADDR + 0x3fff,
-		.flags	= IORESOURCE_MEM
-	}, {
-		.start	= MX25_INT_SSI2,
-		.end	= MX25_INT_SSI2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_ssi_device0 = {
-	.name = "imx-ssi",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(imx_ssi_resources0),
-	.resource = imx_ssi_resources0,
-};
-
-struct platform_device imx_ssi_device1 = {
-	.name = "imx-ssi",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(imx_ssi_resources1),
-	.resource = imx_ssi_resources1,
-};
-
 static struct resource mx25_csi_resources[] = {
 	{
 		.start	= MX25_CSI_BASE_ADDR,
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index 4aceb68..f6e6d3a 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -11,6 +11,4 @@ extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
 extern struct platform_device mxc_wdt;
 extern struct platform_device mx25_kpp_device;
-extern struct platform_device imx_ssi_device0;
-extern struct platform_device imx_ssi_device1;
 extern struct platform_device mx25_csi_device;
diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
index 4aaadc7..2062dd9 100644
--- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
@@ -34,7 +34,6 @@
 #include <mach/mx25.h>
 #include <mach/imx-uart.h>
 #include <mach/imxfb.h>
-#include <mach/ssi.h>
 #include <mach/audmux.h>
 
 #include "devices-imx25.h"
@@ -205,7 +204,8 @@ static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
 	},
 };
 
-struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata = {
+static const
+struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
 	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
 };
 
@@ -239,7 +239,7 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 
 	imx25_add_imx_uart1(&uart_pdata);
 	mxc_register_device(&mx25_fb_device, &eukrea_mximxsd_fb_pdata);
-	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
+	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 5cee1a5..d762bf8 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -17,6 +17,7 @@ config MACH_MX31ADS
 	bool "Support MX31ADS platforms"
 	select ARCH_MX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	default y
 	help
@@ -118,6 +119,7 @@ config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select ARCH_MX35
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_FLEXCAN
@@ -172,8 +174,8 @@ choice
 	default MACH_EUKREA_MBIMXSD35_BASEBOARD
 
 config MACH_EUKREA_MBIMXSD35_BASEBOARD
-	prompt "Eukrea MBIMXSD development board"
-	bool
+	bool "Eukrea MBIMXSD development board"
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index a8c5f1b..b8568a1 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -16,6 +16,10 @@
 #define imx31_add_imx_i2c2(pdata)	\
 	imx_add_imx_i2c(2, MX31_I2C3_BASE_ADDR, SZ_4K, MX31_INT_I2C3, pdata)
 
+extern const struct imx_imx_ssi_data imx31_imx_ssi_data[] __initconst;
+#define imx31_add_imx_ssi(id, pdata)    \
+	imx_add_imx_ssi(&imx31_imx_ssi_data[id], pdata)
+
 extern const struct imx_imx_uart_1irq_data imx31_imx_uart_data[] __initconst;
 #define imx31_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx31_imx_uart_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 6a76b4d..813e570 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -21,6 +21,10 @@
 #define imx35_add_imx_i2c2(pdata)	\
 	imx_add_imx_i2c(2, MX35_I2C3_BASE_ADDR, SZ_4K, MX35_INT_I2C3, pdata)
 
+extern const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst;
+#define imx35_add_imx_ssi(id, pdata)    \
+	imx_add_imx_ssi(&imx35_imx_ssi_data[id], pdata)
+
 extern const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst;
 #define imx35_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx35_imx_uart_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index a4fd1a2..87a9a21 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -302,44 +302,6 @@ struct platform_device mxc_fec_device = {
 };
 #endif
 
-static struct resource imx_ssi_resources0[] = {
-	{
-		.start	= SSI1_BASE_ADDR,
-		.end	= SSI1_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MX31_INT_SSI1,
-		.end	= MX31_INT_SSI1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource imx_ssi_resources1[] = {
-	{
-		.start	= SSI2_BASE_ADDR,
-		.end	= SSI2_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM
-	}, {
-		.start	= MX31_INT_SSI2,
-		.end	= MX31_INT_SSI2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_ssi_device0 = {
-	.name = "imx-ssi",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(imx_ssi_resources0),
-	.resource = imx_ssi_resources0,
-};
-
-struct platform_device imx_ssi_device1 = {
-	.name = "imx-ssi",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(imx_ssi_resources1),
-	.resource = imx_ssi_resources1,
-};
-
 static struct resource imx_wdt_resources[] = {
 	{
 		.flags = IORESOURCE_MEM,
@@ -410,10 +372,6 @@ static int __init mx3_devices_init(void)
 		mxc_usbh1_resources[0].end = MX35_OTG_BASE_ADDR + 0x5ff;
 		mxc_usbh1_resources[1].start = MXC_INT_USBHS;
 		mxc_usbh1_resources[1].end = MXC_INT_USBHS;
-		imx_ssi_resources0[1].start = MX35_INT_SSI1;
-		imx_ssi_resources0[1].end = MX35_INT_SSI1;
-		imx_ssi_resources1[1].start = MX35_INT_SSI2;
-		imx_ssi_resources1[1].end = MX35_INT_SSI2;
 		imx_wdt_resources[0].start = MX35_WDOG_BASE_ADDR;
 		imx_wdt_resources[0].end = MX35_WDOG_BASE_ADDR + 0x3fff;
 	}
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index e553523..2a69465 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -10,9 +10,6 @@ extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
 extern struct platform_device mxc_rnga_device;
-extern struct platform_device imx_ssi_device0;
-extern struct platform_device imx_ssi_device1;
-extern struct platform_device imx_ssi_device1;
 extern struct platform_device imx_wdt_device0;
 extern struct platform_device imx_rtc_device0;
 extern struct platform_device imx_kpp_device;
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index f8f15e3..cb667b6 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -43,7 +43,6 @@
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
 #include <mach/audmux.h>
-#include <mach/ssi.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -206,7 +205,8 @@ static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
 	},
 };
 
-struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata = {
+static const
+struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
 	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
 };
 
@@ -242,7 +242,7 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
 
-	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
+	imx35_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index 94b3e7c..96cedc4 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -517,7 +517,7 @@ static unsigned int ssi_pins[] = {
 
 static void mxc_init_audio(void)
 {
-	mxc_register_device(&imx_ssi_device0, NULL);
+	imx31_add_imx_ssi(0, NULL);
 	mxc_iomux_setup_multiple_pins(ssi_pins, ARRAY_SIZE(ssi_pins), "ssi");
 }
 
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 28886f0..dcc216b 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -42,7 +42,6 @@
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 #include <mach/audmux.h>
-#include <mach/ssi.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -293,7 +292,7 @@ err1:
 	mdelay(1);
 }
 
-static struct imx_ssi_platform_data pcm043_ssi_pdata = {
+static const struct imx_ssi_platform_data pcm043_ssi_pdata __initconst = {
 	.ac97_reset = pcm043_ac97_cold_reset,
 	.ac97_warm_reset = pcm043_ac97_warm_reset,
 	.flags = IMX_SSI_USE_AC97,
@@ -361,7 +360,7 @@ static void __init mxc_board_init(void)
 
 	imx35_add_imx_uart0(&uart_pdata);
 	imx35_add_mxc_nand(&pcm037_nand_board_info);
-	mxc_register_device(&imx_ssi_device0, &pcm043_ssi_pdata);
+	imx35_add_imx_ssi(0, &pcm043_ssi_pdata);
 
 	imx35_add_imx_uart1(&uart_pdata);
 
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 9ab784b..d736c3d 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -5,6 +5,9 @@ config IMX_HAVE_PLATFORM_FLEXCAN
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
 
+config IMX_HAVE_PLATFORM_IMX_SSI
+	bool
+
 config IMX_HAVE_PLATFORM_IMX_UART
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 2062ab4..ac77383 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
new file mode 100644
index 0000000..1535bc9
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
@@ -0,0 +1,98 @@
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
+#define imx_imx_ssi_data_entry(soc, _id, _hwid, _size)			\
+	[_id] = {							\
+		.id = _id,						\
+		.iobase = soc ## _SSI ## _hwid ## _BASE_ADDR,		\
+		.iosize = _size,					\
+		.irq = soc ## _INT_SSI ## _hwid,			\
+		.dmatx0 = soc ## _DMA_REQ_SSI ## _hwid ## _TX0,		\
+		.dmarx0 = soc ## _DMA_REQ_SSI ## _hwid ## _RX0,		\
+		.dmatx1 = soc ## _DMA_REQ_SSI ## _hwid ## _TX1,		\
+		.dmarx1 = soc ## _DMA_REQ_SSI ## _hwid ## _RX1,		\
+	}
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_imx_ssi_data imx21_imx_ssi_data[] __initconst = {
+#define imx21_imx_ssi_data_entry(_id, _hwid)				\
+	imx_imx_ssi_data_entry(MX21, _id, _hwid, SZ_4K)
+	imx21_imx_ssi_data_entry(0, 1),
+	imx21_imx_ssi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+#ifdef CONFIG_ARCH_MX25
+const struct imx_imx_ssi_data imx25_imx_ssi_data[] __initconst = {
+#define imx25_imx_ssi_data_entry(_id, _hwid)				\
+	imx_imx_ssi_data_entry(MX25, _id, _hwid, SZ_4K)
+	imx25_imx_ssi_data_entry(0, 1),
+	imx25_imx_ssi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst = {
+#define imx27_imx_ssi_data_entry(_id, _hwid)				\
+	imx_imx_ssi_data_entry(MX27, _id, _hwid, SZ_4K)
+	imx27_imx_ssi_data_entry(0, 1),
+	imx27_imx_ssi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+#ifdef CONFIG_ARCH_MX31
+const struct imx_imx_ssi_data imx31_imx_ssi_data[] __initconst = {
+#define imx31_imx_ssi_data_entry(_id, _hwid)				\
+	imx_imx_ssi_data_entry(MX31, _id, _hwid, SZ_4K)
+	imx31_imx_ssi_data_entry(0, 1),
+	imx31_imx_ssi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX31 */
+
+#ifdef CONFIG_ARCH_MX35
+const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst = {
+#define imx35_imx_ssi_data_entry(_id, _hwid)				\
+	imx_imx_ssi_data_entry(MX35, _id, _hwid, SZ_4K)
+	imx35_imx_ssi_data_entry(0, 1),
+	imx35_imx_ssi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX35 */
+
+struct platform_device *__init imx_add_imx_ssi(
+		const struct imx_imx_ssi_data *data,
+		const struct imx_ssi_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + data->iosize - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+#define DMARES(_name) {							\
+	.name = #_name,							\
+	.start = data->dma ## _name,					\
+	.end = data->dma ## _name,					\
+	.flags = IORESOURCE_DMA,					\
+}
+		DMARES(tx0),
+		DMARES(rx0),
+		DMARES(tx1),
+		DMARES(rx1),
+	};
+
+	return imx_add_platform_device("imx-ssi", data->id,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 12bdc7d..84bfe44 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -25,6 +25,21 @@ struct platform_device *__init imx_add_imx_i2c(int id,
 		resource_size_t iobase, resource_size_t iosize, int irq,
 		const struct imxi2c_platform_data *pdata);
 
+#include <mach/ssi.h>
+struct imx_imx_ssi_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+	resource_size_t dmatx0;
+	resource_size_t dmarx0;
+	resource_size_t dmatx1;
+	resource_size_t dmarx1;
+};
+struct platform_device *__init imx_add_imx_ssi(
+		const struct imx_imx_ssi_data *data,
+		const struct imx_ssi_platform_data *pdata);
+
 #include <mach/imx-uart.h>
 struct imx_imx_uart_3irq_data {
 	int id;
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 4a6f800..8f809eb 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -77,4 +77,13 @@
 #define MX25_INT_UART1		45
 #define MX25_INT_FEC		57
 
+#define MX25_DMA_REQ_SSI2_RX1	22
+#define MX25_DMA_REQ_SSI2_TX1	23
+#define MX25_DMA_REQ_SSI2_RX0	24
+#define MX25_DMA_REQ_SSI2_TX0	25
+#define MX25_DMA_REQ_SSI1_RX1	26
+#define MX25_DMA_REQ_SSI1_TX1	27
+#define MX25_DMA_REQ_SSI1_RX0	28
+#define MX25_DMA_REQ_SSI1_TX0	29
+
 #endif /* ifndef __MACH_MX25_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index afee3ab..eb8bbc7 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -197,6 +197,15 @@ static inline void mx31_setup_weimcs(size_t cs,
 #define MX31_INT_EXT_WDOG	62
 #define MX31_INT_EXT_TV		63
 
+#define MX31_DMA_REQ_SSI2_RX1	22
+#define MX31_DMA_REQ_SSI2_TX1	23
+#define MX31_DMA_REQ_SSI2_RX0	24
+#define MX31_DMA_REQ_SSI2_TX0	25
+#define MX31_DMA_REQ_SSI1_RX1	26
+#define MX31_DMA_REQ_SSI1_TX1	27
+#define MX31_DMA_REQ_SSI1_RX0	28
+#define MX31_DMA_REQ_SSI1_TX0	29
+
 #define MX31_PROD_SIGNATURE		0x1	/* For MX31 */
 
 /* silicon revisions specific to i.MX31 */
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index af3038c..867b8c0c 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -173,6 +173,15 @@
 #define MX35_INT_EXT_WDOG	62
 #define MX35_INT_EXT_TV		63
 
+#define MX35_DMA_REQ_SSI2_RX1   22
+#define MX35_DMA_REQ_SSI2_TX1   23
+#define MX35_DMA_REQ_SSI2_RX0   24
+#define MX35_DMA_REQ_SSI2_TX0   25
+#define MX35_DMA_REQ_SSI1_RX1   26
+#define MX35_DMA_REQ_SSI1_TX1   27
+#define MX35_DMA_REQ_SSI1_RX0   28
+#define MX35_DMA_REQ_SSI1_TX0   29
+
 #define MX35_PROD_SIGNATURE		0x1	/* For MX31 */
 
 /* silicon revisions specific to i.MX31 */
-- 
1.7.2.3
