From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 15 Aug 2011 14:28:16 -0600
Subject: [RFC PATCH v2 09/13] gpio/tegra: Add device tree support
In-Reply-To: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
Message-ID: <1313440100-17131-10-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/gpio/gpio-tegra.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 4da4839..1d0a764 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -326,6 +326,30 @@ static struct irq_chip tegra_gpio_irq_chip = {
 #endif
 };
 
+#ifdef CONFIG_OF
+static void __init tegra_gpio_probe_dt(struct platform_device *pdev)
+{
+	const __be32 *gpios;
+	u32 gpioslen;
+	int i;
+
+	gpios = of_get_property(pdev->dev.of_node, "nvidia,enabled-gpios",
+				&gpioslen);
+	if (gpios == NULL)
+		return;
+
+	gpioslen /= sizeof(*gpios);
+	for (i = 0; i < gpioslen; i++, gpios++) {
+		u32 gpio = be32_to_cpup(gpios);
+		dev_dbg(&pdev->dev, "Enabling GPIO %d\n", gpio);
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
@@ -371,13 +395,21 @@ static int __init tegra_gpio_probe(struct platform_device *pdev)
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
