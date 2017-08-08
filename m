From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue,  8 Aug 2017 11:06:07 +0530
Subject: [PATCH] memory: mtk-smi: Handle return value of clk_prepare_enable
In-Reply-To: <472bce58da459a7c64d0ad1cd39b74fa0fcf77f1.1502167256.git.arvind.yadav.cs@gmail.com>
References: <472bce58da459a7c64d0ad1cd39b74fa0fcf77f1.1502167256.git.arvind.yadav.cs@gmail.com>
Message-ID: <2c1de1862ce9fdefe7653706915c146038b12c4c.1502167256.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/memory/mtk-smi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 4afbc41..edf36f0 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -321,6 +321,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	struct resource *res;
 	const struct of_device_id *of_id;
 	enum mtk_smi_gen smi_gen;
+	int ret;
 
 	if (!dev->pm_domain)
 		return -EPROBE_DEFER;
@@ -359,7 +360,9 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
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
