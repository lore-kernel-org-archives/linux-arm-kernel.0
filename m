From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:31:45 +0800
Subject: [PATCH V6 2/9] ARM: tegra: irq: add wake up handling
In-Reply-To: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
References: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364988712-24797-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the wake up handling for legacy irq controller, and using
IRQCHIP_MASK_ON_SUSPEND for wake irq handling.

Based on the work by:
Varun Wadekar <vwadekar@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V6:
* no change
V5:
* don't use BUG_ON when irq_nr is not correct in set_wake function
V4:
* no change
V3:
* no change
V2:
* no change
---
 arch/arm/mach-tegra/common.c |  2 +
 arch/arm/mach-tegra/irq.c    | 96 +++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/irq.h    |  6 +++
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index b02ebe7..c84505c 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -33,6 +33,7 @@
 #include "common.h"
 #include "fuse.h"
 #include "iomap.h"
+#include "irq.h"
 #include "pmc.h"
 #include "apbio.h"
 #include "sleep.h"
@@ -64,6 +65,7 @@ void __init tegra_dt_init_irq(void)
 	tegra_pmc_init();
 	tegra_init_irq();
 	irqchip_init();
+	tegra_legacy_irq_syscore_init();
 }
 #endif
 
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 1952e82..0de4eed 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -4,7 +4,7 @@
  * Author:
  *	Colin Cross <ccross@android.com>
  *
- * Copyright (C) 2010, NVIDIA Corporation
+ * Copyright (C) 2010,2013, NVIDIA Corporation
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/syscore_ops.h>
 
 #include "board.h"
 #include "iomap.h"
@@ -43,6 +44,7 @@
 #define ICTLR_COP_IEP_CLASS	0x3c
 
 #define FIRST_LEGACY_IRQ 32
+#define TEGRA_MAX_NUM_ICTLRS	5
 
 #define SGI_MASK 0xFFFF
 
@@ -56,6 +58,15 @@ static void __iomem *ictlr_reg_base[] = {
 	IO_ADDRESS(TEGRA_QUINARY_ICTLR_BASE),
 };
 
+#ifdef CONFIG_PM_SLEEP
+static u32 cop_ier[TEGRA_MAX_NUM_ICTLRS];
+static u32 cop_iep[TEGRA_MAX_NUM_ICTLRS];
+static u32 cpu_ier[TEGRA_MAX_NUM_ICTLRS];
+static u32 cpu_iep[TEGRA_MAX_NUM_ICTLRS];
+
+static u32 ictlr_wake_mask[TEGRA_MAX_NUM_ICTLRS];
+#endif
+
 bool tegra_pending_sgi(void)
 {
 	u32 pending_set;
@@ -125,6 +136,87 @@ static int tegra_retrigger(struct irq_data *d)
 	return 1;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int tegra_set_wake(struct irq_data *d, unsigned int enable)
+{
+	u32 irq = d->irq;
+	u32 index, mask;
+
+	if (irq < FIRST_LEGACY_IRQ ||
+		irq >= FIRST_LEGACY_IRQ + num_ictlrs * 32)
+		return -EINVAL;
+
+	index = ((irq - FIRST_LEGACY_IRQ) / 32);
+	mask = BIT((irq - FIRST_LEGACY_IRQ) % 32);
+	if (enable)
+		ictlr_wake_mask[index] |= mask;
+	else
+		ictlr_wake_mask[index] &= ~mask;
+
+	return 0;
+}
+
+static int tegra_legacy_irq_suspend(void)
+{
+	unsigned long flags;
+	int i;
+
+	local_irq_save(flags);
+	for (i = 0; i < num_ictlrs; i++) {
+		void __iomem *ictlr = ictlr_reg_base[i];
+		/* Save interrupt state */
+		cpu_ier[i] = readl_relaxed(ictlr + ICTLR_CPU_IER);
+		cpu_iep[i] = readl_relaxed(ictlr + ICTLR_CPU_IEP_CLASS);
+		cop_ier[i] = readl_relaxed(ictlr + ICTLR_COP_IER);
+		cop_iep[i] = readl_relaxed(ictlr + ICTLR_COP_IEP_CLASS);
+
+		/* Disable COP interrupts */
+		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
+
+		/* Disable CPU interrupts */
+		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
+
+		/* Enable the wakeup sources of ictlr */
+		writel_relaxed(ictlr_wake_mask[i], ictlr + ICTLR_CPU_IER_SET);
+	}
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static void tegra_legacy_irq_resume(void)
+{
+	unsigned long flags;
+	int i;
+
+	local_irq_save(flags);
+	for (i = 0; i < num_ictlrs; i++) {
+		void __iomem *ictlr = ictlr_reg_base[i];
+		writel_relaxed(cpu_iep[i], ictlr + ICTLR_CPU_IEP_CLASS);
+		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
+		writel_relaxed(cpu_ier[i], ictlr + ICTLR_CPU_IER_SET);
+		writel_relaxed(cop_iep[i], ictlr + ICTLR_COP_IEP_CLASS);
+		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
+		writel_relaxed(cop_ier[i], ictlr + ICTLR_COP_IER_SET);
+	}
+	local_irq_restore(flags);
+}
+
+static struct syscore_ops tegra_legacy_irq_syscore_ops = {
+	.suspend = tegra_legacy_irq_suspend,
+	.resume = tegra_legacy_irq_resume,
+};
+
+int tegra_legacy_irq_syscore_init(void)
+{
+	register_syscore_ops(&tegra_legacy_irq_syscore_ops);
+
+	return 0;
+}
+#else
+#define tegra_set_wake NULL
+#endif
+
 void __init tegra_init_irq(void)
 {
 	int i;
@@ -150,6 +242,8 @@ void __init tegra_init_irq(void)
 	gic_arch_extn.irq_mask = tegra_mask;
 	gic_arch_extn.irq_unmask = tegra_unmask;
 	gic_arch_extn.irq_retrigger = tegra_retrigger;
+	gic_arch_extn.irq_set_wake = tegra_set_wake;
+	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
 
 	/*
 	 * Check if there is a devicetree present, since the GIC will be
diff --git a/arch/arm/mach-tegra/irq.h b/arch/arm/mach-tegra/irq.h
index 5142649..bc05ce5 100644
--- a/arch/arm/mach-tegra/irq.h
+++ b/arch/arm/mach-tegra/irq.h
@@ -19,4 +19,10 @@
 
 bool tegra_pending_sgi(void);
 
+#ifdef CONFIG_PM_SLEEP
+int tegra_legacy_irq_syscore_init(void);
+#else
+static inline int tegra_legacy_irq_syscore_init(void) { return 0; }
+#endif
+
 #endif
-- 
1.8.2
