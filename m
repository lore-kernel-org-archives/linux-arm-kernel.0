From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Thu, 4 Sep 2014 17:48:58 +0800
Subject: [PATCH V1 1/2] ARM: clk-imx6q: refine clock tree for ASRC
Message-ID: <98d2985de76fa84525e9958522bd371a34ff84f0.1409824001.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ASRC has "asrc", "asrc_ipg", "asrc_mem" clocks, and they share
the same gate bits.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c             |    5 ++++-
 include/dt-bindings/clock/imx6qdl-clock.h |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 2edcebf..d5bf1e2 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -107,6 +107,7 @@ static struct clk_div_table video_div_table[] = {
 };
 
 static unsigned int share_count_esai;
+static unsigned int share_count_asrc;
 
 static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
@@ -317,7 +318,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 
 	/*                                            name             parent_name          reg         shift */
 	clk[IMX6QDL_CLK_APBH_DMA]     = imx_clk_gate2("apbh_dma",      "usdhc3",            base + 0x68, 4);
-	clk[IMX6QDL_CLK_ASRC]         = imx_clk_gate2("asrc",          "asrc_podf",         base + 0x68, 6);
+	clk[IMX6QDL_CLK_ASRC]         = imx_clk_gate2_shared("asrc",         "asrc_podf",   base + 0x68, 6, &share_count_asrc);
+	clk[IMX6QDL_CLK_ASRC_IPG]     = imx_clk_gate2_shared("asrc_ipg",     "ahb",         base + 0x68, 6, &share_count_asrc);
+	clk[IMX6QDL_CLK_ASRC_MEM]     = imx_clk_gate2_shared("asrc_mem",     "ahb",         base + 0x68, 6, &share_count_asrc);
 	clk[IMX6QDL_CLK_CAN1_IPG]     = imx_clk_gate2("can1_ipg",      "ipg",               base + 0x68, 14);
 	clk[IMX6QDL_CLK_CAN1_SERIAL]  = imx_clk_gate2("can1_serial",   "can_root",          base + 0x68, 16);
 	clk[IMX6QDL_CLK_CAN2_IPG]     = imx_clk_gate2("can2_ipg",      "ipg",               base + 0x68, 18);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 323e865..1e99613 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -220,6 +220,8 @@
 #define IMX6QDL_CLK_LVDS2_GATE			207
 #define IMX6QDL_CLK_ESAI_IPG			208
 #define IMX6QDL_CLK_ESAI_MEM			209
-#define IMX6QDL_CLK_END				210
+#define IMX6QDL_CLK_ASRC_IPG			210
+#define IMX6QDL_CLK_ASRC_MEM			211
+#define IMX6QDL_CLK_END				212
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
1.7.9.5
