From: abrestic@chromium.org (Andrew Bresticker)
Date: Fri, 20 Sep 2013 14:13:52 -0700
Subject: [PATCH 1/6] clk: exynos-audss: convert to platform device
Message-ID: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos AudioSS clock controller will later be modified to allow
input clocks to be specified via device-tree in order to support
multiple Exynos SoCs.  This will introduce a dependency on the core
SoC clock controller being initialized first so that the AudioSS driver
can look up its input clocks, but the order in which clock providers
are probed in of_clk_init() is not guaranteed.  Since deferred probing
is not supported in of_clk_init() and the AudioSS block is not the core
controller, we can initialize it later as a platform device.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/samsung/clk-exynos-audss.c | 71 +++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 39b40aa..7571e88 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -14,6 +14,8 @@
 #include <linux/clk-provider.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <dt-bindings/clk/exynos-audss-clk.h>
 
@@ -62,24 +64,29 @@ static struct syscore_ops exynos_audss_clk_syscore_ops = {
 #endif /* CONFIG_PM_SLEEP */
 
 /* register exynos_audss clocks */
-static void __init exynos_audss_clk_init(struct device_node *np)
+static int exynos_audss_clk_probe(struct platform_device *pdev)
 {
-	reg_base = of_iomap(np, 0);
-	if (!reg_base) {
-		pr_err("%s: failed to map audss registers\n", __func__);
-		return;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg_base)) {
+		dev_err(&pdev->dev, "failed to map audss registers\n");
+		return PTR_ERR(reg_base);
 	}
 
-	clk_table = kzalloc(sizeof(struct clk *) * EXYNOS_AUDSS_MAX_CLKS,
+	clk_table = devm_kzalloc(&pdev->dev,
+				sizeof(struct clk *) * EXYNOS_AUDSS_MAX_CLKS,
 				GFP_KERNEL);
 	if (!clk_table) {
-		pr_err("%s: could not allocate clk lookup table\n", __func__);
-		return;
+		dev_err(&pdev->dev, "could not allocate clk lookup table\n");
+		return -ENOMEM;
 	}
 
 	clk_data.clks = clk_table;
 	clk_data.clk_num = EXYNOS_AUDSS_MAX_CLKS;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
+				&clk_data);
 
 	clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
 				mout_audss_p, ARRAY_SIZE(mout_audss_p),
@@ -128,8 +135,46 @@ static void __init exynos_audss_clk_init(struct device_node *np)
 #endif
 
 	pr_info("Exynos: Audss: clock setup completed\n");
+
+	return 0;
+}
+
+static int exynos_audss_clk_remove(struct platform_device *pdev)
+{
+	of_clk_del_provider(pdev->dev.of_node);
+
+	return 0;
 }
-CLK_OF_DECLARE(exynos4210_audss_clk, "samsung,exynos4210-audss-clock",
-		exynos_audss_clk_init);
-CLK_OF_DECLARE(exynos5250_audss_clk, "samsung,exynos5250-audss-clock",
-		exynos_audss_clk_init);
+
+static const struct of_device_id exynos_audss_clk_of_match[] = {
+	{ .compatible = "samsung,exynos4210-audss-clock", },
+	{ .compatible = "samsung,exynos5250-audss-clock", },
+	{},
+};
+
+static struct platform_driver exynos_audss_clk_driver = {
+	.driver	= {
+		.name = "exynos-audss-clk",
+		.owner = THIS_MODULE,
+		.of_match_table = exynos_audss_clk_of_match,
+	},
+	.probe = exynos_audss_clk_probe,
+	.remove = exynos_audss_clk_remove,
+};
+
+static int __init exynos_audss_clk_init(void)
+{
+	return platform_driver_register(&exynos_audss_clk_driver);
+}
+core_initcall(exynos_audss_clk_init);
+
+static void __init exynos_audss_clk_exit(void)
+{
+	platform_driver_unregister(&exynos_audss_clk_driver);
+}
+module_exit(exynos_audss_clk_exit);
+
+MODULE_AUTHOR("Padmavathi Venna <padma.v@samsung.com>");
+MODULE_DESCRIPTION("Exynos AudioSS Clock Controller");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:exynos-audss-clk");
-- 
1.8.4
