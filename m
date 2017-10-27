From: tpiepho@impinj.com (Trent Piepho)
Date: Thu, 26 Oct 2017 18:08:39 -0700
Subject: [PATCH v2 2/4] spi: imx: Fix failure path leak on GPIO request error
In-Reply-To: <20171027010841.28624-1-tpiepho@impinj.com>
References: <20171027010841.28624-1-tpiepho@impinj.com>
Message-ID: <20171027010841.28624-3-tpiepho@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the code that requests any chip select GPIOs fails, the cleanup of
spi_bitbang_start() by calling spi_bitbang_stop() is not done.

Fix this by moving spi_bitbang_start() to after the code that requets
GPIOs.  The GPIOs are dev managed and don't need explicit cleanup.
Since spi_bitbang_start() is now the last operation, it doesn't need
to be cleaned up in the failure path.

CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <kernel@pengutronix.de>
CC: Fabio Estevam <fabio.estevam@nxp.com>
CC: Mark Brown <broonie@kernel.org>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/spi/spi-imx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 07e6250f2dad..fea46cbf458a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1451,11 +1451,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
 	master->dev.of_node = pdev->dev.of_node;
-	ret = spi_bitbang_start(&spi_imx->bitbang);
-	if (ret) {
-		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_clk_put;
-	}
 
 	/* Request GPIO CS lines, if any */
 	if (master->cs_gpios) {
@@ -1473,6 +1468,12 @@ static int spi_imx_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = spi_bitbang_start(&spi_imx->bitbang);
+	if (ret) {
+		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
+		goto out_clk_put;
+	}
+
 	dev_info(&pdev->dev, "probed\n");
 
 	clk_disable(spi_imx->clk_ipg);
-- 
2.14.3
