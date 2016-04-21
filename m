From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Apr 2016 15:21:52 -0700
Subject: [PATCH v2 01/13] clkdev: Remove clk_register_clkdevs()
In-Reply-To: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1461277324-27185-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we've converted the only caller over to another clkdev
API, remove this one.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clkdev.c   | 27 ---------------------------
 include/linux/clkdev.h |  1 -
 2 files changed, 28 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index eb20b941154b..ae8e40a82d34 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -402,30 +402,3 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
 	return cl ? 0 : -ENOMEM;
 }
 EXPORT_SYMBOL(clk_register_clkdev);
-
-/**
- * clk_register_clkdevs - register a set of clk_lookup for a struct clk
- * @clk: struct clk to associate with all clk_lookups
- * @cl: array of clk_lookup structures with con_id and dev_id pre-initialized
- * @num: number of clk_lookup structures to register
- *
- * To make things easier for mass registration, we detect error clks
- * from a previous clk_register() call, and return the error code for
- * those.  This is to permit this function to be called immediately
- * after clk_register().
- */
-int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num)
-{
-	unsigned i;
-
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	for (i = 0; i < num; i++, cl++) {
-		cl->clk_hw = __clk_get_hw(clk);
-		__clkdev_add(cl);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(clk_register_clkdevs);
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index c2c04f7cbe8a..e6f8eb1d585f 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -45,7 +45,6 @@ void clkdev_add_table(struct clk_lookup *, size_t);
 int clk_add_alias(const char *, const char *, const char *, struct device *);
 
 int clk_register_clkdev(struct clk *, const char *, const char *);
-int clk_register_clkdevs(struct clk *, struct clk_lookup *, size_t);
 
 #ifdef CONFIG_COMMON_CLK
 int __clk_get(struct clk *clk);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
