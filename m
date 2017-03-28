From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 28 Mar 2017 13:42:58 +0100
Subject: [PATCH V3 6/6] soc/tegra: Add initial flowctrl support for
 Tegra132/210
In-Reply-To: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
References: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1490704978-22906-7-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra132 and Tegra210 support the flowctrl module and so add initial
support for these devices.

Please note that Tegra186 does not support the flowctrl module, so
update the initialisation function such that we do not fall back and
attempt to map the 'hardcoded' address range for Tegra186. Furthermore
64-bit Tegra devices have always had the flowctrl node defined in their
device-tree and so only use the 'hardcoded' addresses for 32-bit Tegra
devices.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/Kconfig    |  2 ++
 drivers/soc/tegra/flowctrl.c | 31 +++++++++++++++++++++----------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index c7e8ddfb574e..dcf088db40b6 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -63,6 +63,7 @@ if ARM64
 config ARCH_TEGRA_132_SOC
 	bool "NVIDIA Tegra132 SoC"
 	select PINCTRL_TEGRA124
+	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	help
 	  Enable support for NVIDIA Tegra132 SoC, based on the Denver
@@ -73,6 +74,7 @@ config ARCH_TEGRA_132_SOC
 config ARCH_TEGRA_210_SOC
 	bool "NVIDIA Tegra210 SoC"
 	select PINCTRL_TEGRA210
+	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	help
 	  Enable support for the NVIDIA Tegra210 SoC. Also known as Tegra X1,
diff --git a/drivers/soc/tegra/flowctrl.c b/drivers/soc/tegra/flowctrl.c
index 25eddfc8475d..0e345c05fc65 100644
--- a/drivers/soc/tegra/flowctrl.c
+++ b/drivers/soc/tegra/flowctrl.c
@@ -165,6 +165,7 @@ static int tegra_flowctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_flowctrl_match[] = {
+	{ .compatible = "nvidia,tegra210-flowctrl" },
 	{ .compatible = "nvidia,tegra124-flowctrl" },
 	{ .compatible = "nvidia,tegra114-flowctrl" },
 	{ .compatible = "nvidia,tegra30-flowctrl" },
@@ -184,9 +185,7 @@ builtin_platform_driver(tegra_flowctrl_driver);
 
 static int __init tegra_flowctrl_init(void)
 {
-	/* hardcoded fallback if device tree node is missing */
-	unsigned long base = 0x60007000;
-	unsigned long size = SZ_4K;
+	struct resource res;
 	struct device_node *np;
 
 	if (!soc_is_tegra())
@@ -194,17 +193,29 @@ static int __init tegra_flowctrl_init(void)
 
 	np = of_find_matching_node(NULL, tegra_flowctrl_match);
 	if (np) {
-		struct resource res;
-
-		if (of_address_to_resource(np, 0, &res) == 0) {
-			size = resource_size(&res);
-			base = res.start;
+		if (of_address_to_resource(np, 0, &res) < 0) {
+			pr_err("failed to get flowctrl register\n");
+			return -ENXIO;
 		}
-
 		of_node_put(np);
+	} else if (IS_ENABLED(CONFIG_ARM)) {
+		/*
+		 * Hardcoded fallback for 32-bit Tegra
+		 * devices if device tree node is missing.
+		 */
+		res.start = 0x60007000;
+		res.end = 0x60007fff;
+		res.flags = IORESOURCE_MEM;
+	} else {
+		/*
+		 * At this point we're running on a Tegra,
+		 * that doesn't support the flow controller
+		 * (eg. Tegra186), so just return.
+		 */
+		return 0;
 	}
 
-	tegra_flowctrl_base = ioremap_nocache(base, size);
+	tegra_flowctrl_base = ioremap_nocache(res.start, resource_size(&res));
 	if (!tegra_flowctrl_base)
 		return -ENXIO;
 
-- 
2.7.4
