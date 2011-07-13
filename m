From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 13 Jul 2011 15:57:52 -0600
Subject: [PATCH 2/2] ARM: Tegra: Seaboard: Add USB devices
In-Reply-To: <1310594272-8229-1-git-send-email-swarren@nvidia.com>
References: <1310594272-8229-1-git-send-email-swarren@nvidia.com>
Message-ID: <1310594272-8229-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seaboard has a couple of external USB ports. Add the platform devices and
GPIO infra-structure to enable these.

I tested both ports with a mouse on Seaboard non-clamshell.

This change is extracted from code in the ChromeOS 2.6.38 kernel.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-seaboard-pinmux.c |    1 +
 arch/arm/mach-tegra/board-seaboard.c        |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index e693246..1e15b01 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -167,6 +167,7 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_LIDSWITCH,		.enable = true },
 	{ .gpio = TEGRA_GPIO_POWERKEY,		.enable = true },
 	{ .gpio = TEGRA_GPIO_ISL29018_IRQ,	.enable = true },
+	{ .gpio = TEGRA_GPIO_USB1,		.enable = true },
 };
 
 void __init seaboard_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index 07cd8e4..237a94a 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -69,6 +69,8 @@ static __initdata struct tegra_clk_init_table seaboard_clk_init_table[] = {
 	{ "pll_a_out0",	"pll_a",	11289600,	true },
 	{ "cdev1",	NULL,		0,		true },
 	{ "i2s1",	"pll_a_out0",	11289600,	false},
+	{ "usbd",	"clk_m",	12000000,	true},
+	{ "usb3",	"clk_m",	12000000,	true},
 	{ NULL,		NULL,		0,		0},
 };
 
@@ -182,6 +184,29 @@ static struct i2c_board_info __initdata wm8903_device = {
 	.irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_CDC_IRQ),
 };
 
+static int seaboard_ehci_init(void)
+{
+	int gpio_status;
+
+	gpio_status = gpio_request(TEGRA_GPIO_USB1, "VBUS_USB1");
+	if (gpio_status < 0) {
+		pr_err("VBUS_USB1 request GPIO FAILED\n");
+		WARN_ON(1);
+	}
+
+	gpio_status = gpio_direction_output(TEGRA_GPIO_USB1, 1);
+	if (gpio_status < 0) {
+		pr_err("VBUS_USB1 request GPIO DIRECTION FAILED\n");
+		WARN_ON(1);
+	}
+	gpio_set_value(TEGRA_GPIO_USB1, 1);
+
+	platform_device_register(&tegra_ehci1_device);
+	platform_device_register(&tegra_ehci3_device);
+
+	return 0;
+}
+
 static void __init seaboard_i2c_init(void)
 {
 	gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
@@ -209,6 +234,8 @@ static void __init seaboard_common_init(void)
 	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
 
 	platform_add_devices(seaboard_devices, ARRAY_SIZE(seaboard_devices));
+
+	seaboard_ehci_init();
 }
 
 static void __init tegra_seaboard_init(void)
-- 
1.7.0.4
