From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:41 +0530
Subject: [PATCH 16/50] pinctrl: nomadic: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-17-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c  | 3 ++-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index 1f7469c..d488124 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -1212,7 +1212,8 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 
 	abx500_pinctrl_desc.pins = pct->soc->pins;
 	abx500_pinctrl_desc.npins = pct->soc->npins;
-	pct->pctldev = pinctrl_register(&abx500_pinctrl_desc, &pdev->dev, pct);
+	pct->pctldev = devm_pinctrl_register(&pdev->dev, &abx500_pinctrl_desc,
+					     pct);
 	if (IS_ERR(pct->pctldev)) {
 		dev_err(&pdev->dev,
 			"could not register abx500 pinctrl driver\n");
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 3524061..ca5e9ea 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -2044,7 +2044,7 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 	nmk_pinctrl_desc.npins = npct->soc->npins;
 	npct->dev = &pdev->dev;
 
-	npct->pctl = pinctrl_register(&nmk_pinctrl_desc, &pdev->dev, npct);
+	npct->pctl = devm_pinctrl_register(&pdev->dev, &nmk_pinctrl_desc, npct);
 	if (IS_ERR(npct->pctl)) {
 		dev_err(&pdev->dev, "could not register Nomadik pinctrl driver\n");
 		return PTR_ERR(npct->pctl);
-- 
2.1.4
