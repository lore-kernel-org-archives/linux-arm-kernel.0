From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 31 Aug 2017 01:36:09 +0200
Subject: [PATCH 3/3] dmaengine: sun6i: Add support for Allwinner A64
In-Reply-To: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
References: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SoC has the same dma engine as the H3 (sun8i), with a
reduced amount of physical channels. Add the proper config data
and compatible string to support it.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++++
 drivers/dma/sun6i-dma.c                       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index f96287d3043a..b86019238b77 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -494,6 +494,8 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_pins>;
 			resets = <&ccu RST_BUS_SPI0>;
@@ -509,6 +511,8 @@
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 24>, <&dma 24>;
+			dma-names = "rx", "tx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi1_pins>;
 			resets = <&ccu RST_BUS_SPI1>;
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 5f4eee4513e5..6a17c5d63582 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1068,6 +1068,12 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_vchans   = 34,
 	.dmac_variant    = DMAC_VARIANT_H3,
 };
+
+static struct sun6i_dma_config sun50i_a64_dma_cfg = {
+	.nr_max_channels = 8,
+	.nr_max_requests = 27,
+	.nr_max_vchans   = 38,
+	.dmac_variant    = DMAC_VARIANT_H3,
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
@@ -1075,6 +1081,7 @@ static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
+	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dma_match);
-- 
2.14.1
