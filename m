From: swarren@nvidia.com (Stephen Warren)
Date: Wed,  1 Feb 2012 16:29:56 -0700
Subject: [PATCH V2 1/2] ARM: tegra: Add pinmux board file for Cardhu
Message-ID: <1328138997-25665-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now, this just sets up the pinmux and GPIOs required for the SD
card slot.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2:
* Set PULL_UP for CMD and DATA pins on SD interface
* Add power GPIO for SDMMC1
* Add pinmux configuration for SDMMC4

This will hopefully be replaced by the pinmux DT binding in the near
future, but until that happens, Tegra30 pinmux functionality needs to
be exposed somehow to unblock getting drivers tested on Tegra30.
---
 arch/arm/mach-tegra/Makefile              |    1 +
 arch/arm/mach-tegra/board-cardhu-pinmux.c |   82 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-cardhu.h        |   29 ++++++++++
 arch/arm/mach-tegra/board-dt-tegra30.c    |   25 ++++++++-
 arch/arm/mach-tegra/board-pinmux.c        |    2 +-
 5 files changed, 137 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-cardhu-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-cardhu.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index b78bda8..49ff80c 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-cardhu-pinmux.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_TEGRA_SYSTEM_DMA)		+= dma.o apbio.o
diff --git a/arch/arm/mach-tegra/board-cardhu-pinmux.c b/arch/arm/mach-tegra/board-cardhu-pinmux.c
new file mode 100644
index 0000000..92e7ac6
--- /dev/null
+++ b/arch/arm/mach-tegra/board-cardhu-pinmux.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/kernel.h>
+
+#include <mach/gpio-tegra.h>
+
+#include "board-cardhu.h"
+#include "board-pinmux.h"
+
+static struct pinmux_map cardhu_map[] = {
+	TEGRA_PINMUX_MAP("sdmmc1_dat0_py7",   "sdmmc1"),
+	TEGRA_PINMUX_MAP("sdmmc1_dat1_py6",   "sdmmc1"),
+	TEGRA_PINMUX_MAP("sdmmc1_dat2_py5",   "sdmmc1"),
+	TEGRA_PINMUX_MAP("sdmmc1_dat3_py4",   "sdmmc1"),
+	TEGRA_PINMUX_MAP("sdmmc1_clk_pz0",    "sdmmc1"),
+	TEGRA_PINMUX_MAP("sdmmc1_cmd_pz1",    "sdmmc1"),
+	TEGRA_PINMUX_MAP("sdmmc4_dat0_paa0",  "sdmmc4"),
+	TEGRA_PINMUX_MAP("sdmmc4_dat1_paa1",  "sdmmc4"),
+	TEGRA_PINMUX_MAP("sdmmc4_dat2_paa2",  "sdmmc4"),
+	TEGRA_PINMUX_MAP("sdmmc4_dat3_paa3",  "sdmmc4"),
+	TEGRA_PINMUX_MAP("sdmmc4_dat4_paa4",  "sdmmc4"),
+	TEGRA_PINMUX_MAP("sdmmc4_dat5_paa5",  "sdmmc4"),
+	TEGRA_PINMUX_MAP("sdmmc4_dat6_paa6",  "sdmmc4"),
+	TEGRA_PINMUX_MAP("sdmmc4_dat7_paa7",  "sdmmc4"),
+	TEGRA_PINMUX_MAP("sdmmc4_rst_n_pcc3", "sdmmc4"),
+	TEGRA_PINMUX_MAP("sdmmc4_clk_pcc4",   "sdmmc4"),
+
+};
+
+struct tegra_board_pinmux_pg_conf cardhu_pg[] = {
+	{"sdmmc1_dat0_py7",   TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc1_dat1_py6",   TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc1_dat2_py5",   TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc1_dat3_py4",   TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc1_clk_pz0",    TEGRA_PINCONFIG_PULL_NONE, TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc1_cmd_pz1",    TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_dat0_paa0",  TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_dat1_paa1",  TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_dat2_paa2",  TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_dat3_paa3",  TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_dat4_paa4",  TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_dat5_paa5",  TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_dat6_paa6",  TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_dat7_paa7",  TEGRA_PINCONFIG_PULL_UP,   TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_rst_n_pcc3", TEGRA_PINCONFIG_PULL_NONE, TEGRA_PINCONFIG_DRIVEN},
+	{"sdmmc4_clk_pcc4",   TEGRA_PINCONFIG_PULL_NONE, TEGRA_PINCONFIG_DRIVEN},
+};
+
+static struct tegra_gpio_table gpio_table[] = {
+	{ .gpio = TEGRA_GPIO_SD1_CD,		.enable = true  },
+	{ .gpio = TEGRA_GPIO_SD1_WP,		.enable = true  },
+	{ .gpio = TEGRA_GPIO_SD1_POWER,		.enable = true  },
+};
+
+static struct tegra_board_pinmux_conf conf = {
+	.maps = cardhu_map,
+	.map_count = ARRAY_SIZE(cardhu_map),
+	.pgs = cardhu_pg,
+	.pg_count = ARRAY_SIZE(cardhu_pg),
+	.gpios = gpio_table,
+	.gpio_count = ARRAY_SIZE(gpio_table),
+};
+
+void cardhu_pinmux_init(void)
+{
+	tegra_board_pinmux_init(&conf, NULL);
+}
diff --git a/arch/arm/mach-tegra/board-cardhu.h b/arch/arm/mach-tegra/board-cardhu.h
new file mode 100644
index 0000000..0d8dd91
--- /dev/null
+++ b/arch/arm/mach-tegra/board-cardhu.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef _MACH_TEGRA_BOARD_CARDHU_H
+#define _MACH_TEGRA_BOARD_CARDHU_H
+
+#include "gpio-names.h"
+
+#define TEGRA_GPIO_SD1_CD		TEGRA_GPIO_PI5 /* GMI_IORDY */
+#define TEGRA_GPIO_SD1_WP		TEGRA_GPIO_PT3 /* VI_D11 */
+#define TEGRA_GPIO_SD1_POWER		TEGRA_GPIO_PD7 /* VI_HSYNC */
+
+void cardhu_pinmux_init(void);
+
+#endif
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index b4124b1..918cbbf 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -3,7 +3,7 @@
  *
  * NVIDIA Tegra30 device tree board support
  *
