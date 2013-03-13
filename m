From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 13 Mar 2013 15:00:08 +0100
Subject: [PATCH v2 3/4] clk: samsung: always allocate the clk_table
In-Reply-To: <201303131458.18671.heiko@sntech.de>
References: <201303131458.18671.heiko@sntech.de>
Message-ID: <201303131500.08457.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to allow looking up previous created clocks when
adding separate aliases to them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v1:
adapt to the changes in patch 2/4

 drivers/clk/samsung/clk.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index ca04b9e..1ed5716 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -76,14 +76,14 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 	}
 #endif
 
-	if (!np)
-		return;
-
-#ifdef CONFIG_OF
 	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
 	if (!clk_table)
 		panic("could not allocate clock lookup table\n");
 
+	if (!np)
+		return;
+
+#ifdef CONFIG_OF
 	clk_data.clks = clk_table;
 	clk_data.clk_num = nr_clks;
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-- 
1.7.2.3
