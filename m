From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri, 13 Sep 2013 09:49:09 +0200
Subject: [RFC PATCH 3/4] pinctrl: at91: improve pinconf_set/get function
 robustness
In-Reply-To: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
References: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1379058549-3413-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reset caller's config variable before setting current config flags to avoid
erronous config return.

DEBOUNCE and DEGLITCH options are mutually exclusive. Return an error if they
are both defined in the config.
Do not call set_deglitch if DEBOUNCE is enabled to avoid reseting the IFSR
register (which will result in disabling the debounce filter).

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/pinctrl/pinctrl-at91.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 6624bce..ac9dbea 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -724,6 +724,7 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
 	dev_dbg(info->dev, "%s:%d, pin_id=%d, config=0x%lx", __func__, __LINE__, pin_id, *config);
 	pio = pin_to_controller(info, pin_to_bank(pin_id));
 	pin = pin_id % MAX_NB_GPIO_PER_BANK;
+	*config = 0;
 
 	if (at91_mux_get_multidrive(pio, pin))
 		*config |= MULTI_DRIVE;
@@ -757,13 +758,20 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 	if (config & PULL_UP && config & PULL_DOWN)
 		return -EINVAL;
 
-	at91_mux_set_pullup(pio, mask, config & PULL_UP);
-	at91_mux_set_multidrive(pio, mask, config & MULTI_DRIVE);
-	if (info->ops->set_deglitch)
-		info->ops->set_deglitch(pio, mask, config & DEGLITCH);
-	if (info->ops->set_debounce)
+	if (config & DEBOUNCE && config & DEGLITCH)
+		return -EINVAL;
+
+	if (config & DEBOUNCE) {
+		if (!info->ops->set_debounce)
+			return -ENOTSUPP;
+
 		info->ops->set_debounce(pio, mask, config & DEBOUNCE,
 				(config & DEBOUNCE_VAL) >> DEBOUNCE_VAL_SHIFT);
+	} else if (info->ops->set_deglitch)
+		info->ops->set_deglitch(pio, mask, config & DEGLITCH);
+
+	at91_mux_set_pullup(pio, mask, config & PULL_UP);
+	at91_mux_set_multidrive(pio, mask, config & MULTI_DRIVE);
 	if (info->ops->set_pulldown)
 		info->ops->set_pulldown(pio, mask, config & PULL_DOWN);
 	if (info->ops->disable_schmitt_trig && config & DIS_SCHMIT)
-- 
1.7.9.5
