From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Apr 2010 18:23:58 +0100
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
Message-ID: <1271093038-31773-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linux expects that if a CPU modifies a memory location, then that
modification will eventually become visible to other CPUs in the system.

On an ARM11MPCore processor, loads are prioritised over stores so it is
possible for a store operation to be postponed if a polling loop immediately
follows it. If the variable being polled indirectly depends on the outstanding
store [for example, another CPU may be polling the variable that is pending
modification] then there is the potential for deadlock if interrupts are
disabled. This deadlock occurs in the KGDB testsuire when executing on an
SMP ARM11MPCore configuration.

This patch changes the definition of cpu_relax() to smp_mb() for ARMv6 cores,
forcing the write buffer to drain while inside a polling loop on an SMP system.
If the Kernel is not compiled for SMP support, this will expand to a barrier()
as before.

Cc: KGDB Mailing List <kgdb-bugreport@lists.sourceforge.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/processor.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 6a89567..da2078e 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -91,7 +91,16 @@ extern void release_thread(struct task_struct *);
 
 unsigned long get_wchan(struct task_struct *p);
 
+#if __LINUX_ARM_ARCH__ == 6
+/*
+ * The store buffer on ARM11MPCore is not guaranteed to drain when the CPU
+ * is performing aggresive loads. This is usually the case in a polling loop,
+ * so we add a memory barrier to allow any pending stores to complete.
+ */
+#define cpu_relax()			smp_mb()
+#else
 #define cpu_relax()			barrier()
+#endif
 
 /*
  * Create a new kernel thread
-- 
1.6.3.3
