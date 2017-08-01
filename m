From: vigneshr@ti.com (Vignesh R)
Date: Tue, 1 Aug 2017 10:24:29 +0530
Subject: [PATCH 2/7] mtd: spi-nor: cadence-quadspi: Add support to enable
 loopback clock circuit
In-Reply-To: <20170801045434.8733-1-vigneshr@ti.com>
References: <20170801045434.8733-1-vigneshr@ti.com>
Message-ID: <20170801045434.8733-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cadence QSPI IP has a adapted loopback circuit which can be enabled by
setting BYPASS field to 0 in READCAPTURE register. It enables use of
QSPI return clock to latch the data rather than the internal QSPI
reference clock. For high speed operations, adapted loopback circuit
using QSPI return clock helps to increase data valid window.

Add DT parameter cdns,rclk-en to help enable adapted loopback circuit
for boards which do have QSPI return clock provided.
This patch also modifies cqspi_readdata_capture() function's bypass
parameter to bool to match how its used in the function.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 3 +++
 drivers/mtd/spi-nor/cadence-quadspi.c                     | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
index fdd511a83511..6cc7d58ce7f6 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
@@ -15,6 +15,9 @@ Required properties:
 
 Optional properties:
 - cdns,is-decoded-cs : Flag to indicate whether decoder is used or not.
+- cdns,rclk-en : Flag to indicate that QSPI return clock is used to latch
+  the read data rather than the QSPI clock. Make sure that QSPI return
+  clock is populated on the board before using this property.
 
 Optional subnodes:
 Subnodes of the Cadence Quad SPI controller are spi slave nodes with additional
diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 94571590371d..297c86a2d4a7 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -75,6 +75,7 @@ struct cqspi_st {
 	bool			is_decoded_cs;
 	u32			fifo_depth;
 	u32			fifo_width;
+	bool			rclk_en;
 	u32			trigger_address;
 	u32			wr_delay;
 	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
@@ -784,7 +785,7 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 }
 
 static void cqspi_readdata_capture(struct cqspi_st *cqspi,
-				   const unsigned int bypass,
+				   const bool bypass,
 				   const unsigned int delay)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -848,7 +849,8 @@ static void cqspi_configure(struct spi_nor *nor)
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(nor);
-		cqspi_readdata_capture(cqspi, 1, f_pdata->read_delay);
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+				       f_pdata->read_delay);
 	}
 
 	if (switch_cs || switch_ck)
@@ -1045,6 +1047,8 @@ static int cqspi_of_get_pdata(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
+
 	return 0;
 }
 
-- 
2.13.3
