From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:53 +0530
Subject: [PATCH 28/50] pinctrl: ssbi-mpp: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-29-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
the error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 4513550..8eb6de8 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -932,18 +932,15 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	pctrl_desc->pctlops = &sunxi_pctrl_ops;
 	pctrl_desc->pmxops =  &sunxi_pmx_ops;
 
-	pctl->pctl_dev = pinctrl_register(pctrl_desc,
-					  &pdev->dev, pctl);
+	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
 	if (IS_ERR(pctl->pctl_dev)) {
 		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
 		return PTR_ERR(pctl->pctl_dev);
 	}
 
 	pctl->chip = devm_kzalloc(&pdev->dev, sizeof(*pctl->chip), GFP_KERNEL);
-	if (!pctl->chip) {
-		ret = -ENOMEM;
-		goto pinctrl_error;
-	}
+	if (!pctl->chip)
+		return -ENOMEM;
 
 	last_pin = pctl->desc->pins[pctl->desc->npins - 1].pin.number;
 	pctl->chip->owner = THIS_MODULE;
@@ -965,7 +962,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 
 	ret = gpiochip_add_data(pctl->chip, pctl);
 	if (ret)
-		goto pinctrl_error;
+		return ret;
 
 	for (i = 0; i < pctl->desc->npins; i++) {
 		const struct sunxi_desc_pin *pin = pctl->desc->pins + i;
@@ -1041,7 +1038,5 @@ clk_error:
 	clk_disable_unprepare(clk);
 gpiochip_error:
 	gpiochip_remove(pctl->chip);
-pinctrl_error:
-	pinctrl_unregister(pctl->pctl_dev);
 	return ret;
 }
-- 
2.1.4
