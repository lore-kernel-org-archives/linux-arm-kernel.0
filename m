From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 10 Jun 2014 09:27:40 +0800
Subject: [PATCH 04/12] clk: mmp: move definiton of mmp_clk_frac to clk.h
In-Reply-To: <1402363668-25806-1-git-send-email-chao.xie@marvell.com>
References: <1402363668-25806-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1402363668-25806-5-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Move the definition of structure of mmp_clk_frac to
clk.h.
So device tree support can use this structure.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/clk/mmp/clk-frac.c |  8 --------
 drivers/clk/mmp/clk.h      | 32 ++++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index 1876d2c..eeba52c 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -23,14 +23,6 @@
  */
 
 #define to_clk_factor(hw) container_of(hw, struct mmp_clk_factor, hw)
-struct mmp_clk_factor {
-	struct clk_hw		hw;
-	void __iomem		*base;
-	struct mmp_clk_factor_masks	*masks;
-	struct mmp_clk_factor_tbl	*ftbl;
-	unsigned int		ftbl_cnt;
-	spinlock_t *lock;
-};
 
 static long clk_factor_round_rate(struct clk_hw *hw, unsigned long drate,
 		unsigned long *prate)
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index b71b717..d267639 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -7,12 +7,14 @@
 #define APBC_NO_BUS_CTRL	BIT(0)
 #define APBC_POWER_CTRL		BIT(1)
 
+
+/* Clock type "factor" */
 struct mmp_clk_factor_masks {
-	unsigned int	factor;
-	unsigned int	num_mask;
-	unsigned int	den_mask;
-	unsigned int	num_shift;
-	unsigned int	den_shift;
+	unsigned int factor;
+	unsigned int num_mask;
+	unsigned int den_mask;
+	unsigned int num_shift;
+	unsigned int den_shift;
 };
 
 struct mmp_clk_factor_tbl {
@@ -20,6 +22,21 @@ struct mmp_clk_factor_tbl {
 	unsigned int den;
 };
 
+struct mmp_clk_factor {
+	struct clk_hw hw;
+	void __iomem *base;
+	struct mmp_clk_factor_masks *masks;
+	struct mmp_clk_factor_tbl *ftbl;
+	unsigned int ftbl_cnt;
+	spinlock_t *lock;
+};
+
+extern struct clk *mmp_clk_register_factor(const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *base, struct mmp_clk_factor_masks *masks,
+		struct mmp_clk_factor_tbl *ftbl, unsigned int ftbl_cnt,
+		spinlock_t *lock);
+
 extern struct clk *mmp_clk_register_pll2(const char *name,
 		const char *parent_name, unsigned long flags);
 extern struct clk *mmp_clk_register_apbc(const char *name,
@@ -28,9 +45,4 @@ extern struct clk *mmp_clk_register_apbc(const char *name,
 extern struct clk *mmp_clk_register_apmu(const char *name,
 		const char *parent_name, void __iomem *base, u32 enable_mask,
 		spinlock_t *lock);
-extern struct clk *mmp_clk_register_factor(const char *name,
-		const char *parent_name, unsigned long flags,
-		void __iomem *base, struct mmp_clk_factor_masks *masks,
-		struct mmp_clk_factor_tbl *ftbl, unsigned int ftbl_cnt,
-		spinlock_t *lock);
 #endif
-- 
1.8.3.2
