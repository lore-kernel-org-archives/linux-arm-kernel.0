From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 30 Mar 2015 13:24:21 +0800
Subject: [PATCH v2 2/5] clk: hisi: add API for allocation clk data struct
In-Reply-To: <1427693064-11062-1-git-send-email-leo.yan@linaro.org>
References: <1427693064-11062-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1427693064-11062-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the clk init function, it will read the register base address from
dts and allocate the clk data structures. But for the some cases, the
clock driver don't need init the reg's base address, which will directly
access mmio region with syscon.

So for clock's initialization, this patch adds one more API which is
only for allocating clock data structure.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/clk.c | 30 +++++++++++++++++++++++-------
 drivers/clk/hisilicon/clk.h |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 1951b37..87f8173 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -38,16 +38,14 @@
 
 static DEFINE_SPINLOCK(hisi_clk_lock);
 
-struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
-					     int nr_clks)
+struct hisi_clock_data __init *hisi_clk_alloc_data(struct device_node *np,
+						   int nr_clks)
 {
 	struct hisi_clock_data *clk_data;
 	struct clk **clk_table;
-	void __iomem *base;
 
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("%s: failed to map clock registers\n", __func__);
+	if (!np) {
+		pr_err("%s: invalid device node handler\n", __func__);
 		goto err;
 	}
 
@@ -56,7 +54,6 @@ struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
 		pr_err("%s: could not allocate clock data\n", __func__);
 		goto err;
 	}
-	clk_data->base = base;
 
 	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
 	if (!clk_table) {
@@ -67,12 +64,31 @@ struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
 	clk_data->clk_data.clk_num = nr_clks;
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
 	return clk_data;
+
 err_data:
 	kfree(clk_data);
 err:
 	return NULL;
 }
 
+struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
+					     int nr_clks)
+{
+	struct hisi_clock_data *clk_data;
+	void __iomem *base;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s: failed to map clock registers\n", __func__);
+		return NULL;
+	}
+
+	clk_data = hisi_clk_alloc_data(np, nr_clks);
+	if (clk_data)
+		clk_data->base = base;
+	return clk_data;
+}
+
 void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
 					 int nums, struct hisi_clock_data *data)
 {
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 31083ff..624f608 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -96,6 +96,8 @@ struct clk *hisi_register_clkgate_sep(struct device *, const char *,
 				u8, spinlock_t *);
 
 struct hisi_clock_data __init *hisi_clk_init(struct device_node *, int);
+struct hisi_clock_data __init *hisi_clk_alloc_data(struct device_node *np,
+						   int nr_clks);
 void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
 					int, struct hisi_clock_data *);
 void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *,
-- 
1.9.1
