From: olof@lixom.net (Olof Johansson)
Date: Thu,  5 Sep 2013 12:30:52 -0700
Subject: [PATCH] ARM: pxa: ssp: Check return values from phandle lookups
Message-ID: <1378409452-24281-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a6e56c28a178cef5f (ARM: pxa: ssp: add DT bindings) causes warnings
when built:

arch/arm/plat-pxa/ssp.c: In function 'pxa_ssp_probe':
arch/arm/plat-pxa/ssp.c:145:17: warning: 'dma_spec.args[0]' may be used
	uninitialized in this function [-Wmaybe-uninitialized]

Resolve by checking return values and aborting when lookups fail.

Cc: Daniel Mack <zonque@gmail.com>
Cc: Mark Brown <broonie@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---

Haojian, Daniel, I'll include this with our first round of arm-soc
fixes for 3.12-rc1. Tested/Acked tags would be appreciated, since I
lack hardware.


-Olof

 arch/arm/plat-pxa/ssp.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index c83f27b..3ea0290 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -132,6 +132,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		struct of_phandle_args dma_spec;
 		struct device_node *np = dev->of_node;
+		int ret;
 
 		/*
 		 * FIXME: we should allocate the DMA channel from this
@@ -140,14 +141,23 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 		 */
 
 		/* rx */
-		of_parse_phandle_with_args(np, "dmas", "#dma-cells",
-					   0, &dma_spec);
+		ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells",
+						 0, &dma_spec);
+
+		if (ret) {
+			dev_err(dev, "Can't parse dmas property\n");
+			return -ENODEV;
+		}
 		ssp->drcmr_rx = dma_spec.args[0];
 		of_node_put(dma_spec.np);
 
 		/* tx */
-		of_parse_phandle_with_args(np, "dmas", "#dma-cells",
-					   1, &dma_spec);
+		ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells",
+						 1, &dma_spec);
+		if (ret) {
+			dev_err(dev, "Can't parse dmas property\n");
+			return -ENODEV;
+		}
 		ssp->drcmr_tx = dma_spec.args[0];
 		of_node_put(dma_spec.np);
 	} else {
-- 
1.7.10.4
