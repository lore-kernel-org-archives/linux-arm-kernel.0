From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:37 +0530
Subject: [PATCH 12/50] pinctrl: intel: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-13-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 85536b4..27bb21b 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1014,7 +1014,8 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 	pctrl->pctldesc.pins = pctrl->soc->pins;
 	pctrl->pctldesc.npins = pctrl->soc->npins;
 
-	pctrl->pctldev = pinctrl_register(&pctrl->pctldesc, &pdev->dev, pctrl);
+	pctrl->pctldev = devm_pinctrl_register(&pdev->dev, &pctrl->pctldesc,
+					       pctrl);
 	if (IS_ERR(pctrl->pctldev)) {
 		dev_err(&pdev->dev, "failed to register pinctrl driver\n");
 		return PTR_ERR(pctrl->pctldev);
@@ -1037,7 +1038,6 @@ int intel_pinctrl_remove(struct platform_device *pdev)
 	struct intel_pinctrl *pctrl = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&pctrl->chip);
-	pinctrl_unregister(pctrl->pctldev);
 
 	return 0;
 }
-- 
2.1.4
