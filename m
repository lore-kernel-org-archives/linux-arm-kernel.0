From: marex@denx.de (Marek Vasut)
Date: Tue, 15 May 2012 10:23:38 +0200
Subject: [PATCH 7/8] MXS: Add platform registration hooks for USB EHCI
In-Reply-To: <1337070219-3630-1-git-send-email-marex@denx.de>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
Message-ID: <1337070219-3630-8-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on code by:
Tony Lin <tony.lin@freescale.com>

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Liu JunJie-B08287 <B08287@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shi Make-B15407 <B15407@freescale.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/mach-mxs/devices-mx28.h                |    5 ++
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-usb.c        |   84 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   13 ++++
 5 files changed, 106 insertions(+)
 create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c

diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 9dbeae1..04a9120 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -11,6 +11,7 @@
 #include <mach/mx28.h>
 #include <mach/devices-common.h>
 #include <mach/mxsfb.h>
+#include <linux/usb/mxs-usb.h>
 
 extern const struct amba_device mx28_duart_device __initconst;
 #define mx28_add_duart() \
@@ -47,6 +48,10 @@ extern const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst;
 
 #define mx28_add_mxs_pwm(id)		mxs_add_mxs_pwm(MX28_PWM_BASE_ADDR, id)
 
+extern const struct mxs_usbh_data mx28_mxs_usbh_data[] __initconst;
+#define mx28_add_mxs_usbh(id, pdata) \
+	mxs_add_mxs_usbh(&mx28_mxs_usbh_data[id], pdata)
+
 struct platform_device *__init mx28_add_mxsfb(
 		const struct mxsfb_platform_data *pdata);
 
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index b8913df..f6709bc 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -32,3 +32,6 @@ config MXS_HAVE_PLATFORM_MXS_SAIF
 
 config MXS_HAVE_PLATFORM_RTC_STMP3XXX
 	bool
+
+config MXS_HAVE_PLATFORM_USB
+	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index c8f5c95..be4cc9e 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -11,3 +11,4 @@ obj-y += platform-gpio-mxs.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXSFB) += platform-mxsfb.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_SAIF) += platform-mxs-saif.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_RTC_STMP3XXX) += platform-rtc-stmp3xxx.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_USB) += platform-usb.o
diff --git a/arch/arm/mach-mxs/devices/platform-usb.c b/arch/arm/mach-mxs/devices/platform-usb.c
new file mode 100644
index 0000000..2477d56
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-usb.c
@@ -0,0 +1,84 @@
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
+#include <linux/usb/mxs-usb.h>
+
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+#define mxs_usbh_data_entry_single(soc, _id, hwid)			\
+	{								\
+		.id = _id,						\
+		.usb_irq = soc ## _INT_USB ## hwid,			\
+		.phy_irq = soc ## _INT_USB ## hwid ## _WAKEUP,		\
+		.usb_iobase = soc ## _USBCTRL ## hwid ## _BASE_ADDR,	\
+		.phy_iobase = soc ## _USBPHY ## hwid ## _BASE_ADDR,	\
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
+void __init mxs_add_mxs_usbh(const struct mxs_usbh_data *data,
+			const struct mxs_usb_platform_data *pdata)
+{
+	struct platform_device *pdev;
+	struct resource phy_res[] = {
+		{
+			.start	= data->phy_iobase,
+			.end	= data->phy_iobase + SZ_256 - 1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.start	= data->usb_irq,
+			.end	= data->usb_irq,
+			.flags	= IORESOURCE_IRQ,
+		},
+	};
+
+	struct resource usb_res[] = {
+		{
+			.start	= data->usb_iobase,
+			.end	= data->usb_iobase + SZ_64K - 1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.start	= data->usb_irq,
+			.end	= data->usb_irq,
+			.flags	= IORESOURCE_IRQ,
+		},
+	};
+
+	pdev = mxs_add_platform_device_dmamask("mxs-usb-phy", data->id,
+					phy_res, ARRAY_SIZE(phy_res),
+					pdata, sizeof(*pdata),
+					DMA_BIT_MASK(32));
+	if (!pdev)
+		pr_err("Failed to register USB PHY driver!\n");
+
+	pdev = mxs_add_platform_device_dmamask("mxs-usb", data->id,
+					usb_res, ARRAY_SIZE(usb_res),
+					NULL, 0, DMA_BIT_MASK(32));
+	if (!pdev)
+		pr_err("Failed to register CI13xxx driver!\n");
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index f2e3839..e1339ed 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -10,6 +10,8 @@
 #include <linux/platform_device.h>
 #include <linux/init.h>
 #include <linux/amba/bus.h>
+#include <linux/fsl_devices.h>
+#include <linux/usb/mxs-usb.h>
 
 extern struct device mxs_apbh_bus;
 
@@ -42,6 +44,17 @@ struct mxs_auart_data {
 struct platform_device *__init mxs_add_auart(
 		const struct mxs_auart_data *data);
 
+/* usb host */
+struct mxs_usbh_data {
+	int id;
+	resource_size_t usb_irq;
+	resource_size_t phy_irq;
+	resource_size_t usb_iobase;
+	resource_size_t phy_iobase;
+};
+void __init mxs_add_mxs_usbh(const struct mxs_usbh_data *data,
+			const struct mxs_usb_platform_data *pdata);
+
 /* fec */
 #include <linux/fec.h>
 struct mxs_fec_data {
-- 
1.7.10
