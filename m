From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 19 Jan 2018 21:11:05 +0800
Subject: [PATCH V3 05/10] clk: imx: add composite clk support
In-Reply-To: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
References: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1516367470-24340-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx composite clk is designed for Peripheral Clock Control (PCC)
module observed in IMX ULP SoC series. e.g. i.MX7ULP.

NOTE pcc can only be operated when clk is gated.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * no changes
v1->v2:
 * remove an unneeded blank line change
 * use clk_hw_register
---
 drivers/clk/imx/Makefile        |  1 +
 drivers/clk/imx/clk-composite.c | 90 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |  6 +++
 3 files changed, 97 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 9c04ae4..eab606c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -4,6 +4,7 @@ obj-y += \
 	clk.o \
 	clk-busy.o \
 	clk-cpu.o \
+	clk-composite.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
 	clk-gate-exclusive.o \
diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c
new file mode 100644
index 0000000..78b891e
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#define PCG_PCS_SHIFT	24
+#define PCG_PCS_MASK	0x7
+#define PCG_CGC_SHIFT	30
+#define PCG_FRAC_SHIFT	3
+#define PCG_FRAC_WIDTH	1
+#define PCG_FRAC_MASK	BIT(3)
+#define PCG_PCD_SHIFT	0
+#define PCG_PCD_WIDTH	3
+#define PCG_PCD_MASK	0x7
+
+struct clk_hw *imx_clk_composite(const char *name,
+			      const char * const *parent_names,
+			      int num_parents, bool mux_present,
+			      bool rate_present, bool gate_present,
+			      void __iomem *reg)
+{
+	struct clk_hw *mux_hw = NULL, *fd_hw = NULL, *gate_hw = NULL;
+	struct clk_fractional_divider *fd = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	struct clk_hw *hw;
+
+	if (mux_present) {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return ERR_PTR(-ENOMEM);
+		mux_hw = &mux->hw;
+		mux->reg = reg;
+		mux->shift = PCG_PCS_SHIFT;
+		mux->mask = PCG_PCS_MASK;
+	}
+
+	if (rate_present) {
+		fd = kzalloc(sizeof(*fd), GFP_KERNEL);
+		if (!fd) {
+			kfree(mux);
+			return ERR_PTR(-ENOMEM);
+		}
+		fd_hw = &fd->hw;
+		fd->reg = reg;
+		fd->mshift = PCG_FRAC_SHIFT;
+		fd->mwidth = PCG_FRAC_WIDTH;
+		fd->mmask  = PCG_FRAC_MASK;
+		fd->nshift = PCG_PCD_SHIFT;
+		fd->nwidth = PCG_PCD_WIDTH;
+		fd->nmask = PCG_PCD_MASK;
+		fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
+	}
+
+	if (gate_present) {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate) {
+			kfree(mux);
+			kfree(fd);
+			return ERR_PTR(-ENOMEM);
+		}
+		gate_hw = &gate->hw;
+		gate->reg = reg;
+		gate->bit_idx = PCG_CGC_SHIFT;
+	}
+
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       mux_hw, &clk_mux_ops, fd_hw,
+				       &clk_fractional_divider_ops, gate_hw,
+				       &clk_gate_ops, CLK_SET_RATE_GATE |
+				       CLK_SET_PARENT_GATE);
+	if (IS_ERR(hw)) {
+		kfree(mux);
+		kfree(fd);
+		kfree(gate);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index ccd7181..fed7660 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -71,6 +71,12 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char **parent_names, int num_parents);
 
+struct clk_hw *imx_clk_composite(const char *name,
+				 const char * const *parent_names,
+				 int num_parents, bool mux_present,
+				 bool rate_present, bool gate_present,
+				 void __iomem *reg);
+
 struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val));
-- 
2.7.4
