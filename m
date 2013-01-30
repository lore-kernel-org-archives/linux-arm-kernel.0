From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 30 Jan 2013 20:40:22 +0100
Subject: [PATCH 4/4] pinctrl/abx500: destroy mutex if returning early due to
 error
Message-ID: <1359574822-15729-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

Current failure path neglects to mutex_destroy() before returning
an error due to an invalid parameter or an error received from
gpiochip_add(). This patch aims to remedy that behaviour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-abx500.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
index 426b47c..81ef515 100644
--- a/drivers/pinctrl/pinctrl-abx500.c
+++ b/drivers/pinctrl/pinctrl-abx500.c
@@ -1155,11 +1155,13 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 	default:
 		dev_err(&pdev->dev, "Unsupported pinctrl sub driver (%d)\n",
 				(int) platid->driver_data);
+		mutex_destroy(&pct->lock);
 		return -EINVAL;
 	}
 
 	if (!pct->soc) {
 		dev_err(&pdev->dev, "Invalid SOC data\n");
+		mutex_destroy(&pct->lock);
 		return -EINVAL;
 	}
 
@@ -1176,6 +1178,7 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 	ret = gpiochip_add(&pct->chip);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
+		mutex_destroy(&pct->lock);
 		goto out_rem_irq;
 	}
 	dev_info(&pdev->dev, "added gpiochip\n");
-- 
1.7.11.3
