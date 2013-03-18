From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:47 +0900
Subject: [PATCH 051/142] sh-pfc: Merge sh_pfc_reconfig_pin() into
 sh_pfc_gpio_set_direction()
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-52-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The sh_pfc_reconfig_pin() is only called from a single location. Merge
it into its call site to make the code easier to follow.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pinctrl.c |   71 +++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 79fa170..36f08f8 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -135,43 +135,6 @@ static void sh_pfc_func_disable(struct pinctrl_dev *pctldev, unsigned selector,
 {
 }
 
-static int sh_pfc_reconfig_pin(struct sh_pfc_pinctrl *pmx, unsigned offset,
-			       int new_type)
-{
-	struct sh_pfc *pfc = pmx->pfc;
-	int idx = sh_pfc_get_pin_index(pfc, offset);
-	struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
-	const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
-	unsigned int mark = pin->enum_id;
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&pfc->lock, flags);
-
-	switch (cfg->type) {
-	case PINMUX_TYPE_GPIO:
-	case PINMUX_TYPE_OUTPUT:
-	case PINMUX_TYPE_INPUT:
-	case PINMUX_TYPE_INPUT_PULLUP:
-	case PINMUX_TYPE_INPUT_PULLDOWN:
-		break;
-	default:
-		ret = -EINVAL;
-		goto done;
-	}
-
-	ret = sh_pfc_config_mux(pfc, mark, new_type);
-	if (ret < 0)
-		goto done;
-
-	cfg->type = new_type;
-
-done:
-	spin_unlock_irqrestore(&pfc->lock, flags);
-
-	return ret;
-}
-
 static int sh_pfc_gpio_request_enable(struct pinctrl_dev *pctldev,
 				      struct pinctrl_gpio_range *range,
 				      unsigned offset)
@@ -216,9 +179,39 @@ static int sh_pfc_gpio_set_direction(struct pinctrl_dev *pctldev,
 				     unsigned offset, bool input)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
-	int type = input ? PINMUX_TYPE_INPUT : PINMUX_TYPE_OUTPUT;
+	struct sh_pfc *pfc = pmx->pfc;
+	int new_type = input ? PINMUX_TYPE_INPUT : PINMUX_TYPE_OUTPUT;
+	int idx = sh_pfc_get_pin_index(pfc, offset);
+	struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
+	const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
+	unsigned int mark = pin->enum_id;
+	unsigned long flags;
+	int ret;
 
-	return sh_pfc_reconfig_pin(pmx, offset, type);
+	spin_lock_irqsave(&pfc->lock, flags);
+
+	switch (cfg->type) {
+	case PINMUX_TYPE_GPIO:
+	case PINMUX_TYPE_OUTPUT:
+	case PINMUX_TYPE_INPUT:
+	case PINMUX_TYPE_INPUT_PULLUP:
+	case PINMUX_TYPE_INPUT_PULLDOWN:
+		break;
+	default:
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = sh_pfc_config_mux(pfc, mark, new_type);
+	if (ret < 0)
+		goto done;
+
+	cfg->type = new_type;
+
+done:
+	spin_unlock_irqrestore(&pfc->lock, flags);
+
+	return ret;
 }
 
 static const struct pinmux_ops sh_pfc_pinmux_ops = {
-- 
1.7.10.4
