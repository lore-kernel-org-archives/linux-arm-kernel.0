From: dongas86@gmail.com (Dong Aisheng)
Date: Mon, 11 Sep 2017 17:13:58 +0800
Subject: [PATCH 1/1] clk: bulk: add of_clk_bulk_get()
In-Reply-To: <f9b6af8e-6d1b-702d-40e0-944f5ecedf8a@samsung.com>
References: <CGME20170911074100epcas2p15480963b2119f8954784f9b37ed8d26d@epcas2p1.samsung.com>
 <1505115413-25483-1-git-send-email-aisheng.dong@nxp.com>
 <f9b6af8e-6d1b-702d-40e0-944f5ecedf8a@samsung.com>
Message-ID: <20170911091358.GC19297@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 11, 2017 at 10:58:19AM +0200, Sylwester Nawrocki wrote:
> On 09/11/2017 09:36 AM, Dong Aisheng wrote:
> >'clock-names' property is optinal in DT, so of_clk_bulk_get() is introduced
> >here to handle this for DT users without 'clock-names' specified.
> >
> >Cc: Stephen Boyd <sboyd@codeaurora.org>
> >Cc: Michael Turquette <mturquette@baylibre.com>
> >Cc: Russell King <linux@arm.linux.org.uk>
> >Reported-by: Shawn Guo <shawnguo@kernel.org>
> >Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >---
> >  drivers/clk/clk-bulk.c | 31 +++++++++++++++++++++++++++++++
> >  include/linux/clk.h    |  8 ++++++++
> >  2 files changed, 39 insertions(+)
> >
> >diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
> >index c834f5a..3179f28 100644
> >--- a/drivers/clk/clk-bulk.c
> >+++ b/drivers/clk/clk-bulk.c
> >@@ -19,6 +19,37 @@
> >  #include <linux/clk.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >+#include <linux/of.h>
> >+
> >+#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> >+int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
> >+				 struct clk_bulk_data *clks)
> >+{
> >+	int ret;
> >+	int i;
> >+
> >+	for (i = 0; i < num_clks; i++)
> >+		clks[i].clk = NULL;
> >+
> >+	for (i = 0; i < num_clks; i++) {
> >+		clks[i].clk = of_clk_get(np, i);
> >+		if (IS_ERR(clks[i].clk)) {
> >+			ret = PTR_ERR(clks[i].clk);
> 
> >+			pr_err("%s: Failed to get clk index: %d ret: %d\n",
> >+			       np->full_name, i, ret);
> 
> AFAIU full_node is not supposed now to be dereferenced directly,
> since storing of the full path string for each node is going to be
> removed. %pOF needs to be used instead, e.g.
> 
> 	pr_err("%pOF: failed to get clk %d: %d\n", np, i , ret);
> 

Thanks for telling this.
Just see Rob sent patches to clean up it some days ago.
Will update the patch.

Regards
Dong Aisheng

> >+			clks[i].clk = NULL;
> >+			goto err;
> >+		}
> >+	}
> >+
> >+	return 0;
> >+
> >+err:
> >+	clk_bulk_put(i, clks);
> >+
> >+	return ret;
> >+}
> >+#endif
> 
> -- 
> Regards,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
