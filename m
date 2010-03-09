From: will.deacon@arm.com (Will Deacon)
Date: Tue,  9 Mar 2010 16:06:08 +0000
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
Message-ID: <1268150768-6597-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu_relax() macro is often used in the body of busy-wait loops to ensure
that the variable being spun on is re-loaded for each iteration. On the
ARM11MPCore processor [where loads are prioritised over stores], spinning in
such a loop will prevent the write buffer from draining. If a write contained
in the write buffer indirectly affects the variable being spun on, there is a
potential for deadlock. This deadlock is experienced when executing the KGDB
testsuite on an SMP ARM11MPCore configuration.

This patch changes the definition of cpu_relax() to smp_mb() for ARMv6 cores,
forcing a flushing of the write buffer on SMP systems. If the Kernel is not
compiled for SMP support, this will expand to a barrier() as before.

Cc: KGDB Mailing List <kgdb-bugreport@lists.sourceforge.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/processor.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 6a89567..7bed3da 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -91,7 +91,11 @@ extern void release_thread(struct task_struct *);
 
 unsigned long get_wchan(struct task_struct *p);
 
+#if __LINUX_ARM_ARCH__ == 6
+#define cpu_relax()			smp_mb()
+#else
 #define cpu_relax()			barrier()
+#endif
 
 /*
  * Create a new kernel thread
-- 
1.6.3.3
