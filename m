From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:46:03 +0530
Subject: [PATCH 38/50] pinctrl: digicolor: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-39-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Baruch Siach <baruch@tkos.co.il>
---
 drivers/pinctrl/pinctrl-digicolor.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
index f1343d6..c18014d 100644
--- a/drivers/pinctrl/pinctrl-digicolor.c
+++ b/drivers/pinctrl/pinctrl-digicolor.c
@@ -326,17 +326,15 @@ static int dc_pinctrl_probe(struct platform_device *pdev)
 
 	pmap->dev = &pdev->dev;
 
-	pmap->pctl = pinctrl_register(pctl_desc, &pdev->dev, pmap);
+	pmap->pctl = devm_pinctrl_register(&pdev->dev, pctl_desc, pmap);
 	if (IS_ERR(pmap->pctl)) {
 		dev_err(&pdev->dev, "pinctrl driver registration failed\n");
 		return PTR_ERR(pmap->pctl);
 	}
 
 	ret = dc_gpiochip_add(pmap, pdev->dev.of_node);
-	if (ret < 0) {
-		pinctrl_unregister(pmap->pctl);
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
@@ -345,7 +343,6 @@ static int dc_pinctrl_remove(struct platform_device *pdev)
 {
 	struct dc_pinmap *pmap = platform_get_drvdata(pdev);
 
-	pinctrl_unregister(pmap->pctl);
 	gpiochip_remove(&pmap->chip);
 
 	return 0;
-- 
2.1.4
