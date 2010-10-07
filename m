From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Thu,  7 Oct 2010 18:07:21 +0300
Subject: [PATCHv2 1/2] mx51: Move OTG initialisation for all boards to a
	single file
In-Reply-To: <cover.1286463146.git.amit.kucheria@linaro.org>
References: <cover.1286463146.git.amit.kucheria@linaro.org>
Message-ID: <e36487b7aeb3a70ad411456180ec5f245430e48a.1286463146.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OTG initialisation is the same for all MX51 boards currently known. Move
to a common file.

Fix the pll divider name while at it: MX51_USB_PLL_DIV_24_MHZ corresponds to
0x1, not MX51_USB_PLL_DIV_19_2_MHZ

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm/mach-mx5/Makefile             |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c     |   30 ++--------------------
 arch/arm/mach-mx5/board-mx51_babbage.c |   30 ++--------------------
 arch/arm/mach-mx5/usb.c                |   42 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/usb.h                |    1 +
 5 files changed, 50 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/mach-mx5/usb.c
 create mode 100644 arch/arm/mach-mx5/usb.h

diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 86c66e7..ac0d14c 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Object file lists.
-obj-y   := cpu.o mm.o clock-mx51.o devices.o
+obj-y   := cpu.o mm.o clock-mx51.o devices.o usb.o
 
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
 obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index a6c09c7..ff5d223 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -39,6 +39,7 @@
 
 #include "devices-imx51.h"
 #include "devices.h"
+#include "usb.h"
 
 #define CPUIMX51_USBH1_STP	(0*32 + 27)
 #define CPUIMX51_QUARTA_GPIO	(2*32 + 28)
@@ -56,10 +57,6 @@
 #define MX51_USB_CTRL_1_OFFSET		0x10
 #define MX51_USB_CTRL_UH1_EXT_CLK_EN	(1 << 25)
 
-#define	MX51_USB_PLLDIV_12_MHZ		0x00
-#define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
-#define	MX51_USB_PLL_DIV_24_MHZ		0x02
-
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
@@ -162,27 +159,6 @@ static struct i2c_board_info eukrea_cpuimx51_i2c_devices[] = {
 	},
 };
 
-/* This function is board specific as the bit mask for the plldiv will also
-be different for other Freescale SoCs, thus a common bitmask is not
-possible and cannot get place in /plat-mxc/ehci.c.*/
-static int initialize_otg_port(struct platform_device *pdev)
-{
-	u32 v;
-	void __iomem *usb_base;
-	void __iomem *usbother_base;
-
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
-	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
-
-	/* Set the PHY clock to 19.2MHz */
-	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
-	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
-	v |= MX51_USB_PLL_DIV_19_2_MHZ;
-	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
-	iounmap(usb_base);
-	return 0;
-}
-
 static int initialize_usbh1_port(struct platform_device *pdev)
 {
 	u32 v;
@@ -200,7 +176,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 }
 
 static struct mxc_usbh_platform_data dr_utmi_config = {
-	.init		= initialize_otg_port,
+	.init		= mx51_initialize_otg_port,
 	.portsc	= MXC_EHCI_UTMI_16BIT,
 	.flags	= MXC_EHCI_INTERNAL_PHY,
 };
@@ -262,7 +238,7 @@ static void __init eukrea_cpuimx51_init(void)
 	if (otg_mode_host)
 		mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
 	else {
-		initialize_otg_port(NULL);
+		mx51_initialize_otg_port(NULL);
 		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
 	}
 	mxc_register_device(&mxc_usbh1_device, &usbh1_config);
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 7c0b661..a84de02 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -32,6 +32,7 @@
 
 #include "devices-imx51.h"
 #include "devices.h"
+#include "usb.h"
 
 #define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
 #define BABBAGE_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
@@ -42,10 +43,6 @@
 #define MX51_USB_CTRL_1_OFFSET			0x10
 #define MX51_USB_CTRL_UH1_EXT_CLK_EN		(1 << 25)
 
-#define	MX51_USB_PLLDIV_12_MHZ		0x00
-#define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
-#define	MX51_USB_PLL_DIV_24_MHZ	0x02
-
 static struct platform_device *devices[] __initdata = {
 	&mxc_fec_device,
 };
@@ -210,27 +207,6 @@ static inline void babbage_fec_reset(void)
 	gpio_set_value(BABBAGE_FEC_PHY_RESET, 1);
 }
 
-/* This function is board specific as the bit mask for the plldiv will also
-be different for other Freescale SoCs, thus a common bitmask is not
-possible and cannot get place in /plat-mxc/ehci.c.*/
-static int initialize_otg_port(struct platform_device *pdev)
-{
-	u32 v;
-	void __iomem *usb_base;
-	void __iomem *usbother_base;
-
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
-	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
-
-	/* Set the PHY clock to 19.2MHz */
-	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
-	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
-	v |= MX51_USB_PLL_DIV_19_2_MHZ;
-	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
-	iounmap(usb_base);
-	return 0;
-}
-
 static int initialize_usbh1_port(struct platform_device *pdev)
 {
 	u32 v;
@@ -248,7 +224,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 }
 
 static struct mxc_usbh_platform_data dr_utmi_config = {
-	.init		= initialize_otg_port,
+	.init		= mx51_initialize_otg_port,
 	.portsc	= MXC_EHCI_UTMI_16BIT,
 	.flags	= MXC_EHCI_INTERNAL_PHY,
 };
@@ -299,7 +275,7 @@ static void __init mxc_board_init(void)
 	if (otg_mode_host)
 		mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
 	else {
-		initialize_otg_port(NULL);
+		mx51_initialize_otg_port(NULL);
 		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
 	}
 
diff --git a/arch/arm/mach-mx5/usb.c b/arch/arm/mach-mx5/usb.c
new file mode 100644
index 0000000..ebb7c3a
--- /dev/null
+++ b/arch/arm/mach-mx5/usb.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2010 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/mxc_ehci.h>
+
+#define	MX51_USB_PLL_DIV_24_MHZ	0x01
+
+/* This function is SoC-specific as the bit mask for the plldiv will also
+ * be different for other Freescale SoCs, thus a common bitmask is not
+ * possible and cannot get place in /plat-mxc/ehci.c.
+ */
+int mx51_initialize_otg_port(struct platform_device *pdev)
+{
+	u32 v;
+	void __iomem *usb_base;
+	void __iomem *usbother_base;
+
+	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	if (!usb_base) {
+		dev_err(&pdev->dev, "OTG ioremap failed\n");
+		return -ENOMEM;
+	}
+	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
+
+	/* Set the PHY clock to 24 MHz */
+	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
+	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
+	v |= MX51_USB_PLL_DIV_24_MHZ;
+	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
+	iounmap(usb_base);
+
+	return 0;
+}
diff --git a/arch/arm/mach-mx5/usb.h b/arch/arm/mach-mx5/usb.h
new file mode 100644
index 0000000..a1fc8d9
--- /dev/null
+++ b/arch/arm/mach-mx5/usb.h
@@ -0,0 +1 @@
+extern int mx51_initialize_otg_port(struct platform_device *pdev);
-- 
1.7.0.4
