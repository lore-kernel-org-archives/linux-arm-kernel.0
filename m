From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 26 Jul 2018 15:49:10 -0500
Subject: [PATCH] ASoC: sirf: Fix potential NULL pointer dereference
Message-ID: <20180726204910.GA1635@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a potential execution path in which function
platform_get_resource() returns NULL. If this happens,
we will end up having a NULL pointer dereference.

Fix this by replacing devm_ioremap with devm_ioremap_resource,
which has the NULL check and the memory region request.

This code was detected with the help of Coccinelle.

Cc: stable at vger.kernel.org
Fixes: 2bd8d1d5cf89 ("ASoC: sirf: Add audio usp interface driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/sirf/sirf-usp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sirf/sirf-usp.c b/sound/soc/sirf/sirf-usp.c
index 77e7dcf..d70fcd4 100644
--- a/sound/soc/sirf/sirf-usp.c
+++ b/sound/soc/sirf/sirf-usp.c
@@ -370,10 +370,9 @@ static int sirf_usp_pcm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, usp);
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap(&pdev->dev, mem_res->start,
-		resource_size(mem_res));
-	if (base == NULL)
-		return -ENOMEM;
+	base = devm_ioremap_resource(&pdev->dev, mem_res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 	usp->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					    &sirf_usp_regmap_config);
 	if (IS_ERR(usp->regmap))
-- 
2.7.4
