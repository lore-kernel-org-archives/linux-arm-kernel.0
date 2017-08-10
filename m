From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 10 Aug 2017 10:36:17 +0800
Subject: [PATCH v2] clk: bulk: call of_clk_get() when id is NULL
Message-ID: <1502332577-13600-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Most of clk API users have their clocks defined in device tree, and
client drivers will have to parse clk ids from DT 'clock-names'
property before using clk_bulk_get().  This is a burden for client
driver code.  And 'clock-names' being an optional DT property makes
it even worse.  The client driver will have no way to provide clock
id.

The patch introduces the flag CLK_BULK_CLK_GET_OF in clk_bulk_data.  If
client driver calls API clk_bulk_get() with this flag, clock id will be
ignored completely, and the API will retrieve clock by invoking
of_clk_get() with clock index.  With this change, the bulk clk API will
become much more useful for DT users.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes for v2:
 - Add flag CLK_BULK_CLK_GET_OF for clk_bulk_get() API to decide to call
   clk_get() with id or of_clk_get() with index for retrieving clock.
 - Update kernel-doc of clk_bulk_get() API to reflect the change.

 drivers/clk/clk-bulk.c |  5 ++++-
 include/linux/clk.h    | 12 +++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index c834f5abfc49..2812f87bf27e 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -39,7 +39,10 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 		clks[i].clk = NULL;
 
 	for (i = 0; i < num_clks; i++) {
-		clks[i].clk = clk_get(dev, clks[i].id);
+		if (clks->flags & CLK_BULK_CLK_GET_OF)
+			clks[i].clk = of_clk_get(dev->of_node, i);
+		else
+			clks[i].clk = clk_get(dev, clks[i].id);
 		if (IS_ERR(clks[i].clk)) {
 			ret = PTR_ERR(clks[i].clk);
 			dev_err(dev, "Failed to get clk '%s': %d\n",
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 12c96d94d1fa..31fee2e8d4a2 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -82,16 +82,24 @@ struct clk_notifier_data {
  *
  * @id: clock consumer ID
  * @clk: struct clk * to store the associated clock
+ * @flags: bulk clk operation flags
  *
  * The CLK APIs provide a series of clk_bulk_() API calls as
  * a convenience to consumers which require multiple clks.  This
  * structure is used to manage data for these calls.
+ *
+ * Flags:
+ * CLK_BULK_CLK_GET_OF - Instead of calling clk_get() to retrieve clock by id,
+ *	clk_bulk_get() API will call of_clk_get() to find clock by index.
  */
 struct clk_bulk_data {
 	const char		*id;
 	struct clk		*clk;
+	unsigned long		flags;
 };
 
+#define CLK_BULK_CLK_GET_OF	BIT(0)
+
 #ifdef CONFIG_COMMON_CLK
 
 /**
@@ -270,7 +278,9 @@ static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
  * Returns 0 if all clocks specified in clk_bulk_data table are obtained
  * successfully, or valid IS_ERR() condition containing errno.
  * The implementation uses @dev and @clk_bulk_data.id to determine the
- * clock consumer, and thereby the clock producer.
+ * clock consumer, and thereby the clock producer.  If flag CLK_BULK_CLK_GET_OF
+ * is set in @clk_bulk_data.flags, @clk_bulk_data.id will be ignored and the API
+ * will look up clock by calling of_clk_get() with clock index.
  * The clock returned is stored in each @clk_bulk_data.clk field.
  *
  * Drivers must assume that the clock source is not enabled.
-- 
1.9.1
