From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 2 Nov 2018 09:13:03 +0000
Subject: [PATCH V4 06/10] pinctrl: fsl: imx7ulp: change to use imx legacy
 binding
In-Reply-To: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
References: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1541149669-10857-7-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already had an earlier conclusion that all new i.MX Socs will keep
using the legacy i.MX Pinctrl bindings instead of generic pin config.
However, MX7ULP generic pin config binding support has already been in
tree before that time. Per SoC maintainers' suggestions, in order to
get a better consistency for all i.MX devices, we'd like to go back to
imx legacy binding for MX7ULP as well.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-gpio at vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3: new patch
---
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c | 42 -----------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
index f521bdb..922ff73 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
@@ -256,46 +256,8 @@ static const struct pinctrl_pin_desc imx7ulp_pinctrl_pads[] = {
 
 #define BM_OBE_ENABLED		BIT(17)
 #define BM_IBE_ENABLED		BIT(16)
-#define BM_LK_ENABLED		BIT(15)
 #define BM_MUX_MODE		0xf00
 #define BP_MUX_MODE		8
-#define BM_PULL_ENABLED		BIT(1)
-
-static const struct imx_cfg_params_decode imx7ulp_cfg_decodes[] = {
-	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_DRIVE_STRENGTH, 		BIT(6), 6),
-	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_DRIVE_PUSH_PULL,		BIT(5), 5),
-	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_SLEW_RATE,			BIT(2), 2),
-	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_BIAS_DISABLE,			BIT(1), 1),
-	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_BIAS_PULL_UP,			BIT(0), 0),
-
-	IMX_CFG_PARAMS_DECODE_INVERT(PIN_CONFIG_DRIVE_OPEN_DRAIN,	BIT(5), 5),
-	IMX_CFG_PARAMS_DECODE_INVERT(PIN_CONFIG_BIAS_PULL_DOWN,		BIT(0), 0),
-};
-
-static void imx7ulp_cfg_params_fixup(unsigned long *configs,
-				    unsigned int num_configs,
-				    u32 *raw_config)
-{
-	enum pin_config_param param;
-	u32 param_val;
-	int i;
-
-	/* lock field disabled */
-	*raw_config &= ~BM_LK_ENABLED;
-
-	for (i = 0; i < num_configs; i++) {
-		param = pinconf_to_config_param(configs[i]);
-		param_val = pinconf_to_config_argument(configs[i]);
-
-		if ((param == PIN_CONFIG_BIAS_PULL_UP) ||
-		    (param == PIN_CONFIG_BIAS_PULL_DOWN)) {
-			/* pull enabled */
-			*raw_config |= BM_PULL_ENABLED;
-
-			return;
-		}
-	}
-}
 
 static int imx7ulp_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 					  struct pinctrl_gpio_range *range,
@@ -326,10 +288,6 @@ static const struct imx_pinctrl_soc_info imx7ulp_pinctrl_info = {
 	.gpio_set_direction = imx7ulp_pmx_gpio_set_direction,
 	.mux_mask = BM_MUX_MODE,
 	.mux_shift = BP_MUX_MODE,
-	.generic_pinconf = true,
-	.decodes = imx7ulp_cfg_decodes,
-	.num_decodes = ARRAY_SIZE(imx7ulp_cfg_decodes),
-	.fixup = imx7ulp_cfg_params_fixup,
 };
 
 static const struct of_device_id imx7ulp_pinctrl_of_match[] = {
-- 
2.7.4
