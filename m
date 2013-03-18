From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:09 +0900
Subject: [PATCH 013/142] sh-pfc: Don't needlessly check GPIO type in
 sh_gpio_free()
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-14-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The GPIO type is always PINMUX_TYPE_FUNCTION when freeing a function
GPIO. Hardcode the type value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/gpio.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 80a50d8..8f01113 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -71,16 +71,13 @@ static void sh_gpio_free(struct gpio_chip *gc, unsigned offset)
 {
 	struct sh_pfc *pfc = gpio_to_pfc(gc);
 	unsigned long flags;
-	int pinmux_type;
 
 	if (offset < pfc->info->nr_pins)
 		return pinctrl_free_gpio(offset);
 
 	spin_lock_irqsave(&pfc->lock, flags);
 
-	pinmux_type = pfc->info->gpios[offset].flags & PINMUX_FLAG_TYPE;
-
-	sh_pfc_config_gpio(pfc, offset, pinmux_type, GPIO_CFG_FREE);
+	sh_pfc_config_gpio(pfc, offset, PINMUX_TYPE_FUNCTION, GPIO_CFG_FREE);
 
 	spin_unlock_irqrestore(&pfc->lock, flags);
 }
-- 
1.7.10.4
