From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Fri, 8 Aug 2014 15:02:47 +0800
Subject: [PATCH V3 1/3] ARM: clk-imx6q: refine clock tree for ESAI
In-Reply-To: <cover.1407481023.git.shengjiu.wang@freescale.com>
References: <cover.1407481023.git.shengjiu.wang@freescale.com>
Message-ID: <cdb30bb5d7f8a61c778ed53988976c4e79f56ace.1407481023.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are three clock for ESAI, esai_extal, esai_ipg, esai_mem. Rename
'esai' to 'esai_extal', 'esai_ahb' to 'esai_mem', and add 'esai_ipg'.
Make the clock for ESAI more clear and align them with imx6sx.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c             |    7 ++++---
 include/dt-bindings/clock/imx6qdl-clock.h |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 6cceb77..1d6dd59 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -64,7 +64,7 @@ static const char *cko2_sels[] = {
 	"ipu2", "vdo_axi", "osc", "gpu2d_core",
 	"gpu3d_core", "usdhc2", "ssi1", "ssi2",
 	"ssi3", "gpu3d_shader", "vpu_axi", "can_root",
-	"ldb_di0", "ldb_di1", "esai", "eim_slow",
+	"ldb_di0", "ldb_di1", "esai_extal", "eim_slow",
 	"uart_serial", "spdif", "asrc", "hsi_tx",
 };
 static const char *cko_sels[] = { "cko1", "cko2", };
@@ -325,8 +325,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	else
 		clk[IMX6Q_CLK_ECSPI5] = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
 	clk[IMX6QDL_CLK_ENET]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
-	clk[IMX6QDL_CLK_ESAI]         = imx_clk_gate2_shared("esai",   "esai_podf",         base + 0x6c, 16, &share_count_esai);
-	clk[IMX6QDL_CLK_ESAI_AHB]     = imx_clk_gate2_shared("esai_ahb", "ahb",             base + 0x6c, 16, &share_count_esai);
+	clk[IMX6QDL_CLK_ESAI_EXTAL]   = imx_clk_gate2_shared("esai_extal",   "esai_podf",   base + 0x6c, 16, &share_count_esai);
+	clk[IMX6QDL_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ipg",           base + 0x6c, 16, &share_count_esai);
+	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_GPT_IPG]      = imx_clk_gate2("gpt_ipg",       "ipg",               base + 0x6c, 20);
 	clk[IMX6QDL_CLK_GPT_IPG_PER]  = imx_clk_gate2("gpt_ipg_per",   "ipg_per",           base + 0x6c, 22);
 	if (cpu_is_imx6dl())
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 654151e..323e865 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -128,7 +128,7 @@
 #define IMX6Q_CLK_ECSPI5			116
 #define IMX6DL_CLK_I2C4				116
 #define IMX6QDL_CLK_ENET			117
-#define IMX6QDL_CLK_ESAI			118
+#define IMX6QDL_CLK_ESAI_EXTAL			118
 #define IMX6QDL_CLK_GPT_IPG			119
 #define IMX6QDL_CLK_GPT_IPG_PER			120
 #define IMX6QDL_CLK_GPU2D_CORE			121
@@ -218,7 +218,8 @@
 #define IMX6QDL_CLK_LVDS2_SEL			205
 #define IMX6QDL_CLK_LVDS1_GATE			206
 #define IMX6QDL_CLK_LVDS2_GATE			207
-#define IMX6QDL_CLK_ESAI_AHB			208
-#define IMX6QDL_CLK_END				209
+#define IMX6QDL_CLK_ESAI_IPG			208
+#define IMX6QDL_CLK_ESAI_MEM			209
+#define IMX6QDL_CLK_END				210
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
1.7.9.5
