From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 19 Jan 2018 21:11:08 +0800
Subject: [PATCH V3 08/10] clk: imx: implement new clk_hw based APIs
In-Reply-To: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
References: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1516367470-24340-9-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock providers are recommended to use the new struct clk_hw based API,
so implement IMX clk_hw based provider helpers functions to the new
approach.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * no changes
v1->v2:  new patches
---
 drivers/clk/imx/clk.c | 22 ++++++++++++++++++
 drivers/clk/imx/clk.h | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 9074e69..1efed86 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -18,6 +18,16 @@ void __init imx_check_clocks(struct clk *clks[], unsigned int count)
 			       i, PTR_ERR(clks[i]));
 }
 
+void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (IS_ERR(clks[i]))
+			pr_err("i.MX clk %u: register failed with %ld\n",
+			       i, PTR_ERR(clks[i]));
+}
+
 static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
 {
 	struct of_phandle_args phandle;
@@ -49,6 +59,18 @@ struct clk * __init imx_obtain_fixed_clock(
 	return clk;
 }
 
+struct clk_hw * __init imx_obtain_fixed_clk_hw(struct device_node *np,
+					       const char *name)
+{
+	struct clk *clk;
+
+	clk = of_clk_get_by_name(np, name);
+	if (IS_ERR(clk))
+		return ERR_PTR(-ENOENT);
+
+	return __clk_get_hw(clk);
+}
+
 /*
  * This fixups the register CCM_CSCMR1 write value.
  * The write/read/divider values of the aclk_podf field
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 956155c..3d58420 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -8,6 +8,7 @@
 extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
+void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
 void imx_register_uart_clocks(struct clk ** const clks[]);
 
 extern void imx_cscmr1_fixup(u32 *val);
@@ -54,6 +55,9 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
 struct clk * imx_obtain_fixed_clock(
 			const char *name, unsigned long rate);
 
+struct clk_hw *imx_obtain_fixed_clk_hw(struct device_node *np,
+				       const char *name);
+
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
 
@@ -90,6 +94,16 @@ static inline struct clk *imx_clk_fixed(const char *name, int rate)
 	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
+static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
+{
+	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+}
+
+static inline struct clk_hw *imx_get_clk_hw_fixed(const char *name, int rate)
+{
+	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+}
+
 static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
@@ -113,6 +127,15 @@ static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_divider(const char *name,
+						const char *parent,
+						void __iomem *reg, u8 shift,
+						u8 width)
+{
+	return clk_hw_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+				       reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_divider_flags(const char *name,
 		const char *parent, void __iomem *reg, u8 shift, u8 width,
 		unsigned long flags)
@@ -121,6 +144,15 @@ static inline struct clk *imx_clk_divider_flags(const char *name,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_divider_flags(const char *name,
+						   const char *parent,
+						   void __iomem *reg, u8 shift,
+						   u8 width, unsigned long flags)
+{
+	return clk_hw_register_divider(NULL, name, parent, flags,
+				       reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
@@ -136,6 +168,13 @@ static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 			shift, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_gate(const char *name, const char *parent,
+					     void __iomem *reg, u8 shift)
+{
+	return clk_hw_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+				    shift, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -208,6 +247,17 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_mux2(const char *name, void __iomem *reg,
+					     u8 shift, u8 width,
+					     const char * const *parents,
+					     int num_parents)
+{
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
+				   CLK_SET_RATE_NO_REPARENT |
+				   CLK_OPS_PARENT_ENABLE,
+				   reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_mux_flags(const char *name,
 			void __iomem *reg, u8 shift, u8 width,
 			const char * const *parents, int num_parents,
@@ -218,6 +268,18 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 			&imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_mux_flags(const char *name,
+						  void __iomem *reg, u8 shift,
+						  u8 width,
+						  const char * const *parents,
+						  int num_parents,
+						  unsigned long flags)
+{
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
+				   flags | CLK_SET_RATE_NO_REPARENT,
+				   reg, shift, width, 0, &imx_ccm_lock);
+}
+
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
-- 
2.7.4
