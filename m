From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 31 Oct 2011 20:58:53 +0100
Subject: [PATCH 1/3] ARM: tegra: paz00: add support for wakeup gpio key
In-Reply-To: <cover.1320088857.git.marvin24@gmx.de>
References: <cover.1320088857.git.marvin24@gmx.de>
Message-ID: <36b0283d86591d2bc64fe454676ae214732cdb54.1320088857.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for a wakeup gpio which is connected to the
embedded controller. This will be used later on for wakeup from suspend.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h |    3 +++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 55c55ba..799e420 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -23,8 +23,10 @@
 #include <linux/serial_8250.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/gpio_keys.h>
 #include <linux/pda_power.h>
 #include <linux/io.h>
+#include <linux/input.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/rfkill-gpio.h>
@@ -114,12 +116,37 @@ static struct platform_device leds_gpio = {
         },
 };
 
+static struct gpio_keys_button paz00_gpio_keys_buttons[] = {
+	{
+		.code		= KEY_POWER,
+		.gpio		= TEGRA_GPIO_POWERKEY,
+		.active_low	= 1,
+		.desc		= "Power",
+		.type		= EV_KEY,
+		.wakeup		= 1,
+	},
+};
+
+static struct gpio_keys_platform_data paz00_gpio_keys = {
+	.buttons	= paz00_gpio_keys_buttons,
+	.nbuttons	= ARRAY_SIZE(paz00_gpio_keys_buttons),
+};
+
+static struct platform_device gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &paz00_gpio_keys,
+	},
+};
+
 static struct platform_device *paz00_devices[] __initdata = {
 	&debug_uart,
 	&tegra_sdhci_device4,
 	&tegra_sdhci_device1,
 	&wifi_rfkill_device,
 	&leds_gpio,
+	&gpio_keys_device,
 };
 
 static void paz00_i2c_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index 8aff06e..ffa83f5 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -32,6 +32,9 @@
 #define TEGRA_WIFI_RST			TEGRA_GPIO_PD1
 #define TEGRA_WIFI_LED			TEGRA_GPIO_PD0
 
+/* WakeUp */
+#define TEGRA_GPIO_POWERKEY	TEGRA_GPIO_PJ7
+
 void paz00_pinmux_init(void);
 
 #endif
-- 
1.7.5.4
