From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Mar 2012 14:36:00 +0100
Subject: [PATCH 2/8] ARM i.MX: prepare for common clock framework
In-Reply-To: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1332164166-6055-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Add necessary #ifdefs for CONFIG_COMMON_CLOCK
- Add a global spinlock to protect the CCM registers

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk.h                |   44 ++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/clock.c              |   11 ++++++++
 arch/arm/plat-mxc/include/mach/clock.h |    4 +++
 3 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk.h

diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
new file mode 100644
index 0000000..2f1a7b2
--- /dev/null
+++ b/arch/arm/mach-imx/clk.h
@@ -0,0 +1,44 @@
+#ifndef __MACH_IMX_CLK_H
+#define __MACH_IMX_CLK_H
+
+#include <linux/spinlock.h>
+#include <linux/clk-provider.h>
+#include <mach/clock.h>
+
+struct clk *imx_clk_pllv1(const char *name, char *parent,
+		void __iomem *base);
+
+static inline struct clk *imx_clk_fixed(const char *name, int rate)
+{
+	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
+}
+
+static inline struct clk *imx_clk_divider(const char *name, const char *parent,
+		void __iomem *reg, u8 shift, u8 width)
+{
+	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_gate(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, 0, &imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
+		u8 shift, u8 width, char **parents, int num_parents)
+{
+	return clk_register_mux(NULL, name, parents, num_parents, 0, reg, shift,
+			width, 0, &imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_fixed_factor(const char *name,
+		const char *parent, unsigned int mult, unsigned int div)
+{
+	return clk_register_fixed_factor(NULL, name, parent,
+			CLK_SET_RATE_PARENT, mult, div);
+}
+
+#endif
diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 2ed3ab1..5079787 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -41,6 +41,7 @@
 #include <mach/clock.h>
 #include <mach/hardware.h>
 
+#ifndef CONFIG_COMMON_CLK
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
@@ -200,6 +201,16 @@ struct clk *clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_parent);
 
+#else
+
+/*
+ * Lock to protect the clock module (ccm) registers. Used
+ * on all i.MXs
+ */
+DEFINE_SPINLOCK(imx_ccm_lock);
+
+#endif /* CONFIG_COMMON_CLK */
+
 /*
  * Get the resulting clock rate from a PLL register value and the input
  * frequency. PLLs with this register layout can at least be found on
diff --git a/arch/arm/plat-mxc/include/mach/clock.h b/arch/arm/plat-mxc/include/mach/clock.h
index 753a598..bd940c7 100644
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ b/arch/arm/plat-mxc/include/mach/clock.h
@@ -23,6 +23,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/list.h>
 
+#ifndef CONFIG_COMMON_CLK
 struct module;
 
 struct clk {
@@ -59,6 +60,9 @@ struct clk {
 
 int clk_register(struct clk *clk);
 void clk_unregister(struct clk *clk);
+#endif /* CONFIG_COMMON_CLK */
+
+extern spinlock_t imx_ccm_lock;
 
 unsigned long mxc_decode_pll(unsigned int pll, u32 f_ref);
 
-- 
1.7.9.1
