From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 25 Mar 2013 14:53:11 +0100
Subject: [PATCH 05/10] arm: zynq: Move slcr initialization to separate file
In-Reply-To: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <1364219596-4954-5-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create separate slcr driver instead of pollute common code.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/Makefile |    2 +-
 arch/arm/mach-zynq/common.c |   10 +------
 arch/arm/mach-zynq/common.h |    3 ++
 arch/arm/mach-zynq/slcr.c   |   69 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-zynq/slcr.c

diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index 320faed..13ee09b 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -3,4 +3,4 @@
 #
 
 # Common support
-obj-y				:= common.o
+obj-y				:= common.o slcr.o
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 13f9d8b..2734bd6 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -61,15 +61,7 @@ static void __init xilinx_init_machine(void)
 
 static void __init xilinx_zynq_timer_init(void)
 {
-	struct device_node *np;
-	void __iomem *slcr;
-
-	np = of_find_compatible_node(NULL, NULL, "xlnx,zynq-slcr");
-	slcr = of_iomap(np, 0);
-	WARN_ON(!slcr);
-
-	xilinx_zynq_clocks_init(slcr);
-
+	slcr_init();
 	clocksource_of_init();
 }
 
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 38727a2..e30898a 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -17,6 +17,9 @@
 #ifndef __MACH_ZYNQ_COMMON_H__
 #define __MACH_ZYNQ_COMMON_H__
 
+extern int slcr_init(void);
+
+extern void __iomem *zynq_slcr_base;
 extern void __iomem *scu_base;
 
 #endif
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
new file mode 100644
index 0000000..1883b70
--- /dev/null
+++ b/arch/arm/mach-zynq/slcr.c
@@ -0,0 +1,69 @@
+/*
+ * Xilinx SLCR driver
+ *
+ * Copyright (c) 2011-2013 Xilinx Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the Free
+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
+ * 02139, USA.
+ */
+
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/uaccess.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/clk/zynq.h>
+#include "common.h"
+
+#define SLCR_UNLOCK_MAGIC		0xDF0D
+#define SLCR_UNLOCK			0x8   /* SCLR unlock register */
+
+void __iomem *zynq_slcr_base;
+
+/**
+ * xslcr_init()
+ * Returns 0 on success, negative errno otherwise.
+ *
+ * Called early during boot from platform code to remap SLCR area.
+ */
+int __init slcr_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynq-slcr");
+	if (!np) {
+		pr_err("%s: no slcr node found\n", __func__);
+		BUG();
+	}
+
+	zynq_slcr_base = of_iomap(np, 0);
+	if (!zynq_slcr_base) {
+		pr_err("%s: Unable to map I/O memory\n", __func__);
+		BUG();
+	}
+
+	/* unlock the SLCR so that registers can be changed */
+	writel(SLCR_UNLOCK_MAGIC, zynq_slcr_base + SLCR_UNLOCK);
+
+	pr_info("%s mapped to %p\n", np->name, zynq_slcr_base);
+
+	xilinx_zynq_clocks_init(zynq_slcr_base);
+
+	of_node_put(np);
+
+	return 0;
+}
-- 
1.7.9.7
