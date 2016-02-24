From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:59 +0530
Subject: [PATCH 34/50] pinctrl: amd: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-35-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pinctrl/pinctrl-amd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 5c025f5..59aa2ca 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -783,8 +783,8 @@ static int amd_gpio_probe(struct platform_device *pdev)
 	gpio_dev->ngroups = ARRAY_SIZE(kerncz_groups);
 
 	amd_pinctrl_desc.name = dev_name(&pdev->dev);
-	gpio_dev->pctrl = pinctrl_register(&amd_pinctrl_desc,
-					&pdev->dev, gpio_dev);
+	gpio_dev->pctrl = devm_pinctrl_register(&pdev->dev, &amd_pinctrl_desc,
+						gpio_dev);
 	if (IS_ERR(gpio_dev->pctrl)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
 		return PTR_ERR(gpio_dev->pctrl);
@@ -792,7 +792,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 
 	ret = gpiochip_add_data(&gpio_dev->gc, gpio_dev);
 	if (ret)
-		goto out1;
+		return ret;
 
 	ret = gpiochip_add_pin_range(&gpio_dev->gc, dev_name(&pdev->dev),
 				0, 0, TOTAL_NUMBER_OF_PINS);
@@ -825,8 +825,6 @@ static int amd_gpio_probe(struct platform_device *pdev)
 out2:
 	gpiochip_remove(&gpio_dev->gc);
 
-out1:
-	pinctrl_unregister(gpio_dev->pctrl);
 	return ret;
 }
 
@@ -837,7 +835,6 @@ static int amd_gpio_remove(struct platform_device *pdev)
 	gpio_dev = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&gpio_dev->gc);
-	pinctrl_unregister(gpio_dev->pctrl);
 
 	return 0;
 }
-- 
2.1.4
