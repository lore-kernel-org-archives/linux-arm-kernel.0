From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:35 +0200
Subject: [PATCH 06/14] pinctrl: berlin: prepare to use regmap provided by
 syscon
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-7-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

The Berlin pin controller nodes will be simple-mfd probed sub-nodes of
soc-controller and system-controller nodes. The register bank is managed
by syscon, which provides a regmap.

Prepare to get the regmap from syscon parent node instead of SoC stub
provided regmap.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/berlin/berlin-bg2.c   | 8 ++++++++
 drivers/pinctrl/berlin/berlin-bg2cd.c | 8 ++++++++
 drivers/pinctrl/berlin/berlin-bg2q.c  | 8 ++++++++
 drivers/pinctrl/berlin/berlin.c       | 7 ++++++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
index b71a6fffef1b..6931ce4b1e12 100644
--- a/drivers/pinctrl/berlin/berlin-bg2.c
+++ b/drivers/pinctrl/berlin/berlin-bg2.c
@@ -225,6 +225,14 @@ static const struct of_device_id berlin2_pinctrl_match[] = {
 		.compatible = "marvell,berlin2-system-ctrl",
 		.data = &berlin2_sysmgr_pinctrl_data
 	},
+	{
+		.compatible = "marvell,berlin2-soc-pinctrl",
+		.data = &berlin2_soc_pinctrl_data
+	},
+	{
+		.compatible = "marvell,berlin2-system-pinctrl",
+		.data = &berlin2_sysmgr_pinctrl_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, berlin2_pinctrl_match);
diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
index 19ac5a22c947..18e1af0e6b8c 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -168,6 +168,14 @@ static const struct of_device_id berlin2cd_pinctrl_match[] = {
 		.compatible = "marvell,berlin2cd-system-ctrl",
 		.data = &berlin2cd_sysmgr_pinctrl_data
 	},
+	{
+		.compatible = "marvell,berlin2cd-soc-pinctrl",
+		.data = &berlin2cd_soc_pinctrl_data
+	},
+	{
+		.compatible = "marvell,berlin2cd-system-pinctrl",
+		.data = &berlin2cd_sysmgr_pinctrl_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, berlin2cd_pinctrl_match);
diff --git a/drivers/pinctrl/berlin/berlin-bg2q.c b/drivers/pinctrl/berlin/berlin-bg2q.c
index bd9662e57ad3..24e4cbb4d044 100644
--- a/drivers/pinctrl/berlin/berlin-bg2q.c
+++ b/drivers/pinctrl/berlin/berlin-bg2q.c
@@ -387,6 +387,14 @@ static const struct of_device_id berlin2q_pinctrl_match[] = {
 		.compatible = "marvell,berlin2q-system-ctrl",
 		.data = &berlin2q_sysmgr_pinctrl_data,
 	},
+	{
+		.compatible = "marvell,berlin2q-soc-pinctrl",
+		.data = &berlin2q_soc_pinctrl_data,
+	},
+	{
+		.compatible = "marvell,berlin2q-system-pinctrl",
+		.data = &berlin2q_sysmgr_pinctrl_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, berlin2q_pinctrl_match);
diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index 7f0b0f93242b..28551123d04f 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -295,13 +296,17 @@ int berlin_pinctrl_probe(struct platform_device *pdev,
 			 const struct berlin_pinctrl_desc *desc)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *parent_np = of_get_parent(dev->of_node);
 	struct berlin_pinctrl *pctrl;
 	struct regmap *regmap;
 	int ret;
 
 	regmap = dev_get_regmap(&pdev->dev, NULL);
 	if (!regmap)
-		return -ENODEV;
+		regmap = syscon_node_to_regmap(parent_np);
+	of_node_put(parent_np);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
-- 
2.1.0
