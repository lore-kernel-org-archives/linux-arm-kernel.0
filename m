From: B56489@freescale.com (Yunhui Cui)
Date: Thu, 18 Aug 2016 15:38:03 +0800
Subject: [PATCH v3 8/9] mtd: fsl-quadspi: disable AHB buffer prefetch
In-Reply-To: <1471505884-33996-1-git-send-email-B56489@freescale.com>
References: <1471505884-33996-1-git-send-email-B56489@freescale.com>
Message-ID: <1471505884-33996-8-git-send-email-B56489@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yunhui Cui <yunhui.cui@nxp.com>

A-009282: QuadSPI: QuadSPI data pre-fetch can result in incorrect data
Affects: QuadSPI
Description: With AHB buffer prefetch enabled, the QuadSPI may return
incorrect data on the AHB
interface. The buffer pre-fetch is enabled if the fetch size as
configured either in the LUT or in
the BUFxCR register is greater than 8 bytes.
Impact: Only 64 bit read allowed.
Workaround: Keep the read data size to 64 bits (8 Bytes), which disables
the prefetch on the AHB buffer,
and prevents this issue from occurring.

Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index f9a7d4b..193e81b 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -41,6 +41,8 @@
 #define QUADSPI_QUIRK_TKT253890		(1 << 2)
 /* Controller cannot wake up from wait mode, TKT245618 */
 #define QUADSPI_QUIRK_TKT245618         (1 << 3)
+/*Errata A-009282: disable the AHB buffer prefetch */
+#define QUADSPI_QUIRK_ADASZ_8BYTE_LIMIT (1 << 4)
 /* QSPI_AMBA_BASE is internally added by SOC design */
 #define QUADSPI_AMBA_BASE_INTERNAL	(0x10000)
 
@@ -270,7 +272,7 @@ static struct fsl_qspi_devtype_data ls1021a_data = {
 	.rxfifo = 128,
 	.txfifo = 64,
 	.ahb_buf_size = 1024,
-	.driver_data = 0,
+	.driver_data = QUADSPI_QUIRK_ADASZ_8BYTE_LIMIT,
 };
 
 static struct fsl_qspi_devtype_data ls2080a_data = {
@@ -278,7 +280,8 @@ static struct fsl_qspi_devtype_data ls2080a_data = {
 	.rxfifo = 128,
 	.txfifo = 64,
 	.ahb_buf_size = 1024,
-	.driver_data = QUADSPI_AMBA_BASE_INTERNAL,
+	.driver_data = QUADSPI_AMBA_BASE_INTERNAL
+		       | QUADSPI_QUIRK_ADASZ_8BYTE_LIMIT,
 };
 
 #define FSL_QSPI_MAX_CHIP	4
@@ -328,6 +331,11 @@ static inline int has_added_amba_base_internal(struct fsl_qspi *q)
 	return q->devtype_data->driver_data & QUADSPI_AMBA_BASE_INTERNAL;
 }
 
+static inline int needs_disable_ahb_prefetch(struct fsl_qspi *q)
+{
+	return q->devtype_data->driver_data & QUADSPI_QUIRK_ADASZ_8BYTE_LIMIT;
+}
+
 /*
  * R/W functions for big- or little-endian registers:
  * The qSPI controller's endian is independent of the CPU core's endian.
@@ -757,14 +765,21 @@ static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
 	qspi_writel(q, QUADSPI_BUFXCR_INVALID_MSTRID, base + QUADSPI_BUF0CR);
 	qspi_writel(q, QUADSPI_BUFXCR_INVALID_MSTRID, base + QUADSPI_BUF1CR);
 	qspi_writel(q, QUADSPI_BUFXCR_INVALID_MSTRID, base + QUADSPI_BUF2CR);
-	/*
-	 * Set ADATSZ with the maximum AHB buffer size to improve the
-	 * read performance.
-	 */
-	qspi_writel(q, QUADSPI_BUF3CR_ALLMST_MASK |
-			((q->devtype_data->ahb_buf_size / 8)
-			<< QUADSPI_BUF3CR_ADATSZ_SHIFT),
+
+	if (needs_disable_ahb_prefetch(q)) {
+		qspi_writel(q, QUADSPI_BUF3CR_ALLMST_MASK |
+			(1 << QUADSPI_BUF3CR_ADATSZ_SHIFT),
 			base + QUADSPI_BUF3CR);
+	} else {
+		/*
+		 * Set ADATSZ with the maximum AHB buffer size to improve the
+		 * read performance.
+		*/
+		qspi_writel(q, QUADSPI_BUF3CR_ALLMST_MASK |
+				((q->devtype_data->ahb_buf_size / 8)
+				<< QUADSPI_BUF3CR_ADATSZ_SHIFT),
+				base + QUADSPI_BUF3CR);
+	}
 
 	/* We only use the buffer3 */
 	qspi_writel(q, 0, base + QUADSPI_BUF0IND);
-- 
2.1.0.27.g96db324
