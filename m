From: esmil@mailme.dk (Emil Renner Berthing)
Date: Wed, 31 Oct 2018 11:57:11 +0100
Subject: [PATCH v1 14/14] spi: rockchip: support lsb-first mode
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <20181031105711.19575-15-esmil@mailme.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add missing support for lsb-first mode.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 9e47e81553a1..3912526ead66 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -476,6 +476,8 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 
 	cr0 |= rs->rsd << CR0_RSD_OFFSET;
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
+	if (spi->mode & SPI_LSB_FIRST)
+		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
 		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
@@ -681,7 +683,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_LSB_FIRST;
 	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
-- 
2.19.1
