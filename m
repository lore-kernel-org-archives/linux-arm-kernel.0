From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 Aug 2012 00:09:59 -0700
Subject: [PATCH 1/2] ARM: tegra: remove dead code
Message-ID: <1346137800-7448-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Now that all boards are converted to device tree, devices.[ch] and
board-pinmux.[ch] are no longer used. So, remove them.

The only exception is the EHCI platform data in devices.h. Move that
data to board-dt-tegra20.c - the only places it's used.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
These patches are both destined for Tegra's for-3.7/board-removal branch.

 arch/arm/mach-tegra/Makefile           |    2 -
 arch/arm/mach-tegra/board-dt-tegra20.c |   27 +-
 arch/arm/mach-tegra/board-pinmux.c     |   87 ----
 arch/arm/mach-tegra/board-pinmux.h     |   54 ---
 arch/arm/mach-tegra/devices.c          |  701 --------------------------------
 arch/arm/mach-tegra/devices.h          |   60 ---
 6 files changed, 26 insertions(+), 905 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-pinmux.c
 delete mode 100644 arch/arm/mach-tegra/board-pinmux.h
 delete mode 100644 arch/arm/mach-tegra/devices.c
 delete mode 100644 arch/arm/mach-tegra/devices.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index b94858f..90a40c3 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,6 +1,4 @@
-obj-y                                   += board-pinmux.o
 obj-y                                   += common.o
-obj-y                                   += devices.o
 obj-y                                   += io.o
 obj-y                                   += irq.o
 obj-y                                   += clock.o
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index d9eeae6..30f8036 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -28,6 +28,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pda_power.h>
+#include <linux/platform_data/tegra_usb.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-tegra.h>
@@ -40,11 +41,35 @@
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
+#include <mach/usb_phy.h>
 
 #include "board.h"
 #include "board-harmony.h"
 #include "clock.h"
-#include "devices.h"
+
+struct tegra_ehci_platform_data tegra_ehci1_pdata = {
+	.operating_mode = TEGRA_USB_OTG,
+	.power_down_on_bus_suspend = 1,
+	.vbus_gpio = -1,
+};
+
+struct tegra_ulpi_config tegra_ehci2_ulpi_phy_config = {
+	.reset_gpio = -1,
+	.clk = "cdev2",
+};
+
+struct tegra_ehci_platform_data tegra_ehci2_pdata = {
+	.phy_config = &tegra_ehci2_ulpi_phy_config,
+	.operating_mode = TEGRA_USB_HOST,
+	.power_down_on_bus_suspend = 1,
+	.vbus_gpio = -1,
+};
+
+struct tegra_ehci_platform_data tegra_ehci3_pdata = {
+	.operating_mode = TEGRA_USB_HOST,
+	.power_down_on_bus_suspend = 1,
+	.vbus_gpio = -1,
+};
 
 struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
