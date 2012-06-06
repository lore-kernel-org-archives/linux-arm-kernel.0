From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  6 Jun 2012 12:33:14 +0200
Subject: [PATCH 2/4] mtd nand mxc_nand: swap iomem resource order
In-Reply-To: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
References: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1338978796-26129-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX v3 nand controller (i.MX5) needs two memory resources.
Traditionally we have the AXI resource first. For sorting in this
driver into the devicetree it feels much more natural to have the
IP resource first. This patch swaps the ordering of these two
resources.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/devices/platform-mxc_nand.c |   11 ++++----
 drivers/mtd/nand/mxc_nand.c                   |   35 ++++++++++++++-----------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
index 1568f39..95b75cc 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_nand.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
@@ -63,10 +63,6 @@ struct platform_device *__init imx_add_mxc_nand(
 	/* AXI has to come first, that's how the mxc_nand driver expect it */
 	struct resource res[] = {
 		{
-			.start = data->axibase,
-			.end = data->axibase + SZ_16K - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
 			.start = data->iobase,
 			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
@@ -74,10 +70,13 @@ struct platform_device *__init imx_add_mxc_nand(
 			.start = data->irq,
 			.end = data->irq,
 			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->axibase,
+			.end = data->axibase + SZ_16K - 1,
+			.flags = IORESOURCE_MEM,
 		},
 	};
 	return imx_add_platform_device("mxc_nand", data->id,
-			res + !data->axibase,
-			ARRAY_SIZE(res) - !data->axibase,
+			res, ARRAY_SIZE(res) - !data->axibase,
 			pdata, sizeof(*pdata));
 }
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index a1136f3..cc0f6e7 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1355,7 +1355,25 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	if (IS_ERR(host->clk))
 		return PTR_ERR(host->clk);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	err = mxcnd_probe_dt(host);
+	if (err > 0)
+		err = mxcnd_probe_pdata(host);
+	if (err < 0)
+		return err;
+
+	if (host->devtype_data->needs_ip) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res)
+			return -ENODEV;
+		host->regs_ip = devm_request_and_ioremap(&pdev->dev, res);
+		if (!host->regs_ip)
+			return -ENOMEM;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	}
+
 	if (!res)
 		return -ENODEV;
 
@@ -1365,12 +1383,6 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 
 	host->main_area0 = host->base;
 
-	err = mxcnd_probe_dt(host);
-	if (err > 0)
-		err = mxcnd_probe_pdata(host);
-	if (err < 0)
-		return err;
-
 	if (host->devtype_data->regs_offset)
 		host->regs = host->base + host->devtype_data->regs_offset;
 	host->spare0 = host->base + host->devtype_data->spare0_offset;
@@ -1384,15 +1396,6 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	this->ecc.size = 512;
 	this->ecc.layout = host->devtype_data->ecclayout_512;
 
-	if (host->devtype_data->needs_ip) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		if (!res)
-			return -ENODEV;
-		host->regs_ip = devm_request_and_ioremap(&pdev->dev, res);
-		if (!host->regs_ip)
-			return -ENOMEM;
-	}
-
 	if (host->pdata.hw_ecc) {
 		this->ecc.calculate = mxc_nand_calculate_ecc;
 		this->ecc.hwctl = mxc_nand_enable_hwecc;
-- 
1.7.10
