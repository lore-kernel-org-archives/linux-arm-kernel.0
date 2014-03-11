From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 11 Mar 2014 09:40:02 +0800
Subject: [PATCH 3/3] clk: hisi: remove static variable
In-Reply-To: <1394502002-31058-1-git-send-email-haojian.zhuang@linaro.org>
References: <1394502002-31058-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1394502002-31058-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the static variable. So these common clock register helper could
be used in more SoCs.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/clk/hisilicon/clk-hi3620.c | 25 +++++----------
 drivers/clk/hisilicon/clk-hip04.c  |  8 +++--
 drivers/clk/hisilicon/clk.c        | 64 ++++++++++++++++++++++++++++----------
 drivers/clk/hisilicon/clk.h        | 17 ++++++----
 4 files changed, 72 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 38faa469..233eba2 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -210,34 +210,25 @@ static struct hisi_gate_clock hi3620_seperated_gate_clks[] __initdata = {
 
 static void __init hi3620_clk_init(struct device_node *np)
 {
-	void __iomem *base;
+	struct hisi_clock_data *clk_data;
 
-	if (np) {
-		base = of_iomap(np, 0);
-		if (!base) {
-			pr_err("failed to map Hi3620 clock registers\n");
-			return;
-		}
-	} else {
-		pr_err("failed to find Hi3620 clock node in DTS\n");
+	clk_data = hisi_clk_init(np, HI3620_NR_CLKS);
+	if (!clk_data)
 		return;
-	}
-
-	hisi_clk_init(np, HI3620_NR_CLKS);
 
 	hisi_clk_register_fixed_rate(hi3620_fixed_rate_clks,
 				     ARRAY_SIZE(hi3620_fixed_rate_clks),
-				     base);
+				     clk_data);
 	hisi_clk_register_fixed_factor(hi3620_fixed_factor_clks,
 				       ARRAY_SIZE(hi3620_fixed_factor_clks),
-				       base);
+				       clk_data);
 	hisi_clk_register_mux(hi3620_mux_clks, ARRAY_SIZE(hi3620_mux_clks),
-			      base);
+			      clk_data);
 	hisi_clk_register_divider(hi3620_div_clks, ARRAY_SIZE(hi3620_div_clks),
-				  base);
+				  clk_data);
 	hisi_clk_register_gate_sep(hi3620_seperated_gate_clks,
 				   ARRAY_SIZE(hi3620_seperated_gate_clks),
-				   base);
+				   clk_data);
 }
 CLK_OF_DECLARE(hi3620_clk, "hisilicon,hi3620-clock", hi3620_clk_init);
 
diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
index bdc6cd0..132b57a 100644
--- a/drivers/clk/hisilicon/clk-hip04.c
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -45,10 +45,14 @@ static struct hisi_fixed_rate_clock hip04_fixed_rate_clks[] __initdata = {
 
 static void __init hip04_clk_init(struct device_node *np)
 {
-	hisi_clk_init(np, HIP04_NR_CLKS);
+	struct hisi_clock_data *clk_data;
+
+	clk_data = hisi_clk_init(np, HIP04_NR_CLKS);
+	if (!clk_data)
+		return;
 
 	hisi_clk_register_fixed_rate(hip04_fixed_rate_clks,
 				     ARRAY_SIZE(hip04_fixed_rate_clks),
-				     NULL);
+				     clk_data);
 }
 CLK_OF_DECLARE(hip04_clk, "hisilicon,hip04-clock", hip04_clk_init);
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 18fc21f..276f672 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -37,23 +37,49 @@
 #include "clk.h"
 
 static DEFINE_SPINLOCK(hisi_clk_lock);
-static struct clk **clk_table;
-static struct clk_onecell_data clk_data;
 
-void __init hisi_clk_init(struct device_node *np, int nr_clks)
+struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
+					     int nr_clks)
 {
+	struct hisi_clock_data *clk_data;
+	struct clk **clk_table;
+	void __iomem *base;
+
+	if (np) {
+		base = of_iomap(np, 0);
+		if (!base) {
+			pr_err("failed to map Hisilicon clock registers\n");
+			goto err;
+		}
+	} else {
+		pr_err("failed to find Hisilicon clock node in DTS\n");
+		goto err;
+	}
+
+	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data) {
+		pr_err("%s: could not allocate clock data\n", __func__);
+		goto err;
+	}
+	clk_data->base = base;
+
 	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
 	if (!clk_table) {
 		pr_err("%s: could not allocate clock lookup table\n", __func__);
-		return;
+		goto err_data;
 	}
-	clk_data.clks = clk_table;
-	clk_data.clk_num = nr_clks;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	clk_data->clk_data.clks = clk_table;
+	clk_data->clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
+	return clk_data;
+err_data:
+	kfree(clk_data);
+err:
+	return NULL;
 }
 
 void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
-					 int nums, void __iomem *base)
+					 int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
 	int i;
@@ -68,12 +94,13 @@ void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
 			       __func__, clks[i].name);
 			continue;
 		}
-		clk_table[clks[i].id] = clk;
+		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
 
 void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
-					   int nums, void __iomem *base)
+					   int nums,
+					   struct hisi_clock_data *data)
 {
 	struct clk *clk;
 	int i;
@@ -88,14 +115,15 @@ void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
 			       __func__, clks[i].name);
 			continue;
 		}
-		clk_table[clks[i].id] = clk;
+		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
 
 void __init hisi_clk_register_mux(struct hisi_mux_clock *clks,
-				  int nums, void __iomem *base)
+				  int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
+	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
@@ -113,14 +141,15 @@ void __init hisi_clk_register_mux(struct hisi_mux_clock *clks,
 		if (clks[i].alias)
 			clk_register_clkdev(clk, clks[i].alias, NULL);
 
-		clk_table[clks[i].id] = clk;
+		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
 
 void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
-				      int nums, void __iomem *base)
+				      int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
+	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
@@ -141,14 +170,15 @@ void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
 		if (clks[i].alias)
 			clk_register_clkdev(clk, clks[i].alias, NULL);
 
-		clk_table[clks[i].id] = clk;
+		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
 
 void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
-				       int nums, void __iomem *base)
+				       int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
+	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
@@ -168,6 +198,6 @@ void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
 		if (clks[i].alias)
 			clk_register_clkdev(clk, clks[i].alias, NULL);
 
-		clk_table[clks[i].id] = clk;
+		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 4a6beeb..43fa5da 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -30,6 +30,11 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 
+struct hisi_clock_data {
+	struct clk_onecell_data	clk_data;
+	void __iomem		*base;
+};
+
 struct hisi_fixed_rate_clock {
 	unsigned int		id;
 	char			*name;
@@ -89,15 +94,15 @@ struct clk *hisi_register_clkgate_sep(struct device *, const char *,
 				void __iomem *, u8,
 				u8, spinlock_t *);
 
-void __init hisi_clk_init(struct device_node *, int);
+struct hisi_clock_data __init *hisi_clk_init(struct device_node *, int);
 void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
-					int, void __iomem *);
+					int, struct hisi_clock_data *);
 void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *,
-					int, void __iomem *);
+					int, struct hisi_clock_data *);
 void __init hisi_clk_register_mux(struct hisi_mux_clock *, int,
-				void __iomem *);
+				struct hisi_clock_data *);
 void __init hisi_clk_register_divider(struct hisi_divider_clock *,
-				int, void __iomem *);
+				int, struct hisi_clock_data *);
 void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *,
-					int, void __iomem *);
+					int, struct hisi_clock_data *);
 #endif	/* __HISI_CLK_H */
-- 
1.8.3.2
