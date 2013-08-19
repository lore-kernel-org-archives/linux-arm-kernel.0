From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon, 19 Aug 2013 13:34:17 +0800
Subject: [PATCH] clk: debugfs add clk_rate_fops with DEBUG
In-Reply-To: <1376875884-13459-1-git-send-email-zhangfei.gao@linaro.org>
References: <1376875884-13459-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1376890457-17871-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_rate_fops is added to debug
1. set_rate (e.g. PLL)
2. Choose mux parent, since mux could choose parent accordingly when set_rate.

Causion: set_rate can be called directly from user space

Example:
sfc_mux have two parents: 24M and 200M

cat clk_summary
   clock                        enable_cnt  prepare_cnt  rate
---------------------------------------------------------------------
 osc24mhz                       3           3            24000000
    bpll_fout3                  0           0            200000000
       sfc_mux                  0           0            200000000
          sfc                   0           0            200000000

cat osc24mhz/bpll/bpll_fout3/sfc_mux/sfc/clk_rate
200000000

echo 24000000 >  osc24mhz/bpll/bpll_fout3/sfc_mux/sfc/clk_rate
cat clk_summary
   clock                        enable_cnt  prepare_cnt  rate
---------------------------------------------------------------------
 osc24mhz                       3           3            24000000
    sfc_mux                     0           0            24000000
       sfc                      0           0            24000000
    bpll_fout3                  0           0            200000000

cat osc24mhz/sfc_mux/sfc/clk_rate
24000000

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/clk/clk.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 373cd54..6b582f7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -226,6 +226,35 @@ static const struct file_operations clk_dump_fops = {
 	.release	= single_release,
 };
 
+#ifdef DEBUG
+static int clk_rate_fops_get(void *data, u64 *rate)
+{
+	struct clk *clk = data;
+
+	*rate = clk->rate;
+
+	return 0;
+};
+
+static int clk_rate_fops_set(void *data, u64 rate)
+{
+	struct clk *clk = data;
+	int ret = 0;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto out;
+	clk_set_rate(clk, rate);
+	clk_disable_unprepare(clk);
+
+out:
+	return ret;
+};
+
+DEFINE_SIMPLE_ATTRIBUTE(clk_rate_fops, clk_rate_fops_get,
+			clk_rate_fops_set, "%llu\n");
+#endif
+
 /* caller must hold prepare_lock */
 static int clk_debug_create_one(struct clk *clk, struct dentry *pdentry)
 {
@@ -243,8 +272,13 @@ static int clk_debug_create_one(struct clk *clk, struct dentry *pdentry)
 
 	clk->dentry = d;
 
+#ifdef DEBUG
+	d = debugfs_create_file("clk_rate", S_IWUSR | S_IRUGO, clk->dentry,
+				clk, &clk_rate_fops);
+#else
 	d = debugfs_create_u32("clk_rate", S_IRUGO, clk->dentry,
 			(u32 *)&clk->rate);
+#endif
 	if (!d)
 		goto err_out;
 
-- 
1.7.9.5
