From: bs14@csr.com (Barry Song)
Date: Wed, 6 Jul 2011 23:36:56 -0700
Subject: [PATCH v4 3/3] ARM: CSR: initializing L2 cache
In-Reply-To: <1310020616-27856-1-git-send-email-bs14@csr.com>
References: <1310020616-27856-1-git-send-email-bs14@csr.com>
Message-ID: <1310020616-27856-4-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <baohua.song@csr.com>
---
 arch/arm/mach-prima2/Makefile |    1 +
 arch/arm/mach-prima2/l2x0.c   |   59 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-prima2/l2x0.c

diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index f2fba66..7af7fc0 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -4,3 +4,4 @@ obj-y += clock.o
 obj-y += rstc.o
 obj-y += prima2.o
 obj-$(CONFIG_DEBUG_LL) += lluart.o
+obj-$(CONFIG_CACHE_L2X0) += l2x0.o
diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
new file mode 100644
index 0000000..9cda205
--- /dev/null
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -0,0 +1,59 @@
+/*
+ * l2 cache initialization for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <mach/memory.h>
+
+#define L2X0_ADDR_FILTERING_START       0xC00
+#define L2X0_ADDR_FILTERING_END         0xC04
+
+static struct of_device_id l2x_ids[]  = {
+	{ .compatible = "arm,pl310-cache" },
+};
+
+static int __init sirfsoc_of_l2x_init(void)
+{
+	struct device_node *np;
+	void __iomem *sirfsoc_l2x_base;
+
+	np = of_find_matching_node(NULL, l2x_ids);
+	if (!np)
+		panic("unable to find compatible l2x node in dtb\n");
+
+	sirfsoc_l2x_base = of_iomap(np, 0);
+	if (!sirfsoc_l2x_base)
+		panic("unable to map l2x cpu registers\n");
+
+	of_node_put(np);
+
+	if (!(readl_relaxed(sirfsoc_l2x_base + L2X0_CTRL) & 1)) {
+		/*
+		 * set the physical memory windows L2 cache will cover
+		 */
+		writel_relaxed(PLAT_PHYS_OFFSET + 1024 * 1024 * 1024,
+			sirfsoc_l2x_base + L2X0_ADDR_FILTERING_END);
+		writel_relaxed(PLAT_PHYS_OFFSET | 0x1,
+			sirfsoc_l2x_base + L2X0_ADDR_FILTERING_START);
+
+		writel_relaxed(0,
+			sirfsoc_l2x_base + L2X0_TAG_LATENCY_CTRL);
+		writel_relaxed(0,
+			sirfsoc_l2x_base + L2X0_DATA_LATENCY_CTRL);
+	}
+	l2x0_init((void __iomem *)sirfsoc_l2x_base, 0x00040000,
+		0x00000000);
+
+	return 0;
+}
+early_initcall(sirfsoc_of_l2x_init);
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
