From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:40 +0200
Subject: [PATCH 44/61] ARM: imx: dynamically register imx-i2c devices (imx25)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-45-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/devices-imx25.h    |    7 ++++
 arch/arm/mach-mx25/devices.c          |   57 ---------------------------------
 arch/arm/mach-mx25/devices.h          |    3 --
 arch/arm/plat-mxc/include/mach/mx25.h |   14 ++++++--
 4 files changed, 17 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index f8d4ee0..6464be4 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -9,5 +9,12 @@
 #include <mach/mx25.h>
 #include <mach/devices-common.h>
 
+#define imx25_add_imx_i2c0(pdata)	\
+	imx_add_imx_i2c(0, MX25_I2C1_BASE_ADDR, SZ_16K, MX25_INT_I2C1, pdata)
+#define imx25_add_imx_i2c1(pdata)	\
+	imx_add_imx_i2c(1, MX25_I2C2_BASE_ADDR, SZ_16K, MX25_INT_I2C2, pdata)
+#define imx25_add_imx_i2c2(pdata)	\
+	imx_add_imx_i2c(2, MX25_I2C3_BASE_ADDR, SZ_16K, MX25_INT_I2C3, pdata)
+
 #define imx25_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX25_NFC_BASE_ADDR, MX25_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index e1c3cd1..1af852a 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -333,63 +333,6 @@ struct platform_device mxc_pwm_device3 = {
 	.resource = mxc_pwm_resources3,
 };
 
-static struct resource mxc_i2c_1_resources[] = {
-	{
-		.start	= 0x43f80000,
-		.end	= 0x43f83fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= 3,
-		.end	= 3,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_i2c_device0 = {
-	.name = "imx-i2c",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_i2c_1_resources),
-	.resource = mxc_i2c_1_resources,
-};
-
-static struct resource mxc_i2c_2_resources[] = {
-	{
-		.start	= 0x43f98000,
-		.end	= 0x43f9bfff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= 4,
-		.end	= 4,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_i2c_device1 = {
-	.name = "imx-i2c",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_i2c_2_resources),
-	.resource = mxc_i2c_2_resources,
-};
-
-static struct resource mxc_i2c_3_resources[] = {
-	{
-		.start	= 0x43f84000,
-		.end	= 0x43f87fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= 10,
-		.end	= 10,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_i2c_device2 = {
-	.name = "imx-i2c",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(mxc_i2c_3_resources),
-	.resource = mxc_i2c_3_resources,
-};
-
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index f212c93..f277514 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -14,9 +14,6 @@ extern struct platform_device mxc_pwm_device1;
 extern struct platform_device mxc_pwm_device2;
 extern struct platform_device mxc_pwm_device3;
 extern struct platform_device mxc_keypad_device;
-extern struct platform_device mxc_i2c_device0;
-extern struct platform_device mxc_i2c_device1;
-extern struct platform_device mxc_i2c_device2;
 extern struct platform_device mx25_fec_device;
 extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 4eb6e33..1ebf33f 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -11,6 +11,9 @@
 #define MX25_AVIC_BASE_ADDR_VIRT	0xfc400000
 #define MX25_AVIC_SIZE			SZ_1M
 
+#define MX25_I2C1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x80000)
+#define MX25_I2C3_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x84000)
+#define MX25_I2C2_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x98000)
 #define MX25_IOMUXC_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0xac000)
 
 #define MX25_CRM_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x80000)
@@ -35,10 +38,13 @@
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
 #define MX25_LCDC_BASE_ADDR		0x53fbc000
 
-#define MX25_INT_DRYICE	25
-#define MX25_INT_FEC	57
-#define MX25_INT_NANDFC	33
-#define MX25_INT_LCDC	39
+#define MX25_INT_I2C1		3
+#define MX25_INT_I2C2		4
+#define MX25_INT_I2C3		10
+#define MX25_INT_DRYICE		25
+#define MX25_INT_FEC		57
+#define MX25_INT_NANDFC		33
+#define MX25_INT_LCDC		39
 
 #if defined(IMX_NEEDS_DEPRECATED_SYMBOLS)
 #define UART1_BASE_ADDR			MX25_UART1_BASE_ADDR
-- 
1.7.1
