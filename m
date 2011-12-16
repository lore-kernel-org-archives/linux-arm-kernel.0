From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 16 Dec 2011 15:12:31 -0700
Subject: [PATCH 8/9] arm/tegra: Refactor board-*-pinmux.c to share code
In-Reply-To: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
References: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
Message-ID: <1324073552-15542-9-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the implementation of *_pinmux_init() into a single location.
The board-specific pinmux data is left in each board's own file. This
will allow future changes that set up the pinmux in a more complex
fashion to do so without duplicating that code in each board's pinmux
file.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Makefile                 |    1 +
 arch/arm/mach-tegra/board-harmony-pinmux.c   |   22 ++++------
 arch/arm/mach-tegra/board-paz00-pinmux.c     |   22 ++++------
 arch/arm/mach-tegra/board-pinmux.c           |   52 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-pinmux.h           |   38 +++++++++++++++++++
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |   51 ++++++++++++-------------
 arch/arm/mach-tegra/board-trimslice-pinmux.c |   22 +++++------
 7 files changed, 144 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-pinmux.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index c9ec38e..92bf292 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,3 +1,4 @@
+obj-y                                   += board-pinmux.o
 obj-y                                   += common.o
 obj-y                                   += devices.o
 obj-y                                   += io.o
diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index 7a4a26d..5038f5b 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -22,7 +22,7 @@
 
 #include "gpio-names.h"
 #include "board-harmony.h"
-#include "devices.h"
+#include "board-pinmux.h"
 
 static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -143,11 +143,6 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
-static struct platform_device *pinmux_devices[] = {
-	&tegra_gpio_device,
-	&tegra_pinmux_device,
-};
-
 static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true	},
 	{ .gpio = TEGRA_GPIO_SD2_WP,		.enable = true	},
@@ -161,13 +156,14 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_EXT_MIC_EN,	.enable = true	},
 };
 
+static struct tegra_board_pinmux_conf conf = {
+	.pgs = harmony_pinmux,
+	.pg_count = ARRAY_SIZE(harmony_pinmux),
+	.gpios = gpio_table,
+	.gpio_count = ARRAY_SIZE(gpio_table),
+};
+
 void harmony_pinmux_init(void)
 {
-	if (!of_machine_is_compatible("nvidia,tegra20"))
-		platform_add_devices(pinmux_devices,
-					ARRAY_SIZE(pinmux_devices));
-
-	tegra_pinmux_config_table(harmony_pinmux, ARRAY_SIZE(harmony_pinmux));
-
-	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
+	tegra_board_pinmux_init(&conf, NULL);
 }
diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index 126892c..d6b37da 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -22,7 +22,7 @@
 
 #include "gpio-names.h"
 #include "board-paz00.h"
-#include "devices.h"
+#include "board-pinmux.h"
 
 static struct tegra_pingroup_config paz00_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -143,11 +143,6 @@ static struct tegra_pingroup_config paz00_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
-static struct platform_device *pinmux_devices[] = {
-	&tegra_gpio_device,
-	&tegra_pinmux_device,
-};
-
 static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD1_CD,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true },
@@ -158,13 +153,14 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_WIFI_LED,	.enable = true },
 };
 
+static struct tegra_board_pinmux_conf conf = {
+	.pgs = paz00_pinmux,
+	.pg_count = ARRAY_SIZE(paz00_pinmux),
+	.gpios = gpio_table,
+	.gpio_count = ARRAY_SIZE(gpio_table),
+};
+
 void paz00_pinmux_init(void)
 {
-	if (!of_machine_is_compatible("nvidia,tegra20"))
-		platform_add_devices(pinmux_devices,
-					ARRAY_SIZE(pinmux_devices));
-
-	tegra_pinmux_config_table(paz00_pinmux, ARRAY_SIZE(paz00_pinmux));
-
-	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
+	tegra_board_pinmux_init(&conf, NULL);
 }
diff --git a/arch/arm/mach-tegra/board-pinmux.c b/arch/arm/mach-tegra/board-pinmux.c
new file mode 100644
index 0000000..103ef65
--- /dev/null
+++ b/arch/arm/mach-tegra/board-pinmux.c
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2011, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/of.h>
+
+#include <mach/gpio-tegra.h>
+#include <mach/pinmux.h>
+
+#include "board-pinmux.h"
+#include "devices.h"
+
+static struct platform_device *devices[] = {
+	&tegra_gpio_device,
+	&tegra_pinmux_device,
+};
+
+void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
+			     struct tegra_board_pinmux_conf *conf_b)
+{
+	struct tegra_board_pinmux_conf *confs[] = {conf_a, conf_b};
+	int i;
+
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	for (i = 0; i < ARRAY_SIZE(confs); i++) {
+		if (!confs[i])
+			continue;
+
+		tegra_pinmux_config_table(confs[i]->pgs, confs[i]->pg_count);
+
+		if (confs[i]->drives)
+			tegra_drive_pinmux_config_table(confs[i]->drives,
+							confs[i]->drive_count);
+
+		tegra_gpio_config(confs[i]->gpios, confs[i]->gpio_count);
+	}
+
+	if (!of_machine_is_compatible("nvidia,tegra20"))
+		platform_add_devices(devices, ARRAY_SIZE(devices));
+}
diff --git a/arch/arm/mach-tegra/board-pinmux.h b/arch/arm/mach-tegra/board-pinmux.h
new file mode 100644
index 0000000..4aac735
--- /dev/null
+++ b/arch/arm/mach-tegra/board-pinmux.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) 2011, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_BOARD_PINMUX_H
+#define __MACH_TEGRA_BOARD_PINMUX_H
+
+#define GPIO_DEV "tegra-gpio"
+#define PINMUX_DEV "tegra-pinmux"
+
+struct tegra_pingroup_config;
+struct tegra_gpio_table;
+
+struct tegra_board_pinmux_conf {
+	struct tegra_pingroup_config *pgs;
+	int pg_count;
+
+	struct tegra_drive_pingroup_config *drives;
+	int drive_count;
+
+	struct tegra_gpio_table *gpios;
+	int gpio_count;
+};
+
+void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
+			     struct tegra_board_pinmux_conf *conf_b);
+
+#endif
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index 04cff83..af28fd3 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -22,8 +22,8 @@
 #include <mach/pinmux-t2.h>
 
 #include "gpio-names.h"
