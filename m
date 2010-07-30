From: ccross@google.com (Colin Cross)
Date: Thu, 29 Jul 2010 17:29:23 -0700
Subject: [PATCH 2/9] [ARM] tegra: Add legacy irq support
In-Reply-To: <1280449771-24043-1-git-send-email-ccross@google.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
Message-ID: <1280449771-24043-3-git-send-email-ccross@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

The "legacy irq controller" duplicates the functionality of the GIC,
but remains powered during the cpu suspend and idle modes that power
down the CPU and the GIC.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/Makefile                  |    2 +-
 arch/arm/mach-tegra/include/mach/legacy_irq.h |   31 +++++++
 arch/arm/mach-tegra/legacy_irq.c              |  114 +++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/legacy_irq.h
 create mode 100644 arch/arm/mach-tegra/legacy_irq.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 51e9370..0a975b5 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,6 +1,6 @@
 obj-y                                   += common.o
 obj-y                                   += io.o
-obj-y                                   += irq.o
+obj-y                                   += irq.o legacy_irq.o
 obj-y                                   += clock.o
 obj-y                                   += timer.o
 obj-y                                   += gpio.o
diff --git a/arch/arm/mach-tegra/include/mach/legacy_irq.h b/arch/arm/mach-tegra/include/mach/legacy_irq.h
new file mode 100644
index 0000000..db1eb3d
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/legacy_irq.h
@@ -0,0 +1,31 @@
+/*
+ * arch/arm/mach-tegra/include/mach/legacy_irq.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Author: Colin Cross <ccross@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _ARCH_ARM_MACH_TEGRA_LEGARY_IRQ_H
+#define _ARCH_ARM_MACH_TEGRA_LEGARY_IRQ_H
+
+void tegra_legacy_mask_irq(unsigned int irq);
+void tegra_legacy_unmask_irq(unsigned int irq);
+void tegra_legacy_select_fiq(unsigned int irq, bool fiq);
+void tegra_legacy_force_irq_set(unsigned int irq);
+void tegra_legacy_force_irq_clr(unsigned int irq);
+int tegra_legacy_force_irq_status(unsigned int irq);
+void tegra_legacy_select_fiq(unsigned int irq, bool fiq);
+unsigned long tegra_legacy_vfiq(int nr);
+unsigned long tegra_legacy_class(int nr);
+
+#endif
diff --git a/arch/arm/mach-tegra/legacy_irq.c b/arch/arm/mach-tegra/legacy_irq.c
new file mode 100644
index 0000000..7cc8601
--- /dev/null
+++ b/arch/arm/mach-tegra/legacy_irq.c
@@ -0,0 +1,114 @@
+/*
+ * arch/arm/mach-tegra/legacy_irq.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Author: Colin Cross <ccross@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <mach/iomap.h>
+#include <mach/legacy_irq.h>
+
+#define ICTLR_CPU_IER		0x20
+#define ICTLR_CPU_IER_SET	0x24
+#define ICTLR_CPU_IER_CLR	0x28
+#define ICTLR_CPU_IEP_CLASS	0x2C
+#define ICTLR_CPU_IEP_VFIQ	0x08
+#define ICTLR_CPU_IEP_FIR	0x14
+#define ICTLR_CPU_IEP_FIR_SET	0x18
+#define ICTLR_CPU_IEP_FIR_CLR	0x1c
+
+static void __iomem *ictlr_reg_base[] = {
+	IO_ADDRESS(TEGRA_PRIMARY_ICTLR_BASE),
+	IO_ADDRESS(TEGRA_SECONDARY_ICTLR_BASE),
+	IO_ADDRESS(TEGRA_TERTIARY_ICTLR_BASE),
+	IO_ADDRESS(TEGRA_QUATERNARY_ICTLR_BASE),
+};
+
+/* When going into deep sleep, the CPU is powered down, taking the GIC with it
+   In order to wake, the wake interrupts need to be enabled in the legacy
+   interrupt controller. */
+void tegra_legacy_unmask_irq(unsigned int irq)
+{
+	void __iomem *base;
+	pr_debug("%s: %d\n", __func__, irq);
+
+	irq -= 32;
+	base = ictlr_reg_base[irq>>5];
+	writel(1 << (irq & 31), base + ICTLR_CPU_IER_SET);
+}
+
+void tegra_legacy_mask_irq(unsigned int irq)
+{
+	void __iomem *base;
+	pr_debug("%s: %d\n", __func__, irq);
+
+	irq -= 32;
+	base = ictlr_reg_base[irq>>5];
+	writel(1 << (irq & 31), base + ICTLR_CPU_IER_CLR);
+}
+
+void tegra_legacy_force_irq_set(unsigned int irq)
+{
+	void __iomem *base;
+	pr_debug("%s: %d\n", __func__, irq);
+
+	irq -= 32;
+	base = ictlr_reg_base[irq>>5];
+	writel(1 << (irq & 31), base + ICTLR_CPU_IEP_FIR_SET);
+}
+
+void tegra_legacy_force_irq_clr(unsigned int irq)
+{
+	void __iomem *base;
+	pr_debug("%s: %d\n", __func__, irq);
+
+	irq -= 32;
+	base = ictlr_reg_base[irq>>5];
+	writel(1 << (irq & 31), base + ICTLR_CPU_IEP_FIR_CLR);
+}
+
+int tegra_legacy_force_irq_status(unsigned int irq)
+{
+	void __iomem *base;
+	pr_debug("%s: %d\n", __func__, irq);
+
+	irq -= 32;
+	base = ictlr_reg_base[irq>>5];
+	return !!(readl(base + ICTLR_CPU_IEP_FIR) & (1 << (irq & 31)));
+}
+
+void tegra_legacy_select_fiq(unsigned int irq, bool fiq)
+{
+	void __iomem *base;
+	pr_debug("%s: %d\n", __func__, irq);
+
+	irq -= 32;
+	base = ictlr_reg_base[irq>>5];
+	writel(fiq << (irq & 31), base + ICTLR_CPU_IEP_CLASS);
+}
+
+unsigned long tegra_legacy_vfiq(int nr)
+{
+	void __iomem *base;
+	base = ictlr_reg_base[nr];
+	return readl(base + ICTLR_CPU_IEP_VFIQ);
+}
+
+unsigned long tegra_legacy_class(int nr)
+{
+	void __iomem *base;
+	base = ictlr_reg_base[nr];
+	return readl(base + ICTLR_CPU_IEP_CLASS);
+}
-- 
1.7.1
