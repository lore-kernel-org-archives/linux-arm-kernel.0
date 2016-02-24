From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:57 +0530
Subject: [PATCH 32/50] pinctrl: vt8500: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-33-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
the error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 drivers/pinctrl/vt8500/pinctrl-wmt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 5c261bf..159672b 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -583,7 +583,7 @@ int wmt_pinctrl_probe(struct platform_device *pdev,
 
 	data->dev = &pdev->dev;
 
-	data->pctl_dev = pinctrl_register(&wmt_desc, &pdev->dev, data);
+	data->pctl_dev = devm_pinctrl_register(&pdev->dev, &wmt_desc, data);
 	if (IS_ERR(data->pctl_dev)) {
 		dev_err(&pdev->dev, "Failed to register pinctrl\n");
 		return PTR_ERR(data->pctl_dev);
@@ -592,7 +592,7 @@ int wmt_pinctrl_probe(struct platform_device *pdev,
 	err = gpiochip_add_data(&data->gpio_chip, data);
 	if (err) {
 		dev_err(&pdev->dev, "could not add GPIO chip\n");
-		goto fail_gpio;
+		return ret;
 	}
 
 	err = gpiochip_add_pin_range(&data->gpio_chip, dev_name(data->dev),
@@ -606,8 +606,6 @@ int wmt_pinctrl_probe(struct platform_device *pdev,
 
 fail_range:
 	gpiochip_remove(&data->gpio_chip);
-fail_gpio:
-	pinctrl_unregister(data->pctl_dev);
 	return err;
 }
 
@@ -616,7 +614,6 @@ int wmt_pinctrl_remove(struct platform_device *pdev)
 	struct wmt_pinctrl_data *data = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&data->gpio_chip);
-	pinctrl_unregister(data->pctl_dev);
 
 	return 0;
 }
-- 
2.1.4
