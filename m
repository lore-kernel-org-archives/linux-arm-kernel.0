From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:46:15 +0530
Subject: [PATCH 50/50] pinctrl: zynq: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-51-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and
remove the need of .remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Cc: linux-gpio at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/pinctrl/pinctrl-zynq.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 76f1abd..5bbf94c0 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -1195,7 +1195,7 @@ static int zynq_pinctrl_probe(struct platform_device *pdev)
 	pctrl->funcs = zynq_pmux_functions;
 	pctrl->nfuncs = ARRAY_SIZE(zynq_pmux_functions);
 
-	pctrl->pctrl = pinctrl_register(&zynq_desc, &pdev->dev, pctrl);
+	pctrl->pctrl = devm_pinctrl_register(&pdev->dev, &zynq_desc, pctrl);
 	if (IS_ERR(pctrl->pctrl))
 		return PTR_ERR(pctrl->pctrl);
 
@@ -1206,15 +1206,6 @@ static int zynq_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int zynq_pinctrl_remove(struct platform_device *pdev)
-{
-	struct zynq_pinctrl *pctrl = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(pctrl->pctrl);
-
-	return 0;
-}
-
 static const struct of_device_id zynq_pinctrl_of_match[] = {
 	{ .compatible = "xlnx,pinctrl-zynq" },
 	{ }
@@ -1227,7 +1218,6 @@ static struct platform_driver zynq_pinctrl_driver = {
 		.of_match_table = zynq_pinctrl_of_match,
 	},
 	.probe = zynq_pinctrl_probe,
-	.remove = zynq_pinctrl_remove,
 };
 
 static int __init zynq_pinctrl_init(void)
-- 
2.1.4
