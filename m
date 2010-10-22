From: Dinh.Nguyen@freescale.com (Dinh.Nguyen at freescale.com)
Date: Fri, 22 Oct 2010 11:56:14 -0500
Subject: [PATCHv5 2/3] ARM: imx: Add gpio-keys to plat-mxc
In-Reply-To: <1287766575-4092-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1287766575-4092-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <1287766575-4092-2-git-send-email-Dinh.Nguyen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <Dinh.Nguyen@freescale.com>

Add imx_add_gpio_keys function to add gpio-keys in plat-mxc

This patch is based on Sascha Hauer's imx/linux-2.6 for-rmk tree.

Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
---
 arch/arm/plat-mxc/devices/Kconfig               |    4 +++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-gpio_keys.c  |   27 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    4 +++
 arch/arm/plat-mxc/include/mach/iomux-mx51.h     |    2 +-
 5 files changed, 37 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-gpio_keys.c

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 4047994..f4772e7 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -9,6 +9,10 @@ config IMX_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN
 	bool
 
+config IMX_HAVE_PLATFORM_GPIO_KEYS
+	bool
+	default y if ARCH_MX51
+	
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 0a3c1f0..45aefeb 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_IMX_HAVE_PLATFORM_ESDHC) += platform-esdhc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
 obj-y += platform-imx-dma.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
diff --git a/arch/arm/plat-mxc/devices/platform-gpio_keys.c b/arch/arm/plat-mxc/devices/platform-gpio_keys.c
new file mode 100644
index 0000000..1c53a53
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-gpio_keys.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
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
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ * Boston, MA  02110-1301, USA.
+ */
+#include <asm/sizes.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+struct platform_device *__init imx_add_gpio_keys(
+		const struct gpio_keys_platform_data *pdata)
+{
+	return imx_add_platform_device("gpio-keys", -1, NULL,
+		 0, pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 86d7575..8c6896f 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -29,6 +29,10 @@ struct platform_device *__init imx_add_flexcan(int id,
 		resource_size_t irq,
 		const struct flexcan_platform_data *pdata);
 
+#include <linux/gpio_keys.h>
+struct platform_device *__init imx_add_gpio_keys(
+		const struct gpio_keys_platform_data *pdata);
+
 #include <mach/i2c.h>
 struct imx_imx_i2c_data {
 	int id;
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index e46b1c2..7ae27e8 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -114,7 +114,7 @@ typedef enum iomux_config {
 #define MX51_PAD_EIM_A24__GPIO_2_18             IOMUX_PAD(0x450, 0x0bc, 1, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_EIM_A25__GPIO_2_19             IOMUX_PAD(0x454, 0x0c0, 1, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_EIM_A26__GPIO_2_20             IOMUX_PAD(0x458, 0x0c4, 1, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_EIM_A27__GPIO_2_21             IOMUX_PAD(0x45c, 0x0c8, 1, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_EIM_A27__GPIO_2_21             IOMUX_PAD(0x45c, 0x0c8, 1, 0x0,   0, MX51_GPIO_PAD_CTRL | PAD_CTL_PUS_100K_UP)
 #define MX51_PAD_EIM_EB0__EIM_EB0               IOMUX_PAD(0x460, 0x0cc, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_EIM_EB1__EIM_EB1               IOMUX_PAD(0x464, 0x0d0, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_EIM_EB2__GPIO_2_22             IOMUX_PAD(0x468, 0x0d4, 1, 0x0,   0, NO_PAD_CTRL)
-- 
1.6.0.4
