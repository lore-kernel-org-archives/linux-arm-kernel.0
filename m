From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Aug 2013 19:19:44 +0200
Subject: [PATCH] pinctrl: sunxi: drop lock on error path
Message-ID: <1377796784-31147-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I forgot to drop the lock for the return inside the loop
protected by the spinlock in the pin config routine when
merging in -rc7 in commit 6ad30ce046aefbdc3848232c665a728860d7bb68

Reported-by: Sherman Yin <syin@broadcom.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-sunxi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 532202b..4432e5e 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -291,8 +291,10 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 		switch (pinconf_to_config_param(configs[i])) {
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			strength = pinconf_to_config_argument(configs[i]);
-			if (strength > 40)
+			if (strength > 40) {
+				spin_unlock_irqrestore(&pctl->lock, flags);
 				return -EINVAL;
+			}
 			/*
 			 * We convert from mA to what the register expects:
 			 *   0: 10mA
-- 
1.8.3.1
