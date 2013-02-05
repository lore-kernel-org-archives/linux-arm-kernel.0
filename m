From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 5 Feb 2013 20:48:26 +0100
Subject: [PATCH 05/14] pinctrl/abx500: prevent error path from corrupting
 returning error
In-Reply-To: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1360093715-6348-6-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

Prior to this patch abx500_gpio_probe() would return the return-value
of gpiochip_remove() during its error patch regardless of what the
actual failure was. So as long as gpiochip_remove() succeeded, probe()
would look like it succeeded too.

This patch ensures the correct error value is returned and that
mutex_destroy() is invoked if gpiochip_add_pin_range() were to fail.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-abx500.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
index 81ef515..9bdfcb9 100644
--- a/drivers/pinctrl/pinctrl-abx500.c
+++ b/drivers/pinctrl/pinctrl-abx500.c
@@ -1111,7 +1111,7 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 	struct abx500_gpio_platform_data *pdata;
 	struct abx500_pinctrl *pct;
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
-	int ret;
+	int ret, err;
 	int i;
 
 	pdata = abx500_pdata->gpio;
@@ -1189,6 +1189,7 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 	if (!pct->pctldev) {
 		dev_err(&pdev->dev,
 			"could not register abx500 pinctrl driver\n");
+		ret = -EINVAL;
 		goto out_rem_chip;
 	}
 	dev_info(&pdev->dev, "registered pin controller\n");
@@ -1201,7 +1202,7 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 					dev_name(&pdev->dev),
 					p->offset - 1, p->offset, p->npins);
 		if (ret < 0)
-			return ret;
+			goto out_rem_chip;
 	}
 
 	platform_set_drvdata(pdev, pct);
@@ -1210,8 +1211,8 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 	return 0;
 
 out_rem_chip:
-	ret = gpiochip_remove(&pct->chip);
-	if (ret)
+	err = gpiochip_remove(&pct->chip);
+	if (err)
 		dev_info(&pdev->dev, "failed to remove gpiochip\n");
 out_rem_irq:
 	abx500_gpio_irq_remove(pct);
-- 
1.7.11.3
