From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 20 Jun 2018 15:54:03 +0300
Subject: [PATCH 2/5] gpio: tegra186: Add support for Tegra194
In-Reply-To: <20180620125406.11906-1-mperttunen@nvidia.com>
References: <20180620125406.11906-1-mperttunen@nvidia.com>
Message-ID: <20180620125406.11906-2-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Tegra194 GPIO bank configuration.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 7f1aa4c21e0d..9d0292c8a199 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 
 #include <dt-bindings/gpio/tegra186-gpio.h>
+#include <dt-bindings/gpio/tegra194-gpio.h>
 
 #define TEGRA186_GPIO_ENABLE_CONFIG 0x00
 #define  TEGRA186_GPIO_ENABLE_CONFIG_ENABLE BIT(0)
@@ -593,6 +594,73 @@ static const struct tegra_gpio_soc tegra186_aon_soc = {
 	.name = "tegra186-gpio-aon",
 };
 
+#define TEGRA194_MAIN_GPIO_PORT(port, base, count, controller)	\
+	[TEGRA194_MAIN_GPIO_PORT_##port] = {			\
+		.name = #port,					\
+		.offset = base,					\
+		.pins = count,					\
+		.irq = controller,				\
+	}
+
+static const struct tegra_gpio_port tegra194_main_ports[] = {
+	TEGRA194_MAIN_GPIO_PORT( A, 0x1400, 8, 1),
+	TEGRA194_MAIN_GPIO_PORT( B, 0x4e00, 2, 4),
+	TEGRA194_MAIN_GPIO_PORT( C, 0x4600, 8, 4),
+	TEGRA194_MAIN_GPIO_PORT( D, 0x4800, 4, 4),
+	TEGRA194_MAIN_GPIO_PORT( E, 0x4a00, 8, 4),
+	TEGRA194_MAIN_GPIO_PORT( F, 0x4c00, 6, 4),
+	TEGRA194_MAIN_GPIO_PORT( G, 0x4000, 8, 4),
+	TEGRA194_MAIN_GPIO_PORT( H, 0x4200, 8, 4),
+	TEGRA194_MAIN_GPIO_PORT( I, 0x4400, 5, 4),
+	TEGRA194_MAIN_GPIO_PORT( J, 0x5200, 6, 5),
+	TEGRA194_MAIN_GPIO_PORT( K, 0x3000, 8, 3),
+	TEGRA194_MAIN_GPIO_PORT( L, 0x3200, 4, 3),
+	TEGRA194_MAIN_GPIO_PORT( M, 0x2600, 8, 2),
+	TEGRA194_MAIN_GPIO_PORT( N, 0x2800, 3, 2),
+	TEGRA194_MAIN_GPIO_PORT( O, 0x5000, 6, 5),
+	TEGRA194_MAIN_GPIO_PORT( P, 0x2a00, 8, 2),
+	TEGRA194_MAIN_GPIO_PORT( Q, 0x2c00, 8, 2),
+	TEGRA194_MAIN_GPIO_PORT( R, 0x2e00, 6, 2),
+	TEGRA194_MAIN_GPIO_PORT( S, 0x3600, 8, 3),
+	TEGRA194_MAIN_GPIO_PORT( T, 0x3800, 8, 3),
+	TEGRA194_MAIN_GPIO_PORT( U, 0x3a00, 1, 3),
+	TEGRA194_MAIN_GPIO_PORT( V, 0x1000, 8, 1),
+	TEGRA194_MAIN_GPIO_PORT( W, 0x1200, 2, 1),
+	TEGRA194_MAIN_GPIO_PORT( X, 0x2000, 8, 2),
+	TEGRA194_MAIN_GPIO_PORT( Y, 0x2200, 8, 2),
+	TEGRA194_MAIN_GPIO_PORT( Z, 0x2400, 8, 2),
+	TEGRA194_MAIN_GPIO_PORT(FF, 0x3400, 2, 3),
+	TEGRA194_MAIN_GPIO_PORT(GG, 0x0000, 2, 0)
+};
+
+static const struct tegra_gpio_soc tegra194_main_soc = {
+	.num_ports = ARRAY_SIZE(tegra194_main_ports),
+	.ports = tegra194_main_ports,
+	.name = "tegra194-gpio",
+};
+
+#define TEGRA194_AON_GPIO_PORT(port, base, count, controller)	\
+	[TEGRA194_AON_GPIO_PORT_##port] = {			\
+		.name = #port,					\
+		.offset = base,					\
+		.pins = count,					\
+		.irq = controller,				\
+	}
+
+static const struct tegra_gpio_port tegra194_aon_ports[] = {
+	TEGRA194_AON_GPIO_PORT(AA, 0x0600, 8, 0),
+	TEGRA194_AON_GPIO_PORT(BB, 0x0800, 4, 0),
+	TEGRA194_AON_GPIO_PORT(CC, 0x0200, 8, 0),
+	TEGRA194_AON_GPIO_PORT(DD, 0x0400, 3, 0),
+	TEGRA194_AON_GPIO_PORT(EE, 0x0000, 7, 0)
+};
+
+static const struct tegra_gpio_soc tegra194_aon_soc = {
+	.num_ports = ARRAY_SIZE(tegra194_aon_ports),
+	.ports = tegra194_aon_ports,
+	.name = "tegra194-gpio-aon",
+};
+
 static const struct of_device_id tegra186_gpio_of_match[] = {
 	{
 		.compatible = "nvidia,tegra186-gpio",
@@ -600,6 +668,12 @@ static const struct of_device_id tegra186_gpio_of_match[] = {
 	}, {
 		.compatible = "nvidia,tegra186-gpio-aon",
 		.data = &tegra186_aon_soc
+	}, {
+		.compatible = "nvidia,tegra194-gpio",
+		.data = &tegra194_main_soc
+	}, {
+		.compatible = "nvidia,tegra194-gpio-aon",
+		.data = &tegra194_aon_soc
 	}, {
 		/* sentinel */
 	}
-- 
2.16.1
