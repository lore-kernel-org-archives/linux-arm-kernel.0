From: olof@lixom.net (Olof Johansson)
Date: Mon,  7 Mar 2011 17:34:22 -0600
Subject: [PATCH v2] ARM: tegra: seaboard: register i2c devices
Message-ID: <1299540862-3848-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the base i2c devices on seaboard. A few more are pending,
but it's a start.

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-seaboard-pinmux.c |    1 +
 arch/arm/mach-tegra/board-seaboard.c        |   62 +++++++++++++++++++++++++--
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index 7e96d49..d84d1dd 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -166,6 +166,7 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD2_POWER,		.enable = true },
 	{ .gpio = TEGRA_GPIO_LIDSWITCH,		.enable = true },
 	{ .gpio = TEGRA_GPIO_POWERKEY,		.enable = true },
+	{ .gpio = TEGRA_GPIO_ISL29018_IRQ, 	.enable = true },
 };
 
 void __init seaboard_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index eb28dbd..a8d7ace 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -18,9 +18,12 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/i2c.h>
+#include <linux/i2c-tegra.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 
 #include <mach/iomap.h>
@@ -63,6 +66,22 @@ static __initdata struct tegra_clk_init_table seaboard_clk_init_table[] = {
 	{ NULL,		NULL,		0,		0},
 };
 
+static struct tegra_i2c_platform_data seaboard_i2c1_platform_data = {
+	.bus_clk_rate	= 400000.
+};
+
+static struct tegra_i2c_platform_data seaboard_i2c2_platform_data = {
+	.bus_clk_rate	= 400000,
+};
+
+static struct tegra_i2c_platform_data seaboard_i2c3_platform_data = {
+	.bus_clk_rate	= 400000,
+};
+
+static struct tegra_i2c_platform_data seaboard_dvc_platform_data = {
+	.bus_clk_rate	= 400000,
+};
+
 static struct gpio_keys_button seaboard_gpio_keys_buttons[] = {
 	{
 		.code		= SW_LID,
@@ -124,7 +143,36 @@ static struct platform_device *seaboard_devices[] __initdata = {
 	&seaboard_gpio_keys_device,
 };
 
-static void __init __tegra_seaboard_init(void)
+static struct i2c_board_info __initdata isl29018_device = {
+	I2C_BOARD_INFO("isl29018", 0x44),
+	.irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_ISL29018_IRQ),
+};
+
+static struct i2c_board_info __initdata adt7461_device = {
+	I2C_BOARD_INFO("adt7461", 0x4c),
+};
+
+static void __init seaboard_i2c_init(void)
+{
+	gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
+	gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
+
+	i2c_register_board_info(0, &isl29018_device, 1);
+
+	i2c_register_board_info(4, &adt7461_device, 1);
+
+	tegra_i2c_device1.dev.platform_data = &seaboard_i2c1_platform_data;
+	tegra_i2c_device2.dev.platform_data = &seaboard_i2c2_platform_data;
+	tegra_i2c_device3.dev.platform_data = &seaboard_i2c3_platform_data;
+	tegra_i2c_device4.dev.platform_data = &seaboard_dvc_platform_data;
+
+	platform_device_register(&tegra_i2c_device1);
+	platform_device_register(&tegra_i2c_device2);
+	platform_device_register(&tegra_i2c_device3);
+	platform_device_register(&tegra_i2c_device4);
+}
+
+static void __init seaboard_common_init(void)
 {
 	seaboard_pinmux_init();
 
@@ -144,7 +192,9 @@ static void __init tegra_seaboard_init(void)
 	debug_uart_platform_data[0].mapbase = TEGRA_UARTD_BASE;
 	debug_uart_platform_data[0].irq = INT_UARTD;
 
-	__tegra_seaboard_init();
+	seaboard_common_init();
+
+	seaboard_i2c_init();
 }
 
 static void __init tegra_kaen_init(void)
@@ -154,7 +204,9 @@ static void __init tegra_kaen_init(void)
 	debug_uart_platform_data[0].mapbase = TEGRA_UARTB_BASE;
 	debug_uart_platform_data[0].irq = INT_UARTB;
 
-	__tegra_seaboard_init();
+	seaboard_common_init();
+
+	seaboard_i2c_init();
 }
 
 static void __init tegra_wario_init(void)
@@ -164,7 +216,9 @@ static void __init tegra_wario_init(void)
 	debug_uart_platform_data[0].mapbase = TEGRA_UARTB_BASE;
 	debug_uart_platform_data[0].irq = INT_UARTB;
 
-	__tegra_seaboard_init();
+	seaboard_common_init();
+
+	seaboard_i2c_init();
 }
 
 
-- 
1.7.0.4
