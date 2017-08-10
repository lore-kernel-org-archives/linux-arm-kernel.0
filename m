From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 10 Aug 2017 10:47:32 +0530
Subject: [PATCH v2] memory: mtk-smi: Handle return value of clk_prepare_enable
Message-ID: <daeed02ff9e257286bbae9e4e496e40e4c5480c5.1502341483.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             Rebase patch[1]https://lkml.org/lkml/2017/8/3/968
             and apply this change. Otherwise will merge conflict.

 drivers/memory/mtk-smi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 2b798bb..583fb8d 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -315,6 +315,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	struct mtk_smi *common;
 	struct resource *res;
 	enum mtk_smi_gen smi_gen;
+	int ret;
 
 	if (!dev->pm_domain)
 		return -EPROBE_DEFER;
@@ -349,7 +350,9 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 		if (IS_ERR(common->clk_async))
 			return PTR_ERR(common->clk_async);
 
-		clk_prepare_enable(common->clk_async);
+		ret = clk_prepare_enable(common->clk_async);
+		if (ret)
+			return ret;
 	}
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, common);
-- 
1.9.1
