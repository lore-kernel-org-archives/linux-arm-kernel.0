From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  9 Aug 2013 14:20:53 +0200
Subject: [PATCH 4/5] pinctrl: imx: do not fail when parsing a function fails
In-Reply-To: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1376050854-3303-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When parsing a function fails this is no reason to make the whole
driver fail. Just continue with the next function.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pinctrl/pinctrl-imx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index e876122..f3c38e0 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -520,7 +520,6 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *child;
-	int ret;
 	u32 nfuncs = 0;
 	u32 i = 0;
 
@@ -547,13 +546,8 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 	if (!info->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
-		ret = imx_pinctrl_parse_functions(child, info, i++);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to parse function\n");
-			return ret;
-		}
-	}
+	for_each_child_of_node(np, child)
+		imx_pinctrl_parse_functions(child, info, i++);
 
 	return 0;
 }
-- 
1.8.4.rc1
