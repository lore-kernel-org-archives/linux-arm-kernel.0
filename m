From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:46:11 +0530
Subject: [PATCH 46/50] pinctrl: tb10x: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-47-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pinctrl/pinctrl-tb10x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tb10x.c b/drivers/pinctrl/pinctrl-tb10x.c
index 6546b9b..170d3ee 100644
--- a/drivers/pinctrl/pinctrl-tb10x.c
+++ b/drivers/pinctrl/pinctrl-tb10x.c
@@ -806,7 +806,7 @@ static int tb10x_pinctrl_probe(struct platform_device *pdev)
 		}
 	}
 
-	state->pctl = pinctrl_register(&tb10x_pindesc, dev, state);
+	state->pctl = devm_pinctrl_register(dev, &tb10x_pindesc, state);
 	if (IS_ERR(state->pctl)) {
 		dev_err(dev, "could not register TB10x pin driver\n");
 		ret = PTR_ERR(state->pctl);
@@ -824,7 +824,6 @@ static int tb10x_pinctrl_remove(struct platform_device *pdev)
 {
 	struct tb10x_pinctrl *state = platform_get_drvdata(pdev);
 
-	pinctrl_unregister(state->pctl);
 	mutex_destroy(&state->mutex);
 
 	return 0;
-- 
2.1.4
