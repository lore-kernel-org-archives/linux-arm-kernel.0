From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Tue, 13 Feb 2018 12:21:14 +0530
Subject: [PATCH v3 1/2] mtd: fsl-quadspi: Update slave device hwcap based on
 mode provided in dtsi file
In-Reply-To: <1518504675-26286-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1518504675-26286-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1518504675-26286-2-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FSL QuadSPI controller supports Single, dual, quad modes of operation.
Mode information is available via "spi-tx-bus-width" and
"spi-rx-bus-width" nodes of device tree for the connected slave device.

Update read and write hwcap capability for slave device by reading
"spi-rx-bus-width" and "spi-tx-bus-width" respectively.
Assign hwcaps mask to minimal caps for the slave node i.e.
 SNOR_HWCAPS_READ | SNOR_HWCAPS_READ_FAST | SNOR_HWCAPS_PP

If value not provided in device tree file, then fallback to default
hwcaps for QSPI controller i.e. SNOR_HWCAPS_READ_1_1_4 and SNOR_HWCAPS_PP

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- Incorporated changes as per Cyrille's review comments.
Changes for v2:
- None.

 drivers/mtd/spi-nor/fsl-quadspi.c | 72 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index b9c5918..88f1184 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -29,6 +29,7 @@
 #include <linux/mutex.h>
 #include <linux/pm_qos.h>
 #include <linux/sizes.h>
+#include <linux/spi/spi.h>
 
 /* Controller needs driver to swap endian */
 #define QUADSPI_QUIRK_SWAP_ENDIAN	(1 << 0)
@@ -994,17 +995,14 @@ static void fsl_qspi_unprep(struct spi_nor *nor, enum spi_nor_ops ops)
 
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
-	const struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ_1_1_4 |
-			SNOR_HWCAPS_PP,
-	};
+	struct spi_nor_hwcaps hwcaps;
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct fsl_qspi *q;
 	struct resource *res;
 	struct spi_nor *nor;
 	struct mtd_info *mtd;
-	int ret, i = 0;
+	int ret, i = 0, value, mode;
 
 	q = devm_kzalloc(dev, sizeof(*q), GFP_KERNEL);
 	if (!q)
@@ -1077,6 +1075,13 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	/* iterate the subnodes. */
 	for_each_available_child_of_node(dev->of_node, np) {
+		/* Reset hwcaps mask to minimal caps for the slave node. */
+		hwcaps.mask = SNOR_HWCAPS_READ |
+			      SNOR_HWCAPS_READ_FAST |
+			      SNOR_HWCAPS_PP;
+		value = 0;
+		mode = 0;
+
 		/* skip the holes */
 		if (!q->has_second_chip)
 			i *= 2;
@@ -1106,6 +1111,63 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		/* set the chip address for READID */
 		fsl_qspi_set_base_addr(q, nor);
 
+		/*
+		 * If spi-rx-bus-width and spi-tx-bus-width not defined assign
+		 * default hardware capabilities for READ as
+		 * SNOR_HWCAPS_READ_1_1_4.
+		 */
+		if (!of_property_read_u32(np, "spi-rx-bus-width", &value)) {
+			switch (value) {
+			case 1:
+				break;
+			case 2:
+				mode |= SPI_RX_DUAL;
+				break;
+			case 4:
+				mode |= SPI_RX_QUAD;
+				break;
+			default:
+				dev_err(dev,
+					"spi-rx-bus-width %d not supported\n",
+					value);
+				break;
+			}
+		} else {
+			hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
+		}
+
+		if (!of_property_read_u32(np, "spi-tx-bus-width", &value)) {
+			switch (value) {
+			case 1:
+				break;
+			case 2:
+				mode |= SPI_TX_DUAL;
+				break;
+			case 4:
+				mode |= SPI_TX_QUAD;
+				break;
+			default:
+				dev_err(dev,
+					"spi-tx-bus-width %d not supported\n",
+					value);
+				break;
+			}
+		}
+
+		if (mode & SPI_RX_QUAD) {
+			hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
+
+			if (mode & SPI_TX_QUAD)
+				hwcaps.mask |= (SNOR_HWCAPS_READ_1_4_4 |
+						SNOR_HWCAPS_PP_1_1_4 |
+						SNOR_HWCAPS_PP_1_4_4);
+		} else if (mode & SPI_RX_DUAL) {
+			hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
+
+			if (mode & SPI_TX_DUAL)
+				hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
+		}
+
 		ret = spi_nor_scan(nor, NULL, &hwcaps);
 		if (ret)
 			goto mutex_failed;
-- 
1.9.1
