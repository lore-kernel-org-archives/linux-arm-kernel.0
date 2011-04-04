From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 4 Apr 2011 14:06:45 -0300
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
Message-ID: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/devices/Kconfig               |    3 +++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-gpio_leds.c  |   22 ++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    4 ++++
 4 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-gpio_leds.c

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index b9ab1d5..3d4f63c 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -13,6 +13,9 @@ config IMX_HAVE_PLATFORM_GPIO_KEYS
 	bool
 	default y if SOC_IMX51
 
+config IMX_HAVE_PLATFORM_GPIO_LEDS
+	bool
+
 config IMX_HAVE_PLATFORM_IMX21_HCD
 	bool
 	
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 75cd2ec..ceefca6 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_LEDS) += platform-gpio_leds.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMXDI_RTC) += platform-imxdi_rtc.o
diff --git a/arch/arm/plat-mxc/devices/platform-gpio_leds.c b/arch/arm/plat-mxc/devices/platform-gpio_leds.c
new file mode 100644
index 0000000..a430213
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-gpio_leds.c
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <asm/sizes.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+struct platform_device *__init imx_add_gpio_leds(
+		 const struct gpio_led_platform_data *pdata)
+{
+	return imx_add_platform_device("leds-gpio", -1, NULL,
+		 0, pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8658c9c..94ee936 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -57,6 +57,10 @@ struct platform_device *__init imx_add_fsl_usb2_udc(
 struct platform_device *__init imx_add_gpio_keys(
 		const struct gpio_keys_platform_data *pdata);
 
+#include <linux/leds.h>
+struct platform_device *__init imx_add_gpio_leds(
+		const struct gpio_led_platform_data *pdata);
+
 #include <mach/mx21-usbhost.h>
 struct imx_imx21_hcd_data {
 	resource_size_t iobase;
-- 
1.6.0.4
