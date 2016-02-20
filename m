From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Sat, 20 Feb 2016 11:20:51 +0100
Subject: [PATCH 3/4] ARM: dts: imx6ul: Add GPMI nand controller support
In-Reply-To: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
Message-ID: <1455963652-24618-4-git-send-email-michael@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for GPMI nand controller.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6ul.dtsi          | 33 +++++++++++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 10 ++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |  6 ++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index f369fa4..42b0a29 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -142,6 +142,39 @@
 			reg = <0x00900000 0x20000>;
 		};
 
+		dma_apbh: dma-apbh at 01804000 {
+			compatible = "fsl,imx6ul-dma-apbh", "fsl,imx28-dma-apbh";
+			reg = <0x01804000 0x2000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
+			#dma-cells = <1>;
+			dma-channels = <4>;
+			clocks = <&clks IMX6UL_CLK_APBHDMA>;
+		};
+
+		gpmi: gpmi-nand at 01806000 {
+			compatible = "fsl,imx6ul-gpmi-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x01806000 0x2000>, <0x01808000 0x4000>;
+			reg-names = "gpmi-nand", "bch";
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "bch";
+			clocks = <&clks IMX6UL_CLK_GPMI_IO>,
+				 <&clks IMX6UL_CLK_GPMI_APB>,
+				 <&clks IMX6UL_CLK_GPMI_BCH>,
+				 <&clks IMX6UL_CLK_GPMI_BCH_APB>,
+				 <&clks IMX6UL_CLK_PER_BCH>;
+			clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
+				      "gpmi_bch_apb", "per1_bch";
+			dmas = <&dma_apbh 0>;
+			dma-names = "rx-tx";
+			status = "disabled";
+		};
+
 		aips1: aips-bus at 02000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 235ddcb..b7528a1 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -77,6 +77,12 @@ static const struct gpmi_devdata gpmi_devdata_imx6sx = {
 	.max_chain_delay = 12,
 };
 
+static const struct gpmi_devdata gpmi_devdata_imx6ul = {
+	.type = IS_MX6UL,
+	.bch_max_ecc_strength = 40,
+	.max_chain_delay = 12,
+};
+
 static irqreturn_t bch_irq(int irq, void *cookie)
 {
 	struct gpmi_nand_data *this = cookie;
@@ -1975,7 +1981,11 @@ static const struct of_device_id gpmi_nand_id_table[] = {
 	}, {
 		.compatible = "fsl,imx6sx-gpmi-nand",
 		.data = &gpmi_devdata_imx6sx,
+	}, {
+		.compatible = "fsl,imx6ul-gpmi-nand",
+		.data = &gpmi_devdata_imx6ul,
 	}, {}
+
 };
 MODULE_DEVICE_TABLE(of, gpmi_nand_id_table);
 
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 4e49a1f..c5fa52a 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -123,7 +123,8 @@ enum gpmi_type {
 	IS_MX23,
 	IS_MX28,
 	IS_MX6Q,
-	IS_MX6SX
+	IS_MX6SX,
+	IS_MX6UL,
 };
 
 struct gpmi_devdata {
@@ -305,6 +306,7 @@ void gpmi_copy_bits(u8 *dst, size_t dst_bit_off,
 #define GPMI_IS_MX28(x)		((x)->devdata->type == IS_MX28)
 #define GPMI_IS_MX6Q(x)		((x)->devdata->type == IS_MX6Q)
 #define GPMI_IS_MX6SX(x)	((x)->devdata->type == IS_MX6SX)
+#define GPMI_IS_MX6UL(x)	((x)->devdata->type == IS_MX6UL)
 
-#define GPMI_IS_MX6(x)		(GPMI_IS_MX6Q(x) || GPMI_IS_MX6SX(x))
+#define GPMI_IS_MX6(x)		(GPMI_IS_MX6Q(x) || GPMI_IS_MX6SX(x) || GPMI_IS_MX6UL(x))
 #endif
-- 
2.7.0
