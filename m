From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 17:07:51 +0200
Subject: [PATCH 5/6] clk: oxnas: Add OX820 Gate clocks
In-Reply-To: <20161005150752.22618-1-narmstrong@baylibre.com>
References: <20161005150752.22618-1-narmstrong@baylibre.com>
Message-ID: <20161005150752.22618-6-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Oxford Semiconductor OX820 SoC gate clocks
along the OX810SE SoC support.
This rework on concerns the gate clocks since they are different.
Future PLL handling code will be added for OX820.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/clk-oxnas.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/clk/clk-oxnas.c b/drivers/clk/clk-oxnas.c
index b1ef3ea9..e51e002 100644
--- a/drivers/clk/clk-oxnas.c
+++ b/drivers/clk/clk-oxnas.c
@@ -27,6 +27,7 @@
 #include <linux/mfd/syscon.h>
 
 #include <dt-bindings/clock/oxsemi,ox810se.h>
+#include <dt-bindings/clock/oxsemi,ox820.h>
 
 /* Standard regmap gate clocks */
 struct clk_oxnas_gate {
@@ -130,6 +131,38 @@ static struct clk_oxnas_gate *ox810se_gates[] = {
 	&ox810se_nand,
 };
 
+static OXNAS_GATE(ox820_leon, 0, osc_parents);
+static OXNAS_GATE(ox820_dma_sgdma, 1, osc_parents);
+static OXNAS_GATE(ox820_cipher, 2, osc_parents);
+static OXNAS_GATE(ox820_sd, 3, osc_parents);
+static OXNAS_GATE(ox820_sata, 4, osc_parents);
+static OXNAS_GATE(ox820_audio, 5, osc_parents);
+static OXNAS_GATE(ox820_usbmph, 6, osc_parents);
+static OXNAS_GATE(ox820_etha, 7, eth_parents);
+static OXNAS_GATE(ox820_pciea, 8, osc_parents);
+static OXNAS_GATE(ox820_nand, 9, osc_parents);
+static OXNAS_GATE(ox820_ethb, 10, eth_parents);
+static OXNAS_GATE(ox820_pcieb, 11, osc_parents);
+static OXNAS_GATE(ox820_ref600, 12, osc_parents);
+static OXNAS_GATE(ox820_usbdev, 13, osc_parents);
+
+static struct clk_oxnas_gate *ox820_gates[] = {
+	&ox820_leon,
+	&ox820_dma_sgdma,
+	&ox820_cipher,
+	&ox820_sd,
+	&ox820_sata,
+	&ox820_audio,
+	&ox820_usbmph,
+	&ox820_etha,
+	&ox820_pciea,
+	&ox820_nand,
+	&ox820_etha,
+	&ox820_pciea,
+	&ox820_ref600,
+	&ox820_usbdev,
+};
+
 static struct clk_hw_onecell_data ox810se_hw_onecell_data = {
 	.hws = {
 		[CLK_810_LEON]	= &ox810se_leon.hw,
@@ -145,6 +178,25 @@ static struct clk_hw_onecell_data ox810se_hw_onecell_data = {
 	.num = ARRAY_SIZE(ox810se_gates),
 };
 
+static struct clk_hw_onecell_data ox820_hw_onecell_data = {
+	.hws = {
+		[CLK_820_LEON]	= &ox820_leon.hw,
+		[CLK_820_DMA_SGDMA]	= &ox820_dma_sgdma.hw,
+		[CLK_820_CIPHER]	= &ox820_cipher.hw,
+		[CLK_820_SD]	= &ox820_sd.hw,
+		[CLK_820_SATA]	= &ox820_sata.hw,
+		[CLK_820_AUDIO]	= &ox820_audio.hw,
+		[CLK_820_USBMPH]	= &ox820_usbmph.hw,
+		[CLK_820_ETHA]	= &ox820_etha.hw,
+		[CLK_820_PCIEA]	= &ox820_pciea.hw,
+		[CLK_820_NAND]	= &ox820_nand.hw,
+		[CLK_820_ETHB]	= &ox820_ethb.hw,
+		[CLK_820_PCIEB]	= &ox820_pcieb.hw,
+		[CLK_820_REF600]	= &ox820_ref600.hw,
+		[CLK_820_USBDEV]	= &ox820_usbdev.hw,
+	},
+	.num = ARRAY_SIZE(ox820_gates),
+};
 
 static struct oxnas_stdclk_data ox810se_stdclk_data = {
 	.onecell_data = &ox810se_hw_onecell_data,
@@ -152,9 +204,15 @@ static struct oxnas_stdclk_data ox810se_stdclk_data = {
 	.ngates = ARRAY_SIZE(ox810se_gates),
 };
 
+static struct oxnas_stdclk_data ox820_stdclk_data = {
+	.onecell_data = &ox820_hw_onecell_data,
+	.gates = ox820_gates,
+	.ngates = ARRAY_SIZE(ox820_gates),
+};
 
 static const struct of_device_id oxnas_stdclk_dt_ids[] = {
 	{ .compatible = "oxsemi,ox810se-stdclk", &ox810se_stdclk_data },
+	{ .compatible = "oxsemi,ox820-stdclk", &ox820_stdclk_data },
 	{ }
 };
 
-- 
2.7.0
