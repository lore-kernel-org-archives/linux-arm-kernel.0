From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Thu, 23 Apr 2015 04:49:44 +0800
Subject: [PATCH 1/1] arm: imx: move clk common part to driver/clk/imx
Message-ID: <1429735784-32492-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

move clock common part to driver/clk/imx
except clk-pllv1.c because it use cpu_is_xxx()

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/mach-imx/Makefile                         |   5 +-
 drivers/clk/Makefile                               |   1 +
 drivers/clk/imx/Makefile                           |   4 +
 {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c  |   0
 .../mach-imx => drivers/clk/imx}/clk-fixup-div.c   |   0
 .../mach-imx => drivers/clk/imx}/clk-fixup-mux.c   |   0
 .../clk/imx}/clk-gate-exclusive.c                  |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c   |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk.c       |   0
 drivers/clk/imx/clk.h                              | 139 +++++++++++++++++++++
 13 files changed, 145 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/imx/Makefile
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-div.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-mux.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate-exclusive.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk.c (100%)
 create mode 100644 drivers/clk/imx/clk.h

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8d1b101..91c3fda 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -14,10 +14,7 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clk-imx35.o ehci-imx35.o pm-imx
 imx5-pm-$(CONFIG_PM) += pm-imx5.o
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o clk-imx51-imx53.o clk-cpu.o $(imx5-pm-y)
 
-obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
-			    clk-pfd.o clk-busy.o clk.o \
-			    clk-fixup-div.o clk-fixup-mux.o \
-			    clk-gate-exclusive.o
+obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o
 
 obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d478ceb..ebe86b3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -70,3 +70,4 @@ obj-$(CONFIG_ARCH_U8500)		+= ux500/
 obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
 obj-$(CONFIG_X86)			+= x86/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
