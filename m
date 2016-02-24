From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:46:14 +0530
Subject: [PATCH 49/50] pinctrl: u300: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-50-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and
remove the need of .remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pinctrl/pinctrl-u300.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-u300.c b/drivers/pinctrl/pinctrl-u300.c
index c076021..d1af908 100644
--- a/drivers/pinctrl/pinctrl-u300.c
+++ b/drivers/pinctrl/pinctrl-u300.c
@@ -1067,7 +1067,7 @@ static int u300_pmx_probe(struct platform_device *pdev)
 	if (IS_ERR(upmx->virtbase))
 		return PTR_ERR(upmx->virtbase);
 
-	upmx->pctl = pinctrl_register(&u300_pmx_desc, &pdev->dev, upmx);
+	upmx->pctl = devm_pinctrl_register(&pdev->dev, &u300_pmx_desc, upmx);
 	if (IS_ERR(upmx->pctl)) {
 		dev_err(&pdev->dev, "could not register U300 pinmux driver\n");
 		return PTR_ERR(upmx->pctl);
@@ -1080,15 +1080,6 @@ static int u300_pmx_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int u300_pmx_remove(struct platform_device *pdev)
-{
-	struct u300_pmx *upmx = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(upmx->pctl);
-
-	return 0;
-}
-
 static const struct of_device_id u300_pinctrl_match[] = {
 	{ .compatible = "stericsson,pinctrl-u300" },
 	{},
@@ -1101,7 +1092,6 @@ static struct platform_driver u300_pmx_driver = {
 		.of_match_table = u300_pinctrl_match,
 	},
 	.probe = u300_pmx_probe,
-	.remove = u300_pmx_remove,
 };
 
 static int __init u300_pmx_init(void)
-- 
2.1.4
