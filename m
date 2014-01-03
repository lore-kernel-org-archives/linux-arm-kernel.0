From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  3 Jan 2014 10:59:44 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the revision
 of a SoC
In-Reply-To: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the mvebu SoCs have information related to their variant and
revision that can be read from the PCI control register.

This patch adds support for Armada XP and Armada 370. This reading of
the revision and the ID are done before the PCI initialization to
avoid any conflicts. Once these data are retrieved, the resources are
freed to let the PCI subsystem use it.

Cc: stable at vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Makefile       |   2 +-
 arch/arm/mach-mvebu/mvebu-soc-id.c | 111 +++++++++++++++++++++++++++++++++++++
 include/linux/mvebu-soc-id.h       |  32 +++++++++++
 3 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-mvebu/mvebu-soc-id.c
 create mode 100644 include/linux/mvebu-soc-id.h

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 2d04f0e21870..878aebe98dcc 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -3,7 +3,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
-obj-y				 += system-controller.o
+obj-y				 += system-controller.o mvebu-soc-id.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
new file mode 100644
index 000000000000..86c901be284c
--- /dev/null
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -0,0 +1,111 @@
+/*
+ * Variant and revision information for mvebu SoCs
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * All the mvebu SoCs have information related to their variant and
+ * revision that can be read from the PCI control register. This is
+ * done before the PCI initialization to avoid any conflict. Once the
+ * ID and revision are retrieved, the mapping is freed.
+ */
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mvebu-soc-id.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define PCIE_DEV_ID_OFF		0x0
+#define PCIE_DEV_REV_OFF	0x8
+
+#define SOC_ID_MASK	    0xFFFF0000
+#define SOC_REV_MASK	    0xFF
+
+static u32 soc_dev_id;
+static u32 soc_rev;
+static bool is_id_valid;
+
+static const struct of_device_id mvebu_pcie_of_match_table[] = {
+	{ .compatible = "marvell,armada-xp-pcie", },
+	{ .compatible = "marvell,armada-370-pcie", },
+	{},
+};
+
+int mvebu_get_soc_id(u32 *dev, u32 *rev)
+{
+	if (is_id_valid) {
+		*dev = soc_dev_id;
+		*rev = soc_rev;
+		return 0;
+	} else
+		return -1;
+}
+
+EXPORT_SYMBOL(mvebu_get_soc_id);
+
+static int __init mvebu_soc_id_init(void)
+{
+	struct device_node *np;
+	int ret = 0;
+
+	np = of_find_matching_node(NULL, mvebu_pcie_of_match_table);
+	if (np) {
+		void __iomem *pci_base;
+		struct clk *clk;
+		/*
+		 * ID and revision are available from any port, so we
+		 * just pick the first one
+		 */
+		struct device_node *child = of_get_next_child(np, NULL);
+
+		clk = of_clk_get_by_name(child, NULL);
+		if (IS_ERR(clk)) {
+			pr_err("%s: cannot get clock\n", __func__);
+			ret = -ENOMEM;
+			goto clk_err;
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			pr_err("%s: cannot enable clock\n", __func__);
+			goto clk_err;
+		}
+
+		pci_base = of_iomap(child, 0);
+		if (IS_ERR(pci_base)) {
+			pr_err("%s: cannot map registers\n",  __func__);
+			ret = -ENOMEM;
+			goto res_ioremap;
+		}
+
+		/* SoC ID */
+		soc_dev_id = __raw_readl(pci_base + PCIE_DEV_ID_OFF) >> 16;
+
+		/* SoC revision */
+		soc_rev = __raw_readl(pci_base + PCIE_DEV_REV_OFF)
+			& SOC_REV_MASK;
+
+		is_id_valid = true;
+
+		iounmap(pci_base);
+
+res_ioremap:
+		clk_disable_unprepare(clk);
+
+clk_err:
+		of_node_put(child);
+		of_node_put(np);
+	}
+
+	return ret;
+}
+arch_initcall(mvebu_soc_id_init);
+
diff --git a/include/linux/mvebu-soc-id.h b/include/linux/mvebu-soc-id.h
new file mode 100644
index 000000000000..602ce1c50d1d
--- /dev/null
+++ b/include/linux/mvebu-soc-id.h
@@ -0,0 +1,32 @@
+/*
+ * Marvell EBU SoC ID and revision definitions.
+ *
+ * Copyright (C) 2014 Marvell Semiconductor
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __LINUX_MVEBU_SOC_ID_H
+#define __LINUX_MVEBU_SOC_ID_H
+
+/* Armada XP ID */
+#define MV78230_DEV_ID	    0x7823
+#define MV78260_DEV_ID	    0x7826
+#define MV78460_DEV_ID	    0x7846
+
+/* Armada XP Revision */
+#define MV78XX0_A0_REV	    0x1
+#define MV78XX0_B0_REV	    0x2
+
+#ifdef CONFIG_ARCH_MVEBU
+int mvebu_get_soc_id(u32 *dev, u32 *rev);
+#else
+int mvebu_get_soc_id(u32 *dev, u32 *rev)
+{
+	return -1;
+}
+#endif
+
+#endif /* __LINUX_MVEBU_SOC_ID_H */
-- 
1.8.1.2