+obj-$(CONFIG_ARCH_MXC)			+= imx/
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
new file mode 100644
index 0000000..b45ff25
--- /dev/null
+++ b/drivers/clk/imx/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_COMMON_CLK) += clk-pllv2.o clk-pllv3.o clk-gate2.o \
+                            clk-pfd.o clk-busy.o clk.o \
+                            clk-fixup-div.o clk-fixup-mux.o \
+			    clk-gate-exclusive.o
diff --git a/arch/arm/mach-imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
similarity index 100%
rename from arch/arm/mach-imx/clk-busy.c
rename to drivers/clk/imx/clk-busy.c
diff --git a/arch/arm/mach-imx/clk-fixup-div.c b/drivers/clk/imx/clk-fixup-div.c
similarity index 100%
rename from arch/arm/mach-imx/clk-fixup-div.c
rename to drivers/clk/imx/clk-fixup-div.c
diff --git a/arch/arm/mach-imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mux.c
similarity index 100%
rename from arch/arm/mach-imx/clk-fixup-mux.c
rename to drivers/clk/imx/clk-fixup-mux.c
diff --git a/arch/arm/mach-imx/clk-gate-exclusive.c b/drivers/clk/imx/clk-gate-exclusive.c
similarity index 100%
rename from arch/arm/mach-imx/clk-gate-exclusive.c
rename to drivers/clk/imx/clk-gate-exclusive.c
diff --git a/arch/arm/mach-imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
similarity index 100%
rename from arch/arm/mach-imx/clk-gate2.c
rename to drivers/clk/imx/clk-gate2.c
diff --git a/arch/arm/mach-imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
similarity index 100%
rename from arch/arm/mach-imx/clk-pfd.c
rename to drivers/clk/imx/clk-pfd.c
diff --git a/arch/arm/mach-imx/clk-pllv2.c b/drivers/clk/imx/clk-pllv2.c
similarity index 100%
rename from arch/arm/mach-imx/clk-pllv2.c
rename to drivers/clk/imx/clk-pllv2.c
diff --git a/arch/arm/mach-imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
similarity index 100%
rename from arch/arm/mach-imx/clk-pllv3.c
rename to drivers/clk/imx/clk-pllv3.c
diff --git a/arch/arm/mach-imx/clk.c b/drivers/clk/imx/clk.c
similarity index 100%
rename from arch/arm/mach-imx/clk.c
rename to drivers/clk/imx/clk.c
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
new file mode 100644
index 0000000..6a07903
--- /dev/null
+++ b/drivers/clk/imx/clk.h
@@ -0,0 +1,139 @@
+#ifndef __MACH_IMX_CLK_H
+#define __MACH_IMX_CLK_H
+
+#include <linux/spinlock.h>
+#include <linux/clk-provider.h>
+
+extern spinlock_t imx_ccm_lock;
+
+void imx_check_clocks(struct clk *clks[], unsigned int count);
+
+extern void imx_cscmr1_fixup(u32 *val);
+
+struct clk *imx_clk_pllv1(const char *name, const char *parent,
+		void __iomem *base);
+
+struct clk *imx_clk_pllv2(const char *name, const char *parent,
+		void __iomem *base);
+
+enum imx_pllv3_type {
+	IMX_PLLV3_GENERIC,
+	IMX_PLLV3_SYS,
+	IMX_PLLV3_USB,
+	IMX_PLLV3_USB_VF610,
+	IMX_PLLV3_AV,
+	IMX_PLLV3_ENET,
+};
+
+struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
+		const char *parent_name, void __iomem *base, u32 div_mask);
+
+struct clk *clk_register_gate2(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock,
+		unsigned int *share_count);
+
+struct clk * imx_obtain_fixed_clock(
+			const char *name, unsigned long rate);
+
+struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
+	 void __iomem *reg, u8 shift, u32 exclusive_mask);
+
+static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, 0, &imx_ccm_lock, NULL);
+}
+
+static inline struct clk *imx_clk_gate2_shared(const char *name,
+		const char *parent, void __iomem *reg, u8 shift,
+		unsigned int *share_count)
+{
+	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, 0, &imx_ccm_lock, share_count);
+}
+
+struct clk *imx_clk_pfd(const char *name, const char *parent_name,
+		void __iomem *reg, u8 idx);
+
+struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
+				 void __iomem *reg, u8 shift, u8 width,
+				 void __iomem *busy_reg, u8 busy_shift);
+
+struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
+			     u8 width, void __iomem *busy_reg, u8 busy_shift,
+			     const char **parent_names, int num_parents);
+
+struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
+				  void __iomem *reg, u8 shift, u8 width,
+				  void (*fixup)(u32 *val));
+
+struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
+			      u8 shift, u8 width, const char **parents,
+			      int num_parents, void (*fixup)(u32 *val));
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
+static inline struct clk *imx_clk_divider_flags(const char *name,
+		const char *parent, void __iomem *reg, u8 shift, u8 width,
+		unsigned long flags)
+{
+	return clk_register_divider(NULL, name, parent, flags,
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
+static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
+		u8 shift, u8 width, const char **parents, int num_parents)
+{
+	return clk_register_mux(NULL, name, parents, num_parents,
+			CLK_SET_RATE_NO_REPARENT, reg, shift,
+			width, 0, &imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_mux_flags(const char *name,
+		void __iomem *reg, u8 shift, u8 width, const char **parents,
+		int num_parents, unsigned long flags)
+{
+	return clk_register_mux(NULL, name, parents, num_parents,
+			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
+			&imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_fixed_factor(const char *name,
+		const char *parent, unsigned int mult, unsigned int div)
+{
+	return clk_register_fixed_factor(NULL, name, parent,
+			CLK_SET_RATE_PARENT, mult, div);
+}
+
+struct clk *imx_clk_cpu(const char *name, const char *parent_name,
+		struct clk *div, struct clk *mux, struct clk *pll,
+		struct clk *step);
+
+#endif
-- 
1.9.1
