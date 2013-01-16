From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 16 Jan 2013 16:10:26 +0800
Subject: [PATCH V4 1/5] ARM: tegra: add pending SGI checking API
Message-ID: <1358323826-30248-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "powered-down" CPU idle mode of Tegra cut off the vdd_cpu rail, it
include the power of GIC. That caused the SGI (Software Generated
Interrupt) been lost. Because the SGI can't wake up the CPU that in
the "powered-down" CPU idle mode. We need to check if there is any
pending SGI when go into "powered-down" CPU idle mode. This is important
especially when applying the coupled cpuidle framework into "power-down"
cpuidle dirver. Because the coupled cpuidle framework may have the
chance that misses IPI_SINGLE_FUNC handling sometimes.

For the PPI or SPI, something like the legacy peripheral interrupt. It
still can be maintained by Tegra legacy interrupt controller. If there
is any pending PPI or SPI when CPU in "powered-down" CPU idle mode. The
CPU can be woken up immediately. So we don't need to take care the same
situation for PPI or SPI.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V4:
* no change
V3:
* move the static mapping of GIC addr into tegra_pending_sgi
V2:
* new in V2
---
 arch/arm/mach-tegra/irq.c | 15 +++++++++++++++
 arch/arm/mach-tegra/irq.h | 22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm/mach-tegra/irq.h

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index b7886f1..c9976e3 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -45,6 +45,8 @@
 
 #define FIRST_LEGACY_IRQ 32
 
+#define SGI_MASK 0xFFFF
+
 static int num_ictlrs;
 
 static void __iomem *ictlr_reg_base[] = {
@@ -55,6 +57,19 @@ static void __iomem *ictlr_reg_base[] = {
 	IO_ADDRESS(TEGRA_QUINARY_ICTLR_BASE),
 };
 
+bool tegra_pending_sgi(void)
+{
+	u32 pending_set;
+	void __iomem *distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
+
+	pending_set = readl_relaxed(distbase + GIC_DIST_PENDING_SET);
+
+	if (pending_set & SGI_MASK)
+		return true;
+
+	return false;
+}
+
 static inline void tegra_irq_write_mask(unsigned int irq, unsigned long reg)
 {
 	void __iomem *base;
diff --git a/arch/arm/mach-tegra/irq.h b/arch/arm/mach-tegra/irq.h
new file mode 100644
index 0000000..5142649
--- /dev/null
+++ b/arch/arm/mach-tegra/irq.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2012, NVIDIA Corporation. All rights reserved.
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __TEGRA_IRQ_H
+#define __TEGRA_IRQ_H
+
+bool tegra_pending_sgi(void);
+
+#endif
-- 
1.8.0.3
