From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:50 +0530
Subject: [PATCH 25/50] pinctrl: ish-pfc: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-26-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc at vger.kernel.org
---
 drivers/pinctrl/sh-pfc/core.c    |  1 -
 drivers/pinctrl/sh-pfc/core.h    |  1 -
 drivers/pinctrl/sh-pfc/pinctrl.c | 12 +-----------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 181ea98..4b28fbb 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -587,7 +587,6 @@ static int sh_pfc_remove(struct platform_device *pdev)
 #ifdef CONFIG_GPIO_SH_PFC
 	sh_pfc_unregister_gpiochip(pfc);
 #endif
-	sh_pfc_unregister_pinctrl(pfc);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 62f53b2..8272114 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -57,7 +57,6 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc);
 int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
 
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
-int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc);
 
 u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width);
 void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 87b0a59..f17b5fc 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -692,19 +692,9 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	pmx->pctl_desc.pins = pmx->pins;
 	pmx->pctl_desc.npins = pfc->info->nr_pins;
 
-	pmx->pctl = pinctrl_register(&pmx->pctl_desc, pfc->dev, pmx);
+	pmx->pctl = devm_pinctrl_register(pfc->dev, &pmx->pctl_desc, pmx);
 	if (IS_ERR(pmx->pctl))
 		return PTR_ERR(pmx->pctl);
 
 	return 0;
 }
-
-int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc)
-{
-	struct sh_pfc_pinctrl *pmx = pfc->pinctrl;
-
-	pinctrl_unregister(pmx->pctl);
-
-	pfc->pinctrl = NULL;
-	return 0;
-}
-- 
2.1.4
