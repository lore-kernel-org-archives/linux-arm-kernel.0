From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 31 Aug 2018 12:45:53 +0800
Subject: [PATCH V6 1/4] clk: bulk: add of_clk_bulk_get()
In-Reply-To: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1535690756-22234-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'clock-names' property is optional in DT, so of_clk_bulk_get() is
introduced here to handle this for DT users without 'clock-names'
specified. Later clk_bulk_get_all() will be implemented on top of
it and this API will be kept private until someone proves they need
it because they don't have a struct device pointer.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Russell King <linux@arm.linux.org.uk>
Reported-by: Shawn Guo <shawnguo@kernel.org>
Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v3->v4:
 * no changes
v2->v3:
 * remove #if define condition
 * remove EXPORT_SYMBOL
---
 drivers/clk/clk-bulk.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 6904ed6..4460ac5 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -19,6 +19,35 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/of.h>
+
+static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
+					struct clk_bulk_data *clks)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < num_clks; i++)
+		clks[i].clk = NULL;
+
+	for (i = 0; i < num_clks; i++) {
+		clks[i].clk = of_clk_get(np, i);
+		if (IS_ERR(clks[i].clk)) {
+			ret = PTR_ERR(clks[i].clk);
+			pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
+			       np, i, ret);
+			clks[i].clk = NULL;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	clk_bulk_put(i, clks);
+
+	return ret;
+}
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
-- 
2.7.4
