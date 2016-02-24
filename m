From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:52 +0530
Subject: [PATCH 27/50] pinctrl: stm32: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-28-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 8deb566..7291f07 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -813,10 +813,11 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	pctl->pctl_desc.pmxops = &stm32_pmx_ops;
 	pctl->dev = &pdev->dev;
 
-	pctl->pctl_dev = pinctrl_register(&pctl->pctl_desc, &pdev->dev, pctl);
-	if (!pctl->pctl_dev) {
+	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, &pctl->pctl_desc,
+					       pctl);
+	if (IS_ERR(pctl->pctl_dev)) {
 		dev_err(&pdev->dev, "Failed pinctrl registration\n");
-		return -EINVAL;
+		return PTR_ERR(pctl->pctl_dev);
 	}
 
 	for (i = 0; i < pctl->nbanks; i++)
-- 
2.1.4
