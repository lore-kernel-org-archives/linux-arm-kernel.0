From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 23 Jun 2010 13:52:31 -0700 (PDT)
Subject: [PATCH] mx31_3ds: Allow selection between host/device modes on the
	OTG port
Message-ID: <343567.80487.qm@web51007.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow selection between host/device modes on the OTG port.

Selection is made via kernel command line option:

'otg_mode=host' or 'otg_mode=device'. Default mode is device.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |   38 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 7e8d09a..82ba957 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -29,6 +29,8 @@
 #include <linux/regulator/machine.h>
 #include <linux/fsl_devices.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -42,6 +44,8 @@
 #include <mach/iomux-mx3.h>
 #include <mach/mxc_nand.h>
 #include <mach/spi.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 #include "devices.h"
 
 /*!
@@ -220,6 +224,14 @@ usbotg_free_reset:
 	return err;
 }
 
+#if defined(CONFIG_USB_ULPI)
+static struct mxc_usbh_platform_data otg_pdata = {
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+#endif
+
 static struct fsl_usb2_platform_data usbotg_pdata = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_ULPI,
@@ -399,6 +411,20 @@ static void __init mx31_3ds_map_io(void)
 	iotable_init(mx31_3ds_io_desc, ARRAY_SIZE(mx31_3ds_io_desc));
 }
 
+static int otg_mode_host;
+
+static int __init mx31_3ds_otg_mode(char *options)
+{
+	if (!strcmp(options, "host"))
+		otg_mode_host = 1;
+	else if (!strcmp(options, "device"))
+		otg_mode_host = 0;
+	else
+		pr_info("otg_mode neither \"host\" nor \"device\". "
+			"Defaulting to device\n");
+	return 0;
+}
+__setup("otg_mode=", mx31_3ds_otg_mode);
 /*!
  * Board specific initialization.
  */
@@ -417,7 +443,17 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&imx_kpp_device, &mx31_3ds_keymap_data);
 
 	mx31_3ds_usbotg_init();
-	mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
+
+#if defined(CONFIG_USB_ULPI)
+	if (otg_mode_host) {
+		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+		mxc_register_device(&mxc_otg_host, &otg_pdata);
+	}
+#endif
+	if (!otg_mode_host)
+		mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
 
 	if (!mx31_3ds_init_expio())
 		platform_device_register(&smsc911x_device);
-- 
1.6.0.4




      
