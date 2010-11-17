From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:57 +0100
Subject: [PATCH 29/51] ARM: mx25: dynamically allocate fsl-usb2-udc devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-29-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Kconfig                        |    1 +
 arch/arm/mach-mx25/devices-imx25.h                |    4 +++
 arch/arm/mach-mx25/devices.c                      |   26 ---------------------
 arch/arm/mach-mx25/devices.h                      |    1 -
 arch/arm/mach-mx25/mach-cpuimx25.c                |    5 +--
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c |    5 ++++
 6 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index b55585b..2944bb7 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -13,6 +13,7 @@ config MACH_EUKREA_CPUIMX25
 	bool "Support Eukrea CPUIMX25 Platform"
 	select IMX_HAVE_PLATFORM_ESDHC
 	select IMX_HAVE_PLATFORM_FLEXCAN
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index ac343ae..448939a 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -19,6 +19,10 @@ extern const struct imx_flexcan_data imx25_flexcan_data[] __initconst;
 #define imx25_add_flexcan0(pdata)	imx25_add_flexcan(0, pdata)
 #define imx25_add_flexcan1(pdata)	imx25_add_flexcan(1, pdata)
 
+extern const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst;
+#define imx25_add_fsl_usb2_udc(pdata)	\
+	imx_add_fsl_usb2_udc(&imx25_fsl_usb2_udc_data, pdata)
+
 extern const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst;
 #define imx25_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx25_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 4611c76..27d07ce 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -22,32 +22,6 @@
 #include <mach/mx25.h>
 #include <mach/irqs.h>
 
-static u64 otg_dmamask = DMA_BIT_MASK(32);
-
-static struct resource mxc_otg_resources[] = {
-	{
-		.start = MX25_USB_OTG_BASE_ADDR,
-		.end = MX25_USB_OTG_BASE_ADDR + 0x1ff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX25_INT_USB_OTG,
-		.end = MX25_INT_USB_OTG,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-/* OTG gadget device */
-struct platform_device otg_udc_device = {
-	.name = "fsl-usb2-udc",
-	.id   = -1,
-	.dev  = {
-		.dma_mask          = &otg_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-	},
-	.resource = mxc_otg_resources,
-	.num_resources = ARRAY_SIZE(mxc_otg_resources),
-};
-
 static struct resource mxc_pwm_resources0[] = {
 	{
 		.start	= 0x53fe0000,
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index e6ad640..266c305 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -1,4 +1,3 @@
-extern struct platform_device otg_udc_device;
 extern struct platform_device mxc_pwm_device0;
 extern struct platform_device mxc_pwm_device1;
 extern struct platform_device mxc_pwm_device2;
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index 0ee0fe7..2094bdd 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -26,7 +26,6 @@
 #include <linux/platform_device.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
-#include <linux/fsl_devices.h>
 
 #include <mach/eukrea-baseboards.h>
 #include <mach/hardware.h>
@@ -97,7 +96,7 @@ static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
 		  MXC_EHCI_IPPUE_DOWN,
 };
 
-static struct fsl_usb2_platform_data otg_device_pdata = {
+static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
 	.phy_mode       = FSL_USB2_PHY_UTMI,
 };
@@ -135,7 +134,7 @@ static void __init eukrea_cpuimx25_init(void)
 	if (otg_mode_host)
 		imx25_add_mxc_ehci_otg(&otg_pdata);
 	else
-		mxc_register_device(&otg_udc_device, &otg_device_pdata);
+		imx25_add_fsl_usb2_udc(&otg_device_pdata);
 
 	imx25_add_mxc_ehci_hs(&usbh2_pdata);
 
diff --git a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
index 3116f9a..cb5fb71 100644
--- a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
+++ b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
@@ -15,6 +15,11 @@
 		.irq = soc ## _INT_USB_OTG,				\
 	}
 
+#ifdef CONFIG_ARCH_MX25
+const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst =
+	imx_fsl_usb2_udc_data_entry_single(MX25);
+#endif
+
 #ifdef CONFIG_SOC_IMX27
 const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst =
 	imx_fsl_usb2_udc_data_entry_single(MX27);
-- 
1.7.2.3
