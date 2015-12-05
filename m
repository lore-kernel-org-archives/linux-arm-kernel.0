From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat,  5 Dec 2015 17:57:05 +0100
Subject: [PATCH v5 07/11] spi: imx: defer spi initialization, if DMA engine is
In-Reply-To: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1449334629-4715-8-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If SPI device supports DMA mode, but DMA controller is not yet
available due to e.g. a delay in the corresponding kernel module
initialization, retry to initialize SPI driver later on instead of
falling back into PIO only mode.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 277dd75..fa24637 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1221,6 +1221,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 */
 	if (is_imx51_ecspi(spi_imx)) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master, res);
+		if (ret == -EPROBE_DEFER)
+			goto out_clk_put;
+
 		if (ret < 0)
 			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
 				ret);
-- 
2.6.3
