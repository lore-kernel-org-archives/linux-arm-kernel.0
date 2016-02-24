From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:46:00 +0530
Subject: [PATCH 35/50] pinctrl: as3722: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-36-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pinctrl/pinctrl-as3722.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index e844fdc..0808569 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -569,8 +569,8 @@ static int as3722_pinctrl_probe(struct platform_device *pdev)
 	as3722_pinctrl_desc.name = dev_name(&pdev->dev);
 	as3722_pinctrl_desc.pins = as3722_pins_desc;
 	as3722_pinctrl_desc.npins = ARRAY_SIZE(as3722_pins_desc);
-	as_pci->pctl = pinctrl_register(&as3722_pinctrl_desc,
-					&pdev->dev, as_pci);
+	as_pci->pctl = devm_pinctrl_register(&pdev->dev, &as3722_pinctrl_desc,
+					     as_pci);
 	if (IS_ERR(as_pci->pctl)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
 		return PTR_ERR(as_pci->pctl);
@@ -582,7 +582,7 @@ static int as3722_pinctrl_probe(struct platform_device *pdev)
 	ret = gpiochip_add_data(&as_pci->gpio_chip, as_pci);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't register gpiochip, %d\n", ret);
-		goto fail_chip_add;
+		return ret;
 	}
 
 	ret = gpiochip_add_pin_range(&as_pci->gpio_chip, dev_name(&pdev->dev),
@@ -596,8 +596,6 @@ static int as3722_pinctrl_probe(struct platform_device *pdev)
 
 fail_range_add:
 	gpiochip_remove(&as_pci->gpio_chip);
-fail_chip_add:
-	pinctrl_unregister(as_pci->pctl);
 	return ret;
 }
 
@@ -606,7 +604,6 @@ static int as3722_pinctrl_remove(struct platform_device *pdev)
 	struct as3722_pctrl_info *as_pci = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&as_pci->gpio_chip);
-	pinctrl_unregister(as_pci->pctl);
 	return 0;
 }
 
-- 
2.1.4
