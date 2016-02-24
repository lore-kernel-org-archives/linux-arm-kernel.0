From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:46:06 +0530
Subject: [PATCH 41/50] pinctrl: palmas: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-42-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and
remove the need of .remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pinctrl/pinctrl-palmas.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-palmas.c b/drivers/pinctrl/pinctrl-palmas.c
index f7e1680..07b952b 100644
--- a/drivers/pinctrl/pinctrl-palmas.c
+++ b/drivers/pinctrl/pinctrl-palmas.c
@@ -1043,7 +1043,8 @@ static int palmas_pinctrl_probe(struct platform_device *pdev)
 	palmas_pinctrl_desc.name = dev_name(&pdev->dev);
 	palmas_pinctrl_desc.pins = palmas_pins_desc;
 	palmas_pinctrl_desc.npins = ARRAY_SIZE(palmas_pins_desc);
-	pci->pctl = pinctrl_register(&palmas_pinctrl_desc, &pdev->dev, pci);
+	pci->pctl = devm_pinctrl_register(&pdev->dev, &palmas_pinctrl_desc,
+					  pci);
 	if (IS_ERR(pci->pctl)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
 		return PTR_ERR(pci->pctl);
@@ -1051,21 +1052,12 @@ static int palmas_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int palmas_pinctrl_remove(struct platform_device *pdev)
-{
-	struct palmas_pctrl_chip_info *pci = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(pci->pctl);
-	return 0;
-}
-
 static struct platform_driver palmas_pinctrl_driver = {
 	.driver = {
 		.name = "palmas-pinctrl",
 		.of_match_table = palmas_pinctrl_of_match,
 	},
 	.probe = palmas_pinctrl_probe,
-	.remove = palmas_pinctrl_remove,
 };
 
 module_platform_driver(palmas_pinctrl_driver);
-- 
2.1.4
