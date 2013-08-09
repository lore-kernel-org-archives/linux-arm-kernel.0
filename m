From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  9 Aug 2013 14:20:51 +0200
Subject: [PATCH 2/5] pinctrl: imx: Catch no fsl,pins property
In-Reply-To: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1376050854-3303-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of crashing the kernel print an error message when
the fsl,pins property is missing.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pinctrl/pinctrl-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index b063189..780b197 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -426,6 +426,11 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 	 * do sanity check and calculate pins number
 	 */
 	list = of_get_property(np, "fsl,pins", &size);
+	if (!list) {
+		dev_err(info->dev, "no fsl,pins property in node %s\n", np->full_name);
+		return -EINVAL;
+	}
+
 	/* we do not check return since it's safe node passed down */
 	if (!size || size % pin_size) {
 		dev_err(info->dev, "Invalid fsl,pins property in node %s\n", np->full_name);
-- 
1.8.4.rc1
