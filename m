From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:14 +0200
Subject: [PATCH 04/13] pinctrl: tegra: Only set the gpio range if needed
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-5-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the gpio DT node has the gpio-ranges property, the range will be
added by the gpio core and doesn't need to be added by the pinctrl
driver.

By having the gpio-ranges property, we have an explicit dependency from
the gpio node to the pinctrl node and we can stop using the deprecated
pinctrl_add_gpio_range() function.

Note that when the GPIO device gets probed before the associated
princtrl device, the gpio core actually won't register the gpio range.
Thus, this patch is only safe to be merged after we have in place a way
to assure that gpio devices are probed after their associated pinctrl
devices (such as ordered probing).

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/pinctrl/pinctrl-tegra.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-tegra.c b/drivers/pinctrl/pinctrl-tegra.c
index 0f982b8..0fd7fd2 100644
--- a/drivers/pinctrl/pinctrl-tegra.c
+++ b/drivers/pinctrl/pinctrl-tegra.c
@@ -624,6 +624,22 @@ static struct pinctrl_desc tegra_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
+static bool gpio_node_has_range(void)
+{
+	struct device_node *np;
+	bool has_prop = false;
+
+	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra30-gpio");
+	if (!np)
+		return has_prop;
+
+	has_prop = of_find_property(np, "gpio-ranges", NULL);
+
+	of_node_put(np);
+
+	return has_prop;
+}
+
 int tegra_pinctrl_probe(struct platform_device *pdev,
 			const struct tegra_pinctrl_soc_data *soc_data)
 {
@@ -708,7 +724,8 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 		return PTR_ERR(pmx->pctl);
 	}
 
-	pinctrl_add_gpio_range(pmx->pctl, &tegra_pinctrl_gpio_range);
+	if (!gpio_node_has_range())
+		pinctrl_add_gpio_range(pmx->pctl, &tegra_pinctrl_gpio_range);
 
 	platform_set_drvdata(pdev, pmx);
 
-- 
2.4.1
