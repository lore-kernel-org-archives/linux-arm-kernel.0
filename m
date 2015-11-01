From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sun,  1 Nov 2015 15:41:38 +0100
Subject: [PATCH v3 4/7] spi: imx: add function to check for IMX51 family
 controller
In-Reply-To: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1446388901-6073-5-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anton Bondarenko <anton_bondarenko@mentor.com>

Similar to other controller type checks add check function for
IMX51. This also includes IMX53 and IMX6.

Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
---
 drivers/spi/spi-imx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 06f52c3..48fdfa1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -127,9 +127,14 @@ static inline int is_imx35_cspi(struct spi_imx_data *d)
 	return d->devtype_data->devtype == IMX35_CSPI;
 }
 
+static inline int is_imx51_ecspi(struct spi_imx_data *d)
+{
+	return d->devtype_data->devtype == IMX51_ECSPI;
+}
+
 static inline unsigned spi_imx_get_fifosize(struct spi_imx_data *d)
 {
-	return (d->devtype_data->devtype == IMX51_ECSPI) ? 64 : 8;
+	return is_imx51_ecspi(d) ? 64 : 8;
 }
 
 #define MXC_SPI_BUF_RX(type)						\
@@ -1334,7 +1339,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx6 now, can remove the constrain if validated on
 	 * other chips.
 	 */
-	if (spi_imx->devtype_data == &imx51_ecspi_devtype_data &&
+	if (is_imx51_ecspi(spi_imx) &&
 	    spi_imx_sdma_init(&pdev->dev, spi_imx, master))
 		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
 
-- 
2.6.2