diff --git a/arch/arm/mach-tegra/board-pinmux.c b/arch/arm/mach-tegra/board-pinmux.c
deleted file mode 100644
index a5574c7..0000000
--- a/arch/arm/mach-tegra/board-pinmux.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * Copyright (c) 2011,2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/notifier.h>
-#include <linux/string.h>
-
-#include "board-pinmux.h"
-#include "devices.h"
-
-unsigned long tegra_pincfg_pullnone_driven[2] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_NONE),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_DRIVEN),
-};
-
-unsigned long tegra_pincfg_pullnone_tristate[2] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_NONE),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_TRISTATE),
-};
-
-unsigned long tegra_pincfg_pullnone_na[1] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_NONE),
-};
-
-unsigned long tegra_pincfg_pullup_driven[2] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_UP),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_DRIVEN),
-};
-
-unsigned long tegra_pincfg_pullup_tristate[2] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_UP),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_TRISTATE),
-};
-
-unsigned long tegra_pincfg_pullup_na[1] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_UP),
-};
-
-unsigned long tegra_pincfg_pulldown_driven[2] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_DOWN),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_DRIVEN),
-};
-
-unsigned long tegra_pincfg_pulldown_tristate[2] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_DOWN),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_TRISTATE),
-};
-
-unsigned long tegra_pincfg_pulldown_na[1] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_DOWN),
-};
-
-unsigned long tegra_pincfg_pullna_driven[1] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_DRIVEN),
-};
-
-unsigned long tegra_pincfg_pullna_tristate[1] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_TRISTATE),
-};
-
-static struct platform_device *devices[] = {
-	&tegra_gpio_device,
-	&tegra_pinmux_device,
-};
-
-void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
-			     struct tegra_board_pinmux_conf *conf_b)
-{
-	if (conf_a)
-		pinctrl_register_mappings(conf_a->maps, conf_a->map_count);
-	if (conf_b)
-		pinctrl_register_mappings(conf_b->maps, conf_b->map_count);
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-}
diff --git a/arch/arm/mach-tegra/board-pinmux.h b/arch/arm/mach-tegra/board-pinmux.h
deleted file mode 100644
index c5f3f33..0000000
--- a/arch/arm/mach-tegra/board-pinmux.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Copyright (c) 2011,2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __MACH_TEGRA_BOARD_PINMUX_H
-#define __MACH_TEGRA_BOARD_PINMUX_H
-
-#include <linux/pinctrl/machine.h>
-
-#include <mach/pinconf-tegra.h>
-
-#define PINMUX_DEV "tegra20-pinctrl"
-
-#define TEGRA_MAP_MUX(_group_, _function_) \
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT(PINMUX_DEV, _group_, _function_)
-
-#define TEGRA_MAP_CONF(_group_, _pull_, _drive_) \
-	PIN_MAP_CONFIGS_GROUP_HOG_DEFAULT(PINMUX_DEV, _group_, tegra_pincfg_pull##_pull_##_##_drive_)
-
-#define TEGRA_MAP_MUXCONF(_group_, _function_, _pull_, _drive_) \
-	TEGRA_MAP_MUX(_group_, _function_), \
-	TEGRA_MAP_CONF(_group_, _pull_, _drive_)
-
-extern unsigned long tegra_pincfg_pullnone_driven[2];
-extern unsigned long tegra_pincfg_pullnone_tristate[2];
-extern unsigned long tegra_pincfg_pullnone_na[1];
-extern unsigned long tegra_pincfg_pullup_driven[2];
-extern unsigned long tegra_pincfg_pullup_tristate[2];
-extern unsigned long tegra_pincfg_pullup_na[1];
-extern unsigned long tegra_pincfg_pulldown_driven[2];
-extern unsigned long tegra_pincfg_pulldown_tristate[2];
-extern unsigned long tegra_pincfg_pulldown_na[1];
-extern unsigned long tegra_pincfg_pullna_driven[1];
-extern unsigned long tegra_pincfg_pullna_tristate[1];
-
-struct tegra_board_pinmux_conf {
-	struct pinctrl_map *maps;
-	int map_count;
-};
-
-void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
-			     struct tegra_board_pinmux_conf *conf_b);
-
-#endif
diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
deleted file mode 100644
index 61e9603..0000000
--- a/arch/arm/mach-tegra/devices.c
+++ /dev/null
@@ -1,701 +0,0 @@
-/*
- * Copyright (C) 2010,2011 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@android.com>
- *	Erik Gilling <ccross@android.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-
-#include <linux/resource.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/fsl_devices.h>
-#include <linux/serial_8250.h>
-#include <linux/i2c-tegra.h>
-#include <mach/irqs.h>
-#include <mach/iomap.h>
-#include <mach/dma.h>
-#include <mach/usb_phy.h>
-
-#include "gpio-names.h"
-#include "devices.h"
-
-static struct resource gpio_resource[] = {
-	[0] = {
-		.start	= TEGRA_GPIO_BASE,
-		.end	= TEGRA_GPIO_BASE + TEGRA_GPIO_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= INT_GPIO1,
-		.end	= INT_GPIO1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= INT_GPIO2,
-		.end	= INT_GPIO2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= INT_GPIO3,
-		.end	= INT_GPIO3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[4] = {
-		.start	= INT_GPIO4,
-		.end	= INT_GPIO4,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[5] = {
-		.start	= INT_GPIO5,
-		.end	= INT_GPIO5,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[6] = {
-		.start	= INT_GPIO6,
-		.end	= INT_GPIO6,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[7] = {
-		.start	= INT_GPIO7,
-		.end	= INT_GPIO7,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device tegra_gpio_device = {
-	.name		= "tegra-gpio",
-	.id		= -1,
-	.resource	= gpio_resource,
-	.num_resources	= ARRAY_SIZE(gpio_resource),
-};
-
-static struct resource pinmux_resource[] = {
-	[0] = {
-		/* Tri-state registers */
-		.start	= TEGRA_APB_MISC_BASE + 0x14,
-		.end	= TEGRA_APB_MISC_BASE + 0x20 + 3,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		/* Mux registers */
-		.start	= TEGRA_APB_MISC_BASE + 0x80,
-		.end	= TEGRA_APB_MISC_BASE + 0x9c + 3,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		/* Pull-up/down registers */
-		.start	= TEGRA_APB_MISC_BASE + 0xa0,
-		.end	= TEGRA_APB_MISC_BASE + 0xb0 + 3,
-		.flags	= IORESOURCE_MEM,
-	},
-	[3] = {
-		/* Pad control registers */
-		.start	= TEGRA_APB_MISC_BASE + 0x868,
-		.end	= TEGRA_APB_MISC_BASE + 0x90c + 3,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device tegra_pinmux_device = {
-	.name		= "tegra20-pinctrl",
-	.id		= -1,
-	.resource	= pinmux_resource,
-	.num_resources	= ARRAY_SIZE(pinmux_resource),
-};
-
-static struct resource i2c_resource1[] = {
-	[0] = {
-		.start	= INT_I2C,
-		.end	= INT_I2C,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_I2C_BASE,
-		.end	= TEGRA_I2C_BASE + TEGRA_I2C_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource i2c_resource2[] = {
-	[0] = {
-		.start	= INT_I2C2,
-		.end	= INT_I2C2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_I2C2_BASE,
-		.end	= TEGRA_I2C2_BASE + TEGRA_I2C2_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource i2c_resource3[] = {
-	[0] = {
-		.start	= INT_I2C3,
-		.end	= INT_I2C3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_I2C3_BASE,
-		.end	= TEGRA_I2C3_BASE + TEGRA_I2C3_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource i2c_resource4[] = {
-	[0] = {
-		.start	= INT_DVC,
-		.end	= INT_DVC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_DVC_BASE,
-		.end	= TEGRA_DVC_BASE + TEGRA_DVC_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct tegra_i2c_platform_data tegra_i2c1_platform_data = {
-	.bus_clk_rate   = 400000,
-};
-
-static struct tegra_i2c_platform_data tegra_i2c2_platform_data = {
-	.bus_clk_rate   = 400000,
-};
-
-static struct tegra_i2c_platform_data tegra_i2c3_platform_data = {
-	.bus_clk_rate   = 400000,
-};
-
-static struct tegra_i2c_platform_data tegra_dvc_platform_data = {
-	.bus_clk_rate   = 400000,
-};
-
-struct platform_device tegra_i2c_device1 = {
-	.name		= "tegra-i2c",
-	.id		= 0,
-	.resource	= i2c_resource1,
-	.num_resources	= ARRAY_SIZE(i2c_resource1),
-	.dev = {
-		.platform_data = &tegra_i2c1_platform_data,
-	},
-};
-
-struct platform_device tegra_i2c_device2 = {
-	.name		= "tegra-i2c",
-	.id		= 1,
-	.resource	= i2c_resource2,
-	.num_resources	= ARRAY_SIZE(i2c_resource2),
-	.dev = {
-		.platform_data = &tegra_i2c2_platform_data,
-	},
-};
-
-struct platform_device tegra_i2c_device3 = {
-	.name		= "tegra-i2c",
-	.id		= 2,
-	.resource	= i2c_resource3,
-	.num_resources	= ARRAY_SIZE(i2c_resource3),
-	.dev = {
-		.platform_data = &tegra_i2c3_platform_data,
-	},
-};
-
-struct platform_device tegra_i2c_device4 = {
-	.name		= "tegra-i2c",
-	.id		= 3,
-	.resource	= i2c_resource4,
-	.num_resources	= ARRAY_SIZE(i2c_resource4),
-	.dev = {
-		.platform_data = &tegra_dvc_platform_data,
-	},
-};
-
-static struct resource spi_resource1[] = {
-	[0] = {
-		.start	= INT_S_LINK1,
-		.end	= INT_S_LINK1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_SPI1_BASE,
-		.end	= TEGRA_SPI1_BASE + TEGRA_SPI1_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource spi_resource2[] = {
-	[0] = {
-		.start	= INT_SPI_2,
-		.end	= INT_SPI_2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_SPI2_BASE,
-		.end	= TEGRA_SPI2_BASE + TEGRA_SPI2_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource spi_resource3[] = {
-	[0] = {
-		.start	= INT_SPI_3,
-		.end	= INT_SPI_3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_SPI3_BASE,
-		.end	= TEGRA_SPI3_BASE + TEGRA_SPI3_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource spi_resource4[] = {
-	[0] = {
-		.start	= INT_SPI_4,
-		.end	= INT_SPI_4,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_SPI4_BASE,
-		.end	= TEGRA_SPI4_BASE + TEGRA_SPI4_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device tegra_spi_device1 = {
-	.name		= "spi_tegra",
-	.id		= 0,
-	.resource	= spi_resource1,
-	.num_resources	= ARRAY_SIZE(spi_resource1),
-	.dev		= {
-		.coherent_dma_mask	= 0xffffffff,
-	},
-};
-
-struct platform_device tegra_spi_device2 = {
-	.name		= "spi_tegra",
-	.id		= 1,
-	.resource	= spi_resource2,
-	.num_resources	= ARRAY_SIZE(spi_resource2),
-	.dev		= {
-		.coherent_dma_mask	= 0xffffffff,
-	},
-};
-
-struct platform_device tegra_spi_device3 = {
-	.name		= "spi_tegra",
-	.id		= 2,
-	.resource	= spi_resource3,
-	.num_resources	= ARRAY_SIZE(spi_resource3),
-	.dev		= {
-		.coherent_dma_mask	= 0xffffffff,
-	},
-};
-
-struct platform_device tegra_spi_device4 = {
-	.name		= "spi_tegra",
-	.id		= 3,
-	.resource	= spi_resource4,
-	.num_resources	= ARRAY_SIZE(spi_resource4),
-	.dev		= {
-		.coherent_dma_mask	= 0xffffffff,
-	},
-};
-
-
-static struct resource sdhci_resource1[] = {
-	[0] = {
-		.start	= INT_SDMMC1,
-		.end	= INT_SDMMC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_SDMMC1_BASE,
-		.end	= TEGRA_SDMMC1_BASE + TEGRA_SDMMC1_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource sdhci_resource2[] = {
-	[0] = {
-		.start	= INT_SDMMC2,
-		.end	= INT_SDMMC2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_SDMMC2_BASE,
-		.end	= TEGRA_SDMMC2_BASE + TEGRA_SDMMC2_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource sdhci_resource3[] = {
-	[0] = {
-		.start	= INT_SDMMC3,
-		.end	= INT_SDMMC3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_SDMMC3_BASE,
-		.end	= TEGRA_SDMMC3_BASE + TEGRA_SDMMC3_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource sdhci_resource4[] = {
-	[0] = {
-		.start	= INT_SDMMC4,
-		.end	= INT_SDMMC4,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= TEGRA_SDMMC4_BASE,
-		.end	= TEGRA_SDMMC4_BASE + TEGRA_SDMMC4_SIZE-1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-/* board files should fill in platform_data register the devices themselvs.
- * See board-harmony.c for an example
- */
-struct platform_device tegra_sdhci_device1 = {
-	.name		= "sdhci-tegra",
-	.id		= 0,
-	.resource	= sdhci_resource1,
-	.num_resources	= ARRAY_SIZE(sdhci_resource1),
-};
-
-struct platform_device tegra_sdhci_device2 = {
-	.name		= "sdhci-tegra",
-	.id		= 1,
-	.resource	= sdhci_resource2,
-	.num_resources	= ARRAY_SIZE(sdhci_resource2),
-};
-
-struct platform_device tegra_sdhci_device3 = {
-	.name		= "sdhci-tegra",
-	.id		= 2,
-	.resource	= sdhci_resource3,
-	.num_resources	= ARRAY_SIZE(sdhci_resource3),
-};
-
-struct platform_device tegra_sdhci_device4 = {
-	.name		= "sdhci-tegra",
-	.id		= 3,
-	.resource	= sdhci_resource4,
-	.num_resources	= ARRAY_SIZE(sdhci_resource4),
-};
-
-static struct resource tegra_usb1_resources[] = {
-	[0] = {
-		.start	= TEGRA_USB_BASE,
-		.end	= TEGRA_USB_BASE + TEGRA_USB_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= INT_USB,
-		.end	= INT_USB,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource tegra_usb2_resources[] = {
-	[0] = {
-		.start	= TEGRA_USB2_BASE,
-		.end	= TEGRA_USB2_BASE + TEGRA_USB2_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= INT_USB2,
-		.end	= INT_USB2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource tegra_usb3_resources[] = {
-	[0] = {
-		.start	= TEGRA_USB3_BASE,
-		.end	= TEGRA_USB3_BASE + TEGRA_USB3_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= INT_USB3,
-		.end	= INT_USB3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct tegra_ulpi_config tegra_ehci2_ulpi_phy_config = {
-	.reset_gpio = -1,
-	.clk = "cdev2",
-};
-
-struct tegra_ehci_platform_data tegra_ehci1_pdata = {
-	.operating_mode = TEGRA_USB_OTG,
-	.power_down_on_bus_suspend = 1,
-	.vbus_gpio = -1,
-};
-
-struct tegra_ehci_platform_data tegra_ehci2_pdata = {
-	.phy_config = &tegra_ehci2_ulpi_phy_config,
-	.operating_mode = TEGRA_USB_HOST,
-	.power_down_on_bus_suspend = 1,
-	.vbus_gpio = -1,
-};
-
-struct tegra_ehci_platform_data tegra_ehci3_pdata = {
-	.operating_mode = TEGRA_USB_HOST,
-	.power_down_on_bus_suspend = 1,
-	.vbus_gpio = -1,
-};
-
-static u64 tegra_ehci_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device tegra_ehci1_device = {
-	.name	= "tegra-ehci",
-	.id	= 0,
-	.dev	= {
-		.dma_mask	= &tegra_ehci_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &tegra_ehci1_pdata,
-	},
-	.resource = tegra_usb1_resources,
-	.num_resources = ARRAY_SIZE(tegra_usb1_resources),
-};
-
-struct platform_device tegra_ehci2_device = {
-	.name	= "tegra-ehci",
-	.id	= 1,
-	.dev	= {
-		.dma_mask	= &tegra_ehci_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &tegra_ehci2_pdata,
-	},
-	.resource = tegra_usb2_resources,
-	.num_resources = ARRAY_SIZE(tegra_usb2_resources),
-};
-
-struct platform_device tegra_ehci3_device = {
-	.name	= "tegra-ehci",
-	.id	= 2,
-	.dev	= {
-		.dma_mask	= &tegra_ehci_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &tegra_ehci3_pdata,
-	},
-	.resource = tegra_usb3_resources,
-	.num_resources = ARRAY_SIZE(tegra_usb3_resources),
-};
-
-static struct resource tegra_pmu_resources[] = {
-	[0] = {
-		.start	= INT_CPU0_PMU_INTR,
-		.end	= INT_CPU0_PMU_INTR,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start	= INT_CPU1_PMU_INTR,
-		.end	= INT_CPU1_PMU_INTR,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device tegra_pmu_device = {
-	.name		= "arm-pmu",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(tegra_pmu_resources),
-	.resource	= tegra_pmu_resources,
-};
-
-static struct resource tegra_uarta_resources[] = {
-	[0] = {
-		.start	= TEGRA_UARTA_BASE,
-		.end	= TEGRA_UARTA_BASE + TEGRA_UARTA_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= INT_UARTA,
-		.end	= INT_UARTA,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource tegra_uartb_resources[] = {
-	[0] = {
-		.start	= TEGRA_UARTB_BASE,
-		.end	= TEGRA_UARTB_BASE + TEGRA_UARTB_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= INT_UARTB,
-		.end	= INT_UARTB,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource tegra_uartc_resources[] = {
-	[0] = {
-		.start	= TEGRA_UARTC_BASE,
-		.end	= TEGRA_UARTC_BASE + TEGRA_UARTC_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= INT_UARTC,
-		.end	= INT_UARTC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource tegra_uartd_resources[] = {
-	[0] = {
-		.start	= TEGRA_UARTD_BASE,
-		.end	= TEGRA_UARTD_BASE + TEGRA_UARTD_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= INT_UARTD,
-		.end	= INT_UARTD,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource tegra_uarte_resources[] = {
-	[0] = {
-		.start	= TEGRA_UARTE_BASE,
-		.end	= TEGRA_UARTE_BASE + TEGRA_UARTE_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= INT_UARTE,
-		.end	= INT_UARTE,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device tegra_uarta_device = {
-	.name	= "tegra_uart",
-	.id	= 0,
-	.num_resources	= ARRAY_SIZE(tegra_uarta_resources),
-	.resource	= tegra_uarta_resources,
-	.dev	= {
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-struct platform_device tegra_uartb_device = {
-	.name	= "tegra_uart",
-	.id	= 1,
-	.num_resources	= ARRAY_SIZE(tegra_uartb_resources),
-	.resource	= tegra_uartb_resources,
-	.dev	= {
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-struct platform_device tegra_uartc_device = {
-	.name	= "tegra_uart",
-	.id	= 2,
-	.num_resources	= ARRAY_SIZE(tegra_uartc_resources),
-	.resource	= tegra_uartc_resources,
-	.dev	= {
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-struct platform_device tegra_uartd_device = {
-	.name	= "tegra_uart",
-	.id	= 3,
-	.num_resources	= ARRAY_SIZE(tegra_uartd_resources),
-	.resource	= tegra_uartd_resources,
-	.dev	= {
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-struct platform_device tegra_uarte_device = {
-	.name	= "tegra_uart",
-	.id	= 4,
-	.num_resources	= ARRAY_SIZE(tegra_uarte_resources),
-	.resource	= tegra_uarte_resources,
-	.dev	= {
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-static struct resource i2s_resource1[] = {
-	[0] = {
-		.start	= INT_I2S1,
-		.end	= INT_I2S1,
-		.flags	= IORESOURCE_IRQ
-	},
-	[1] = {
-		.start	= TEGRA_DMA_REQ_SEL_I2S_1,
-		.end	= TEGRA_DMA_REQ_SEL_I2S_1,
-		.flags	= IORESOURCE_DMA
-	},
-	[2] = {
-		.start	= TEGRA_I2S1_BASE,
-		.end	= TEGRA_I2S1_BASE + TEGRA_I2S1_SIZE - 1,
-		.flags	= IORESOURCE_MEM
-	}
-};
-
-static struct resource i2s_resource2[] = {
-	[0] = {
-		.start	= INT_I2S2,
-		.end	= INT_I2S2,
-		.flags	= IORESOURCE_IRQ
-	},
-	[1] = {
-		.start	= TEGRA_DMA_REQ_SEL_I2S2_1,
-		.end	= TEGRA_DMA_REQ_SEL_I2S2_1,
-		.flags	= IORESOURCE_DMA
-	},
-	[2] = {
-		.start	= TEGRA_I2S2_BASE,
-		.end	= TEGRA_I2S2_BASE + TEGRA_I2S2_SIZE - 1,
-		.flags	= IORESOURCE_MEM
-	}
-};
-
-struct platform_device tegra_i2s_device1 = {
-	.name		= "tegra20-i2s",
-	.id		= 0,
-	.resource	= i2s_resource1,
-	.num_resources	= ARRAY_SIZE(i2s_resource1),
-};
-
-struct platform_device tegra_i2s_device2 = {
-	.name		= "tegra20-i2s",
-	.id		= 1,
-	.resource	= i2s_resource2,
-	.num_resources	= ARRAY_SIZE(i2s_resource2),
-};
-
-static struct resource tegra_das_resources[] = {
-	[0] = {
-		.start = TEGRA_APB_MISC_DAS_BASE,
-		.end = TEGRA_APB_MISC_DAS_BASE + TEGRA_APB_MISC_DAS_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device tegra_das_device = {
-	.name		= "tegra20-das",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(tegra_das_resources),
-	.resource	= tegra_das_resources,
-};
diff --git a/arch/arm/mach-tegra/devices.h b/arch/arm/mach-tegra/devices.h
deleted file mode 100644
index 4f50527..0000000
--- a/arch/arm/mach-tegra/devices.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * Copyright (C) 2010,2011 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@android.com>
- *	Erik Gilling <ccross@android.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __MACH_TEGRA_DEVICES_H
-#define __MACH_TEGRA_DEVICES_H
-
-#include <linux/platform_device.h>
-#include <linux/platform_data/tegra_usb.h>
-
-#include <mach/usb_phy.h>
-
-extern struct tegra_ulpi_config tegra_ehci2_ulpi_phy_config;
-
-extern struct tegra_ehci_platform_data tegra_ehci1_pdata;
-extern struct tegra_ehci_platform_data tegra_ehci2_pdata;
-extern struct tegra_ehci_platform_data tegra_ehci3_pdata;
-
-extern struct platform_device tegra_gpio_device;
-extern struct platform_device tegra_pinmux_device;
-extern struct platform_device tegra_sdhci_device1;
-extern struct platform_device tegra_sdhci_device2;
-extern struct platform_device tegra_sdhci_device3;
-extern struct platform_device tegra_sdhci_device4;
-extern struct platform_device tegra_i2c_device1;
-extern struct platform_device tegra_i2c_device2;
-extern struct platform_device tegra_i2c_device3;
-extern struct platform_device tegra_i2c_device4;
-extern struct platform_device tegra_spi_device1;
-extern struct platform_device tegra_spi_device2;
-extern struct platform_device tegra_spi_device3;
-extern struct platform_device tegra_spi_device4;
-extern struct platform_device tegra_ehci1_device;
-extern struct platform_device tegra_ehci2_device;
-extern struct platform_device tegra_ehci3_device;
-extern struct platform_device tegra_uarta_device;
-extern struct platform_device tegra_uartb_device;
-extern struct platform_device tegra_uartc_device;
-extern struct platform_device tegra_uartd_device;
-extern struct platform_device tegra_uarte_device;
-extern struct platform_device tegra_pmu_device;
-extern struct platform_device tegra_i2s_device1;
-extern struct platform_device tegra_i2s_device2;
-extern struct platform_device tegra_das_device;
-
-#endif
-- 
1.7.9.5
