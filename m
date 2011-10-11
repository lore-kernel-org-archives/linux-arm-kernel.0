From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 11 Oct 2011 14:23:55 -0600
Subject: [PATCH v2 1/4] arm/tegra: Prep boards for gpio/pinmux conversion to
	pdevs
In-Reply-To: <1318364638-20191-1-git-send-email-swarren@nvidia.com>
References: <1318364638-20191-1-git-send-email-swarren@nvidia.com>
Message-ID: <1318364638-20191-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra GPIO driver will be converted from static registration via
postcore_initcall() to be a platform device later in this patch series.
A new Tegra pinmux platform device will also be added.

Prepare for this by modifying all boards to register the appropriate
platform devices before-hand, so that when the drivers are converted,
those devices will be probed, and git bisectability will be maintained.

v2: Add resource definitions for GPIO and pinmux

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony-pinmux.c   |    8 +++
 arch/arm/mach-tegra/board-paz00-pinmux.c     |    8 +++
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |    9 ++-
 arch/arm/mach-tegra/board-trimslice-pinmux.c |    7 ++
 arch/arm/mach-tegra/devices.c                |   84 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/devices.h                |    2 +
 6 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index 4d63e2e..e99b456 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -20,6 +20,7 @@
 
 #include "gpio-names.h"
 #include "board-harmony.h"
+#include "devices.h"
 
 static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -140,6 +141,11 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
+static struct platform_device *pinmux_devices[] = {
+	&tegra_gpio_device,
+	&tegra_pinmux_device,
+};
+
 static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true	},
 	{ .gpio = TEGRA_GPIO_SD2_WP,		.enable = true	},
@@ -155,6 +161,8 @@ static struct tegra_gpio_table gpio_table[] = {
 
 void harmony_pinmux_init(void)
 {
+	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+
 	tegra_pinmux_config_table(harmony_pinmux, ARRAY_SIZE(harmony_pinmux));
 
 	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index 2225769..fb20894 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -20,6 +20,7 @@
 
 #include "gpio-names.h"
 #include "board-paz00.h"
+#include "devices.h"
 
 static struct tegra_pingroup_config paz00_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -140,6 +141,11 @@ static struct tegra_pingroup_config paz00_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
+static struct platform_device *pinmux_devices[] = {
+	&tegra_gpio_device,
+	&tegra_pinmux_device,
+};
+
 static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD1_CD,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true },
@@ -152,6 +158,8 @@ static struct tegra_gpio_table gpio_table[] = {
 
 void paz00_pinmux_init(void)
 {
+	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+
 	tegra_pinmux_config_table(paz00_pinmux, ARRAY_SIZE(paz00_pinmux));
 
 	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index 74f78b7..f092298 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -21,6 +21,7 @@
 
 #include "gpio-names.h"
 #include "board-seaboard.h"
+#include "devices.h"
 
 #define DEFAULT_DRIVE(_name)					\
 	{							\
@@ -157,8 +158,10 @@ static __initdata struct tegra_pingroup_config seaboard_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
-
-
+static struct platform_device *pinmux_devices[] = {
+	&tegra_gpio_device,
+	&tegra_pinmux_device,
+};
 
 static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true },
@@ -173,6 +176,8 @@ static struct tegra_gpio_table gpio_table[] = {
 
 void __init seaboard_pinmux_init(void)
 {
+	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+
 	tegra_pinmux_config_table(seaboard_pinmux, ARRAY_SIZE(seaboard_pinmux));
 
 	tegra_drive_pinmux_config_table(seaboard_drive_pinmux,
diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index bcb1916..4969dd2 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -21,6 +21,7 @@
 
 #include "gpio-names.h"
 #include "board-trimslice.h"
+#include "devices.h"
 
 static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,	TEGRA_TRI_TRISTATE},
@@ -141,6 +142,11 @@ static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
 };
 
+static struct platform_device *pinmux_devices[] = {
+	&tegra_gpio_device,
+	&tegra_pinmux_device,
+};
+
 static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TRIMSLICE_GPIO_SD4_CD, .enable = true	}, /* mmc4 cd */
 	{ .gpio = TRIMSLICE_GPIO_SD4_WP, .enable = true	}, /* mmc4 wp */
@@ -151,6 +157,7 @@ static struct tegra_gpio_table gpio_table[] = {
 
 void __init trimslice_pinmux_init(void)
 {
+	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
 	tegra_pinmux_config_table(trimslice_pinmux, ARRAY_SIZE(trimslice_pinmux));
 	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
 }
diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index 57e35d2..240d5dc 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -31,6 +31,90 @@
 #include <mach/usb_phy.h>
 #include "gpio-names.h"
 
+static struct resource gpio_resource[] = {
+	[0] = {
+		.start	= TEGRA_GPIO_BASE,
+		.end	= TEGRA_GPIO_BASE + TEGRA_GPIO_SIZE-1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= INT_GPIO1,
+		.end	= INT_GPIO1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= INT_GPIO2,
+		.end	= INT_GPIO2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= INT_GPIO3,
+		.end	= INT_GPIO3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[4] = {
+		.start	= INT_GPIO4,
+		.end	= INT_GPIO4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[5] = {
+		.start	= INT_GPIO5,
+		.end	= INT_GPIO5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[6] = {
+		.start	= INT_GPIO6,
+		.end	= INT_GPIO6,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[7] = {
+		.start	= INT_GPIO7,
+		.end	= INT_GPIO7,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device tegra_gpio_device = {
+	.name		= "tegra-gpio",
+	.id		= -1,
+	.resource	= gpio_resource,
+	.num_resources	= ARRAY_SIZE(gpio_resource),
+};
+
+static struct resource pinmux_resource[] = {
+	[0] = {
+		/* Tri-state registers */
+		.start	= TEGRA_APB_MISC_BASE + 0x14,
+		.end	= TEGRA_APB_MISC_BASE + 0x20 + 3,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* Mux registers */
+		.start	= TEGRA_APB_MISC_BASE + 0x80,
+		.end	= TEGRA_APB_MISC_BASE + 0x9c + 3,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		/* Pull-up/down registers */
+		.start	= TEGRA_APB_MISC_BASE + 0xa0,
+		.end	= TEGRA_APB_MISC_BASE + 0xb0 + 3,
+		.flags	= IORESOURCE_MEM,
+	},
+	[3] = {
+		/* Pad control registers */
+		.start	= TEGRA_APB_MISC_BASE + 0x868,
+		.end	= TEGRA_APB_MISC_BASE + 0x90c + 3,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device tegra_pinmux_device = {
+	.name		= "tegra-pinmux",
+	.id		= -1,
+	.resource	= pinmux_resource,
+	.num_resources	= ARRAY_SIZE(pinmux_resource),
+};
+
 static struct resource i2c_resource1[] = {
 	[0] = {
 		.start	= INT_I2C,
diff --git a/arch/arm/mach-tegra/devices.h b/arch/arm/mach-tegra/devices.h
index 4a7dc0a..873ecb2 100644
--- a/arch/arm/mach-tegra/devices.h
+++ b/arch/arm/mach-tegra/devices.h
@@ -21,6 +21,8 @@
 
 #include <linux/platform_device.h>
 
+extern struct platform_device tegra_gpio_device;
+extern struct platform_device tegra_pinmux_device;
 extern struct platform_device tegra_sdhci_device1;
 extern struct platform_device tegra_sdhci_device2;
 extern struct platform_device tegra_sdhci_device3;
-- 
1.7.0.4