- * Copyright (C) 2011 NVIDIA Corporation
+ * Copyright (C) 2011-2012 NVIDIA Corporation
  *
  * Derived from:
  *
@@ -36,12 +36,16 @@
 #include "board.h"
 #include "clock.h"
 
+void cardhu_pinmux_init(void);
+
 static struct of_device_id tegra_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
 	{}
 };
 
 struct of_dev_auxdata tegra30_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("nvidia,tegra30-pinmux", 0x70000868, "tegra-pinmux", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-gpio", 0x6000d000, "tegra-gpio", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", 0x78000000, "sdhci-tegra.0", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", 0x78000200, "sdhci-tegra.1", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", 0x78000400, "sdhci-tegra.2", NULL),
@@ -60,10 +64,29 @@ static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
 	{ NULL,		NULL,		0,		0},
 };
 
+static struct {
+	char *machine;
+	void (*init)(void);
+} pinmux_configs[] = {
+	{ "nvidia,cardhu", cardhu_pinmux_init },
+};
+
 static void __init tegra30_dt_init(void)
 {
+	int i;
+
 	tegra_clk_init_from_table(tegra_dt_clk_init_table);
 
+	for (i = 0; i < ARRAY_SIZE(pinmux_configs); i++) {
+		if (of_machine_is_compatible(pinmux_configs[i].machine)) {
+			pinmux_configs[i].init();
+			break;
+		}
+	}
+
+	WARN(i == ARRAY_SIZE(pinmux_configs),
+		"Unknown platform! Pinmuxing not initialized\n");
+
 	of_platform_populate(NULL, tegra_dt_match_table,
 				tegra30_auxdata_lookup, NULL);
 }
diff --git a/arch/arm/mach-tegra/board-pinmux.c b/arch/arm/mach-tegra/board-pinmux.c
index 4e18e14..0e145b6 100644
--- a/arch/arm/mach-tegra/board-pinmux.c
+++ b/arch/arm/mach-tegra/board-pinmux.c
@@ -147,6 +147,6 @@ void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
 
 	bus_register_notifier(&platform_bus_type, &nb);
 
-	if (!of_machine_is_compatible("nvidia,tegra20"))
+	if (!of_have_populated_dt())
 		platform_add_devices(devices, ARRAY_SIZE(devices));
 }
-- 
1.7.0.4
