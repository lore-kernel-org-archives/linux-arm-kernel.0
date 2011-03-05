From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  4 Mar 2011 22:42:31 -0700
Subject: [PATCH 4/5] ARM: tegra: Harmony: I2C-related portions of audio support
In-Reply-To: <1299303752-7779-1-git-send-email-swarren@nvidia.com>
References: <1299303752-7779-1-git-send-email-swarren@nvidia.com>
Message-ID: <1299303752-7779-5-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is the portion of the audio-related setup that relies additionally
on the latest Tegra I2C driver being merged.

* Define platform data for WM8903 audio codec
* Register WM8903 as an I2C device

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 17262b4..d002d16 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -27,6 +27,8 @@
 #include <linux/i2c-tegra.h>
 #include <linux/gpio.h>
 
+#include <sound/wm8903.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -81,6 +83,25 @@ static struct tegra_i2c_platform_data harmony_dvc_platform_data = {
 	.bus_clk_rate   = 400000,
 };
 
+static struct wm8903_platform_data harmony_wm8903_pdata = {
+	.irq_active_low = 0,
+	.micdet_cfg = 0,
+	.micdet_delay = 100,
+	.gpio_cfg = {
+		WM8903_GPIO_NO_CONFIG,
+		WM8903_GPIO_NO_CONFIG,
+		0,
+		WM8903_GPIO_NO_CONFIG,
+		WM8903_GPIO_NO_CONFIG,
+	},
+};
+
+static struct i2c_board_info __initdata wm8903_board_info = {
+	I2C_BOARD_INFO("wm8903", 0x1a),
+	.platform_data = &harmony_wm8903_pdata,
+	.irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_CDC_IRQ),
+};
+
 static void harmony_i2c_init(void)
 {
 	tegra_i2c_device1.dev.platform_data = &harmony_i2c1_platform_data;
@@ -92,6 +113,8 @@ static void harmony_i2c_init(void)
 	platform_device_register(&tegra_i2c_device2);
 	platform_device_register(&tegra_i2c_device3);
 	platform_device_register(&tegra_i2c_device4);
+
+	i2c_register_board_info(0, &wm8903_board_info, 1);
 }
 
 static struct harmony_audio_platform_data harmony_audio_pdata = {
-- 
1.7.1
