From: richardcochran@gmail.com (Richard Cochran)
Date: Sat,  3 Nov 2012 09:25:29 +0100
Subject: [PATCH net-next 1/2] cpsw: rename register banks to match the
 reference manual, part 2
In-Reply-To: <cover.1351930782.git.richardcochran@gmail.com>
References: <cover.1351930782.git.richardcochran@gmail.com>
Message-ID: <824b3d1af4563af6fdd9c73ecccb04ff2f5cb1a1.1351930782.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code mixes up the CPSW_SS and the CPSW_WR register naming. This patch
changes the names to conform to the published Technical Reference Manual
from TI, in order to make working on the code less confusing.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 023d439..6215246 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -286,7 +286,7 @@ struct cpsw_priv {
 	struct platform_device		*pdev;
 	struct net_device		*ndev;
 	struct resource			*cpsw_res;
-	struct resource			*cpsw_ss_res;
+	struct resource			*cpsw_wr_res;
 	struct napi_struct		napi;
 	struct device			*dev;
 	struct cpsw_platform_data	data;
@@ -1270,25 +1270,25 @@ static int __devinit cpsw_probe(struct platform_device *pdev)
 	priv->host_port_regs = regs + data->host_port_reg_ofs;
 	priv->cpts.reg = regs + data->cpts_reg_ofs;
 
-	priv->cpsw_ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!priv->cpsw_ss_res) {
+	priv->cpsw_wr_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!priv->cpsw_wr_res) {
 		dev_err(priv->dev, "error getting i/o resource\n");
 		ret = -ENOENT;
 		goto clean_clk_ret;
 	}
 
-	if (!request_mem_region(priv->cpsw_ss_res->start,
-			resource_size(priv->cpsw_ss_res), ndev->name)) {
+	if (!request_mem_region(priv->cpsw_wr_res->start,
+			resource_size(priv->cpsw_wr_res), ndev->name)) {
 		dev_err(priv->dev, "failed request i/o region\n");
 		ret = -ENXIO;
 		goto clean_clk_ret;
 	}
 
-	regs = ioremap(priv->cpsw_ss_res->start,
-				resource_size(priv->cpsw_ss_res));
+	regs = ioremap(priv->cpsw_wr_res->start,
+				resource_size(priv->cpsw_wr_res));
 	if (!regs) {
 		dev_err(priv->dev, "unable to map i/o region\n");
-		goto clean_cpsw_ss_iores_ret;
+		goto clean_cpsw_wr_iores_ret;
 	}
 	priv->wr_regs = regs;
 
@@ -1409,9 +1409,9 @@ clean_dma_ret:
 	cpdma_ctlr_destroy(priv->dma);
 clean_iomap_ret:
 	iounmap(priv->regs);
-clean_cpsw_ss_iores_ret:
-	release_mem_region(priv->cpsw_ss_res->start,
-			   resource_size(priv->cpsw_ss_res));
+clean_cpsw_wr_iores_ret:
+	release_mem_region(priv->cpsw_wr_res->start,
+			   resource_size(priv->cpsw_wr_res));
 clean_cpsw_iores_ret:
 	release_mem_region(priv->cpsw_res->start,
 			   resource_size(priv->cpsw_res));
@@ -1442,8 +1442,8 @@ static int __devexit cpsw_remove(struct platform_device *pdev)
 	iounmap(priv->regs);
 	release_mem_region(priv->cpsw_res->start,
 			   resource_size(priv->cpsw_res));
-	release_mem_region(priv->cpsw_ss_res->start,
-			   resource_size(priv->cpsw_ss_res));
+	release_mem_region(priv->cpsw_wr_res->start,
+			   resource_size(priv->cpsw_wr_res));
 	pm_runtime_disable(&pdev->dev);
 	clk_put(priv->clk);
 	kfree(priv->slaves);
-- 
1.7.2.5
