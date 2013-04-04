From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Apr 2013 11:25:05 +0200
Subject: [PATCH 2/6] ata: i.MX PATA: cleanup error path
In-Reply-To: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
References: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1365067509-10186-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- rename free_priv label to 'err' since priv is allocated with devm_*
  and not freed here.
- add missing 'goto err' in case ata_host_activate fails
- add 'ret' variable to return correct error value instead of hardcoded
  -ENOMEM in error case.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/ata/pata_imx.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index af893dd..f243496 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -98,6 +98,7 @@ static int pata_imx_probe(struct platform_device *pdev)
 	struct pata_imx_priv *priv;
 	int irq = 0;
 	struct resource *io_res;
+	int ret;
 
 	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (io_res == NULL)
@@ -121,8 +122,10 @@ static int pata_imx_probe(struct platform_device *pdev)
 	clk_prepare_enable(priv->clk);
 
 	host = ata_host_alloc(&pdev->dev, 1);
-	if (!host)
-		goto free_priv;
+	if (!host) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	host->private_data = priv;
 	ap = host->ports[0];
@@ -135,7 +138,8 @@ static int pata_imx_probe(struct platform_device *pdev)
 		resource_size(io_res));
 	if (!priv->host_regs) {
 		dev_err(&pdev->dev, "failed to map IO/CTL base\n");
-		goto free_priv;
+		ret = -EBUSY;
+		goto err;
 	}
 
 	ap->ioaddr.cmd_addr = priv->host_regs + PATA_IMX_DRIVE_DATA;
@@ -158,13 +162,17 @@ static int pata_imx_probe(struct platform_device *pdev)
 			priv->host_regs + PATA_IMX_ATA_INT_EN);
 
 	/* activate */
-	return ata_host_activate(host, irq, ata_sff_interrupt, 0,
+	ret = ata_host_activate(host, irq, ata_sff_interrupt, 0,
 				&pata_imx_sht);
 
-free_priv:
+	if (ret)
+		goto err;
+
+	return 0;
+err:
 	clk_disable_unprepare(priv->clk);
 
-	return -ENOMEM;
+	return ret;
 }
 
 static int pata_imx_remove(struct platform_device *pdev)
-- 
1.8.2.rc2
