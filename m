From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 13 Mar 2013 14:59:36 +0100
Subject: [PATCH v2 2/4] clk: samsung: fix pm init on non-dt platforms
In-Reply-To: <201303131458.18671.heiko@sntech.de>
References: <201303131458.18671.heiko@sntech.de>
Message-ID: <201303131459.37255.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock_init function checked for a dt node, returning immediately
for non-dt machines. This let to the suspend init never being reached
on those non-DT machines.

So fix this by moving the pm init code above the check.

Signed-off-by: Heiko Stueber <heiko@sntech.de>
---
changes since v1:
instead of removing the np check, move the pm init above it, as suggested
by Thomas Abraham.
When removing the np check the dt code is wrongly entered on
non-dt machines if dt support is enabled in the kernel

 drivers/clk/samsung/clk.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index d36cdd5..ca04b9e 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -57,18 +57,6 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 		unsigned long nr_rdump)
 {
 	reg_base = base;
-	if (!np)
-		return;
-
-#ifdef CONFIG_OF
-	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
-	if (!clk_table)
-		panic("could not allocate clock lookup table\n");
-
-	clk_data.clks = clk_table;
-	clk_data.clk_num = nr_clks;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-#endif
 
 #ifdef CONFIG_PM_SLEEP
 	if (rdump && nr_rdump) {
@@ -87,6 +75,19 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 		register_syscore_ops(&samsung_clk_syscore_ops);
 	}
 #endif
+
+	if (!np)
+		return;
+
+#ifdef CONFIG_OF
+	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
+	if (!clk_table)
+		panic("could not allocate clock lookup table\n");
+
+	clk_data.clks = clk_table;
+	clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+#endif
 }
 
 /* add a clock instance to the clock lookup table used for dt based lookup */
-- 
1.7.2.3
