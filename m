From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 6 Dec 2011 18:43:14 +0800
Subject: [RFC PATCH 3/3] ARM: mx51: Create two usb phy platform drivers
In-Reply-To: <1323168194-24191-1-git-send-email-peter.chen@freescale.com>
References: <1323168194-24191-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1323168194-24191-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates two usb phy platform driver: utmi and ulpi.
And this code is to show how generic phy layer work, so I haven't
extracted all plat/mach code to mxc phy driver, and current change
can only work at i.mx51 bbg board

For further, It needs to refine this patch when going to mainline

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/mach-mx5/Kconfig                         |    4 +
 arch/arm/mach-mx5/board-mx51_babbage.c            |   33 ++++++-
 arch/arm/plat-mxc/Makefile                        |    1 +
 arch/arm/plat-mxc/devices/Kconfig                 |    6 +
 arch/arm/plat-mxc/devices/Makefile                |    2 +
 arch/arm/plat-mxc/devices/platform-fsl-phy-ulpi.c |   18 +++
 arch/arm/plat-mxc/devices/platform-fsl-phy-utmi.c |   18 +++
 arch/arm/plat-mxc/include/mach/devices-common.h   |    5 +
 arch/arm/plat-mxc/include/mach/mxc_phy.h          |   20 ++++
 arch/arm/plat-mxc/include/mach/ulpi.h             |   11 --
 arch/arm/plat-mxc/ulpi.c                          |  114 ++++++++++++++++++--
 arch/arm/plat-mxc/utmi.c                          |  121 +++++++++++++++++++++
 drivers/usb/otg/ulpi.c                            |   99 +++++++++---------
 13 files changed, 380 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index af0c212..b7c0449 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -67,6 +67,7 @@ config MACH_IMX51_DT
 
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
+	select MXC_ULPI if USB_ULPI
 	select SOC_IMX51
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
@@ -75,6 +76,9 @@ config MACH_MX51_BABBAGE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select IMX_HAVE_PLATFORM_USB_PHY_ULPI
+	select IMX_HAVE_PLATFORM_USB_PHY_UTMI
+	select USB_PHY
 	help
 	  Include support for MX51 Babbage platform, also known as MX51EVK in
 	  u-boot. This includes specific configurations for the board and its
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 5c83760..35453f3 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -23,6 +23,8 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
+#include <mach/ulpi.h>
+#include <mach/mxc_phy.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -243,6 +245,11 @@ be different for other Freescale SoCs, thus a common bitmask is not
 possible and cannot get place in /plat-mxc/ehci.c.*/
 static int initialize_otg_port(struct platform_device *pdev)
 {
+	return mx51_initialize_usb_hw(0, MXC_EHCI_INTERNAL_PHY);
+}
+
+static int mx51_utmi_init(void)
+{
 	u32 v;
 	void __iomem *usb_base;
 	void __iomem *usbother_base;
@@ -261,7 +268,8 @@ static int initialize_otg_port(struct platform_device *pdev)
 
 	mdelay(10);
 
-	return mx51_initialize_usb_hw(0, MXC_EHCI_INTERNAL_PHY);
+	/* Other UTMI phy setting, like wakeup, OC, etc */
+	return 0;
 }
 
 static int initialize_usbh1_port(struct platform_device *pdev)
@@ -291,6 +299,14 @@ static const struct mxc_usbh_platform_data dr_utmi_config __initconst = {
 	.portsc	= MXC_EHCI_UTMI_16BIT,
 };
 
+static int mx51_bbg_otg_set_vbus(bool on)
+{
+	/* don't needed at mx51 bbg since it is controlled by ID pin
+	 * automatically
+	 */
+	return 0;
+}
+
 static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
@@ -301,6 +317,18 @@ static const struct mxc_usbh_platform_data usbh1_config __initconst = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
 
+static const struct fsl_usb_phy_utmi_platform_data phy_utmi_pdata __initconst = {
+	.recv_name = "mxc-ehci.0",
+	.otg_set_vbus = mx51_bbg_otg_set_vbus,
+	.utmi_init	= mx51_utmi_init,
+	.flags 	= 0,
+};
+
+static const struct fsl_usb_phy_ulpi_platform_data phy_ulpi_pdata __initconst = {
+	.recv_name = "mxc-ehci.1",
+	.flags 	= 0,
+};
+
 static int otg_mode_host;
 
 static int __init babbage_otg_mode(char *options)
