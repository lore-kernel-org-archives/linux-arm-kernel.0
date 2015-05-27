From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 27 May 2015 02:43:55 -0700
Subject: [PATCH 2/2] pinctrl: mediatek: Fix pinctrl register irq fail bug.
In-Reply-To: <1432719835-18939-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1432719835-18939-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1432719835-18939-3-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since mt6397 is no need to support interrupt controller,
I judged "interrupt-controller" property to skip it last patch.
But the if judgement should on the contrary, this is a bug.

And find of_property_read_bool is better for this case.
So using of_property_read_bool instead of of_find_property.

Also fix bug of misuse pointer.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index cd22729..f206a54 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1280,7 +1280,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 		goto pctrl_error;
 	}
 
-	pctl->chip = &mtk_gpio_chip;
+	*pctl->chip = mtk_gpio_chip;
 	pctl->chip->ngpio = pctl->devdata->npins;
 	pctl->chip->label = dev_name(&pdev->dev);
 	pctl->chip->dev = &pdev->dev;
@@ -1300,7 +1300,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 		goto chip_error;
 	}
 
-	if (of_find_property(np, "interrupt-controller", NULL))
+	if (!of_property_read_bool(np, "interrupt-controller"))
 		return 0;
 
 	/* Get EINT register base from dts. */
-- 
1.7.9.5
