From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:00 +0900
Subject: [PATCH 004/142] sh-pfc: Drop the sh_pfc_pinctrl spinlock
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The spinlock is used to protect data that is only accessed sequentially
during initialization. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pinctrl.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index d113746..9bd0a83 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -37,8 +37,6 @@ struct sh_pfc_pinctrl {
 
 	struct pinctrl_pin_desc *pads;
 	unsigned int nr_pads;
-
-	spinlock_t lock;
 };
 
 static int sh_pfc_get_groups_count(struct pinctrl_dev *pctldev)
@@ -321,7 +319,6 @@ static void sh_pfc_map_one_gpio(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx,
 				struct pinmux_gpio *gpio, unsigned offset)
 {
 	struct pinmux_data_reg *dummy;
-	unsigned long flags;
 	int bit;
 
 	gpio->flags &= ~PINMUX_FLAG_TYPE;
@@ -330,10 +327,7 @@ static void sh_pfc_map_one_gpio(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx,
 		gpio->flags |= PINMUX_TYPE_GPIO;
 	else {
 		gpio->flags |= PINMUX_TYPE_FUNCTION;
-
-		spin_lock_irqsave(&pmx->lock, flags);
 		pmx->nr_functions++;
-		spin_unlock_irqrestore(&pmx->lock, flags);
 	}
 }
 
@@ -381,7 +375,6 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 
 static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
-	unsigned long flags;
 	int i, fn;
 
 	pmx->functions = devm_kzalloc(pfc->dev, pmx->nr_functions *
@@ -389,8 +382,6 @@ static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 	if (unlikely(!pmx->functions))
 		return -ENOMEM;
 
-	spin_lock_irqsave(&pmx->lock, flags);
-
 	for (i = fn = 0; i < pmx->nr_pads; i++) {
 		struct pinmux_gpio *gpio = pfc->info->gpios + i;
 
@@ -398,8 +389,6 @@ static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 			pmx->functions[fn++] = gpio;
 	}
 
-	spin_unlock_irqrestore(&pmx->lock, flags);
-
 	return 0;
 }
 
@@ -412,8 +401,6 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	if (unlikely(!pmx))
 		return -ENOMEM;
 
-	spin_lock_init(&pmx->lock);
-
 	pmx->pfc = pfc;
 	pfc->pinctrl = pmx;
 
-- 
1.7.10.4
