From: vigneshr@ti.com (Vignesh R)
Date: Sun, 24 Sep 2017 16:29:23 +0530
Subject: [PATCH v3 4/5] mtd: spi-nor: cadence-quadspi: Add support to enable
 loop-back clock circuit
In-Reply-To: <20170924105924.23923-1-vigneshr@ti.com>
References: <20170924105924.23923-1-vigneshr@ti.com>
Message-ID: <20170924105924.23923-5-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cadence QSPI IP has a adapted loop-back circuit which can be enabled by
setting BYPASS field to 0 in READCAPTURE register. It enables use of
QSPI return clock to latch the data rather than the internal QSPI
reference clock. For high speed operations, adapted loop-back circuit
using QSPI return clock helps to increase data valid window.

Based on DT parameter cdns,rclk-en enable adapted loop-back circuit
for boards which do have QSPI return clock provided.
This patch also modifies cqspi_readdata_capture() function's bypass
parameter to bool to match how its used in the function.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 5cd5d6f7303f..d9629e8f4798 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -78,6 +78,7 @@ struct cqspi_st {
 	bool			is_decoded_cs;
 	u32			fifo_depth;
 	u32			fifo_width;
+	bool			rclk_en;
 	u32			trigger_address;
 	u32			wr_delay;
 	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
@@ -788,7 +789,7 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 }
 
 static void cqspi_readdata_capture(struct cqspi_st *cqspi,
-				   const unsigned int bypass,
+				   const bool bypass,
 				   const unsigned int delay)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -852,7 +853,8 @@ static void cqspi_configure(struct spi_nor *nor)
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(nor);
-		cqspi_readdata_capture(cqspi, 1, f_pdata->read_delay);
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+				       f_pdata->read_delay);
 	}
 
 	if (switch_cs || switch_ck)
@@ -1049,6 +1051,8 @@ static int cqspi_of_get_pdata(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
+
 	return 0;
 }
 
-- 
2.14.1
