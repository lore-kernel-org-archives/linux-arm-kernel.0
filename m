From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Feb 2011 23:55:15 -0600
Subject: [PATCH 4/6] ARM: tegra: harmony: register sdhci devices
In-Reply-To: <1298354117-19097-1-git-send-email-olof@lixom.net>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
Message-ID: <1298354117-19097-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 3 sdhci devices that are available on Harmony as
platform devices. Two go to slots (one 4-lane, one 8-lane),
and one goes to onboard wifi.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/board-harmony.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index f6ad58b..7010774 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -30,10 +30,13 @@
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
+#include <mach/sdhci.h>
 
 #include "board.h"
 #include "board-harmony.h"
 #include "clock.h"
+#include "devices.h"
+#include "gpio-names.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -59,6 +62,9 @@ static struct platform_device debug_uart = {
 
 static struct platform_device *harmony_devices[] __initdata = {
 	&debug_uart,
+	&tegra_sdhci_device1,
+	&tegra_sdhci_device2,
+	&tegra_sdhci_device4,
 };
 
 static void __init tegra_harmony_fixup(struct machine_desc *desc,
@@ -77,6 +83,26 @@ static __initdata struct tegra_clk_init_table harmony_clk_init_table[] = {
 	{ NULL,		NULL,		0,		0},
 };
 
+
+static struct tegra_sdhci_platform_data sdhci_pdata1 = {
+	.cd_gpio	= -1,
+	.wp_gpio	= -1,
+	.power_gpio	= -1,
+};
+
+static struct tegra_sdhci_platform_data sdhci_pdata2 = {
+	.cd_gpio	= TEGRA_GPIO_PI5,
+	.wp_gpio	= TEGRA_GPIO_PH1,
+	.power_gpio	= TEGRA_GPIO_PT3,
+};
+
+static struct tegra_sdhci_platform_data sdhci_pdata4 = {
+	.cd_gpio	= TEGRA_GPIO_PH2,
+	.wp_gpio	= TEGRA_GPIO_PH3,
+	.power_gpio	= TEGRA_GPIO_PI6,
+	.is_8bit	= 1,
+};
+
 static void __init tegra_harmony_init(void)
 {
 	tegra_common_init();
@@ -85,6 +111,10 @@ static void __init tegra_harmony_init(void)
 
 	harmony_pinmux_init();
 
+	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
+	tegra_sdhci_device2.dev.platform_data = &sdhci_pdata2;
+	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
+
 	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
 }
 
-- 
1.7.0.4
