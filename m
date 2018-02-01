From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Thu,  1 Feb 2018 16:30:22 +0530
Subject: [PATCH] soc: mediatek: Handle return of of_match_device function
Message-ID: <1517482822-28758-1-git-send-email-himanshujha199640@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In scpsys_probe function, return value of of_match_device function which
returns null is dereferenced without checking. Therefore, add a check for
potential null dereference.

Detected by CoverityScan, CID#1424087 "Dereference null return value"

Fixes: commit 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 435ce5e..6e7f196 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -981,6 +981,9 @@ static int scpsys_probe(struct platform_device *pdev)
 	int i, ret;
 
 	match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
+	if (!match)
+		return -EINVAL;
+
 	soc = (const struct scp_soc_data *)match->data;
 
 	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
-- 
2.7.4
