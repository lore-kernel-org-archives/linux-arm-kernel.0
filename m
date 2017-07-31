From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 31 Jul 2017 14:49:25 +0900
Subject: [PATCH v2] bus: uniphier-system-bus: set up registers when resuming
Message-ID: <1501480165-10527-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When resuming, set up registers that have been lost in the sleep state.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix define but not used warning

 drivers/bus/uniphier-system-bus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bus/uniphier-system-bus.c b/drivers/bus/uniphier-system-bus.c
index 1e6e0269edcc..f76be6bd6eb3 100644
--- a/drivers/bus/uniphier-system-bus.c
+++ b/drivers/bus/uniphier-system-bus.c
@@ -256,10 +256,23 @@ static int uniphier_system_bus_probe(struct platform_device *pdev)
 
 	uniphier_system_bus_set_reg(priv);
 
+	platform_set_drvdata(pdev, priv);
+
 	/* Now, the bus is configured.  Populate platform_devices below it */
 	return of_platform_default_populate(dev->of_node, NULL, dev);
 }
 
+static int __maybe_unused uniphier_system_bus_resume(struct device *dev)
+{
+	uniphier_system_bus_set_reg(dev_get_drvdata(dev));
+
+	return 0;
+}
+
+static const struct dev_pm_ops uniphier_system_bus_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, uniphier_system_bus_resume)
+};
+
 static const struct of_device_id uniphier_system_bus_match[] = {
 	{ .compatible = "socionext,uniphier-system-bus" },
 	{ /* sentinel */ }
@@ -271,6 +284,7 @@ static struct platform_driver uniphier_system_bus_driver = {
 	.driver = {
 		.name	= "uniphier-system-bus",
 		.of_match_table = uniphier_system_bus_match,
+		.pm = &uniphier_system_bus_pm_ops,
 	},
 };
 module_platform_driver(uniphier_system_bus_driver);
-- 
2.7.4
