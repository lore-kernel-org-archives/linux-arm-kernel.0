From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 26 Jul 2011 07:00:12 -0400
Subject: [RFC][PATCH] spi: s3c64xx: Use clkdev for bus clock lookup
Message-ID: <1311678012-21473-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a clkdev alias for spi bus clock and modify the spi
driver to lookup the clock using the alias name instead of
passing clock name from platform data.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
This patch is tested for S5PV210 platform and similar
changes can be adopted for rest of the Samsung's s3c
and s5p platforms, if this approach is accepted.

 arch/arm/mach-s5pv210/dev-spi.c                  |   16 ++++++++++++++--
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 --
 drivers/spi/spi_s3c64xx.c                        |   13 +++----------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s5pv210/dev-spi.c b/arch/arm/mach-s5pv210/dev-spi.c
index eaf9a7b..44480d1 100644
--- a/arch/arm/mach-s5pv210/dev-spi.c
+++ b/arch/arm/mach-s5pv210/dev-spi.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
+#include <linux/clk.h>
 
 #include <mach/dma.h>
 #include <mach/map.h>
@@ -148,6 +149,9 @@ struct platform_device s5pv210_device_spi1 = {
 void __init s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
 {
 	struct s3c64xx_spi_info *pd;
+	struct device *dev;
+	char devname[16];
+	int ret;
 
 	/* Reject invalid configuration */
 	if (!num_cs || src_clk_nr < 0
@@ -159,17 +163,25 @@ void __init s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
 	switch (cntrlr) {
 	case 0:
 		pd = &s5pv210_spi0_pdata;
+		dev = (src_clk_nr) ? &s5pv210_device_spi0.dev : NULL;
 		break;
 	case 1:
 		pd = &s5pv210_spi1_pdata;
+		dev = (src_clk_nr) ? &s5pv210_device_spi1.dev : NULL;
 		break;
 	default:
 		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
 							__func__, cntrlr);
 		return;
 	}
-
+	sprintf(devname, "s3c64xx-spi.%d", cntrlr);
+	ret = clk_add_alias("clk_spi_bus", devname,
+				spi_src_clks[src_clk_nr], dev);
+	if (0 != ret) {
+		printk(KERN_ERR "failed to create alias for SPI%d clock",
+			cntrlr);
+		return;
+	}
 	pd->num_cs = num_cs;
 	pd->src_clk_nr = src_clk_nr;
-	pd->src_clk_name = spi_src_clks[src_clk_nr];
 }
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index 4c16fa3..c3d82a5 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -31,7 +31,6 @@ struct s3c64xx_spi_csinfo {
 /**
  * struct s3c64xx_spi_info - SPI Controller defining structure
  * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
- * @src_clk_name: Platform name of the corresponding clock.
  * @clk_from_cmu: If the SPI clock/prescalar control block is present
  *     by the platform's clock-management-unit and not in SPI controller.
  * @num_cs: Number of CS this controller emulates.
@@ -43,7 +42,6 @@ struct s3c64xx_spi_csinfo {
  */
 struct s3c64xx_spi_info {
 	int src_clk_nr;
-	char *src_clk_name;
 	bool clk_from_cmu;
 
 	int num_cs;
diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 8945e20..e5431bd 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -978,11 +978,6 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	}
 
 	sci = pdev->dev.platform_data;
-	if (!sci->src_clk_name) {
-		dev_err(&pdev->dev,
-			"Board init must call s3c64xx_spi_set_info()\n");
-		return -EINVAL;
-	}
 
 	/* Check for availability of necessary resource */
 
@@ -1065,17 +1060,15 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
-	sdd->src_clk = clk_get(&pdev->dev, sci->src_clk_name);
+	sdd->src_clk = clk_get(&pdev->dev, "clk_spi_bus");
 	if (IS_ERR(sdd->src_clk)) {
-		dev_err(&pdev->dev,
-			"Unable to acquire clock '%s'\n", sci->src_clk_name);
+		dev_err(&pdev->dev, "Unable to acquire clock 'clk_spi_bus'\n");
 		ret = PTR_ERR(sdd->src_clk);
 		goto err5;
 	}
 
 	if (clk_enable(sdd->src_clk)) {
-		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n",
-							sci->src_clk_name);
+		dev_err(&pdev->dev, "Couldn't enable clock 'clk_spi_bus'\n");
 		ret = -EBUSY;
 		goto err6;
 	}
-- 
1.7.0.4
