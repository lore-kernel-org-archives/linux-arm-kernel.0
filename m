From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 28 May 2015 20:41:48 +0200
Subject: [PATCH 3/3] clk: mediatek: Use regmap clk-mux for mt8135
In-Reply-To: <1432838508-5184-1-git-send-email-matthias.bgg@gmail.com>
References: <1432838508-5184-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1432838508-5184-4-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pericfg controller is used by various device drivers, so that it
is implemented via a regmap. In the actual clk implementation for
mt8135, some clk-mux use the traditional register approach which
acceses the register via iomem.
This patch changes the use from iomem to the needed regmap.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clk/mediatek/clk-mt8135.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index a63435b..bfb56c6 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -513,11 +513,11 @@ static const char * const uart_ck_sel_parents[] __initconst = {
 	"uart_sel",
 };
 
-static const struct mtk_composite peri_clks[] __initconst = {
-	MUX(CLK_PERI_UART0_SEL, "uart0_ck_sel", uart_ck_sel_parents, 0x40c, 0, 1),
-	MUX(CLK_PERI_UART1_SEL, "uart1_ck_sel", uart_ck_sel_parents, 0x40c, 1, 1),
-	MUX(CLK_PERI_UART2_SEL, "uart2_ck_sel", uart_ck_sel_parents, 0x40c, 2, 1),
-	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
+static const struct mtk_regm_mux peri_clks[] __initconst = {
+	MUX_REGMAP(CLK_PERI_UART0_SEL, "uart0_ck_sel", uart_ck_sel_parents, 0x40c, 0, 1),
+	MUX_REGMAP(CLK_PERI_UART1_SEL, "uart1_ck_sel", uart_ck_sel_parents, 0x40c, 1, 1),
+	MUX_REGMAP(CLK_PERI_UART2_SEL, "uart2_ck_sel", uart_ck_sel_parents, 0x40c, 2, 1),
+	MUX_REGMAP(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
 };
 
 static void __init mtk_topckgen_init(struct device_node *node)
@@ -573,20 +573,13 @@ static void __init mtk_pericfg_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
 	int r;
-	void __iomem *base;
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
 						clk_data);
-	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-			&mt8135_clk_lock, clk_data);
+	mtk_clk_regm_register_mux(node, peri_clks, ARRAY_SIZE(peri_clks),
+			clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
-- 
1.9.1
