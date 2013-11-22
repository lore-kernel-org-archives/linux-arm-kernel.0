From: robherring2@gmail.com (Rob Herring)
Date: Fri, 22 Nov 2013 15:05:08 -0600
Subject: [PATCH v2] arm64: enable EDAC on arm64
Message-ID: <1385154308-31335-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Implement atomic_scrub and enable EDAC for arm64.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
v2:
- Add loop for exclusive store success
- Fix size to be 32-bits at a time. The framework gives no alignment
  guarantees.

 arch/arm64/Kconfig            |  1 +
 arch/arm64/include/asm/edac.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 arch/arm64/include/asm/edac.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 88c8b6c1..109687a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -11,6 +11,7 @@ config ARM64
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
diff --git a/arch/arm64/include/asm/edac.h b/arch/arm64/include/asm/edac.h
new file mode 100644
index 0000000..6d2d262
--- /dev/null
+++ b/arch/arm64/include/asm/edac.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2013 Calxeda, Inc.
+ * Based on PPC version Copyright 2007 MontaVista Software, Inc.
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
+#ifndef ASM_EDAC_H
+#define ASM_EDAC_H
+/*
+ * ECC atomic, DMA, SMP and interrupt safe scrub function.
+ * Implements the per arch atomic_scrub() that EDAC use for software
+ * ECC scrubbing.  It reads memory and then writes back the original
+ * value, allowing the hardware to detect and correct memory errors.
+ */
+static inline void atomic_scrub(void *va, u32 size)
+{
+	unsigned int *virt_addr = va;
+	unsigned int i;
+
+	for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
+		long result;
+		unsigned long tmp;
+
+		asm volatile("// atomic_scrub\n"
+		"1:	ldxr	%w0, %2\n"
+		"	stxr	%w1, %w0, %2\n"
+		"	cbnz	%w1, 1b"
+			: "=&r" (result), "=&r" (tmp), "+Q" (*virt_addr)
+			: : "cc");
+	}
+}
+
+#endif
-- 
1.8.1.2
