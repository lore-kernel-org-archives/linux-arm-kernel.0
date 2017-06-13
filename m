From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Jun 2017 15:28:36 +0100
Subject: [PATCH v2 4/5] ARM: perf: Allow the use of the PMUv3 driver on 32bit
 ARM
In-Reply-To: <20170613142837.29738-1-marc.zyngier@arm.com>
References: <20170613142837.29738-1-marc.zyngier@arm.com>
Message-ID: <20170613142837.29738-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only thing stopping the PMUv3 driver from compiling on 32bit
is the lack of defined system registers names. This is easily
solved by providing the sysreg accessors and updating the Kconfig entry.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arm_pmuv3.h | 128 +++++++++++++++++++++++++++++++++++++++
 drivers/perf/Kconfig             |   4 +-
 2 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
new file mode 100644
index 000000000000..c1ee2ed47613
--- /dev/null
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -0,0 +1,128 @@
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
+#define PMCCNTR		__ACCESS_CP15_64(0, c9)
+
+#define ID_DFR0		__ACCESS_CP15(c0, 0, c1,  2)
+#define PMCR		__ACCESS_CP15(c9, 0, c12, 0)
+#define PMCNTENSET	__ACCESS_CP15(c9, 0, c12, 1)
+#define PMCNTENCLR	__ACCESS_CP15(c9, 0, c12, 2)
+#define PMOVSR		__ACCESS_CP15(c9, 0, c12, 3)
+#define PMSELR		__ACCESS_CP15(c9, 0, c12, 5)
+#define PMCEID0		__ACCESS_CP15(c9, 0, c12, 6)
+#define PMCEID1		__ACCESS_CP15(c9, 0, c12, 7)
+#define PMXEVTYPER	__ACCESS_CP15(c9, 0, c13, 1)
+#define PMXEVCNTR	__ACCESS_CP15(c9, 0, c13, 2)
+#define PMINTENSET	__ACCESS_CP15(c9, 0, c14, 1)
+#define PMINTENCLR	__ACCESS_CP15(c9, 0, c14, 2)
+
+static inline int read_pmuver(void)
+{
+	u32 dfr0 = read_sysreg(ID_DFR0);
+	int vers = (s8)((dfr0 >> 24) & 0xff);
+
+	if (vers < 3)
+		vers = -1;
+
+	return vers;
+}
+
+static inline void write_pmcr(u32 val)
+{
+	write_sysreg(val, PMCR);
+}
+
+static inline u32 read_pmcr(void)
+{
+	return read_sysreg(PMCR);
+}
+
+static inline void write_pmselr(u32 val)
+{
+	write_sysreg(val, PMSELR);
+}
+
+static inline void write_pmccntr(u64 val)
+{
+	write_sysreg(val, PMCCNTR);
+}
+
+static inline u64 read_pmccntr(void)
+{
+	return read_sysreg(PMCCNTR);
+}
+
+static inline void write_pmxevcntr(u32 val)
+{
+	write_sysreg(val, PMXEVCNTR);
+}
+
+static inline u32 read_pmxevcntr(void)
+{
+	return read_sysreg(PMXEVCNTR);
+}
+
+static inline void write_pmxevtyper(u32 val)
+{
+	write_sysreg(val, PMXEVTYPER);
+}
+
+static inline void write_pmcntenset(u32 val)
+{
+	write_sysreg(val, PMCNTENSET);
+}
+
+static inline void write_pmcntenclr(u32 val)
+{
+	write_sysreg(val, PMCNTENCLR);
+}
+
+static inline void write_pmintenset(u32 val)
+{
+	write_sysreg(val, PMINTENSET);
+}
+
+static inline void write_pmintenclr(u32 val)
+{
+	write_sysreg(val, PMINTENCLR);
+}
+
+static inline void write_pmovsclr(u32 val)
+{
+	write_sysreg(val, PMOVSR);
+}
+
+static inline u32 read_pmovsclr(void)
+{
+	return read_sysreg(PMOVSR);
+}
+
+static inline u32 read_pmceid0(void)
+{
+	return read_sysreg(PMCEID0);
+}
+
+static inline u32 read_pmceid1(void)
+{
+	return read_sysreg(PMCEID1);
+}
+
+#endif
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index f4dc1f3cbb18..d656c434c349 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -17,9 +17,9 @@ config ARM_PMU_ACPI
 	def_bool y
 
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