@@ -395,6 +423,9 @@ static void __init mx51_babbage_init(void)
 
 	gpio_usbh1_active();
 	imx51_add_mxc_ehci_hs(1, &usbh1_config);
+
+	imx_add_usb_phy_utmi(&phy_utmi_pdata);
+	imx_add_usb_phy_ulpi(&phy_ulpi_pdata);
 	/* setback USBH1_STP to be function */
 	mxc_iomux_v3_setup_pad(usbh1stp);
 	babbage_usbhub_reset();
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index b9f0f5f..f661bf4 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
 obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
+obj-$(CONFIG_MXC_ULPI) += utmi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index cb3e3ee..9cf482e 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -80,6 +80,12 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 config IMX_HAVE_PLATFORM_SPI_IMX
 	bool
 
+config IMX_HAVE_PLATFORM_USB_PHY_ULPI
+	bool
+
+config IMX_HAVE_PLATFORM_USB_PHY_UTMI
+	bool
+
 config IMX_HAVE_PLATFORM_AHCI
 	bool
 	default y if ARCH_MX53
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index c11ac84..f2f3d7c 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -27,3 +27,5 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_AHCI) +=  platform-ahci-imx.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_USB_PHY_ULPI) +=  platform-fsl-phy-ulpi.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_USB_PHY_UTMI) +=  platform-fsl-phy-utmi.o
diff --git a/arch/arm/plat-mxc/devices/platform-fsl-phy-ulpi.c b/arch/arm/plat-mxc/devices/platform-fsl-phy-ulpi.c
new file mode 100644
index 0000000..9ea6738
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-fsl-phy-ulpi.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Peter Chen <peter.chen@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/dma-mapping.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+struct platform_device *__init imx_add_usb_phy_ulpi(
+		const struct fsl_usb_phy_ulpi_platform_data *pdata)
+{
+	return imx_add_platform_device("imx-phy-ulpi", -1, NULL,
+		 0, pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/devices/platform-fsl-phy-utmi.c b/arch/arm/plat-mxc/devices/platform-fsl-phy-utmi.c
new file mode 100644
index 0000000..1f73a3f
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-fsl-phy-utmi.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Peter Chen <peter.chen@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/dma-mapping.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+struct platform_device *__init imx_add_usb_phy_utmi(
+		const struct fsl_usb_phy_utmi_platform_data *pdata)
+{
+	return imx_add_platform_device("imx-phy-utmi", -1, NULL,
+		 0, pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index def9ba5..cbb0d27 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -233,7 +233,12 @@ struct imx_mxc_ehci_data {
 struct platform_device *__init imx_add_mxc_ehci(
 		const struct imx_mxc_ehci_data *data,
 		const struct mxc_usbh_platform_data *pdata);
+#include <mach/mxc_phy.h>
+struct platform_device *__init imx_add_usb_phy_ulpi(
+		const struct fsl_usb_phy_ulpi_platform_data *pdata);
 
+struct platform_device *__init imx_add_usb_phy_utmi(
+		const struct fsl_usb_phy_utmi_platform_data *pdata);
 #include <mach/mmc.h>
 struct imx_mxc_mmc_data {
 	int id;
diff --git a/arch/arm/plat-mxc/include/mach/mxc_phy.h b/arch/arm/plat-mxc/include/mach/mxc_phy.h
new file mode 100644
index 0000000..821edaa
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/mxc_phy.h
@@ -0,0 +1,20 @@
+#ifndef __INCLUDE_ASM_ARCH_MXC_PHY_H
+#define __INCLUDE_ASM_ARCH_MXC_PHY_H
+
+#include <linux/usb/phy.h>
+struct fsl_usb_phy_ulpi_platform_data {
+#define MAX_NAME_LEN 16
+	/* the device name of related usb controller */
+	char recv_name[MAX_NAME_LEN];
+	u32	flags;
+};
+struct fsl_usb_phy_utmi_platform_data {
+#define MAX_NAME_LEN 16
+	/* the device name of related usb controller */
+	char recv_name[MAX_NAME_LEN];
+	u32	flags;
+	int (*otg_set_vbus)(bool on);
+	int (*utmi_init)(void);
+};
+#endif /* __INCLUDE_ASM_ARCH_MXC_PHY_H */
+
diff --git a/arch/arm/plat-mxc/include/mach/ulpi.h b/arch/arm/plat-mxc/include/mach/ulpi.h
index f9161c9..4c041ca 100644
--- a/arch/arm/plat-mxc/include/mach/ulpi.h
+++ b/arch/arm/plat-mxc/include/mach/ulpi.h
@@ -1,16 +1,5 @@
 #ifndef __MACH_ULPI_H
 #define __MACH_ULPI_H
 
-#ifdef CONFIG_USB_ULPI
-struct otg_transceiver *imx_otg_ulpi_create(unsigned int flags);
-#else
-static inline struct otg_transceiver *imx_otg_ulpi_create(unsigned int flags)
-{
-	return NULL;
-}
-#endif
-
-extern struct otg_io_access_ops mxc_ulpi_access_ops;
-
 #endif /* __MACH_ULPI_H */
 
diff --git a/arch/arm/plat-mxc/ulpi.c b/arch/arm/plat-mxc/ulpi.c
index 477e45b..8e08a20 100644
--- a/arch/arm/plat-mxc/ulpi.c
+++ b/arch/arm/plat-mxc/ulpi.c
@@ -16,15 +16,21 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  * MA  02110-1301, USA.
  */
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <linux/usb/otg.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/usb/phy.h>
 #include <linux/usb/ulpi.h>
 
-#include <mach/ulpi.h>
+#include <mach/mxc_phy.h>
+
+#include "../drivers/usb/otg/ulpi.c"
+
+#define	DRIVER_DESC	"i.MX USB Transceiver ULPI Driver"
+#define	DRIVER_AUTHOR	"Sascha Hauer/Daniel Mack"
 
 /* ULPIVIEW register bits */
 #define ULPIVW_WU		(1 << 31)	/* Wakeup */
@@ -40,6 +46,9 @@
 #define ULPIVW_WDATA_MASK	0xff	/* write data field */
 #define ULPIVW_WDATA_SHIFT	0
 
+static const char driver_name[] = "imx-phy-ulpi";
+static const char driver_desc[] = DRIVER_DESC;
+
 static int ulpi_poll(void __iomem *view, u32 bit)
 {
 	int timeout = 10000;
@@ -58,10 +67,10 @@ static int ulpi_poll(void __iomem *view, u32 bit)
 	return -ETIMEDOUT;
 }
 
-static int ulpi_read(struct otg_transceiver *otg, u32 reg)
+static int ulpi_read(struct usb_transceiver *xceiv, u32 reg)
 {
 	int ret;
-	void __iomem *view = otg->io_priv;
+	void __iomem *view = xceiv->io_priv;
 
 	/* make sure interface is running */
 	if (!(__raw_readl(view) & ULPIVW_SS)) {
@@ -84,10 +93,10 @@ static int ulpi_read(struct otg_transceiver *otg, u32 reg)
 	return (__raw_readl(view) >> ULPIVW_RDATA_SHIFT) & ULPIVW_RDATA_MASK;
 }
 
-static int ulpi_write(struct otg_transceiver *otg, u32 val, u32 reg)
+static int ulpi_write(struct usb_transceiver *xceiv, u32 val, u32 reg)
 {
 	int ret;
-	void __iomem *view = otg->io_priv;
+	void __iomem *view = xceiv->io_priv;
 
 	/* make sure the interface is running */
 	if (!(__raw_readl(view) & ULPIVW_SS)) {
@@ -106,13 +115,96 @@ static int ulpi_write(struct otg_transceiver *otg, u32 val, u32 reg)
 	return ulpi_poll(view, ULPIVW_RUN);
 }
 
-struct otg_io_access_ops mxc_ulpi_access_ops = {
+struct usb_xceiv_io_ops mxc_ulpi_access_ops = {
 	.read	= ulpi_read,
 	.write	= ulpi_write,
 };
-EXPORT_SYMBOL_GPL(mxc_ulpi_access_ops);
 
-struct otg_transceiver *imx_otg_ulpi_create(unsigned int flags)
+static int imx_ulpi_probe(struct platform_device *pdev)
+{
+	struct usb_transceiver *xceiv;
+	struct fsl_usb_phy_ulpi_platform_data *pdata = pdev->dev.platform_data;
+	int ret = 0;
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+	printk("%s", __func__);
+
+	xceiv = kzalloc(sizeof(*xceiv), GFP_KERNEL);
+	if (!xceiv)
+		return -ENOMEM;
+
+	xceiv->recv_name = kmalloc(sizeof(pdata->recv_name), GFP_KERNEL);
+	if (!xceiv->recv_name) {
+		ret = -ENOMEM;
+		goto out_of_mem;
+	}
+	strncpy(xceiv->recv_name, pdata->recv_name, sizeof(pdata->recv_name));
+
+	xceiv->flags	= pdata->flags;
+	xceiv->io_ops	= &mxc_ulpi_access_ops;
+	xceiv->interface = USB_XCEIV_ULPI;
+	xceiv->init	= ulpi_init;
+	xceiv->set_vbus	= ulpi_set_vbus;
+	
+	platform_set_drvdata(pdev, xceiv);
+
+	usb_register_transceiver(xceiv);
+
+out_of_mem:
+	return ret;
+}
+
+static int imx_ulpi_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	return 0;
+}
+
+static int imx_ulpi_resume(struct platform_device *pdev)
+{
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	return 0;
+}
+
+static int __exit imx_ulpi_remove(struct platform_device *pdev)
+{
+	struct usb_transceiver *xceiv = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	usb_unregister_transceiver(xceiv);
+
+	return 0;
+}
+
+static struct platform_driver ulpi_driver = {
+	.probe = imx_ulpi_probe,
+	.remove  = __exit_p(imx_ulpi_remove),
+	.suspend = imx_ulpi_suspend,
+	.resume  = imx_ulpi_resume,
+	.driver  = {
+		.name = (char *)driver_name,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init imx_ulpi_init(void)
 {
-	return otg_ulpi_create(&mxc_ulpi_access_ops, flags);
+	printk(KERN_INFO "%s Initilizes\n", driver_desc);
+	return platform_driver_register(&ulpi_driver);
 }
+
+module_init(imx_ulpi_init);
+
+static void __exit imx_ulpi_exit(void)
+{
+	platform_driver_unregister(&ulpi_driver);
+}
+
+module_exit(imx_ulpi_exit);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/plat-mxc/utmi.c b/arch/arm/plat-mxc/utmi.c
new file mode 100644
index 0000000..3735e54
--- /dev/null
+++ b/arch/arm/plat-mxc/utmi.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Peter Chen <peter.chen@freescale.com>
+
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301, USA.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/usb/phy.h>
+
+#include <mach/mxc_phy.h>
+
+
+#define	DRIVER_DESC	"i.MX USB Transceiver UTMI Driver"
+#define	DRIVER_AUTHOR	"Peter Chen"
+
+static const char driver_name[] = "imx-phy-utmi";
+static const char driver_desc[] = DRIVER_DESC;
+
+static int imx_utmi_probe(struct platform_device *pdev)
+{
+	struct usb_transceiver *xceiv;
+	struct fsl_usb_phy_utmi_platform_data *pdata = pdev->dev.platform_data;
+	int ret = 0;
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	xceiv = kzalloc(sizeof(*xceiv), GFP_KERNEL);
+	if (!xceiv)
+		return -ENOMEM;
+
+	xceiv->recv_name = kmalloc(sizeof(pdata->recv_name), GFP_KERNEL);
+	if (!xceiv->recv_name) {
+		ret = -ENOMEM;
+		goto out_of_mem;
+	}
+	strncpy(xceiv->recv_name, pdata->recv_name, sizeof(pdata->recv_name));
+
+	xceiv->flags	= pdata->flags;
+	xceiv->set_vbus	= pdata->otg_set_vbus;
+	xceiv->init	= pdata->utmi_init;
+	xceiv->interface = USB_XCEIV_UTMIPLUS;
+	
+	platform_set_drvdata(pdev, xceiv);
+
+	usb_register_transceiver(xceiv);
+
+out_of_mem:
+	return ret;
+}
+
+static int imx_utmi_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	return 0;
+}
+
+static int imx_utmi_resume(struct platform_device *pdev)
+{
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	return 0;
+}
+
+static int __exit imx_utmi_remove(struct platform_device *pdev)
+{
+	struct usb_transceiver *xceiv = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	usb_unregister_transceiver(xceiv);
+
+	return 0;
+}
+
+static struct platform_driver utmi_driver = {
+	.probe = imx_utmi_probe,
+	.remove  = __exit_p(imx_utmi_remove),
+	.suspend = imx_utmi_suspend,
+	.resume  = imx_utmi_resume,
+	.driver  = {
+		.name = (char *)driver_name,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init imx_utmi_init(void)
+{
+	printk(KERN_INFO "%s Initilizes\n", driver_desc);
+	return platform_driver_register(&utmi_driver);
+}
+
+module_init(imx_utmi_init);
+
+static void __exit imx_utmi_exit(void)
+{
+	platform_driver_unregister(&utmi_driver);
+}
+
+module_exit(imx_utmi_exit);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
index 0b04667..1254ca2 100644
--- a/drivers/usb/otg/ulpi.c
+++ b/drivers/usb/otg/ulpi.c
@@ -27,10 +27,10 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/usb.h>
+#include <linux/usb/phy.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
-
 struct ulpi_info {
 	unsigned int	id;
 	char		*name;
@@ -49,31 +49,31 @@ static struct ulpi_info ulpi_ids[] = {
 	ULPI_INFO(ULPI_ID(0x0424, 0x0006), "SMSC USB331x"),
 };
 
-static int ulpi_set_otg_flags(struct otg_transceiver *otg)
+static int ulpi_set_xceiv_flags(struct usb_transceiver *xceiv)
 {
 	unsigned int flags = ULPI_OTG_CTRL_DP_PULLDOWN |
 			     ULPI_OTG_CTRL_DM_PULLDOWN;
 
-	if (otg->flags & ULPI_OTG_ID_PULLUP)
+	if (xceiv->flags & ULPI_OTG_ID_PULLUP)
 		flags |= ULPI_OTG_CTRL_ID_PULLUP;
 
 	/*
 	 * ULPI Specification rev.1.1 default
 	 * for Dp/DmPulldown is enabled.
 	 */
-	if (otg->flags & ULPI_OTG_DP_PULLDOWN_DIS)
+	if (xceiv->flags & ULPI_OTG_DP_PULLDOWN_DIS)
 		flags &= ~ULPI_OTG_CTRL_DP_PULLDOWN;
 
-	if (otg->flags & ULPI_OTG_DM_PULLDOWN_DIS)
+	if (xceiv->flags & ULPI_OTG_DM_PULLDOWN_DIS)
 		flags &= ~ULPI_OTG_CTRL_DM_PULLDOWN;
 
-	if (otg->flags & ULPI_OTG_EXTVBUSIND)
+	if (xceiv->flags & ULPI_OTG_EXTVBUSIND)
 		flags |= ULPI_OTG_CTRL_EXTVBUSIND;
 
-	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
+	return xceiv_io_write(xceiv, flags, ULPI_OTG_CTRL);
 }
 
-static int ulpi_set_fc_flags(struct otg_transceiver *otg)
+static int ulpi_set_fc_flags(struct usb_transceiver *xceiv)
 {
 	unsigned int flags = 0;
 
@@ -81,27 +81,27 @@ static int ulpi_set_fc_flags(struct otg_transceiver *otg)
 	 * ULPI Specification rev.1.1 default
 	 * for XcvrSelect is Full Speed.
 	 */
-	if (otg->flags & ULPI_FC_HS)
+	if (xceiv->flags & ULPI_FC_HS)
 		flags |= ULPI_FUNC_CTRL_HIGH_SPEED;
-	else if (otg->flags & ULPI_FC_LS)
+	else if (xceiv->flags & ULPI_FC_LS)
 		flags |= ULPI_FUNC_CTRL_LOW_SPEED;
-	else if (otg->flags & ULPI_FC_FS4LS)
+	else if (xceiv->flags & ULPI_FC_FS4LS)
 		flags |= ULPI_FUNC_CTRL_FS4LS;
 	else
 		flags |= ULPI_FUNC_CTRL_FULL_SPEED;
 
-	if (otg->flags & ULPI_FC_TERMSEL)
+	if (xceiv->flags & ULPI_FC_TERMSEL)
 		flags |= ULPI_FUNC_CTRL_TERMSELECT;
 
 	/*
 	 * ULPI Specification rev.1.1 default
 	 * for OpMode is Normal Operation.
 	 */
-	if (otg->flags & ULPI_FC_OP_NODRV)
+	if (xceiv->flags & ULPI_FC_OP_NODRV)
 		flags |= ULPI_FUNC_CTRL_OPMODE_NONDRIVING;
-	else if (otg->flags & ULPI_FC_OP_DIS_NRZI)
+	else if (xceiv->flags & ULPI_FC_OP_DIS_NRZI)
 		flags |= ULPI_FUNC_CTRL_OPMODE_DISABLE_NRZI;
-	else if (otg->flags & ULPI_FC_OP_NSYNC_NEOP)
+	else if (xceiv->flags & ULPI_FC_OP_NSYNC_NEOP)
 		flags |= ULPI_FUNC_CTRL_OPMODE_NOSYNC_NOEOP;
 	else
 		flags |= ULPI_FUNC_CTRL_OPMODE_NORMAL;
@@ -112,54 +112,54 @@ static int ulpi_set_fc_flags(struct otg_transceiver *otg)
 	 */
 	flags |= ULPI_FUNC_CTRL_SUSPENDM;
 
-	return otg_io_write(otg, flags, ULPI_FUNC_CTRL);
+	return xceiv_io_write(xceiv, flags, ULPI_FUNC_CTRL);
 }
 
-static int ulpi_set_ic_flags(struct otg_transceiver *otg)
+static int ulpi_set_ic_flags(struct usb_transceiver *xceiv)
 {
 	unsigned int flags = 0;
 
-	if (otg->flags & ULPI_IC_AUTORESUME)
+	if (xceiv->flags & ULPI_IC_AUTORESUME)
 		flags |= ULPI_IFC_CTRL_AUTORESUME;
 
-	if (otg->flags & ULPI_IC_EXTVBUS_INDINV)
+	if (xceiv->flags & ULPI_IC_EXTVBUS_INDINV)
 		flags |= ULPI_IFC_CTRL_EXTERNAL_VBUS;
 
-	if (otg->flags & ULPI_IC_IND_PASSTHRU)
+	if (xceiv->flags & ULPI_IC_IND_PASSTHRU)
 		flags |= ULPI_IFC_CTRL_PASSTHRU;
 
-	if (otg->flags & ULPI_IC_PROTECT_DIS)
+	if (xceiv->flags & ULPI_IC_PROTECT_DIS)
 		flags |= ULPI_IFC_CTRL_PROTECT_IFC_DISABLE;
 
-	return otg_io_write(otg, flags, ULPI_IFC_CTRL);
+	return xceiv_io_write(xceiv, flags, ULPI_IFC_CTRL);
 }
 
-static int ulpi_set_flags(struct otg_transceiver *otg)
+static int ulpi_set_flags(struct usb_transceiver *xceiv)
 {
 	int ret;
 
-	ret = ulpi_set_otg_flags(otg);
+	ret = ulpi_set_xceiv_flags(xceiv);
 	if (ret)
 		return ret;
 
-	ret = ulpi_set_ic_flags(otg);
+	ret = ulpi_set_ic_flags(xceiv);
 	if (ret)
 		return ret;
 
-	return ulpi_set_fc_flags(otg);
+	return ulpi_set_fc_flags(xceiv);
 }
 
-static int ulpi_check_integrity(struct otg_transceiver *otg)
+static int ulpi_check_integrity(struct usb_transceiver *xceiv)
 {
 	int ret, i;
 	unsigned int val = 0x55;
 
 	for (i = 0; i < 2; i++) {
-		ret = otg_io_write(otg, val, ULPI_SCRATCH);
+		ret = xceiv_io_write(xceiv, val, ULPI_SCRATCH);
 		if (ret < 0)
 			return ret;
 
-		ret = otg_io_read(otg, ULPI_SCRATCH);
+		ret = xceiv_io_read(xceiv, ULPI_SCRATCH);
 		if (ret < 0)
 			return ret;
 
@@ -175,13 +175,13 @@ static int ulpi_check_integrity(struct otg_transceiver *otg)
 	return 0;
 }
 
-static int ulpi_init(struct otg_transceiver *otg)
+static int ulpi_init(struct usb_transceiver *xceiv)
 {
 	int i, vid, pid, ret;
 	u32 ulpi_id = 0;
 
 	for (i = 0; i < 4; i++) {
-		ret = otg_io_read(otg, ULPI_PRODUCT_ID_HIGH - i);
+		ret = xceiv_io_read(xceiv, ULPI_PRODUCT_ID_HIGH - i);
 		if (ret < 0)
 			return ret;
 		ulpi_id = (ulpi_id << 8) | ret;
@@ -199,55 +199,56 @@ static int ulpi_init(struct otg_transceiver *otg)
 		}
 	}
 
-	ret = ulpi_check_integrity(otg);
+	ret = ulpi_check_integrity(xceiv);
 	if (ret)
 		return ret;
 
-	return ulpi_set_flags(otg);
+	return ulpi_set_flags(xceiv);
 }
-
-static int ulpi_set_host(struct otg_transceiver *otg, struct usb_bus *host)
+/*
+static int ulpi_set_host(struct usb_transceiver *xceiv, struct usb_bus *host)
 {
-	unsigned int flags = otg_io_read(otg, ULPI_IFC_CTRL);
+	unsigned int flags = xceiv_io_read(xceiv, ULPI_IFC_CTRL);
 
 	if (!host) {
-		otg->host = NULL;
+		xceiv->otg->usb_bus = NULL;
 		return 0;
 	}
 
-	otg->host = host;
+	xceiv->otg->usb_bus = host;
 
 	flags &= ~(ULPI_IFC_CTRL_6_PIN_SERIAL_MODE |
 		   ULPI_IFC_CTRL_3_PIN_SERIAL_MODE |
 		   ULPI_IFC_CTRL_CARKITMODE);
 
-	if (otg->flags & ULPI_IC_6PIN_SERIAL)
+	if (xceiv->flags & ULPI_IC_6PIN_SERIAL)
 		flags |= ULPI_IFC_CTRL_6_PIN_SERIAL_MODE;
-	else if (otg->flags & ULPI_IC_3PIN_SERIAL)
+	else if (xceiv->flags & ULPI_IC_3PIN_SERIAL)
 		flags |= ULPI_IFC_CTRL_3_PIN_SERIAL_MODE;
-	else if (otg->flags & ULPI_IC_CARKIT)
+	else if (xceiv->flags & ULPI_IC_CARKIT)
 		flags |= ULPI_IFC_CTRL_CARKITMODE;
 
-	return otg_io_write(otg, flags, ULPI_IFC_CTRL);
+	return xceiv_io_write(xceiv, flags, ULPI_IFC_CTRL);
 }
+*/
 
-static int ulpi_set_vbus(struct otg_transceiver *otg, bool on)
+static int ulpi_set_vbus(struct usb_transceiver *xceiv, bool on)
 {
-	unsigned int flags = otg_io_read(otg, ULPI_OTG_CTRL);
+	unsigned int flags = xceiv_io_read(xceiv, ULPI_OTG_CTRL);
 
 	flags &= ~(ULPI_OTG_CTRL_DRVVBUS | ULPI_OTG_CTRL_DRVVBUS_EXT);
 
 	if (on) {
-		if (otg->flags & ULPI_OTG_DRVVBUS)
+		if (xceiv->flags & ULPI_OTG_DRVVBUS)
 			flags |= ULPI_OTG_CTRL_DRVVBUS;
 
-		if (otg->flags & ULPI_OTG_DRVVBUS_EXT)
+		if (xceiv->flags & ULPI_OTG_DRVVBUS_EXT)
 			flags |= ULPI_OTG_CTRL_DRVVBUS_EXT;
 	}
 
-	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
+	return xceiv_io_write(xceiv, flags, ULPI_OTG_CTRL);
 }
-
+/*
 struct otg_transceiver *
 otg_ulpi_create(struct otg_io_access_ops *ops,
 		unsigned int flags)
@@ -268,4 +269,4 @@ otg_ulpi_create(struct otg_io_access_ops *ops,
 	return otg;
 }
 EXPORT_SYMBOL_GPL(otg_ulpi_create);
-
+*/ 
-- 
1.6.3.3
