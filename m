From: tpiepho@impinj.com (Trent Piepho)
Date: Thu, 26 Oct 2017 18:08:40 -0700
Subject: [PATCH v2 3/4] spi: imx: Don't require platform data chipselect array
In-Reply-To: <20171027010841.28624-1-tpiepho@impinj.com>
References: <20171027010841.28624-1-tpiepho@impinj.com>
Message-ID: <20171027010841.28624-4-tpiepho@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the array is not present, assume all chip selects are native.  This
is the standard behavior for SPI masters configured via the device
tree and the behavior of this driver as well when it is configured via
device tree.

This reduces platform data vs DT differences and allows most of the
platform data based boards to remove their chip select arrays.

CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <kernel@pengutronix.de>
CC: Fabio Estevam <fabio.estevam@nxp.com>
CC: Mark Brown <broonie@kernel.org>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/spi/spi-imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index fea46cbf458a..535378ebab18 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1362,8 +1362,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
 
-	if (mxc_platform_info) {
-		master->num_chipselect = mxc_platform_info->num_chipselect;
+	if (mxc_platform_info && master->num_chipselect) {
 		master->cs_gpios = devm_kzalloc(&master->dev,
 			sizeof(int) * master->num_chipselect, GFP_KERNEL);
 		if (!master->cs_gpios)
@@ -1371,7 +1370,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 		for (i = 0; i < master->num_chipselect; i++)
 			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
- 	}
+	}
 
 	spi_imx->bitbang.chipselect = spi_imx_chipselect;
 	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
-- 
2.14.3
