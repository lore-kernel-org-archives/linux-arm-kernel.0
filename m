From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:43 +0200
Subject: [PATCH 47/61] ARM: imx: dynamically register imx-i2c devices (imx35)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-48-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig             |    1 +
 arch/arm/mach-mx3/devices-imx35.h     |    7 ++++
 arch/arm/mach-mx3/devices.c           |   59 ---------------------------------
 arch/arm/mach-mx3/devices.h           |    5 ---
 arch/arm/mach-mx3/mach-pcm043.c       |    7 +---
 arch/arm/plat-mxc/include/mach/mx35.h |    4 +-
 6 files changed, 12 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 557a20b..b8a7610 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -103,6 +103,7 @@ config MACH_QONG
 config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select ARCH_MX35
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 69dac76..6d993ae 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -9,5 +9,12 @@
 #include <mach/mx35.h>
 #include <mach/devices-common.h>
 
+#define imx35_add_imx_i2c0(pdata)	\
+	imx_add_imx_i2c(0, MX35_I2C1_BASE_ADDR, SZ_4K, MX35_INT_I2C1, pdata)
+#define imx35_add_imx_i2c1(pdata)	\
+	imx_add_imx_i2c(1, MX35_I2C2_BASE_ADDR, SZ_4K, MX35_INT_I2C2, pdata)
+#define imx35_add_imx_i2c2(pdata)	\
+	imx_add_imx_i2c(2, MX35_I2C3_BASE_ADDR, SZ_4K, MX35_INT_I2C3, pdata)
+
 #define imx35_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX35_NFC_BASE_ADDR, MX35_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 0743214..a285b16 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -167,65 +167,6 @@ struct platform_device mxc_w1_master_device = {
 	.resource = mxc_w1_master_resources,
 };
 
-#if defined(CONFIG_ARCH_MX35)
-static struct resource mxc_i2c0_resources[] = {
-	{
-		.start = I2C_BASE_ADDR,
-		.end = I2C_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_I2C,
-		.end = MXC_INT_I2C,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_i2c_device0 = {
-	.name = "imx-i2c",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_i2c0_resources),
-	.resource = mxc_i2c0_resources,
-};
-
-static struct resource mxc_i2c1_resources[] = {
-	{
-		.start = I2C2_BASE_ADDR,
-		.end = I2C2_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_I2C2,
-		.end = MXC_INT_I2C2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_i2c_device1 = {
-	.name = "imx-i2c",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_i2c1_resources),
-	.resource = mxc_i2c1_resources,
-};
-
-static struct resource mxc_i2c2_resources[] = {
-	{
-		.start = I2C3_BASE_ADDR,
-		.end = I2C3_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_I2C3,
-		.end = MXC_INT_I2C3,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_i2c_device2 = {
-	.name = "imx-i2c",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(mxc_i2c2_resources),
-	.resource = mxc_i2c2_resources,
-};
-#endif
-
 #ifdef CONFIG_ARCH_MX31
 static struct resource mxcsdhc0_resources[] = {
 	{
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index e108fa3..c50596a 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -5,11 +5,6 @@ extern struct platform_device mxc_uart_device2;
 extern struct platform_device mxc_uart_device3;
 extern struct platform_device mxc_uart_device4;
 extern struct platform_device mxc_w1_master_device;
-#if defined(CONFIG_ARCH_MX35)
-extern struct platform_device mxc_i2c_device0;
-extern struct platform_device mxc_i2c_device1;
-extern struct platform_device mxc_i2c_device2;
-#endif
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 58de305..21305c6 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -37,9 +37,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/imx-uart.h>
-#if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
-#include <mach/i2c.h>
-#endif
 #include <mach/iomux-mx35.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
@@ -123,7 +120,7 @@ static struct imxuart_platform_data uart_pdata = {
 };
 
 #if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
-static struct imxi2c_platform_data pcm043_i2c_1_data = {
+static const struct imxi2c_platform_data pcm043_i2c0_data __initconst = {
 	.bitrate = 50000,
 };
 
@@ -368,7 +365,7 @@ static void __init mxc_board_init(void)
 	i2c_register_board_info(0, pcm043_i2c_devices,
 			ARRAY_SIZE(pcm043_i2c_devices));
 
-	mxc_register_device(&mxc_i2c_device0, &pcm043_i2c_1_data);
+	imx35_add_imx_i2c0(&pcm043_i2c0_data);
 #endif
 
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index 526a558..cda60c7 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -18,7 +18,7 @@
 #define MX35_ETB_SLOT4_BASE_ADDR		(MX35_AIPS1_BASE_ADDR + 0x10000)
 #define MX35_ETB_SLOT5_BASE_ADDR		(MX35_AIPS1_BASE_ADDR + 0x14000)
 #define MX35_ECT_CTIO_BASE_ADDR			(MX35_AIPS1_BASE_ADDR + 0x18000)
-#define MX35_I2C_BASE_ADDR			(MX35_AIPS1_BASE_ADDR + 0x80000)
+#define MX35_I2C1_BASE_ADDR			(MX35_AIPS1_BASE_ADDR + 0x80000)
 #define MX35_I2C3_BASE_ADDR			(MX35_AIPS1_BASE_ADDR + 0x84000)
 #define MX35_UART1_BASE_ADDR			(MX35_AIPS1_BASE_ADDR + 0x90000)
 #define MX35_UART2_BASE_ADDR			(MX35_AIPS1_BASE_ADDR + 0x94000)
@@ -123,7 +123,7 @@
 #define MX35_INT_MMC_SDHC1	7
 #define MX35_INT_MMC_SDHC2	8
 #define MX35_INT_MMC_SDHC3	9
-#define MX35_INT_I2C		10
+#define MX35_INT_I2C1		10
 #define MX35_INT_SSI1		11
 #define MX35_INT_SSI2		12
 #define MX35_INT_CSPI2		13
-- 
1.7.1
