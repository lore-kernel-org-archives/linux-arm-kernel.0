From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:46 +0530
Subject: [PATCH 21/50] pinctrl: msm: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-22-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
the error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 8777cf0..dc7bf77 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -898,17 +898,16 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	msm_pinctrl_desc.name = dev_name(&pdev->dev);
 	msm_pinctrl_desc.pins = pctrl->soc->pins;
 	msm_pinctrl_desc.npins = pctrl->soc->npins;
-	pctrl->pctrl = pinctrl_register(&msm_pinctrl_desc, &pdev->dev, pctrl);
+	pctrl->pctrl = devm_pinctrl_register(&pdev->dev, &msm_pinctrl_desc,
+					     pctrl);
 	if (IS_ERR(pctrl->pctrl)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
 		return PTR_ERR(pctrl->pctrl);
 	}
 
 	ret = msm_gpio_init(pctrl);
-	if (ret) {
-		pinctrl_unregister(pctrl->pctrl);
+	if (ret)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, pctrl);
 
@@ -923,7 +922,6 @@ int msm_pinctrl_remove(struct platform_device *pdev)
 	struct msm_pinctrl *pctrl = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&pctrl->chip);
-	pinctrl_unregister(pctrl->pctrl);
 
 	unregister_restart_handler(&pctrl->restart_nb);
 
-- 
2.1.4
