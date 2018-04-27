From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 03:01:49 +0800
Subject: [PATCH 2/6] pinctrl: pinctrl-imx: improve the code comments of
 PIN_FUNC_ID
In-Reply-To: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
References: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1524855713-15527-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code comments of PIN_FUNC_ID actually is not true for
SHARE_MUX_CONF_REG case which should be a 4 u32 PIN_FUNC_ID.
Fix the comments and re-org it a bit for better extendibility
as we may add a different size for SCU based PIN_FUNC_ID later.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 77cd364..ff6ca6a4 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -414,11 +414,18 @@ static const struct pinconf_ops imx_pinconf_ops = {
 };
 
 /*
- * Each pin represented in fsl,pins consists of 5 u32 PIN_FUNC_ID and
- * 1 u32 CONFIG, so 24 types in total for each pin.
+ * Each pin represented in fsl,pins consists of a number of u32 PIN_FUNC_ID
+ * and 1 u32 CONFIG, the total size is PIN_FUNC_ID + CONFIG for each pin.
+ * For generic_pinconf case, there's no extra u32 CONFIG.
+ *
+ * PIN_FUNC_ID format:
+ * Default:
+ *     <mux_reg conf_reg input_reg mux_mode input_val>
+ * SHARE_MUX_CONF_REG:
+ *     <mux_conf_reg input_reg mux_mode input_val>
  */
 #define FSL_PIN_SIZE 24
-#define SHARE_FSL_PIN_SIZE 20
+#define FSL_PIN_SHARE_SIZE 20
 
 static int imx_pinctrl_parse_groups(struct device_node *np,
 				    struct group_desc *grp,
@@ -434,7 +441,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 	dev_dbg(ipctl->dev, "group(%d): %s\n", index, np->name);
 
 	if (info->flags & SHARE_MUX_CONF_REG)
-		pin_size = SHARE_FSL_PIN_SIZE;
+		pin_size = FSL_PIN_SHARE_SIZE;
 	else
 		pin_size = FSL_PIN_SIZE;
 
-- 
2.7.4
