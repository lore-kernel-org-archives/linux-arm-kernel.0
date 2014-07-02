From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Jul 2014 11:58:51 -0300
Subject: [PATCH v2 3/4] ARM: imx: clk-imx6sx: register SSI/SSI_IPG as shared
 gate clocks
In-Reply-To: <1404313132-14400-1-git-send-email-festevam@gmail.com>
References: <1404313132-14400-1-git-send-email-festevam@gmail.com>
Message-ID: <1404313132-14400-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SSI and SSI_IPG are clocks controlled by the same clock gating field, so 
register them with imx_clk_gate2_shared.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Use imx_clk_gate2_shared
 arch/arm/mach-imx/clk-imx6sx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/arch/arm/mach-imx/clk-imx6sx.c
index 2e96103..7cd3f03 100644
--- a/arch/arm/mach-imx/clk-imx6sx.c
+++ b/arch/arm/mach-imx/clk-imx6sx.c
@@ -124,6 +124,9 @@ static struct clk_div_table video_div_table[] = {
 static u32 share_count_asrc;
 static u32 share_count_audio;
 static u32 share_count_esai;
+static u32 share_count_ssi1;
+static u32 share_count_ssi2;
+static u32 share_count_ssi3;
 
 static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 {
@@ -409,12 +412,12 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
 	clks[IMX6SX_CLK_AUDIO]        = imx_clk_gate2_shared("audio",  "audio_podf",        base + 0x7c, 14, &share_count_audio);
 	clks[IMX6SX_CLK_SPDIF]        = imx_clk_gate2_shared("spdif",  "spdif_podf",        base + 0x7c, 14, &share_count_audio);
-	clks[IMX6SX_CLK_SSI1_IPG]     = imx_clk_gate2("ssi1_ipg",      "ipg",               base + 0x7c, 18);
-	clks[IMX6SX_CLK_SSI2_IPG]     = imx_clk_gate2("ssi2_ipg",      "ipg",               base + 0x7c, 20);
-	clks[IMX6SX_CLK_SSI3_IPG]     = imx_clk_gate2("ssi3_ipg",      "ipg",               base + 0x7c, 22);
-	clks[IMX6SX_CLK_SSI1]         = imx_clk_gate2("ssi1",          "ssi1_podf",         base + 0x7c, 18);
-	clks[IMX6SX_CLK_SSI2]         = imx_clk_gate2("ssi2",          "ssi2_podf",         base + 0x7c, 20);
-	clks[IMX6SX_CLK_SSI3]         = imx_clk_gate2("ssi3",          "ssi3_podf",         base + 0x7c, 22);
+	clks[IMX6SX_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",      "ipg",        base + 0x7c, 18, &share_count_ssi1);
+	clks[IMX6SX_CLK_SSI2_IPG]     = imx_clk_gate2_shared("ssi2_ipg",      "ipg",        base + 0x7c, 20, &share_count_ssi2);
+	clks[IMX6SX_CLK_SSI3_IPG]     = imx_clk_gate2_shared("ssi3_ipg",      "ipg",        base + 0x7c, 22, &share_count_ssi3);
+	clks[IMX6SX_CLK_SSI1]         = imx_clk_gate2_shared("ssi1",          "ssi1_podf",  base + 0x7c, 18, &share_count_ssi1);
+	clks[IMX6SX_CLK_SSI2]         = imx_clk_gate2_shared("ssi2",          "ssi2_podf",  base + 0x7c, 20, &share_count_ssi2);
+	clks[IMX6SX_CLK_SSI3]         = imx_clk_gate2_shared("ssi3",          "ssi3_podf",  base + 0x7c, 22, &share_count_ssi3);
 	clks[IMX6SX_CLK_UART_IPG]     = imx_clk_gate2("uart_ipg",      "ipg",               base + 0x7c, 24);
 	clks[IMX6SX_CLK_UART_SERIAL]  = imx_clk_gate2("uart_serial",   "uart_podf",         base + 0x7c, 26);
 	clks[IMX6SX_CLK_SAI1_IPG]     = imx_clk_gate2("sai1_ipg",      "ipg",               base + 0x7c, 28);
-- 
1.8.3.2
