From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Dec 2013 12:19:02 +0000
Subject: [PATCH] arm64: percpu: implement optimised pcpu access using tpidr_el1
Message-ID: <1387282742-5224-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements optimised percpu variable accesses using the
el1 r/w thread register (tpidr_el1) along the same lines as arch/arm/.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/Kbuild   |  1 -
 arch/arm64/include/asm/percpu.h | 41 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c       | 10 ++++++++++
 arch/arm64/kernel/smp.c         |  6 ++++--
 4 files changed, 55 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/percpu.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 519f89f5b6a3..d0ff25de67ca 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -26,7 +26,6 @@ generic-y += mman.h
 generic-y += msgbuf.h
 generic-y += mutex.h
 generic-y += pci.h
-generic-y += percpu.h
 generic-y += poll.h
 generic-y += posix_types.h
 generic-y += resource.h
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
new file mode 100644
index 000000000000..13fb0b3efc5f
--- /dev/null
+++ b/arch/arm64/include/asm/percpu.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2013 ARM Ltd.
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
+#ifndef __ASM_PERCPU_H
+#define __ASM_PERCPU_H
+
+static inline void set_my_cpu_offset(unsigned long off)
+{
+	asm volatile("msr tpidr_el1, %0" :: "r" (off) : "memory");
+}
+
+static inline unsigned long __my_cpu_offset(void)
+{
+	unsigned long off;
+	register unsigned long *sp asm ("sp");
+
+	/*
+	 * We want to allow caching the value, so avoid using volatile and
+	 * instead use a fake stack read to hazard against barrier().
+	 */
+	asm("mrs %0, tpidr_el1" : "=r" (off) : "Q" (*sp));
+
+	return off;
+}
+#define __my_cpu_offset __my_cpu_offset()
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ASM_PERCPU_H */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index bd9bbd0e44ed..97d90840a7fd 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -108,6 +108,16 @@ void __init early_print(const char *str, ...)
 	printk("%s", buf);
 }
 
+void __init smp_setup_processor_id(void)
+{
+	/*
+	 * clear __my_cpu_offset on boot CPU to avoid hang caused by
+	 * using percpu variable early, for example, lockdep will
+	 * access percpu variable inside lock_release
+	 */
+	set_my_cpu_offset(0);
+}
+
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
 	return phys_id == cpu_logical_map(cpu);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a0c2ca602cf8..b5d2031c12c6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -122,8 +122,6 @@ asmlinkage void secondary_start_kernel(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu = smp_processor_id();
 
-	printk("CPU%u: Booted secondary processor\n", cpu);
-
 	/*
 	 * All kernel threads share the same mm context; grab a
 	 * reference and switch to it.
@@ -132,6 +130,9 @@ asmlinkage void secondary_start_kernel(void)
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 
+	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
+	printk("CPU%u: Booted secondary processor\n", cpu);
+
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
 	 * point to zero page to avoid speculatively fetching new entries.
@@ -271,6 +272,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void __init smp_prepare_boot_cpu(void)
 {
+	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 }
 
 static void (*smp_cross_call)(const struct cpumask *, unsigned int);
-- 
1.8.2.2
