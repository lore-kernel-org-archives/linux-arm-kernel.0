From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Jun 2013 17:53:25 +0100
Subject: [PATCH] ARM: pcpu: ensure __my_cpu_offset cannot be re-ordered across
 barrier()
Message-ID: <1370278405-13261-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__my_cpu_offset is non-volatile, since we want its value to be cached
when we access several per-cpu variables in a row with preemption
disabled. This means that we rely on preempt_{en,dis}able to hazard
with the operation via the barrier() macro, so that we can't end up
migrating CPUs without reloading the per-cpu offset.

Unfortunately, GCC doesn't treat a "memory" clobber on a non-volatile
asm block as a side-effect, and will happily re-order it before other
memory clobbers (including those in prempt_disable()) and cache the
value. This has been observed to break the cmpxchg logic in the slub
allocator, leading to livelock in kmem_cache_alloc in mainline kernels.

This patch adds a dummy memory output operand to __my_cpu_offset,
forcing it to be ordered with respect to the barrier() macro.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/percpu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index 968c0a1..93970eb 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -30,8 +30,12 @@ static inline void set_my_cpu_offset(unsigned long off)
 static inline unsigned long __my_cpu_offset(void)
 {
 	unsigned long off;
-	/* Read TPIDRPRW */
-	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
+	/*
+	 * Read TPIDRPRW.
+	 * We want to allow caching the value, so avoid using volatile and
+	 * instead use a fake memory access to hazard against barrier().
+	 */
+	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off), "=Qo" (off));
 	return off;
 }
 #define __my_cpu_offset __my_cpu_offset()
-- 
1.8.2.2
