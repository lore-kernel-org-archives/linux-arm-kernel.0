From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 25 Sep 2013 14:12:47 -0700
Subject: [PATCH V4 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <1380046016-5811-1-git-send-email-abrestic@chromium.org>
References: <1380046016-5811-1-git-send-email-abrestic@chromium.org>
Message-ID: <1380143572-11741-1-git-send-email-abrestic@chromium.org>
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
Acked-by: Tomasz Figa <t.figa@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v3:
 - __init -> __exit for module exit function
 - fixed nits from Sylwester
Changes since v2:
 - add error handling to probe callback
 - fixed ordering of of_clk_{add,del}_provider
 - fixed nits from Tomasz and Sylwester
Changes since v1:
 - add clk_unregister() calls to remove callback
 - fixed minor nits from Tomasz
---
 drivers/clk/samsung/clk-exynos-audss.c | 104 ++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 39b40aa..742dabc 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -14,6 +14,8 @@
 #include <linux/clk-provider.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <dt-bindings/clk/exynos-audss-clk.h>
 
@@ -62,24 +64,26 @@ static struct syscore_ops exynos_audss_clk_syscore_ops = {
 #endif /* CONFIG_PM_SLEEP */
 
 /* register exynos_audss clocks */
-static void __init exynos_audss_clk_init(struct device_node *np)
+static int exynos_audss_clk_probe(struct platform_device *pdev)
 {
-	reg_base = of_iomap(np, 0);
-	if (!reg_base) {
-		pr_err("%s: failed to map audss registers\n", __func__);
-		return;
+	int i, ret = 0;
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
-	if (!clk_table) {
-		pr_err("%s: could not allocate clk lookup table\n", __func__);
-		return;
-	}
+	if (!clk_table)
+		return -ENOMEM;
 
 	clk_data.clks = clk_table;
 	clk_data.clk_num = EXYNOS_AUDSS_MAX_CLKS;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
 				mout_audss_p, ARRAY_SIZE(mout_audss_p),
@@ -123,13 +127,81 @@ static void __init exynos_audss_clk_init(struct device_node *np)
 				"div_pcm0", CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 5, 0, &lock);
 
+	for (i = 0; i < clk_data.clk_num; i++) {
+		if (IS_ERR(clk_table[i])) {
+			dev_err(&pdev->dev, "failed to register clock %d\n", i);
+			ret = PTR_ERR(clk_table[i]);
+			goto unregister;
+		}
+	}
+
+	ret = of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
+					&clk_data);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add clock provider\n");
+		goto unregister;
+	}
+
 #ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&exynos_audss_clk_syscore_ops);
 #endif
 
-	pr_info("Exynos: Audss: clock setup completed\n");
+	dev_info(&pdev->dev, "setup completed\n");
+
+	return 0;
+
+unregister:
+	for (i = 0; i < clk_data.clk_num; i++) {
+		if (!IS_ERR(clk_table[i]))
+			clk_unregister(clk_table[i]);
+	}
+
+	return ret;
+}
+
+static int exynos_audss_clk_remove(struct platform_device *pdev)
+{
+	int i;
+
+	of_clk_del_provider(pdev->dev.of_node);
+
+	for (i = 0; i < clk_data.clk_num; i++) {
+		if (!IS_ERR(clk_table[i]))
+			clk_unregister(clk_table[i]);
+	}
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
+static void __exit exynos_audss_clk_exit(void)
+{
+	platform_driver_unregister(&exynos_audss_clk_driver);
+}
+module_exit(exynos_audss_clk_exit);
+
+MODULE_AUTHOR("Padmavathi Venna <padma.v@samsung.com>");
+MODULE_DESCRIPTION("Exynos Audio Subsystem Clock Controller");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:exynos-audss-clk");
-- 
1.8.4
