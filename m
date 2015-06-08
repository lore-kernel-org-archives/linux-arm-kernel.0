From: firogm@gmail.com (Firo Yang)
Date: Mon,  8 Jun 2015 16:53:52 +0800
Subject: [PATCH] ARM: pxa: ssp: Use devm_ioremap_resource instead of
 devm_ioremap
Message-ID: <1433753632-28534-1-git-send-email-firogm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using devm_ioremap_resource() API to simplify the code.

Signed-off-by: Firo Yang <firogm@gmail.com>
---
According to Julia's advices:

The patch "[PATCH v2] ARM: pxa: ssp: remove unnessary free for devm_xxx"
submited by Firo Yang should be discard. It was obsoleted by
"[PATCH] ARM: pxa: ssp: remove unnessary free for devm_xxx"
and 
"[PATCH] ARM: pxa: ssp: Use devm_ioremap_resource instead of devm_ioremap"

I am not sure whether it was clear. If there is any doubt, please
 email me.

 arch/arm/plat-pxa/ssp.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index ad9529c..8fd5245 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -182,21 +182,12 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	res = devm_request_mem_region(dev, res->start, resource_size(res),
-				      pdev->name);
-	if (res == NULL) {
-		dev_err(dev, "failed to request memory resource\n");
-		return -EBUSY;
-	}
+	ssp->mmio_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ssp->mmio_base))
+		return PTR_ERR(ssp->mmio_base);
 
 	ssp->phys_base = res->start;
 
-	ssp->mmio_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (ssp->mmio_base == NULL) {
-		dev_err(dev, "failed to ioremap() registers\n");
-		return -ENODEV;
-	}
-
 	ssp->irq = platform_get_irq(pdev, 0);
 	if (ssp->irq < 0) {
 		dev_err(dev, "no IRQ resource defined\n");
-- 
2.4.2
