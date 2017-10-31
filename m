From: tpiepho@impinj.com (Trent Piepho)
Date: Tue, 31 Oct 2017 12:49:06 -0700
Subject: [PATCH v3 3/4] spi: imx: Don't require platform data chipselect array
In-Reply-To: <20171031194907.29108-1-tpiepho@impinj.com>
References: <20171031194907.29108-1-tpiepho@impinj.com>
Message-ID: <20171031194907.29108-4-tpiepho@impinj.com>
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
 drivers/spi/spi-imx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index ad54f8258513..5caa6c9524fa 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1526,13 +1526,15 @@ static int spi_imx_probe(struct platform_device *pdev)
 	/* Get number of chip selects, either platform data or OF */
 	if (mxc_platform_info) {
 		master->num_chipselect = mxc_platform_info->num_chipselect;
-		master->cs_gpios = devm_kzalloc(&master->dev,
-			sizeof(int) * master->num_chipselect, GFP_KERNEL);
-		if (!master->cs_gpios)
-			return -ENOMEM;
-
-		for (i = 0; i < master->num_chipselect; i++)
-			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
+		if (mxc_platform_info->chipselect) {
+			master->cs_gpios = devm_kzalloc(&master->dev,
+				sizeof(int) * master->num_chipselect, GFP_KERNEL);
+			if (!master->cs_gpios)
+				return -ENOMEM;
+
+			for (i = 0; i < master->num_chipselect; i++)
+				master->cs_gpios[i] = mxc_platform_info->chipselect[i];
+		}
 	} else {
 		u32 num_cs;
 
-- 
2.14.3
