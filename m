From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 16 Dec 2011 15:12:24 -0700
Subject: [PATCH 1/9] arm/tegra: Split Seaboard GPIO table to allow for Ventana
In-Reply-To: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
References: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
Message-ID: <1324073552-15542-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seaboard and Ventana share some GPIOs, but others are different. Split the
GPIO table into common, seaboard-specific, and ventana-specific tables, so
that only the correct ones are enabled for each board. Add a few missing
audio-related GPIOs for Ventana.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-seaboard-pinmux.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index b1c2972..cb5b2e9 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -190,14 +190,26 @@ static struct tegra_gpio_table common_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true },
 	{ .gpio = TEGRA_GPIO_SD2_WP,		.enable = true },
 	{ .gpio = TEGRA_GPIO_SD2_POWER,		.enable = true },
+	{ .gpio = TEGRA_GPIO_CDC_IRQ,		.enable = true },
+};
+
+static struct tegra_gpio_table seaboard_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_LIDSWITCH,		.enable = true },
 	{ .gpio = TEGRA_GPIO_POWERKEY,		.enable = true },
 	{ .gpio = TEGRA_GPIO_HP_DET,		.enable = true },
 	{ .gpio = TEGRA_GPIO_ISL29018_IRQ,	.enable = true },
-	{ .gpio = TEGRA_GPIO_CDC_IRQ,		.enable = true },
 	{ .gpio = TEGRA_GPIO_USB1,		.enable = true },
 };
 
+static struct tegra_gpio_table ventana_gpio_table[] = {
+	/* hp_det */
+	{ .gpio = TEGRA_GPIO_PW2,		.enable = true },
+	/* int_mic_en */
+	{ .gpio = TEGRA_GPIO_PX0,		.enable = true },
+	/* ext_mic_en */
+	{ .gpio = TEGRA_GPIO_PX1,		.enable = true },
+};
+
 static void __init update_pinmux(struct tegra_pingroup_config *newtbl, int size)
 {
 	int i, j;
@@ -235,11 +247,13 @@ void __init seaboard_common_pinmux_init(void)
 void __init seaboard_pinmux_init(void)
 {
 	seaboard_common_pinmux_init();
+	tegra_gpio_config(seaboard_gpio_table, ARRAY_SIZE(seaboard_gpio_table));
 }
 
 void __init ventana_pinmux_init(void)
 {
 	update_pinmux(ventana_pinmux, ARRAY_SIZE(ventana_pinmux));
 	seaboard_common_pinmux_init();
+	tegra_gpio_config(ventana_gpio_table, ARRAY_SIZE(ventana_gpio_table));
 }
 
-- 
1.7.0.4
