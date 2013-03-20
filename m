From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Mar 2013 22:39:12 -0300
Subject: [PATCH 1/2] ARM: mach-pca100: Add CONFIG_USB_ULPI dependency
Message-ID: <1363743553-17295-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit edc7cb2e955f (usb: phy: make it a menuconfig) CONFIG_USB_ULPI can 
only be enabled if CONFIG_USB_PHY is selected.

CONFIG_USB_ULPI is selected in the imx_v4_v5_defconfig, but CONFIG_USB_PHY is 
not, which causes the following error:

arch/arm/mach-imx/built-in.o: In function `pca100_init':
platform-mx2-emma.c:(.init.text+0x6788): undefined reference to `otg_ulpi_create'
platform-mx2-emma.c:(.init.text+0x682c): undefined reference to `mxc_ulpi_access_ops'

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-pca100.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index b8b15bb..aa4fffe 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -278,6 +278,7 @@ static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
 
+#if IS_ENABLED(CONFIG_USB_ULPI)
 static int usbh2_phy_init(struct platform_device *pdev)
 {
 	gpio_set_value(USBH2_PHY_CS_GPIO, 0);
@@ -291,6 +292,7 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.init	= usbh2_phy_init,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
+#endif
 
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
@@ -398,11 +400,13 @@ static void __init pca100_init(void)
 		imx27_add_fsl_usb2_udc(&otg_device_pdata);
 	}
 
+#if IS_ENABLED(CONFIG_USB_ULPI)
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	if (usbh2_pdata.otg)
 		imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
+#endif
 
 	imx27_add_imx_fb(&pca100_fb_data);
 
-- 
1.7.9.5
