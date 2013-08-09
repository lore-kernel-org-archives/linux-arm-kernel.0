From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  9 Aug 2013 14:20:52 +0200
Subject: [PATCH 3/5] pinctrl: imx: do not fail when parsing a group fails
In-Reply-To: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1376050854-3303-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX pinctrl driver completely bails out when it detects an error
in the pinctrl nodes. This usually means that whatever error a
devicetree has the user is left blind because even the console cannot
be initialized without working pinmux.

Instead of bailing out completely, just continue probing. This makes
the pinctrl driver work, only the erroneous groups will fail later
during pin request time.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pinctrl/pinctrl-imx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 780b197..e876122 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -489,7 +489,6 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	struct device_node *child;
 	struct imx_pmx_func *func;
 	struct imx_pin_group *grp;
-	int ret;
 	static u32 grp_index;
 	u32 i = 0;
 
@@ -510,9 +509,7 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	for_each_child_of_node(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
-		ret = imx_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret)
-			return ret;
+		imx_pinctrl_parse_groups(child, grp, info, i++);
 	}
 
 	return 0;
-- 
1.8.4.rc1
