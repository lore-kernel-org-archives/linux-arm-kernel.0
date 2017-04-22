From: stefan@agner.ch (Stefan Agner)
Date: Fri, 21 Apr 2017 18:23:35 -0700
Subject: [PATCH v2 2/5] mtd: nand: gpmi: add i.MX 7 SoC support
In-Reply-To: <20170422012338.4635-1-stefan@agner.ch>
References: <20170422012338.4635-1-stefan@agner.ch>
Message-ID: <20170422012338.4635-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for i.MX 7 SoC. The i.MX 7 has a slightly different
clock architecture requiring only two clocks to be referenced.
The IP is slightly different compared to i.MX 6, but currently none
of this differences are in use, therefore reuse GPMI_IS_MX6.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 15 +++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |  7 +++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index c8bbf5da2ab8..9b777be633a9 100644
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
+	.type = IS_MX7D,
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
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 8879c4eff25e..e88a45a62ab6 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -123,7 +123,8 @@ enum gpmi_type {
 	IS_MX23,
 	IS_MX28,
 	IS_MX6Q,
-	IS_MX6SX
+	IS_MX6SX,
+	IS_MX7D,
 };
 
 struct gpmi_devdata {
@@ -307,6 +308,8 @@ void gpmi_copy_bits(u8 *dst, size_t dst_bit_off,
 #define GPMI_IS_MX28(x)		((x)->devdata->type == IS_MX28)
 #define GPMI_IS_MX6Q(x)		((x)->devdata->type == IS_MX6Q)
 #define GPMI_IS_MX6SX(x)	((x)->devdata->type == IS_MX6SX)
+#define GPMI_IS_MX7D(x)		((x)->devdata->type == IS_MX7D)
 
-#define GPMI_IS_MX6(x)		(GPMI_IS_MX6Q(x) || GPMI_IS_MX6SX(x))
+#define GPMI_IS_MX6(x)		(GPMI_IS_MX6Q(x) || GPMI_IS_MX6SX(x) || \
+				 GPMI_IS_MX7D(x))
 #endif
-- 
2.12.2
