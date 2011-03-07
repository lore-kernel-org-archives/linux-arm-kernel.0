From: mike@compulab.co.il (Mike Rapoport)
Date: Mon,  7 Mar 2011 16:57:22 +0200
Subject: [PATCH] ARM: tegra: trimslice: enable MMC/SD slots
Message-ID: <1299509842-21191-1-git-send-email-mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TrimSlice has MicroSD and standard MMC/SD slots.
Register sdhci devices and enable GPIOs for MMC/SD slot.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
Hi Colin,

I know that it's little bit late, but I'd appreciate if you can merge
this one before sending pull request for 2.6.39.

 arch/arm/mach-tegra/board-trimslice-pinmux.c |    9 +++++++++
 arch/arm/mach-tegra/board-trimslice.c        |   19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index 6d4fc9f..532a788 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -16,8 +16,11 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+
 #include <mach/pinmux.h>
+#include <mach/gpio.h>
 
+#include "gpio-names.h"
 #include "board-trimslice.h"
 
 static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
@@ -139,7 +142,13 @@ static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
 };
 
+static struct tegra_gpio_table gpio_table[] = {
+	{ .gpio = TEGRA_GPIO_PP1,	.enable = true	}, /* mmc4 cd */
+	{ .gpio = TEGRA_GPIO_PP2,	.enable = true	}, /* mmc4 wp */
+};
+
 void __init trimslice_pinmux_init(void)
 {
 	tegra_pinmux_config_table(trimslice_pinmux, ARRAY_SIZE(trimslice_pinmux));
+	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
 }
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 7be7d4a..1af6710 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -29,9 +29,12 @@
 #include <asm/setup.h>
 
 #include <mach/iomap.h>
+#include <mach/sdhci.h>
 
 #include "board.h"
 #include "clock.h"
+#include "devices.h"
+#include "gpio-names.h"
 
 #include "board-trimslice.h"
 
@@ -56,9 +59,22 @@ static struct platform_device debug_uart = {
 		.platform_data	= debug_uart_platform_data,
 	},
 };
+static struct tegra_sdhci_platform_data sdhci_pdata1 = {
+	.cd_gpio	= -1,
+	.wp_gpio	= -1,
+	.power_gpio	= -1,
+};
+
+static struct tegra_sdhci_platform_data sdhci_pdata4 = {
+	.cd_gpio	= TEGRA_GPIO_PP1,
+	.wp_gpio	= TEGRA_GPIO_PP2,
+	.power_gpio	= -1,
+};
 
 static struct platform_device *trimslice_devices[] __initdata = {
 	&debug_uart,
+	&tegra_sdhci_device1,
+	&tegra_sdhci_device4,
 };
 
 static void __init tegra_trimslice_fixup(struct machine_desc *desc,
@@ -92,6 +108,9 @@ static void __init tegra_trimslice_init(void)
 
 	trimslice_pinmux_init();
 
+	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
+	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
+
 	platform_add_devices(trimslice_devices, ARRAY_SIZE(trimslice_devices));
 }
 
-- 
1.7.3.1
