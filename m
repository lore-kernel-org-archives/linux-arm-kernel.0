From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 12 Aug 2011 16:54:53 -0600
Subject: [RFC PATCH 08/12] gpio/tegra: Add device tree support
In-Reply-To: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
Message-ID: <1313189697-21287-9-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/gpio/gpio-tegra.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 4da4839..923b413 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -326,6 +326,29 @@ static struct irq_chip tegra_gpio_irq_chip = {
 #endif
 };
 
+#ifdef CONFIG_OF
+static void __init tegra_gpio_probe_dt(struct platform_device *pdev)
+{
+	const __be32 *gpios;
+	u32 gpioslen;
+	int i;
+
+	gpios = of_get_property(pdev->dev.of_node, "nvidia,gpios", &gpioslen);
+	if (gpios == NULL)
+		return;
+
+	gpioslen /= sizeof(*gpios);
+	for (i = 0; i < gpioslen; i++, gpios++) {
+		u32 gpio = be32_to_cpup(gpios);
+		dev_err(&pdev->dev, "Enabling GPIO %d\n", gpio);
+		tegra_gpio_enable(gpio);
+	}
+}
+#else
+static inline void __init tegra_gpio_probe_dt(struct platform_device *pdev)
+{
+}
+#endif
 
 /* This lock class tells lockdep that GPIO irqs are in a different
  * category than their parents, so it won't report false recursion.
@@ -371,13 +394,21 @@ static int __init tegra_gpio_probe(struct platform_device *pdev)
 			spin_lock_init(&bank->lvl_lock[j]);
 	}
 
+	tegra_gpio_probe_dt(pdev);
+
 	return 0;
 }
 
+static struct of_device_id tegra_gpio_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-gpio", },
+	{ },
+};
+
 static struct platform_driver tegra_gpio_driver = {
 	.driver		= {
 		.name	= "tegra-gpio",
 		.owner	= THIS_MODULE,
+		.of_match_table = tegra_gpio_of_match,
 	},
 	.probe		= tegra_gpio_probe,
 };
-- 
1.7.0.4
