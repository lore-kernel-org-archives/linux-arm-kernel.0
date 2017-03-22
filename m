From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 22 Mar 2017 17:00:54 +0000
Subject: [PATCH V2 3/5] soc/tegra: flowctrl: Add basic platform driver
In-Reply-To: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
References: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1490202056-13040-4-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a simple platform driver for the flowctrl module so that it gets
registered as a proper device.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/flowctrl.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/flowctrl.c b/drivers/soc/tegra/flowctrl.c
index 3a5a1cb9ae90..25eddfc8475d 100644
--- a/drivers/soc/tegra/flowctrl.c
+++ b/drivers/soc/tegra/flowctrl.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 
 #include <soc/tegra/common.h>
 #include <soc/tegra/flowctrl.h>
@@ -47,7 +48,7 @@ static void __iomem *tegra_flowctrl_base;
 
 static void flowctrl_update(u8 offset, u32 value)
 {
-	if (WARN_ONCE(!tegra_flowctrl_base,
+	if (WARN_ONCE(IS_ERR_OR_NULL(tegra_flowctrl_base),
 		      "Tegra flowctrl not initialised!\n"))
 		return;
 
@@ -62,7 +63,7 @@ u32 flowctrl_read_cpu_csr(unsigned int cpuid)
 {
 	u8 offset = flowctrl_offset_cpu_csr[cpuid];
 
-	if (WARN_ONCE(!tegra_flowctrl_base,
+	if (WARN_ONCE(IS_ERR_OR_NULL(tegra_flowctrl_base),
 		      "Tegra flowctrl not initialised!\n"))
 		return 0;
 
@@ -148,7 +149,22 @@ void flowctrl_cpu_suspend_exit(unsigned int cpuid)
 	flowctrl_write_cpu_csr(cpuid, reg);
 }
 
-static const struct of_device_id matches[] __initconst = {
+static int tegra_flowctrl_probe(struct platform_device *pdev)
+{
+	void __iomem *base = tegra_flowctrl_base;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tegra_flowctrl_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tegra_flowctrl_base))
+		return PTR_ERR(base);
+
+	iounmap(base);
+
+	return 0;
+}
+
+static const struct of_device_id tegra_flowctrl_match[] = {
 	{ .compatible = "nvidia,tegra124-flowctrl" },
 	{ .compatible = "nvidia,tegra114-flowctrl" },
 	{ .compatible = "nvidia,tegra30-flowctrl" },
@@ -156,6 +172,16 @@ static const struct of_device_id matches[] __initconst = {
 	{ }
 };
 
+static struct platform_driver tegra_flowctrl_driver = {
+	.driver = {
+		.name = "tegra-flowctrl",
+		.suppress_bind_attrs = true,
+		.of_match_table = tegra_flowctrl_match,
+	},
+	.probe = tegra_flowctrl_probe,
+};
+builtin_platform_driver(tegra_flowctrl_driver);
+
 static int __init tegra_flowctrl_init(void)
 {
 	/* hardcoded fallback if device tree node is missing */
@@ -166,7 +192,7 @@ static int __init tegra_flowctrl_init(void)
 	if (!soc_is_tegra())
 		return 0;
 
-	np = of_find_matching_node(NULL, matches);
+	np = of_find_matching_node(NULL, tegra_flowctrl_match);
 	if (np) {
 		struct resource res;
 
-- 
2.7.4
