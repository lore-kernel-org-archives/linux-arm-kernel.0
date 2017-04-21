From: stefan@agner.ch (Stefan Agner)
Date: Thu, 20 Apr 2017 18:07:52 -0700
Subject: [PATCH 2/5] mtd: nand: gpmi: add i.MX 7 SoC support
In-Reply-To: <20170421010755.18025-1-stefan@agner.ch>
References: <20170421010755.18025-1-stefan@agner.ch>
Message-ID: <20170421010755.18025-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for i.MX 7 SoC. The i.MX 7 has a slightly different
clock architecture requiring only two clocks to be referenced.
The IP is slightly different compared to i.MX 6SoloX, but currently
none of this differences are in use so there is no detection needed
and the driver can reuse IS_MX6SX.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index c8bbf5da2ab8..4a45d37ddc80 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -127,6 +127,18 @@ static const struct gpmi_devdata gpmi_devdata_imx6sx = {
 	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx6),
 };
 
+static const char * const gpmi_clks_for_mx7d[] = {
+	"gpmi_io", "gpmi_bch_apb",
+};
+
+static const struct gpmi_devdata gpmi_devdata_imx7d = {
+	.type = IS_MX6SX,
+	.bch_max_ecc_strength = 62,
+	.max_chain_delay = 12,
+	.clks = gpmi_clks_for_mx7d,
+	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx7d),
+};
+
 static irqreturn_t bch_irq(int irq, void *cookie)
 {
 	struct gpmi_nand_data *this = cookie;
@@ -2071,6 +2083,9 @@ static const struct of_device_id gpmi_nand_id_table[] = {
 	}, {
 		.compatible = "fsl,imx6sx-gpmi-nand",
 		.data = &gpmi_devdata_imx6sx,
+	}, {
+		.compatible = "fsl,imx7d-gpmi-nand",
+		.data = &gpmi_devdata_imx7d,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, gpmi_nand_id_table);
-- 
2.12.2