+#include "board-pinmux.h"
 #include "board-seaboard.h"
-#include "devices.h"
 
 #define DEFAULT_DRIVE(_name)					\
 	{							\
@@ -179,11 +179,6 @@ static __initdata struct tegra_pingroup_config ventana_pinmux[] = {
 	{TEGRA_PINGROUP_SPIG, TEGRA_MUX_SPI2_ALT, TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 };
 
-static struct platform_device *pinmux_devices[] = {
-	&tegra_gpio_device,
-	&tegra_pinmux_device,
-};
-
 static struct tegra_gpio_table common_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true },
 	{ .gpio = TEGRA_GPIO_SD2_WP,		.enable = true },
@@ -208,31 +203,35 @@ static struct tegra_gpio_table ventana_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_PX1,		.enable = true },
 };
 
-void __init seaboard_common_pinmux_init(void)
-{
-	if (!of_machine_is_compatible("nvidia,tegra20"))
-		platform_add_devices(pinmux_devices,
-					ARRAY_SIZE(pinmux_devices));
-
-	tegra_pinmux_config_table(common_pinmux, ARRAY_SIZE(common_pinmux));
+static struct tegra_board_pinmux_conf common_conf = {
+	.pgs = common_pinmux,
+	.pg_count = ARRAY_SIZE(common_pinmux),
+	.gpios = common_gpio_table,
+	.gpio_count = ARRAY_SIZE(common_gpio_table),
+};
 
-	tegra_drive_pinmux_config_table(seaboard_drive_pinmux,
-					ARRAY_SIZE(seaboard_drive_pinmux));
+static struct tegra_board_pinmux_conf seaboard_conf = {
+	.pgs = seaboard_pinmux,
+	.pg_count = ARRAY_SIZE(seaboard_pinmux),
+	.drives = seaboard_drive_pinmux,
+	.drive_count = ARRAY_SIZE(seaboard_drive_pinmux),
+	.gpios = seaboard_gpio_table,
+	.gpio_count = ARRAY_SIZE(seaboard_gpio_table),
+};
 
-	tegra_gpio_config(common_gpio_table, ARRAY_SIZE(common_gpio_table));
-}
+static struct tegra_board_pinmux_conf ventana_conf = {
+	.pgs = ventana_pinmux,
+	.pg_count = ARRAY_SIZE(ventana_pinmux),
+	.gpios = ventana_gpio_table,
+	.gpio_count = ARRAY_SIZE(ventana_gpio_table),
+};
 
-void __init seaboard_pinmux_init(void)
+void seaboard_pinmux_init(void)
 {
-	seaboard_common_pinmux_init();
-	tegra_pinmux_config_table(seaboard_pinmux, ARRAY_SIZE(seaboard_pinmux));
-	tegra_gpio_config(seaboard_gpio_table, ARRAY_SIZE(seaboard_gpio_table));
+	tegra_board_pinmux_init(&common_conf, &seaboard_conf);
 }
 
-void __init ventana_pinmux_init(void)
+void ventana_pinmux_init(void)
 {
-	seaboard_common_pinmux_init();
-	tegra_pinmux_config_table(ventana_pinmux, ARRAY_SIZE(ventana_pinmux));
-	tegra_gpio_config(ventana_gpio_table, ARRAY_SIZE(ventana_gpio_table));
+	tegra_board_pinmux_init(&common_conf, &ventana_conf);
 }
-
diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index 5daa6e8..be2f3e8 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -21,8 +21,8 @@
 #include <mach/pinmux.h>
 
 #include "gpio-names.h"
+#include "board-pinmux.h"
 #include "board-trimslice.h"
-#include "devices.h"
 
 static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,	TEGRA_TRI_TRISTATE},
@@ -143,11 +143,6 @@ static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
 };
 
-static struct platform_device *pinmux_devices[] = {
-	&tegra_gpio_device,
-	&tegra_pinmux_device,
-};
-
 static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TRIMSLICE_GPIO_SD4_CD, .enable = true	}, /* mmc4 cd */
 	{ .gpio = TRIMSLICE_GPIO_SD4_WP, .enable = true	}, /* mmc4 wp */
@@ -156,11 +151,14 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TRIMSLICE_GPIO_USB2_RST,  .enable = true }, /* USB2 PHY rst */
 };
 
-void __init trimslice_pinmux_init(void)
+static struct tegra_board_pinmux_conf conf = {
+	.pgs = trimslice_pinmux,
+	.pg_count = ARRAY_SIZE(trimslice_pinmux),
+	.gpios = gpio_table,
+	.gpio_count = ARRAY_SIZE(gpio_table),
+};
+
+void trimslice_pinmux_init(void)
 {
-	if (!of_machine_is_compatible("nvidia,tegra20"))
-		platform_add_devices(pinmux_devices,
-					ARRAY_SIZE(pinmux_devices));
-	tegra_pinmux_config_table(trimslice_pinmux, ARRAY_SIZE(trimslice_pinmux));
-	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
+	tegra_board_pinmux_init(&conf, NULL);
 }
-- 
1.7.0.4
