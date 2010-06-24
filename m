From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:45 +0200
Subject: [PATCH 49/61] ARM: imx: dynamically register spi_imx devices (imx21)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-50-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx21.h |    5 +++++
 arch/arm/mach-imx/devices.c       |    3 +--
 arch/arm/mach-imx/devices.h       |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index c6e5f50..de80ccd 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -14,3 +14,8 @@
 
 #define imx21_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX21_NFC_BASE_ADDR, MX21_INT_NANDFC, pdata)
+
+#define imx21_add_spi_imx0(pdata)	\
+	imx_add_spi_imx(0, MX21_CSPI1_BASE_ADDR, SZ_4K, MX21_INT_CSPI1, pdata)
+#define imx21_add_spi_imx1(pdata)	\
+	imx_add_spi_imx(1, MX21_CSPI2_BASE_ADDR, SZ_4K, MX21_INT_CSPI2, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index f8641c2..e42eead 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -225,6 +225,7 @@ int __init imx1_register_gpios(void)
  * - i.MX21: 2 channel
  * - i.MX27: 3 channel
  */
+#ifdef CONFIG_MACH_MX27
 #define DEFINE_IMX_SPI_DEVICE(n, baseaddr, irq)					\
 	static struct resource mxc_spi_resources ## n[] = {			\
 		{								\
@@ -247,8 +248,6 @@ int __init imx1_register_gpios(void)
 
 DEFINE_IMX_SPI_DEVICE(0, MX2x_CSPI1_BASE_ADDR, MX2x_INT_CSPI1);
 DEFINE_IMX_SPI_DEVICE(1, MX2x_CSPI2_BASE_ADDR, MX2x_INT_CSPI2);
-
-#ifdef CONFIG_MACH_MX27
 DEFINE_IMX_SPI_DEVICE(2, MX27_CSPI3_BASE_ADDR, MX27_INT_CSPI3);
 #endif
 
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 4fe9935..c15b0de 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -34,9 +34,9 @@ extern struct platform_device mxc_otg_udc_device;
 extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
+#ifdef CONFIG_MACH_MX27
 extern struct platform_device mxc_spi_device0;
 extern struct platform_device mxc_spi_device1;
-#ifdef CONFIG_MACH_MX27
 extern struct platform_device mxc_spi_device2;
 #endif
 extern struct platform_device mx21_usbhc_device;
-- 
1.7.1
