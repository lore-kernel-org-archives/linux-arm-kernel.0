From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:54 +0530
Subject: [PATCH 29/50] pinctrl: tegra: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-30-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and remove
need of .remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c    | 12 +-----------
 drivers/pinctrl/tegra/pinctrl-tegra.h    |  2 --
 drivers/pinctrl/tegra/pinctrl-tegra114.c |  1 -
 drivers/pinctrl/tegra/pinctrl-tegra124.c |  1 -
 drivers/pinctrl/tegra/pinctrl-tegra20.c  |  1 -
 drivers/pinctrl/tegra/pinctrl-tegra210.c |  1 -
 drivers/pinctrl/tegra/pinctrl-tegra30.c  |  1 -
 7 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 4938882..e9e8744 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -719,7 +719,7 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 			return PTR_ERR(pmx->regs[i]);
 	}
 
-	pmx->pctl = pinctrl_register(&tegra_pinctrl_desc, &pdev->dev, pmx);
+	pmx->pctl = devm_pinctrl_register(&pdev->dev, &tegra_pinctrl_desc, pmx);
 	if (IS_ERR(pmx->pctl)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
 		return PTR_ERR(pmx->pctl);
@@ -735,13 +735,3 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra_pinctrl_probe);
-
-int tegra_pinctrl_remove(struct platform_device *pdev)
-{
-	struct tegra_pmx *pmx = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(pmx->pctl);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tegra_pinctrl_remove);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegra/pinctrl-tegra.h
index 1615db7..05785e5 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.h
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
@@ -189,6 +189,4 @@ struct tegra_pinctrl_soc_data {
 
 int tegra_pinctrl_probe(struct platform_device *pdev,
 			const struct tegra_pinctrl_soc_data *soc_data);
-int tegra_pinctrl_remove(struct platform_device *pdev);
-
 #endif
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra114.c b/drivers/pinctrl/tegra/pinctrl-tegra114.c
index 05e49d5..236cc57 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra114.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra114.c
@@ -1863,7 +1863,6 @@ static struct platform_driver tegra114_pinctrl_driver = {
 		.of_match_table = tegra114_pinctrl_of_match,
 	},
 	.probe = tegra114_pinctrl_probe,
-	.remove = tegra_pinctrl_remove,
 };
 module_platform_driver(tegra114_pinctrl_driver);
 
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra124.c b/drivers/pinctrl/tegra/pinctrl-tegra124.c
index 7cd44c7..749ea05 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra124.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra124.c
@@ -2075,7 +2075,6 @@ static struct platform_driver tegra124_pinctrl_driver = {
 		.of_match_table = tegra124_pinctrl_of_match,
 	},
 	.probe = tegra124_pinctrl_probe,
-	.remove = tegra_pinctrl_remove,
 };
 module_platform_driver(tegra124_pinctrl_driver);
 
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index 4833db4..979e329 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -2242,7 +2242,6 @@ static struct platform_driver tegra20_pinctrl_driver = {
 		.of_match_table = tegra20_pinctrl_of_match,
 	},
 	.probe = tegra20_pinctrl_probe,
-	.remove = tegra_pinctrl_remove,
 };
 module_platform_driver(tegra20_pinctrl_driver);
 
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra210.c b/drivers/pinctrl/tegra/pinctrl-tegra210.c
index 252b464..cb2c87d8 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra210.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra210.c
@@ -1579,7 +1579,6 @@ static struct platform_driver tegra210_pinctrl_driver = {
 		.of_match_table = tegra210_pinctrl_of_match,
 	},
 	.probe = tegra210_pinctrl_probe,
-	.remove = tegra_pinctrl_remove,
 };
 module_platform_driver(tegra210_pinctrl_driver);
 
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra30.c b/drivers/pinctrl/tegra/pinctrl-tegra30.c
index 47b2fd8..6b3e96c 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra30.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra30.c
@@ -2498,7 +2498,6 @@ static struct platform_driver tegra30_pinctrl_driver = {
 		.of_match_table = tegra30_pinctrl_of_match,
 	},
 	.probe = tegra30_pinctrl_probe,
-	.remove = tegra_pinctrl_remove,
 };
 module_platform_driver(tegra30_pinctrl_driver);
 
-- 
2.1.4
