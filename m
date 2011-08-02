From: tony.lin@freescale.com (Tony Lin)
Date: Tue, 2 Aug 2011 16:39:45 +0800
Subject: [PATCH v4 6/7] ARM: mxs: add usb platform operations
In-Reply-To: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
References: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1312274386-6833-7-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add usb phy register definitions and functions
usb host driver will use these callback functions
to initialize usb phy and change working mode

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 arch/arm/mach-mxs/Kconfig                 |    1 +
 arch/arm/mach-mxs/devices-mx28.h          |    4 +
 arch/arm/mach-mxs/devices/Kconfig         |    3 +
 arch/arm/mach-mxs/devices/Makefile        |    1 +
 arch/arm/mach-mxs/devices/platform-usb.c  |   96 +++++++++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/hardware.h |    2 +
 arch/arm/mach-mxs/include/mach/mx23.h     |    8 +-
 arch/arm/mach-mxs/include/mach/mxs.h      |   12 +++-
 arch/arm/mach-mxs/mach-mx28evk.c          |   11 +++
 9 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 4cd0231..1b11e79 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -48,6 +48,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_FLEXCAN
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
+	select MXS_HAVE_PLATFORM_USB
 	select MXS_OCOTP
 	help
 	  Include support for MX28EVK platform. This includes specific
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 79b9452..b4dc758 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -43,5 +43,9 @@ extern const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst;
 
 #define mx28_add_mxs_pwm(id)		mxs_add_mxs_pwm(MX28_PWM_BASE_ADDR, id)
 
+extern const struct mxs_usbh_data mx28_mxs_usbh_data[] __initconst;
+#define mx28_add_mxs_usbh(id, pdata) \
+	mxs_add_mxs_usbh(&mx28_mxs_usbh_data[id], pdata)
+
 struct platform_device *__init mx28_add_mxsfb(
 		const struct mxsfb_platform_data *pdata);
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index acf9eea..8c0f6fa 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -23,3 +23,6 @@ config MXS_HAVE_PLATFORM_MXS_PWM
 
 config MXS_HAVE_PLATFORM_MXSFB
 	bool
+
+config MXS_HAVE_PLATFORM_USB
+	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 351915c..a964bc9 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_MMC) += platform-mxs-mmc.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
 obj-y += platform-gpio-mxs.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXSFB) += platform-mxsfb.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_USB) += platform-usb.o
diff --git a/arch/arm/mach-mxs/devices/platform-usb.c b/arch/arm/mach-mxs/devices/platform-usb.c
new file mode 100644
index 0000000..b9119ff
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-usb.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/fsl_devices.h>
+
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+#define mxs_usbh_data_entry_single(soc, _id, hwid)			\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _USBCTRL ## hwid ## _BASE_ADDR,	\
+		.phy_iobase = soc ## _USBPHY ## hwid ## _BASE_ADDR,	\
+		.irq = soc ## _INT_USB ## hwid,				\
+	}
+
+#define mxs_usbh_data_entry(soc, _id, hwid)				\
+	[_id] = mxs_usbh_data_entry_single(soc, _id, hwid)
+
+#ifdef CONFIG_SOC_IMX23
+const struct mxs_usbh_data mx23_mxs_usbh_data[] __initconst = {
+	mxs_usbh_data_entry(MX23, 0, 0),
+};
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_usbh_data mx28_mxs_usbh_data[] __initconst = {
+	mxs_usbh_data_entry(MX28, 0, 0),
+	mxs_usbh_data_entry(MX28, 1, 1),
+};
+#endif
+
+struct platform_device *__init mxs_add_mxs_usbh(
+		const struct mxs_usbh_data *data,
+		struct mxc_usbh_platform_data *pdata)
+{
+	struct mxs_usb_private_date *usbh_private;
+	struct platform_device *pdev;
+	struct resource res[] = {
+		{
+			.start	= data->iobase,
+			.end	= data->iobase + SZ_64K - 1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.start	= data->irq,
+			.end	= data->irq,
+			.flags	= IORESOURCE_IRQ,
+		},
+	};
+
+	usbh_private = kmalloc(sizeof(*usbh_private), GFP_KERNEL);
+	if (!usbh_private)
+		return NULL;
+
+	usbh_private->phy_regs = ioremap(data->phy_iobase, SZ_8K);
+	usbh_private->ctrl_regs = ioremap(data->iobase, SZ_64K);
+	if (!usbh_private->phy_regs || !usbh_private->ctrl_regs)
+		goto out;
+
+	if (data->id == 0)
+		usbh_private->usb_phy_clk = clk_get(NULL, "usb0_phy");
+	else if (data->id == 1)
+		usbh_private->usb_phy_clk = clk_get(NULL, "usb1_phy");
+	else
+		BUG();
+	if (IS_ERR(usbh_private->usb_phy_clk))
+		goto out;
+
+	pdata->priv = usbh_private;
+
+	pdev = mxs_add_platform_device_dmamask("mxc-ehci", data->id,
+					res, ARRAY_SIZE(res), pdata,
+					sizeof(*pdata), DMA_BIT_MASK(32));
+	if (pdev)
+		return pdev;
+
+out:
+	if (usbh_private->usb_phy_clk)
+		clk_put(usbh_private->usb_phy_clk);
+	if (usbh_private->phy_regs)
+		iounmap(usbh_private->phy_regs);
+	if (usbh_private->ctrl_regs)
+		iounmap(usbh_private->ctrl_regs);
+	kfree(usbh_private);
+
+	return NULL;
+}
diff --git a/arch/arm/mach-mxs/include/mach/hardware.h b/arch/arm/mach-mxs/include/mach/hardware.h
index 53e89a0..affa72b 100644
--- a/arch/arm/mach-mxs/include/mach/hardware.h
+++ b/arch/arm/mach-mxs/include/mach/hardware.h
@@ -26,4 +26,6 @@
 #define IOMEM(addr)	((void __force __iomem *)(addr))
 #endif
 
