From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 10 Jun 2014 09:27:37 +0800
Subject: [PATCH 01/12] clk: mmp: add prefix "mmp" for structures defined for
 clk-frac
In-Reply-To: <1402363668-25806-1-git-send-email-chao.xie@marvell.com>
References: <1402363668-25806-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1402363668-25806-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

The structures defined for clk-frac will be used out side
of clk-frac.c.
To avoid conflicts, add prefix "mmp" for these structures'
name.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/clk/mmp/clk-frac.c   | 23 ++++++++++++-----------
 drivers/clk/mmp/clk-mmp2.c   |  4 ++--
 drivers/clk/mmp/clk-pxa168.c |  4 ++--
 drivers/clk/mmp/clk-pxa910.c |  4 ++--
 drivers/clk/mmp/clk.h        |  8 ++++----
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index 23a56f5..3fbc9ca 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -22,19 +22,19 @@
  * numerator/denominator = Fin / (Fout * factor)
  */
 
-#define to_clk_factor(hw) container_of(hw, struct clk_factor, hw)
-struct clk_factor {
+#define to_clk_factor(hw) container_of(hw, struct mmp_clk_factor, hw)
+struct mmp_clk_factor {
 	struct clk_hw		hw;
 	void __iomem		*base;
-	struct clk_factor_masks	*masks;
-	struct clk_factor_tbl	*ftbl;
+	struct mmp_clk_factor_masks	*masks;
+	struct mmp_clk_factor_tbl	*ftbl;
 	unsigned int		ftbl_cnt;
 };
 
 static long clk_factor_round_rate(struct clk_hw *hw, unsigned long drate,
 		unsigned long *prate)
 {
-	struct clk_factor *factor = to_clk_factor(hw);
+	struct mmp_clk_factor *factor = to_clk_factor(hw);
 	unsigned long rate = 0, prev_rate;
 	int i;
 
@@ -58,8 +58,8 @@ static long clk_factor_round_rate(struct clk_hw *hw, unsigned long drate,
 static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
-	struct clk_factor *factor = to_clk_factor(hw);
-	struct clk_factor_masks *masks = factor->masks;
+	struct mmp_clk_factor *factor = to_clk_factor(hw);
+	struct mmp_clk_factor_masks *masks = factor->masks;
 	unsigned int val, num, den;
 
 	val = readl_relaxed(factor->base);
@@ -81,8 +81,8 @@ static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
 static int clk_factor_set_rate(struct clk_hw *hw, unsigned long drate,
 				unsigned long prate)
 {
-	struct clk_factor *factor = to_clk_factor(hw);
-	struct clk_factor_masks *masks = factor->masks;
+	struct mmp_clk_factor *factor = to_clk_factor(hw);
+	struct mmp_clk_factor_masks *masks = factor->masks;
 	int i;
 	unsigned long val;
 	unsigned long prev_rate, rate = 0;
@@ -118,10 +118,11 @@ static struct clk_ops clk_factor_ops = {
 
 struct clk *mmp_clk_register_factor(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *base,
-		struct clk_factor_masks *masks, struct clk_factor_tbl *ftbl,
+		struct mmp_clk_factor_masks *masks,
+		struct mmp_clk_factor_tbl *ftbl,
 		unsigned int ftbl_cnt)
 {
-	struct clk_factor *factor;
+	struct mmp_clk_factor *factor;
 	struct clk_init_data init;
 	struct clk *clk;
 
diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index b2721ca..7083f12 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -54,7 +54,7 @@
 
 static DEFINE_SPINLOCK(clk_lock);
 
-static struct clk_factor_masks uart_factor_masks = {
+static struct mmp_clk_factor_masks uart_factor_masks = {
 	.factor = 2,
 	.num_mask = 0x1fff,
 	.den_mask = 0x1fff,
@@ -62,7 +62,7 @@ static struct clk_factor_masks uart_factor_masks = {
 	.den_shift = 0,
 };
 
-static struct clk_factor_tbl uart_factor_tbl[] = {
+static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
 	{.num = 14634, .den = 2165},	/*14.745MHZ */
 	{.num = 3521, .den = 689},	/*19.23MHZ */
 	{.num = 9679, .den = 5728},	/*58.9824MHZ */
diff --git a/drivers/clk/mmp/clk-pxa168.c b/drivers/clk/mmp/clk-pxa168.c
index 014396b..75266ac 100644
--- a/drivers/clk/mmp/clk-pxa168.c
+++ b/drivers/clk/mmp/clk-pxa168.c
@@ -47,7 +47,7 @@
 
 static DEFINE_SPINLOCK(clk_lock);
 
-static struct clk_factor_masks uart_factor_masks = {
+static struct mmp_clk_factor_masks uart_factor_masks = {
 	.factor = 2,
 	.num_mask = 0x1fff,
 	.den_mask = 0x1fff,
@@ -55,7 +55,7 @@ static struct clk_factor_masks uart_factor_masks = {
 	.den_shift = 0,
 };
 
-static struct clk_factor_tbl uart_factor_tbl[] = {
+static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
 	{.num = 8125, .den = 1536},	/*14.745MHZ */
 };
 
diff --git a/drivers/clk/mmp/clk-pxa910.c b/drivers/clk/mmp/clk-pxa910.c
index 9efc6a4..f817999 100644
--- a/drivers/clk/mmp/clk-pxa910.c
+++ b/drivers/clk/mmp/clk-pxa910.c
@@ -45,7 +45,7 @@
 
 static DEFINE_SPINLOCK(clk_lock);
 
-static struct clk_factor_masks uart_factor_masks = {
+static struct mmp_clk_factor_masks uart_factor_masks = {
 	.factor = 2,
 	.num_mask = 0x1fff,
 	.den_mask = 0x1fff,
@@ -53,7 +53,7 @@ static struct clk_factor_masks uart_factor_masks = {
 	.den_shift = 0,
 };
 
-static struct clk_factor_tbl uart_factor_tbl[] = {
+static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
 	{.num = 8125, .den = 1536},	/*14.745MHZ */
 };
 
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index ab86dd4..3fe92be 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -7,7 +7,7 @@
 #define APBC_NO_BUS_CTRL	BIT(0)
 #define APBC_POWER_CTRL		BIT(1)
 
-struct clk_factor_masks {
+struct mmp_clk_factor_masks {
 	unsigned int	factor;
 	unsigned int	num_mask;
 	unsigned int	den_mask;
@@ -15,7 +15,7 @@ struct clk_factor_masks {
 	unsigned int	den_shift;
 };
 
-struct clk_factor_tbl {
+struct mmp_clk_factor_tbl {
 	unsigned int num;
 	unsigned int den;
 };
@@ -30,6 +30,6 @@ extern struct clk *mmp_clk_register_apmu(const char *name,
 		spinlock_t *lock);
 extern struct clk *mmp_clk_register_factor(const char *name,
 		const char *parent_name, unsigned long flags,
-		void __iomem *base, struct clk_factor_masks *masks,
-		struct clk_factor_tbl *ftbl, unsigned int ftbl_cnt);
+		void __iomem *base, struct mmp_clk_factor_masks *masks,
+		struct mmp_clk_factor_tbl *ftbl, unsigned int ftbl_cnt);
 #endif
-- 
1.8.3.2
