From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Jul 2014 22:55:42 +0800
Subject: [PATCH v3 2/9] clk: sunxi: Fix gate indexing for sun6i-a31-apb0-gates
In-Reply-To: <1404399349-20237-1-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
Message-ID: <1404399349-20237-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun6i-a31-apb0-gates supports using clock-indices for holes between
individual gates. However, the driver passes the number of gates
registered in clk_data->clk_num, which of_clk_src_onecell_get uses
to recognize the range of valid indices a consumer can use.

This patch makes the driver pass the maximum gate index + 1, so
of_clk_src_onecell_get does not complain about indices greater
than gates registered.

This was tested on the A23 SoC, which has a similar APB0 clock,
but has holes for gates to removed IP blocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index 44cd27c..b342f2a 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -25,6 +25,7 @@ static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 	void __iomem *reg;
 	int gate_id;
 	int ngates;
+	int gate_max = 0;
 	int i;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -72,9 +73,12 @@ static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 							    reg, gate_id,
 							    0, NULL);
 		WARN_ON(IS_ERR(clk_data->clks[gate_id]));
+
+		if (gate_id > gate_max)
+			gate_max = gate_id;
 	}
 
-	clk_data->clk_num = ngates;
+	clk_data->clk_num = gate_max + 1;
 
 	return of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
 }
-- 
2.0.1
