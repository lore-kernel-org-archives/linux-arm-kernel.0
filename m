From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 20 Nov 2015 16:42:29 +0800
Subject: [PATCH v2 3/6] clk: berlin: add common gateclk driver for newer SoCs
In-Reply-To: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
References: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
Message-ID: <1448008952-1787-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add common gateclk driver for Marvell SoCs newer than BG2, BG2CD,
BG2Q. berlin_gateclk_setup() is provided to setup and register such
kind of clks.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clk/berlin/Makefile |  2 +-
 drivers/clk/berlin/clk.h    | 12 ++++++++
 drivers/clk/berlin/gate.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/berlin/gate.c

diff --git a/drivers/clk/berlin/Makefile b/drivers/clk/berlin/Makefile
index ee2e09d..fc92151 100644
--- a/drivers/clk/berlin/Makefile
+++ b/drivers/clk/berlin/Makefile
@@ -1,5 +1,5 @@
 obj-y += berlin2-avpll.o berlin2-pll.o berlin2-div.o
-obj-y += pll.o clk.o
+obj-y += pll.o clk.o gate.o
 obj-$(CONFIG_MACH_BERLIN_BG2)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2CD)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2Q)	+= bg2q.o
diff --git a/drivers/clk/berlin/clk.h b/drivers/clk/berlin/clk.h
index 5e5680e..4d8af6c 100644
--- a/drivers/clk/berlin/clk.h
+++ b/drivers/clk/berlin/clk.h
@@ -25,9 +25,21 @@ struct clk_desc {
 	unsigned long	flags;
 };
 
+struct gateclk_desc {
+	const char	*name;
+	const char	*parent_name;
+	u8		bit_idx;
+	unsigned long	flags;
+};
+
 void __init berlin_clk_setup(struct device_node *np,
 			     const struct clk_desc *desc,
 			     struct clk_onecell_data *clk_data,
 			     int n);
 
+void __init berlin_gateclk_setup(struct device_node *np,
+				 const struct gateclk_desc *descs,
+				 struct clk_onecell_data *clk_data,
+				 int n);
+
 #endif
diff --git a/drivers/clk/berlin/gate.c b/drivers/clk/berlin/gate.c
new file mode 100644
index 0000000..35200d2
--- /dev/null
+++ b/drivers/clk/berlin/gate.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (c) 2015 Marvell Technology Group Ltd.
+ *
+ * Author: Jisheng Zhang <jszhang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock_types.h>
+
+#include "clk.h"
+
+static DEFINE_SPINLOCK(berlin_gateclk_lock);
+
+void __init berlin_gateclk_setup(struct device_node *np,
+				 const struct gateclk_desc *descs,
+				 struct clk_onecell_data *clk_data,
+				 int n)
+{
+	int i, ret;
+	void __iomem *base;
+	struct clk **clks;
+
+	clks = kcalloc(n, sizeof(struct clk *), GFP_KERNEL);
+	if (!clks)
+		return;
+
+	base = of_iomap(np, 0);
+	if (WARN_ON(!base))
+		goto err_iomap;
+
+	for (i = 0; i < n; i++) {
+		struct clk *clk;
+
+		clk = clk_register_gate(NULL, descs[i].name,
+				descs[i].parent_name,
+				descs[i].flags, base,
+				descs[i].bit_idx, 0,
+				&berlin_gateclk_lock);
+		if (WARN_ON(IS_ERR(clk)))
+			goto err_clk_register;
+		clks[i] = clk;
+	}
+
+	clk_data->clks = clks;
+	clk_data->clk_num = i;
+
+	ret = of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
+	if (WARN_ON(ret))
+		goto err_clk_register;
+	return;
+
+err_clk_register:
+	for (i = 0; i < n; i++)
+		clk_unregister(clks[i]);
+	iounmap(base);
+err_iomap:
+	kfree(clks);
+}
-- 
2.6.2
