From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 21 Sep 2016 15:12:34 +0200
Subject: [PATCH v2] clkdev: Detect errors in clk_hw_register_clkdev() for mass
 registration
Message-ID: <1474463554-25295-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike clk_register_clkdev(), clk_hw_register_clkdev() doesn't check for
passed error objects from a previous registration call. Hence the caller
of clk_hw_register_*() had to check for errors before calling
clk_hw_register_clkdev*().

Make clk_hw_register_clkdev() more similar to clk_register_clkdev() by
adding this error check, removing the burden from callers that do mass
registration.

Fixes: e4f1b49bda6d6aa2 ("clkdev: Add clk_hw based registration APIs")
Fixes: 944b9a41e004534f ("clk: ls1x: Migrate to clk_hw based OF and registration APIs")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Correct wrong function references
    s/clkdev_{,hw_}create/clk_{,hw_}register_clkdev/

Note that in the mean time more clk_hw conversions not checking for
errors have been posted, leading to crashes in error paths, so it would
be good to have this check in the core.
---
 drivers/clk/clkdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 97ae60fa15849954..bb8a77a5985f8627 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -448,12 +448,20 @@ EXPORT_SYMBOL(clk_register_clkdev);
  *
  * con_id or dev_id may be NULL as a wildcard, just as in the rest of
  * clkdev.
+ *
+ * To make things easier for mass registration, we detect error clk_hws
+ * from a previous clk_hw_register_*() call, and return the error code for
+ * those.  This is to permit this function to be called immediately
+ * after clk_hw_register_*().
  */
 int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
 	const char *dev_id)
 {
 	struct clk_lookup *cl;
 
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
 	/*
 	 * Since dev_id can be NULL, and NULL is handled specially, we must
 	 * pass it as either a NULL format string, or with "%s".
-- 
1.9.1
