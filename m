From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 5 May 2017 23:26:10 +0800
Subject: [PATCH 2/6] clk: mediatek: export cpu multiplexer clock for
 MT2701/MT7623 SoCs
In-Reply-To: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493997974-17699-3-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The patch enables CPU multiplexer clock on MT2701/MT7623 SoC which fixes
up cpufreq driver fails at acquiring intermediate clock source when driver
probe is called.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701.c      | 8 ++++++++
 include/dt-bindings/clock/mt2701-clk.h | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 6f26e6a..9598889 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -20,6 +20,7 @@
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-cpumux.h"
 
 #include <dt-bindings/clock/mt2701-clk.h>
 
@@ -493,6 +494,10 @@ static const char * const cpu_parents[] = {
 	"mmpll"
 };
 
+static const struct mtk_composite cpu_muxes[] __initconst = {
+	MUX(CLK_INFRA_CPUSEL, "infra_cpu_sel", cpu_parents, 0x0000, 2, 2),
+};
+
 static const struct mtk_composite top_muxes[] = {
 	MUX_GATE_FLAGS(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
 		0x0040, 0, 3, 7, CLK_IS_CRITICAL),
@@ -759,6 +764,9 @@ static void mtk_infrasys_init_early(struct device_node *node)
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 						infra_clk_data);
 
+	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
+				  infra_clk_data);
+
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/include/dt-bindings/clock/mt2701-clk.h b/include/dt-bindings/clock/mt2701-clk.h
index 2062c67..551f760 100644
--- a/include/dt-bindings/clock/mt2701-clk.h
+++ b/include/dt-bindings/clock/mt2701-clk.h
@@ -221,7 +221,8 @@
 #define CLK_INFRA_PMICWRAP			17
 #define CLK_INFRA_DDCCI				18
 #define CLK_INFRA_CLK_13M			19
-#define CLK_INFRA_NR				20
+#define CLK_INFRA_CPUSEL                        20
+#define CLK_INFRA_NR				21
 
 /* PERICFG */
 
-- 
2.7.4
