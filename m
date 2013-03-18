From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:01 +0900
Subject: [PATCH 005/142] sh-pfc: Don't take the sh_pfc spinlock in
 sh_pfc_map_gpios()
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The sh_pfc_map_gpios() function is only called at initialization time
when no other task can access the sh_pfc fields. Don't protect the
operation with a spinlock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pinctrl.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 9bd0a83..4ce2753 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -334,7 +334,6 @@ static void sh_pfc_map_one_gpio(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx,
 /* pinmux ranges -> pinctrl pin descs */
 static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
-	unsigned long flags;
 	int i;
 
 	pmx->nr_pads = pfc->info->last_gpio - pfc->info->first_gpio + 1;
@@ -346,8 +345,6 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 		return -ENOMEM;
 	}
 
-	spin_lock_irqsave(&pfc->lock, flags);
-
 	/*
 	 * We don't necessarily have a 1:1 mapping between pin and linux
 	 * GPIO number, as the latter maps to the associated enum_id.
@@ -368,8 +365,6 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 		sh_pfc_map_one_gpio(pfc, pmx, gpio, i);
 	}
 
-	spin_unlock_irqrestore(&pfc->lock, flags);
-
 	return 0;
 }
 
-- 
1.7.10.4
