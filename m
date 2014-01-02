From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 15:13:12 +0000
Subject: [PATCH RFC 26/26] ARM: omap2: ensure dma platform device has resources
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Message-ID: <E1VyjxQ-0005Fg-GA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/dma.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index e08e55a173b6..5689c88d986d 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -213,6 +213,12 @@ static struct omap_system_dma_plat_info dma_plat_info __initdata = {
 	.dma_read	= dma_read,
 };
 
+static struct platform_device_info omap_dma_dev_info = {
+	.name = "omap-dma-engine",
+	.id = -1,
+	.dma_mask = DMA_BIT_MASK(32),
+};
+
 /* One time initializations */
 static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 {
@@ -233,11 +239,15 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		return PTR_ERR(pdev);
 	}
 
+	omap_dma_dev_info.res = pdev->resource;
+	omap_dma_dev_info.num_res = pdev->num_resources;
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
 		return -EINVAL;
 	}
+
 	dma_base = ioremap(mem->start, resource_size(mem));
 	if (!dma_base) {
 		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
@@ -258,12 +268,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	return 0;
 }
 
-static const struct platform_device_info omap_dma_dev_info = {
-	.name = "omap-dma-engine",
-	.id = -1,
-	.dma_mask = DMA_BIT_MASK(32),
-};
-
 static int __init omap2_system_dma_init(void)
 {
 	struct platform_device *pdev;
-- 
1.7.4.4
