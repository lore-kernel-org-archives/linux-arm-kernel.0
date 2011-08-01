From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Aug 2011 11:38:25 +0200
Subject: [PATCH 4/8] ARM: mx5: dynamically allocate fsl-usb2-udc devices
In-Reply-To: <1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110801093759.GD9250@pengutronix.de>
	<1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1312191509-21895-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig                         |    3 ++
 arch/arm/mach-mx5/board-cpuimx51.c                |    5 +--
 arch/arm/mach-mx5/board-cpuimx51sd.c              |    5 +--
 arch/arm/mach-mx5/board-mx51_babbage.c            |    4 +-
 arch/arm/mach-mx5/devices-imx51.h                 |    4 +++
 arch/arm/mach-mx5/devices.c                       |   26 ---------------------
 arch/arm/mach-mx5/devices.h                       |    1 -
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c |    5 ++++
 8 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 2905110..d8691a0 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -65,6 +65,7 @@ comment "i.MX51 machines:"
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
 	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -92,6 +93,7 @@ config MACH_MX51_3DS
 config MACH_EUKREA_CPUIMX51
 	bool "Support Eukrea CPUIMX51 module"
 	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
@@ -121,6 +123,7 @@ endchoice
 config MACH_EUKREA_CPUIMX51SD
 	bool "Support Eukrea CPUIMX51SD module"
 	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index aa1ff79..e2afe0c 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -36,7 +36,6 @@
 #include <asm/mach/time.h>
 
 #include "devices-imx51.h"
-#include "devices.h"
 
 #define CPUIMX51_USBH1_STP	IMX_GPIO_NR(1, 27)
 #define CPUIMX51_QUARTA_GPIO	IMX_GPIO_NR(3, 28)
@@ -211,7 +210,7 @@ static const struct mxc_usbh_platform_data dr_utmi_config __initconst = {
 	.portsc	= MXC_EHCI_UTMI_16BIT,
 };
 
-static struct fsl_usb2_platform_data usb_pdata = {
+static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
@@ -273,7 +272,7 @@ static void __init eukrea_cpuimx51_init(void)
 		imx51_add_mxc_ehci_otg(&dr_utmi_config);
 	else {
 		initialize_otg_port(NULL);
-		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
+		imx51_add_fsl_usb2_udc(&usb_pdata);
 	}
 	imx51_add_mxc_ehci_hs(1, &usbh1_config);
 
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index bca3719..71a5832 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -39,7 +39,6 @@
 #include <asm/mach/time.h>
 
 #include "devices-imx51.h"
-#include "devices.h"
 #include "cpu_op-mx51.h"
 
 #define USBH1_RST		IMX_GPIO_NR(2, 28)
@@ -194,7 +193,7 @@ static const struct mxc_usbh_platform_data dr_utmi_config __initconst = {
 	.portsc	= MXC_EHCI_UTMI_16BIT,
 };
 
-static struct fsl_usb2_platform_data usb_pdata = {
+static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
@@ -306,7 +305,7 @@ static void __init eukrea_cpuimx51sd_init(void)
 		imx51_add_mxc_ehci_otg(&dr_utmi_config);
 	else {
 		initialize_otg_port(NULL);
-		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
+		imx51_add_fsl_usb2_udc(&usb_pdata);
 	}
 
 	gpio_request(USBH1_RST, "usb_rst");
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 1d15297..576a799 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -293,7 +293,7 @@ static const struct mxc_usbh_platform_data dr_utmi_config __initconst = {
 	.portsc	= MXC_EHCI_UTMI_16BIT,
 };
 
-static struct fsl_usb2_platform_data usb_pdata = {
+static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
@@ -387,7 +387,7 @@ static void __init mx51_babbage_init(void)
 		imx51_add_mxc_ehci_otg(&dr_utmi_config);
 	else {
 		initialize_otg_port(NULL);
-		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
+		imx51_add_fsl_usb2_udc(&usb_pdata);
 	}
 
 	gpio_usbh1_active();
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index f42acf5..2f2cdb9 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -13,6 +13,10 @@ extern const struct imx_fec_data imx51_fec_data;
 #define imx51_add_fec(pdata)	\
 	imx_add_fec(&imx51_fec_data, pdata)
 
+extern const struct imx_fsl_usb2_udc_data imx51_fsl_usb2_udc_data;
+#define imx51_add_fsl_usb2_udc(pdata)	\
+	imx_add_fsl_usb2_udc(&imx51_fsl_usb2_udc_data, pdata)
+
 extern const struct imx_imx_i2c_data imx51_imx_i2c_data[];
 #define imx51_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 88edf26..1c09026 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -35,29 +35,3 @@ struct platform_device mxc_hsi2c_device = {
 	.num_resources = ARRAY_SIZE(mxc_hsi2c_resources),
 	.resource = mxc_hsi2c_resources
 };
-
-static u64 usb_dma_mask = DMA_BIT_MASK(32);
-
-static struct resource usbotg_resources[] = {
-	{
-		.start = MX51_USB_OTG_BASE_ADDR,
-		.end = MX51_USB_OTG_BASE_ADDR + 0x1ff,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = MX51_INT_USB_OTG,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-/* OTG gadget device */
-struct platform_device mxc_usbdr_udc_device = {
-	.name		= "fsl-usb2-udc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(usbotg_resources),
-	.resource	= usbotg_resources,
-	.dev		= {
-		.dma_mask		= &usb_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index 0f30a6e..6b2edfe 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -1,2 +1 @@
-extern struct platform_device mxc_usbdr_udc_device;
 extern struct platform_device mxc_hsi2c_device;
diff --git a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
index 23ce08e..848038f 100644
--- a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
+++ b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
@@ -36,6 +36,11 @@ const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data __initconst =
 	imx_fsl_usb2_udc_data_entry_single(MX35);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
+#ifdef CONFIG_SOC_IMX51
+const struct imx_fsl_usb2_udc_data imx51_fsl_usb2_udc_data __initconst =
+	imx_fsl_usb2_udc_data_entry_single(MX51);
+#endif
+
 struct platform_device *__init imx_add_fsl_usb2_udc(
 		const struct imx_fsl_usb2_udc_data *data,
 		const struct fsl_usb2_platform_data *pdata)
-- 
1.7.5.4
