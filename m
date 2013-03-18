From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:37 +0900
Subject: [PATCH 041/142] sh-pfc: Fix return value check in
 sh_pfc_register_pinctrl()
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-42-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function pinctrl_register() returns NULL not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pinctrl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index c7f3c40..3e49bf0 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -395,8 +395,8 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	pmx->pctl_desc.npins = pfc->info->nr_pins;
 
 	pmx->pctl = pinctrl_register(&pmx->pctl_desc, pfc->dev, pmx);
-	if (IS_ERR(pmx->pctl))
-		return PTR_ERR(pmx->pctl);
+	if (pmx->pctl == NULL)
+		return -EINVAL;
 
 	return 0;
 }
-- 
1.7.10.4
