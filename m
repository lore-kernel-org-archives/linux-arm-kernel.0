From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:29 +0530
Subject: [PATCH 04/50] pinctrl: bcm2835: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Ray Jui <rjui@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 0f5997c..25bc4a2 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -1027,7 +1027,7 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	pc->pctl_dev = pinctrl_register(&bcm2835_pinctrl_desc, dev, pc);
+	pc->pctl_dev = devm_pinctrl_register(dev, &bcm2835_pinctrl_desc, pc);
 	if (IS_ERR(pc->pctl_dev)) {
 		gpiochip_remove(&pc->gpio_chip);
 		return PTR_ERR(pc->pctl_dev);
@@ -1045,7 +1045,6 @@ static int bcm2835_pinctrl_remove(struct platform_device *pdev)
 {
 	struct bcm2835_pinctrl *pc = platform_get_drvdata(pdev);
 
-	pinctrl_unregister(pc->pctl_dev);
 	gpiochip_remove(&pc->gpio_chip);
 
 	return 0;
-- 
2.1.4
