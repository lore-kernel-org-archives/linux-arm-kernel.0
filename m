From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:46 +0200
Subject: [PATCH 50/61] ARM: imx: dynamically register spi_imx devices (imx25)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-51-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/devices-imx25.h    |    7 ++++
 arch/arm/mach-mx25/devices.c          |   57 ---------------------------------
 arch/arm/mach-mx25/devices.h          |    3 --
 arch/arm/plat-mxc/include/mach/mx25.h |    8 ++++-
 4 files changed, 14 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index 6464be4..33a834e 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -18,3 +18,10 @@
 
 #define imx25_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX25_NFC_BASE_ADDR, MX25_INT_NANDFC, pdata)
+
+#define imx25_add_spi_imx0(pdata)	\
+	imx_add_spi_imx(0, MX25_CSPI1_BASE_ADDR, SZ_16K, MX25_INT_CSPI1, pdata)
+#define imx25_add_spi_imx1(pdata)	\
+	imx_add_spi_imx(1, MX25_CSPI2_BASE_ADDR, SZ_16K, MX25_INT_CSPI2, pdata)
+#define imx25_add_spi_imx2(pdata)	\
+	imx_add_spi_imx(2, MX25_CSPI3_BASE_ADDR, SZ_16K, MX25_INT_CSPI3, pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 1af852a..c267087 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -181,63 +181,6 @@ struct platform_device mxc_usbh2 = {
 	.num_resources = ARRAY_SIZE(mxc_usbh2_resources),
 };
 
-static struct resource mxc_spi_resources0[] = {
-	{
-	       .start = 0x43fa4000,
-	       .end = 0x43fa7fff,
-	       .flags = IORESOURCE_MEM,
-	}, {
-	       .start = 14,
-	       .end = 14,
-	       .flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_spi_device0 = {
-	.name = "spi_imx",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_spi_resources0),
-	.resource = mxc_spi_resources0,
-};
-
-static struct resource mxc_spi_resources1[] = {
-	{
-	       .start = 0x50010000,
-	       .end = 0x50013fff,
-	       .flags = IORESOURCE_MEM,
-	}, {
-	       .start = 13,
-	       .end = 13,
-	       .flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_spi_device1 = {
-	.name = "spi_imx",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_spi_resources1),
-	.resource = mxc_spi_resources1,
-};
-
-static struct resource mxc_spi_resources2[] = {
-	{
-	       .start = 0x50004000,
-	       .end = 0x50007fff,
-	       .flags = IORESOURCE_MEM,
-	}, {
-	       .start = 0,
-	       .end = 0,
-	       .flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_spi_device2 = {
-	.name = "spi_imx",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(mxc_spi_resources2),
-	.resource = mxc_spi_resources2,
-};
-
 static struct resource mxc_pwm_resources0[] = {
 	{
 		.start	= 0x53fe0000,
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index f277514..1f31cbc 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -6,9 +6,6 @@ extern struct platform_device mxc_uart_device4;
 extern struct platform_device mxc_otg;
 extern struct platform_device otg_udc_device;
 extern struct platform_device mxc_usbh2;
-extern struct platform_device mxc_spi_device0;
-extern struct platform_device mxc_spi_device1;
-extern struct platform_device mxc_spi_device2;
 extern struct platform_device mxc_pwm_device0;
 extern struct platform_device mxc_pwm_device1;
 extern struct platform_device mxc_pwm_device2;
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 1ebf33f..16ac6b6 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -14,6 +14,7 @@
 #define MX25_I2C1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x80000)
 #define MX25_I2C3_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x84000)
 #define MX25_I2C2_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x98000)
+#define MX25_CSPI1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0xa4000)
 #define MX25_IOMUXC_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0xac000)
 
 #define MX25_CRM_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x80000)
@@ -33,18 +34,23 @@
 #define MX25_UART1_BASE_ADDR		0x43f90000
 #define MX25_UART2_BASE_ADDR		0x43f94000
 
+#define MX25_CSPI3_BASE_ADDR		0x50004000
+#define MX25_CSPI2_BASE_ADDR		0x50010000
 #define MX25_FEC_BASE_ADDR		0x50038000
 #define MX25_NFC_BASE_ADDR		0xbb000000
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
 #define MX25_LCDC_BASE_ADDR		0x53fbc000
 
+#define MX25_INT_CSPI3		0
 #define MX25_INT_I2C1		3
 #define MX25_INT_I2C2		4
 #define MX25_INT_I2C3		10
+#define MX25_INT_CSPI2		13
+#define MX25_INT_CSPI1		14
 #define MX25_INT_DRYICE		25
-#define MX25_INT_FEC		57
 #define MX25_INT_NANDFC		33
 #define MX25_INT_LCDC		39
+#define MX25_INT_FEC		57
 
 #if defined(IMX_NEEDS_DEPRECATED_SYMBOLS)
 #define UART1_BASE_ADDR			MX25_UART1_BASE_ADDR
-- 
1.7.1