+#include "mxs.h"
+
 #endif /* __MACH_MXS_HARDWARE_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
index 599094b..7955b75 100644
--- a/arch/arm/mach-mxs/include/mach/mx23.h
+++ b/arch/arm/mach-mxs/include/mach/mx23.h
@@ -64,8 +64,8 @@
 #define MX23_AUART1_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x06c000)
 #define MX23_AUART2_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x06e000)
 #define MX23_DUART_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x070000)
-#define MX23_USBPHY_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x07c000)
-#define MX23_USBCTRL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x080000)
+#define MX23_USBPHY0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x07c000)
+#define MX23_USBCTRL0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x080000)
 #define MX23_DRAM_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x0e0000)
 
 #define MX23_IO_P2V(x)			MXS_IO_P2V(x)
@@ -89,8 +89,8 @@
 #define MX23_INT_SPDIF_ERROR		10
 #define MX23_INT_SAIF1_IRQ		10
 #define MX23_INT_SAIF2_IRQ		10
-#define MX23_INT_USB_CTRL		11
-#define MX23_INT_USB_WAKEUP		12
+#define MX23_INT_USB0			11
+#define MX23_INT_USB0_WAKEUP		12
 #define MX23_INT_GPMI_DMA		13
 #define MX23_INT_SSP1_DMA		14
 #define MX23_INT_SSP1_ERROR		15
diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index 35a89dd..0661e90 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -35,7 +35,17 @@
 		machine_is_mx28evk() ||					\
 		machine_is_tx28() ||					\
 		0)
-
+#define cpu_is_mx1()		0
+#define cpu_is_mx21()		0
+#define cpu_is_mx25()		0
+#define cpu_is_mx27()		0
+#define cpu_is_mx31()		0
+#define cpu_is_mx35()		0
+#define cpu_is_mx50()		0
+#define cpu_is_mx51()		0
+#define cpu_is_mx53()		0
+#define cpu_is_mx3()		(cpu_is_mx31() || cpu_is_mx35())
+#define cpu_is_mx2()		(cpu_is_mx21() || cpu_is_mx27())
 /*
  * IO addresses common to MXS-based
  */
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 680d6e4..29c2f29 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -27,6 +27,7 @@
 #include <mach/iomux-mx28.h>
 
 #include "devices-mx28.h"
+#include "usbh.h"
 
 #define MX28EVK_FLEXCAN_SWITCH	MXS_GPIO_NR(2, 13)
 #define MX28EVK_FEC_PHY_POWER	MXS_GPIO_NR(2, 15)
@@ -355,6 +356,14 @@ static struct mxs_mmc_platform_data mx28evk_mmc_pdata[] __initdata = {
 	},
 };
 
+static struct mxc_usbh_platform_data usbh_pdata __initdata = {
+	.init = fsl_usb_host_init,
+	.exit = fsl_usb_host_uninit,
+	.portsc = MXC_EHCI_MODE_ULPI,
+	.otg = NULL,
+	.plt_irq_handler = fsl_plt_usbh_irq_handler,
+};
+
 static void __init mx28evk_init(void)
 {
 	int ret;
@@ -412,6 +421,8 @@ static void __init mx28evk_init(void)
 			       "usb1-power-en");
 	if (ret)
 		pr_warn("failed to request gpio usb1-power-en %d\n", ret);
+	mx28_add_mxs_usbh(1, &usbh_pdata);
+
 	gpio_led_register_device(0, &mx28evk_led_data);
 }
 
-- 
1.7.0.4
