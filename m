From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:50 +0900
Subject: [PATCH 054/142] sh-pfc: Return an error if a pin doesn't support the
 requested direction
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-55-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

When setting a pin direction verify that the requested direction is
supported, and return an error if it isn't.

This requires pin configuration information to be supplied by SoC data.
The check is a no-op if the information is not supplied.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pinctrl.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 52179bb..aef268b 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -218,8 +218,18 @@ static int sh_pfc_gpio_set_direction(struct pinctrl_dev *pctldev,
 	const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
 	struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
 	unsigned long flags;
+	unsigned int dir;
 	int ret;
 
+	/* Check if the requested direction is supported by the pin. Not all SoC
+	 * provide pin config data, so perform the check conditionally.
+	 */
+	if (pin->configs) {
+		dir = input ? SH_PFC_PIN_CFG_INPUT : SH_PFC_PIN_CFG_OUTPUT;
+		if (!(pin->configs & dir))
+			return -EINVAL;
+	}
+
 	spin_lock_irqsave(&pfc->lock, flags);
 
 	ret = sh_pfc_config_mux(pfc, pin->enum_id, new_type);
-- 
1.7.10.4
