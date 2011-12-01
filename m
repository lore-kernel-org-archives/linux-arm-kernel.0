From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 30 Nov 2011 17:45:35 -0700
Subject: [PATCH 1/2] arm/tegra: Remove use of TEGRA_GPIO_TO_IRQ
Message-ID: <1322700336-26866-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace compile-time usage of TEGRA_GPIO_TO_IRQ with run-time calls to
gpio_to_irq(). This will allow the base IRQ number for the Tegra GPIO
driver to be dynamically allocated in a later patch.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony.c  |    2 +-
 arch/arm/mach-tegra/board-seaboard.c |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 70ee674..60afd08 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -101,7 +101,6 @@ static struct wm8903_platform_data harmony_wm8903_pdata = {
 static struct i2c_board_info __initdata wm8903_board_info = {
 	I2C_BOARD_INFO("wm8903", 0x1a),
 	.platform_data = &harmony_wm8903_pdata,
-	.irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_CDC_IRQ),
 };
 
 static void __init harmony_i2c_init(void)
@@ -111,6 +110,7 @@ static void __init harmony_i2c_init(void)
 	platform_device_register(&tegra_i2c_device3);
 	platform_device_register(&tegra_i2c_device4);
 
+	wm8903_board_info.irq = gpio_to_irq(TEGRA_GPIO_CDC_IRQ);
 	i2c_register_board_info(0, &wm8903_board_info, 1);
 }
 
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index c1599eb..ce3c9a2 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -159,7 +159,6 @@ static struct platform_device *seaboard_devices[] __initdata = {
 
 static struct i2c_board_info __initdata isl29018_device = {
 	I2C_BOARD_INFO("isl29018", 0x44),
-	.irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_ISL29018_IRQ),
 };
 
 static struct i2c_board_info __initdata adt7461_device = {
@@ -183,7 +182,6 @@ static struct wm8903_platform_data wm8903_pdata = {
 static struct i2c_board_info __initdata wm8903_device = {
 	I2C_BOARD_INFO("wm8903", 0x1a),
 	.platform_data = &wm8903_pdata,
-	.irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_CDC_IRQ),
 };
 
 static int seaboard_ehci_init(void)
@@ -214,7 +212,10 @@ static void __init seaboard_i2c_init(void)
 	gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
 	gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
 
+	isl29018_device.irq = gpio_to_irq(TEGRA_GPIO_ISL29018_IRQ);
 	i2c_register_board_info(0, &isl29018_device, 1);
+
+	wm8903_device.irq = gpio_to_irq(TEGRA_GPIO_CDC_IRQ);
 	i2c_register_board_info(0, &wm8903_device, 1);
 
 	i2c_register_board_info(3, &adt7461_device, 1);
-- 
1.7.0.4
