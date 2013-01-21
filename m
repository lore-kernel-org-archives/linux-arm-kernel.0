From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 21 Jan 2013 11:08:55 +0100
Subject: [PATCH 02/33] ARM: Convert to devm_ioremap_resource()
In-Reply-To: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1358762966-20791-3-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-omap2/gpmc.c       | 8 +++-----
 arch/arm/mach-tegra/tegra2_emc.c | 8 +++-----
 arch/arm/plat-omap/dmtimer.c     | 8 +++-----
 arch/arm/plat-samsung/adc.c      | 8 +++-----
 4 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8033cb7..64bac53 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1134,11 +1134,9 @@ static int gpmc_probe(struct platform_device *pdev)
 	phys_base = res->start;
 	mem_size = resource_size(res);
 
-	gpmc_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!gpmc_base) {
-		dev_err(&pdev->dev, "error: request memory / ioremap\n");
-		return -EADDRNOTAVAIL;
-	}
+	gpmc_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpmc_base))
+		return PTR_ERR(gpmc_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL)
diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
index e18aa2f..ce7ce42 100644
--- a/arch/arm/mach-tegra/tegra2_emc.c
+++ b/arch/arm/mach-tegra/tegra2_emc.c
@@ -312,11 +312,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	emc_regbase = devm_request_and_ioremap(&pdev->dev, res);
-	if (!emc_regbase) {
-		dev_err(&pdev->dev, "failed to remap registers\n");
-		return -ENOMEM;
-	}
+	emc_regbase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(emc_regbase))
+		return PTR_ERR(emc_regbase);
 
 	pdata = pdev->dev.platform_data;
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7b433f3..a0daa2f 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -808,11 +808,9 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return  -ENOMEM;
 	}
 
-	timer->io_base = devm_request_and_ioremap(dev, mem);
-	if (!timer->io_base) {
-		dev_err(dev, "%s: region already claimed.\n", __func__);
-		return -ENOMEM;
-	}
+	timer->io_base = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(timer->io_base))
+		return PTR_ERR(timer->io_base);
 
 	if (dev->of_node) {
 		if (of_find_property(dev->of_node, "ti,timer-alwon", NULL))
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 2d676ab..ca07cb1 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -386,11 +386,9 @@ static int s3c_adc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	adc->regs = devm_request_and_ioremap(dev, regs);
-	if (!adc->regs) {
-		dev_err(dev, "failed to map registers\n");
-		return -ENXIO;
-	}
+	adc->regs = devm_ioremap_resource(dev, regs);
+	if (IS_ERR(adc->regs))
+		return PTR_ERR(adc->regs);
 
 	ret = regulator_enable(adc->vdd);
 	if (ret)
-- 
1.8.1.1
