From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Mar 2017 12:15:28 +0000
Subject: [PATCH 3/4] ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
In-Reply-To: <20170324121529.22603-1-marc.zyngier@arm.com>
References: <20170324121529.22603-1-marc.zyngier@arm.com>
Message-ID: <20170324121529.22603-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only thing stopping the PMUv3 driver from compiling on 32bit
is the lack of defined system registers names. This is easily
solved by providing the sysreg accessors and updating the Kconfig entry.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arm_pmuv3.h | 115 +++++++++++++++++++++++++++++++++++++++
 drivers/perf/Kconfig             |   4 +-
 2 files changed, 117 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
new file mode 100644
index 000000000000..df14de3d7bdf
--- /dev/null
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -0,0 +1,115 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_PMUV3_H
+#define __ASM_PMUV3_H
+
+#include <asm/cp15.h>
+
+#define pmcr		__ACCESS_CP15(c9, 0, c12, 0)
+#define pmselr		__ACCESS_CP15(c9, 0, c12, 5)
+#define pmccntr		__ACCESS_CP15_64(0, c9)
+#define pmxevcntr	__ACCESS_CP15(c9, 0, c13, 2)
+#define pmxevtyper	__ACCESS_CP15(c9, 0, c13, 1)
+#define pmcntenset	__ACCESS_CP15(c9, 0, c12, 1)
+#define pmcntenclr	__ACCESS_CP15(c9, 0, c12, 2)
+#define pmintenset	__ACCESS_CP15(c9, 0, c12, 1)
+#define pmintenclr	__ACCESS_CP15(c9, 0, c12, 2)
+#define pmovsclr	__ACCESS_CP15(c9, 0, c12, 3)
+#define pmceid0		__ACCESS_CP15(c9, 0, c12, 6)
+#define pmceid1		__ACCESS_CP15(c9, 0, c12, 7)
+
+static inline void write_pmcr(u32 val)
+{
+	write_sysreg(val, pmcr);
+}
+
+static inline u32 read_pmcr(void)
+{
+	return read_sysreg(pmcr);
+}
+
+static inline void write_pmselr(u32 val)
+{
+	write_sysreg(val, pmselr);
+}
+
+static inline void write_pmccntr(u64 val)
+{
+	write_sysreg(val, pmccntr);
+}
+
+static inline u64 read_pmccntr(void)
+{
+	return read_sysreg(pmccntr);
+}
+
+static inline void write_pmxevcntr(u32 val)
+{
+	write_sysreg(val, pmxevcntr);
+}
+
+static inline u32 read_pmxevcntr(void)
+{
+	return read_sysreg(pmxevcntr);
+}
+
+static inline void write_pmxevtyper(u32 val)
+{
+	write_sysreg(val, pmxevtyper);
+}
+
+static inline void write_pmcntenset(u32 val)
+{
+	write_sysreg(val, pmcntenset);
+}
+
+static inline void write_pmcntenclr(u32 val)
+{
+	write_sysreg(val, pmcntenclr);
+}
+
+static inline void write_pmintenset(u32 val)
+{
+	write_sysreg(val, pmintenset);
+}
+
+static inline void write_pmintenclr(u32 val)
+{
+	write_sysreg(val, pmintenclr);
+}
+
+static inline void write_pmovsclr(u32 val)
+{
+	write_sysreg(val, pmovsclr);
+}
+
+static inline u32 read_pmovsclr(void)
+{
+	return read_sysreg(pmovsclr);
+}
+
+static inline u32 read_pmceid0(void)
+{
+	return read_sysreg(pmceid0);
+}
+
+static inline u32 read_pmceid1(void)
+{
+	return read_sysreg(pmceid1);
+}
+
+#endif
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index bd2b1b1cb1b6..5b98a24c2b34 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -23,9 +23,9 @@ config QCOM_L2_PMU
 	  monitoring L2 cache events.
 
 config ARM_PMUV3
-	depends on HW_PERF_EVENTS && ARM64
+	depends on HW_PERF_EVENTS && ((ARM && CPU_V7) || ARM64)
 	bool "ARM PMUv3 support"
-	default y
+	default ARM64
 	help
 	  Say y if you want to use CPU performance monitors on ARMv8
 	  systems that implement the PMUv3 architecture.
-- 
2.11.0
