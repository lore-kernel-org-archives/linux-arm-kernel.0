From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 15 Feb 2018 14:49:48 +0200
Subject: [PATCH 2/5] clk: ti: add support for register read-modify-write
 low-level operation
In-Reply-To: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
References: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
Message-ID: <1518698991-10099-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Useful for changing few bits on a register, this makes sure for example
that the operation is done atomically in case of syscon.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   | 24 ++++++++++++++++++++++++
 include/linux/clk/ti.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index f4d6802..4efa2c9 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -55,6 +55,29 @@ static void clk_memmap_writel(u32 val, const struct clk_omap_reg *reg)
 		writel_relaxed(val, io->mem + reg->offset);
 }
 
+static void _clk_rmw(u32 val, u32 mask, void __iomem *ptr)
+{
+	u32 v;
+
+	v = readl_relaxed(ptr);
+	v &= ~mask;
+	v |= val;
+	writel_relaxed(v, ptr);
+}
+
+static void clk_memmap_rmw(u32 val, u32 mask, const struct clk_omap_reg *reg)
+{
+	struct clk_iomap *io = clk_memmaps[reg->index];
+
+	if (reg->ptr) {
+		_clk_rmw(val, mask, reg->ptr);
+	} else if (io->regmap) {
+		regmap_update_bits(io->regmap, reg->offset, mask, val);
+	} else {
+		_clk_rmw(val, mask, io->mem + reg->offset);
+	}
+}
+
 static u32 clk_memmap_readl(const struct clk_omap_reg *reg)
 {
 	u32 val;
@@ -89,6 +112,7 @@ int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
 	ti_clk_ll_ops = ops;
 	ops->clk_readl = clk_memmap_readl;
 	ops->clk_writel = clk_memmap_writel;
+	ops->clk_rmw = clk_memmap_rmw;
 
 	return 0;
 }
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index d18da83..9e86114 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -211,6 +211,7 @@ enum {
  * struct ti_clk_ll_ops - low-level ops for clocks
  * @clk_readl: pointer to register read function
  * @clk_writel: pointer to register write function
+ * @clk_rmw: pointer to register read-modify-write function
  * @clkdm_clk_enable: pointer to clockdomain enable function
  * @clkdm_clk_disable: pointer to clockdomain disable function
  * @clkdm_lookup: pointer to clockdomain lookup function
@@ -226,6 +227,7 @@ enum {
 struct ti_clk_ll_ops {
 	u32	(*clk_readl)(const struct clk_omap_reg *reg);
 	void	(*clk_writel)(u32 val, const struct clk_omap_reg *reg);
+	void	(*clk_rmw)(u32 val, u32 mask, const struct clk_omap_reg *reg);
 	int	(*clkdm_clk_enable)(struct clockdomain *clkdm, struct clk *clk);
 	int	(*clkdm_clk_disable)(struct clockdomain *clkdm,
 				     struct clk *clk);
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
