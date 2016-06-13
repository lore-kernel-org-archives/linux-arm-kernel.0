From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Mon, 13 Jun 2016 20:23:12 +0530
Subject: [PATCH 2/2] ARM: pxa: ssp: Switch to devm_ioremap_resource
In-Reply-To: <cover.1465827542.git.amitoj1606@gmail.com>
References: <cover.1465827542.git.amitoj1606@gmail.com>
Message-ID: <9afeef532b761b8cfe68003b41a71b8000096511.1465827542.git.amitoj1606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace calls to devm_request_mem_region and devm_ioremap with a
single call to devm_ioremap_resource instead and modify error
handling.

Move the call to devm_ioremap_resource adjacent to the call to
platform_get_resource and the assignment ssp->phys_base below the 
call to devm_ioremap_resource to take advantage of the null check 
on res by devm_ioremap_resource.

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 arch/arm/plat-pxa/ssp.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 97bd43c..aecc8d5 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -175,26 +175,12 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(dev, "no memory resource defined\n");
-		return -ENODEV;
-	}
-
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
1.9.1
