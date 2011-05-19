From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 19 May 2011 14:08:27 +0200
Subject: [PATCH 3/6] ARM: tegra: paz00: enable usb ports
In-Reply-To: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
References: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
Message-ID: <1305806910-3903-4-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the second and third ehci bus on paz00.
The first bus needs gadget and nvec support and will be added once
the needed patches are upstream.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00-pinmux.c |    1 +
 arch/arm/mach-tegra/board-paz00.c        |   35 +++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/board-paz00.h        |    1 +
 3 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index d2faa50..acee62e 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -147,6 +147,7 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD4_CD,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD4_WP,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD4_POWER,	.enable = true },
+	{ .gpio = TEGRA_ULPI_RST,	.enable = true },
 };
 
 void paz00_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 5f1c110..e1e1959 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-tegra.h>
+#include <linux/platform_data/tegra_usb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -36,6 +37,8 @@
 #include <mach/iomap.h>
 #include <mach/irqs.h>
 #include <mach/sdhci.h>
+#include <mach/usb_phy.h>
+#include <mach/gpio.h>
 
 #include "board.h"
 #include "board-paz00.h"
@@ -95,6 +98,36 @@ static void paz00_i2c_init(void)
 	platform_device_register(&tegra_i2c_device4);
 }
 
+static struct tegra_ulpi_config ulpi_phy_config = {
+		.reset_gpio = TEGRA_ULPI_RST,
+		.clk = "cdev2",
+};
+
+static struct tegra_ehci_platform_data tegra_ehci_pdata[] = {
+		[0] = {
+			.operating_mode = TEGRA_USB_OTG,
+			.power_down_on_bus_suspend = 1,
+		},
+		[1] = {
+			.phy_config = &ulpi_phy_config,
+			.operating_mode = TEGRA_USB_HOST,
+			.power_down_on_bus_suspend = 1,
+		},
+		[2] = {
+			.operating_mode = TEGRA_USB_HOST,
+			.power_down_on_bus_suspend = 1,
+		},
+};
+
+static void paz00_usb_init(void)
+{
+	tegra_ehci2_device.dev.platform_data = &tegra_ehci_pdata[1];
+	tegra_ehci3_device.dev.platform_data = &tegra_ehci_pdata[2];
+
+	platform_device_register(&tegra_ehci2_device);
+	platform_device_register(&tegra_ehci3_device);
+}
+
 static void __init tegra_paz00_fixup(struct machine_desc *desc,
 	struct tag *tags, char **cmdline, struct meminfo *mi)
 {
@@ -109,7 +142,6 @@ static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
 	{ NULL,		NULL,		0,		0},
 };
 
-
 static struct tegra_sdhci_platform_data sdhci_pdata1 = {
 	.cd_gpio	= TEGRA_GPIO_SD1_CD,
 	.wp_gpio	= TEGRA_GPIO_SD1_WP,
@@ -142,6 +174,7 @@ static void __init tegra_paz00_init(void)
 	platform_add_devices(paz00_devices, ARRAY_SIZE(paz00_devices));
 
 	paz00_i2c_init();
+	paz00_usb_init();
 }
 
 MACHINE_START(PAZ00, "paz00")
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index 221ce9c..6b0b733 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -23,6 +23,7 @@
 #define TEGRA_GPIO_SD4_CD		TEGRA_GPIO_PH2
 #define TEGRA_GPIO_SD4_WP		TEGRA_GPIO_PH3
 #define TEGRA_GPIO_SD4_POWER		TEGRA_GPIO_PI6
+#define TEGRA_ULPI_RST			TEGRA_GPIO_PV0
 
 void paz00_pinmux_init(void);
 
-- 
1.7.4.2
