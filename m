From: james.morse@arm.com (James Morse)
Date: Fri, 17 Jun 2016 10:34:56 +0100
Subject: [PATCH 1/2] arm64: smp: Add function to determine if cpus are stuck
 in the kernel
In-Reply-To: <1466156097-20028-1-git-send-email-james.morse@arm.com>
References: <1466156097-20028-1-git-send-email-james.morse@arm.com>
Message-ID: <1466156097-20028-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel/smp.c has a fancy counter that keeps track of the number of CPUs
it marked as not-present and left in cpu_park_loop(). If there are any
CPUs spinning in here, features like kexec or hibernate may release them
by overwriting this memory.

This problem also occurs on machines using spin-tables to release
secondary cores.
After commit 44dbcc93ab67 ("arm64: Fix behavior of maxcpus=N")
we bring all known cpus into the secondary holding pen, but may not bring
them up depending on 'maxcpus'. This memory can't be re-used by kexec
or hibernate.

Add a function cpus_are_stuck_in_kernel() to determine if either of these
cases have occurred.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/smp.h | 20 ++++++++++++++++++++
 arch/arm64/kernel/smp.c      | 13 +++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 433e50405274..4be755bcc07a 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -124,6 +124,26 @@ static inline void cpu_panic_kernel(void)
 	cpu_park_loop();
 }
 
+/*
+ * Kernel features such as hibernate and kexec depend on cpu hotplug to know
+ * they can replace any kernel memory they are not using themselves.
+ *
+ * There are two corner cases:
+ * If a secondary CPU fails to come online, (e.g. due to mismatched features),
+ * it will try to call cpu_die(). If this fails, it increases the counter
+ * cpus_stuck_in_kernel and sits in cpu_park_loop(). The memory containing
+ * this function must not be re-used for anything else as the 'stuck' core
+ * is executing it.
+ *
+ * CPUs are also considered stuck in the kernel if we have multiple CPUs
+ * and no way to offline secondary CPUs. This happens when secondaries
+ * are released via spin-table, these CPUs are moved into the kernel's
+ * secondary_holding_pen, which must not be overwritten.
+ *
+ * This function is used to inhibit features like kexec and hibernate.
+ */
+bool cpus_are_stuck_in_kernel(void);
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 678e0842cb3b..e197502f94fd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -909,3 +909,16 @@ int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
 }
+
+bool cpus_are_stuck_in_kernel(void)
+{
+	bool ret = !!cpus_stuck_in_kernel;
+#ifdef CONFIG_HOTPLUG_CPU
+	int any_cpu = raw_smp_processor_id();
+
+	if (num_possible_cpus() > 1 && !cpu_ops[any_cpu]->cpu_die)
+		ret = true;
+#endif
+
+	return ret;
+}
-- 
2.8.0.rc3
