From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:45 +0530
Subject: [PATCH 20/50] pinctrl: ssbi-mpp: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-21-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
the error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 54a5402..49cc734 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -820,7 +820,7 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 	pctrl->desc.custom_conf_items = pm8xxx_conf_items;
 #endif
 
-	pctrl->pctrl = pinctrl_register(&pctrl->desc, &pdev->dev, pctrl);
+	pctrl->pctrl = devm_pinctrl_register(&pdev->dev, &pctrl->desc, pctrl);
 	if (IS_ERR(pctrl->pctrl)) {
 		dev_err(&pdev->dev, "couldn't register pm8xxx mpp driver\n");
 		return PTR_ERR(pctrl->pctrl);
@@ -836,7 +836,7 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "failed register gpiochip\n");
-		goto unregister_pinctrl;
+		return ret;
 	}
 
 	ret = gpiochip_add_pin_range(&pctrl->chip,
@@ -856,9 +856,6 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 unregister_gpiochip:
 	gpiochip_remove(&pctrl->chip);
 
-unregister_pinctrl:
-	pinctrl_unregister(pctrl->pctrl);
-
 	return ret;
 }
 
@@ -868,8 +865,6 @@ static int pm8xxx_mpp_remove(struct platform_device *pdev)
 
 	gpiochip_remove(&pctrl->chip);
 
-	pinctrl_unregister(pctrl->pctrl);
-
 	return 0;
 }
 
-- 
2.1.4
