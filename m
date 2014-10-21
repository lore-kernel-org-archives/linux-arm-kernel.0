From: varkabhadram@gmail.com (Varka Bhadram)
Date: Tue, 21 Oct 2014 16:03:31 +0530
Subject: [PATCH arm-soc 1/2] mach-omap2: gpmc: remove duplicate check on
 resource
In-Reply-To: <1413887612-25012-1-git-send-email-varkab@cdac.in>
References: <1413887612-25012-1-git-send-email-varkab@cdac.in>
Message-ID: <1413887612-25012-2-git-send-email-varkab@cdac.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sanity check on resource happening with devm_ioremap_resource().

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 arch/arm/mach-omap2/gpmc.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 9f42d54..ff5c4d6 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1653,16 +1653,13 @@ static int gpmc_probe(struct platform_device *pdev)
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL)
-		return -ENOENT;
-
-	phys_base = res->start;
-	mem_size = resource_size(res);
-
 	gpmc_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(gpmc_base))
 		return PTR_ERR(gpmc_base);
 
+	phys_base = res->start;
+	mem_size = resource_size(res);
+
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL)
 		dev_warn(&pdev->dev, "Failed to get resource: irq\n");
-- 
1.7.9.5
