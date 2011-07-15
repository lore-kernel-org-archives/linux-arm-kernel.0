From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 15 Jul 2011 12:24:23 +0200
Subject: [PATCH 3/3] ARM: tegra: paz00: enable wifi led
In-Reply-To: <1310725464-2524-1-git-send-email-marvin24@gmx.de>
References: <1310725464-2524-1-git-send-email-marvin24@gmx.de>
Message-ID: <1310725464-2524-4-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the wifi led. It is automaticly triggered by
the rfkill0 event.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00-pinmux.c |    1 +
 arch/arm/mach-tegra/board-paz00.c        |   23 +++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h        |    1 +
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index c02a48f..41a6304 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -146,6 +146,7 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD1_POWER,	.enable = true },
 	{ .gpio = TEGRA_ULPI_RST,	.enable = true },
 	{ .gpio = TEGRA_WIFI_PWRN,	.enable = true },
+	{ .gpio = TEGRA_WIFI_LED,	.enable = true },
 };
 
 void paz00_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 0bc652b..9c7531a 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -26,6 +26,7 @@
 #include <linux/pda_power.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/leds.h>
 #include <linux/i2c.h>
 #include <linux/i2c-tegra.h>
 #include <linux/platform_data/tegra_usb.h>
@@ -79,8 +80,30 @@ static struct platform_device debug_uart = {
 	},
 };
 
+static struct gpio_led gpio_leds[] = {
+	{
+		.name                   = "wifi-led",
+		.default_trigger        = "rfkill0",
+		.gpio                   = TEGRA_WIFI_LED,
+	},
+};
+
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds           = gpio_leds,
+	.num_leds       = ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	.name   = "leds-gpio",
+	.id     = -1,
+	.dev    = {
+		.platform_data  = &gpio_led_info,
+	},
+};
+
 static struct platform_device *paz00_devices[] __initdata = {
 	&debug_uart,
+	&leds_gpio,
 	&tegra_sdhci_device1,
 	&tegra_sdhci_device4,
 };
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index 5d2849e..5d06053 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -27,6 +27,7 @@
 
 /* WIFI */
 #define TEGRA_WIFI_PWRN			TEGRA_GPIO_PK5
+#define TEGRA_WIFI_LED			TEGRA_GPIO_PD0
 
 void paz00_pinmux_init(void);
 
-- 
1.7.4.1
