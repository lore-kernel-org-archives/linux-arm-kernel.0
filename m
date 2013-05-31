From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 31 May 2013 09:50:07 +0800
Subject: [PATCH -next v3] dmaengine: ste_dma40: fix error return code in
 d40_probe()
Message-ID: <CAPgLHd_uppj5twah650PqQnYw1JZp-GKrnBF+ZrXRarJQSNkug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In many of the error handling case, the return value 'ret' not set
and 0 will be return from d40_probe() even if error, but we should
return a negative error code instead in those error handling case.
This patch fixed them, and also removed useless variable 'err'.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
v2 -> v3: move NULL assign below set ret, and remove redundant ENODEV check.
---
 drivers/dma/ste_dma40.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 7f23d45..88e3cd4 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3506,7 +3506,6 @@ static int __init d40_probe(struct platform_device *pdev)
 {
 	struct stedma40_platform_data *plat_data = pdev->dev.platform_data;
 	struct device_node *np = pdev->dev.of_node;
-	int err;
 	int ret = -ENOENT;
 	struct d40_base *base = NULL;
 	struct resource *res = NULL;
@@ -3618,6 +3617,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
 		if (IS_ERR(base->lcpa_regulator)) {
 			d40_err(&pdev->dev, "Failed to get lcpa_regulator\n");
+			ret = PTR_ERR(base->lcpa_regulator);
 			base->lcpa_regulator = NULL;
 			goto failure;
 		}
@@ -3633,13 +3633,13 @@ static int __init d40_probe(struct platform_device *pdev)
 	}
 
 	base->initialized = true;
-	err = d40_dmaengine_init(base, num_reserved_chans);
-	if (err)
+	ret = d40_dmaengine_init(base, num_reserved_chans);
+	if (ret)
 		goto failure;
 
 	base->dev->dma_parms = &base->dma_parms;
-	err = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
-	if (err) {
+	ret = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
+	if (ret) {
 		d40_err(&pdev->dev, "Failed to set dma max seg size\n");
 		goto failure;
 	}
@@ -3647,8 +3647,8 @@ static int __init d40_probe(struct platform_device *pdev)
 	d40_hw_init(base);
 
 	if (np) {
-		err = of_dma_controller_register(np, d40_xlate, NULL);
-		if (err && err != -ENODEV)
+		ret = of_dma_controller_register(np, d40_xlate, NULL);
+		if (ret)
 			dev_err(&pdev->dev,
 				"could not register of_dma_controller\n");
 	}
