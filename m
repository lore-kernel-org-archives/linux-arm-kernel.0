From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  9 Aug 2013 14:20:50 +0200
Subject: [PATCH 1/5] pinctrl: imx: make error messages more informative
In-Reply-To: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1376050854-3303-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When printing error messages about errors in the devicetree also print
the offending node to give the use a hint what might be wrong.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pinctrl/pinctrl-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 57a4eb0..b063189 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -428,7 +428,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 	list = of_get_property(np, "fsl,pins", &size);
 	/* we do not check return since it's safe node passed down */
 	if (!size || size % pin_size) {
-		dev_err(info->dev, "Invalid fsl,pins property\n");
+		dev_err(info->dev, "Invalid fsl,pins property in node %s\n", np->full_name);
 		return -EINVAL;
 	}
 
@@ -496,7 +496,7 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	func->name = np->name;
 	func->num_groups = of_get_child_count(np);
 	if (func->num_groups <= 0) {
-		dev_err(info->dev, "no groups defined\n");
+		dev_err(info->dev, "no groups defined in %s\n", np->full_name);
 		return -EINVAL;
 	}
 	func->groups = devm_kzalloc(info->dev,
-- 
1.8.4.rc1
