From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Tue, 30 Jan 2018 23:01:07 +0530
Subject: [PATCH 1/2] mtd: fsl-quadspi: Update slave device hwcap based on mode
 provided in dtsi file
In-Reply-To: <1517333468-17153-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1517333468-17153-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1517333468-17153-2-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FSL QuadSPI controller supports Single, dual, quad modes of operation.
Mode information is available via "spi-tx-bus-width" and
"spi-rx-bus-width" nodes of device tree for the connected slave device.

Update read and write hwcap capability for slave device by reading
"spi-rx-bus-width" and "spi-tx-bus-width" respectively.
Assign hwcaps mask to minimal caps for the slave node i.e.
	SNOR_HWCAPS_READ | SNOR_HWCAPS_PP

If value not provided in device tree file, then fallback to default
mode i.e. SNOR_HWCAPS_READ_1_1_4 and SNOR_HWCAPS_PP.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 56 +++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index b9c5918..1503e0c 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -994,17 +994,14 @@ static void fsl_qspi_unprep(struct spi_nor *nor, enum spi_nor_ops ops)
 
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
+	int ret, i = 0, value;
 
 	q = devm_kzalloc(dev, sizeof(*q), GFP_KERNEL);
 	if (!q)
@@ -1077,6 +1074,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	/* iterate the subnodes. */
 	for_each_available_child_of_node(dev->of_node, np) {
+		/* Reset hwcaps mask to minimal caps for the slave node. */
+		hwcaps.mask = SNOR_HWCAPS_READ | SNOR_HWCAPS_PP;
+		value = 0;
+
 		/* skip the holes */
 		if (!q->has_second_chip)
 			i *= 2;
@@ -1106,6 +1107,51 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		/* set the chip address for READID */
 		fsl_qspi_set_base_addr(q, nor);
 
+		/*
+		 * If spi-rx-bus-width and spi-tx-bus-width not defined assign
+		 * default hardware capabilities SNOR_HWCAPS_READ_1_1_4 and
+		 * SNOR_HWCAPS_PP supported by the Quad-SPI controller.
+		 */
+		if (!of_property_read_u32(np, "spi-rx-bus-width", &value)) {
+			switch (value) {
+			case 1:
+				hwcaps.mask |= SNOR_HWCAPS_READ |
+					       SNOR_HWCAPS_READ_FAST;
+				break;
+			case 2:
+				hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2 |
+					       SNOR_HWCAPS_READ_1_2_2;
+				break;
+			case 4:
+				hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4 |
+					       SNOR_HWCAPS_READ_1_4_4;
+				break;
+			default:
+				dev_err(dev,
+					"spi-rx-bus-width %d not supported\n",
+					value);
+				break;
+			}
+		} else
+			hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
+
+		if (!of_property_read_u32(np, "spi-tx-bus-width", &value)) {
+			switch (value) {
+			case 1:
+				hwcaps.mask |= SNOR_HWCAPS_PP;
+				break;
+			case 4:
+				hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4 |
+					       SNOR_HWCAPS_PP_1_4_4;
+				break;
+			default:
+				dev_err(dev,
+					"spi-tx-bus-width %d not supported\n",
+					value);
+				break;
+			}
+		}
+
 		ret = spi_nor_scan(nor, NULL, &hwcaps);
 		if (ret)
 			goto mutex_failed;
-- 
1.9.1
