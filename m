From: marvin24@gmx.de (Marc Dietrich)
Date: Sun,  7 Aug 2011 21:00:53 +0200
Subject: [PATCH 3/5] ARM: tegra: paz00: enable wifi led
In-Reply-To: <cover.1312735430.git.marvin24@gmx.de>
References: <cover.1312735430.git.marvin24@gmx.de>
Message-ID: <fdc3b097e452167e5241c369ef053594945fef47.1312742856.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the wifi led. It is automaticly triggered by
the rfkill0 event.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00-pinmux.c |    1 +
 arch/arm/mach-tegra/board-paz00.c        |   22 ++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h        |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index 70c5710..2225769 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -147,6 +147,7 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_ULPI_RST,	.enable = true },
 	{ .gpio = TEGRA_WIFI_PWRN,	.enable = true },
 	{ .gpio = TEGRA_WIFI_RST,	.enable = true },
+	{ .gpio = TEGRA_WIFI_LED,	.enable = true },
 };
 
 void paz00_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 6b798e7..45111f6 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -91,11 +91,33 @@ static struct platform_device wifi_rfkill_device = {
 	},
 };
 
+static struct gpio_led gpio_leds[] = {
+	{
+		.name			= "wifi-led",
+		.default_trigger	= "rfkill0",
+		.gpio			= TEGRA_WIFI_LED,
+	},
+};
+
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &gpio_led_info,
+        },
+};
+
 static struct platform_device *paz00_devices[] __initdata = {
 	&debug_uart,
 	&tegra_sdhci_device1,
 	&tegra_sdhci_device4,
 	&wifi_rfkill_device,
+	&leds_gpio,
 };
 
 static void paz00_i2c_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index e780f30..86057c3 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -28,6 +28,7 @@
 /* WIFI */
 #define TEGRA_WIFI_PWRN		TEGRA_GPIO_PK5
 #define TEGRA_WIFI_RST		TEGRA_GPIO_PD1
+#define TEGRA_WIFI_LED		TEGRA_GPIO_PD0
 
 void paz00_pinmux_init(void);
 
-- 
1.7.4.1
