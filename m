From: hamo.by@gmail.com (hamo.by at gmail.com)
Date: Thu,  5 Jan 2012 20:44:46 +0800
Subject: [PATCH RFC] arm: Define cpu_logical_map when CONFIG_SMP is not set
Message-ID: <1325767486-6392-1-git-send-email-hamo.by@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yang Bai <hamo.by@gmail.com>

If CONFIG_SMP is not set, define cpu_logical_map(cpu) as
(cpu), this fixes the problem described in this mail:
https://lkml.org/lkml/2012/1/2/142

Signed-off-by: Yang Bai <hamo.by@gmail.com>
---
 arch/arm/include/asm/smp.h |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 1e5717a..0a06ead 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -10,14 +10,12 @@
 #ifndef __ASM_ARM_SMP_H
 #define __ASM_ARM_SMP_H
 
+#ifdef CONFIG_SMP
+
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
 
-#ifndef CONFIG_SMP
-# error "<asm/smp.h> included in non-SMP build"
-#endif
-
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
 struct seq_file;
@@ -99,4 +97,10 @@ extern void platform_cpu_enable(unsigned int cpu);
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
+#else
+
+#define cpu_logical_map(cpu)	(cpu)
+
+#endif /* CONFIG_SMP */
+
 #endif /* ifndef __ASM_ARM_SMP_H */
-- 
1.7.8.2
