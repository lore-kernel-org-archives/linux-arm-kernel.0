From: koteswararao18@gmail.com (nelakurthi koteswararao)
Date: Wed, 30 Sep 2009 12:56:18 +0530
Subject: performance counter support for ARM architecture
Message-ID: <bbfde6e10909300026hbccd169s71a5ad1cd45ff944@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

I will change the naming conventions and symbolic names once perfcounter for
ARM is supported.
I want to do intermediate releases for review in mean time

1. I am able to support page faults in ARM with the attached patch along
with application.( this is for linux-2.6.29 kernel)

-bash-3.2# ./perf  stat ./array

 Performance counter stats for './array':

    2005.297192  task-clock-msecs         #      0.998 CPUs
              7  context-switches         #      0.000 M/sec
              0  CPU-migrations           #      0.000 M/sec
             76  page-faults              #      0.000 M/sec
  <not counted>  cycles
  <not counted>  instructions
  <not counted>  cache-references
  <not counted>  cache-misses

    2.009101297  seconds time elapsed


Please look at it and give your review comments.

Regards,
Koteswararao.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090930/7854d777/attachment.htm>
-------------- next part --------------

Supported performance counter for ARM architecture.

ChangeLog:
    2009/09/24
    Location: Linux-2.6.29.y-BRANCH_SS
    refs #6657
    First changelog verison.

---
 arch/arm/Kconfig                    |    3 	3 +	0 -	0 !
 arch/arm/include/asm/atomic.h       |    1 	1 +	0 -	0 !
 arch/arm/include/asm/perf_counter.h |    8 	8 +	0 -	0 !
 arch/arm/include/asm/unistd.h       |    3 	2 +	1 -	0 !
 arch/arm/kernel/calls.S             |    1 	1 +	0 -	0 !
 arch/arm/mm/fault.c                 |   10 	9 +	1 -	0 !
 include/asm-generic/atomic64.h      |   42 	42 +	0 -	0 !
 lib/Kconfig                         |    6 	6 +	0 -	0 !
 lib/Makefile                        |    2 	2 +	0 -	0 !
 lib/atomic64.c                      |  175 	175 +	0 -	0 !
 tools/perf/perf.h                   |    6 	6 +	0 -	0 !
 11 files changed, 255 insertions(+), 2 deletions(-)

Index: b/arch/arm/include/asm/unistd.h
===================================================================
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -387,8 +387,9 @@
 #define __NR_dup3			(__NR_SYSCALL_BASE+358)
 #define __NR_pipe2			(__NR_SYSCALL_BASE+359)
 #define __NR_inotify_init1		(__NR_SYSCALL_BASE+360)
+#define __NR_perf_counter_open		(__NR_SYSCALL_BASE+361)
 
-#define __NR_syscall_max 361
+#define __NR_syscall_max 362
 
 /*
  * The following SWIs are ARM private.
Index: b/arch/arm/kernel/calls.S
===================================================================
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -370,6 +370,7 @@
 		CALL(sys_dup3)
 		CALL(sys_pipe2)
 /* 360 */	CALL(sys_inotify_init1)
+		CALL(sys_perf_counter_open)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
Index: b/tools/perf/perf.h
===================================================================
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -25,6 +25,12 @@
 #define cpu_relax()	asm volatile("" ::: "memory");
 #endif
 
+#ifdef __arm__
+#include "../../arch/arm/include/asm/unistd.h"
+#define rmb()           asm volatile("" ::: "memory")
+#define cpu_relax()     asm volatile("" ::: "memory");
+#endif
+
 #include <time.h>
 #include <unistd.h>
 #include <sys/types.h>
Index: b/arch/arm/Kconfig
===================================================================
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -20,6 +20,7 @@ config ARM
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select GENERIC_ATOMIC64
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
@@ -253,6 +254,7 @@ config ARCH_NE1
 #	select PCI
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select HAVE_PERF_COUNTERS
 	help
 	  This enables support for NEC-EL NaviEngine1-based boards.
 
@@ -463,6 +465,7 @@ config ARCH_MXC
 	select ARCH_MTD_XIP
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_PERF_COUNTERS
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
Index: b/arch/arm/include/asm/perf_counter.h
===================================================================
--- /dev/null
+++ b/arch/arm/include/asm/perf_counter.h
@@ -0,0 +1,8 @@
+#ifndef _ASM_ARM_PERF_COUNTER_H
+#define _ASM_ARM_PERF_COUNTER_H
+
+#define PERF_COUNTER_INDEX_OFFSET	1
+/* ARM only supports software counters through this interface. */
+static inline void set_perf_counter_pending(void) { do { } while(0);
+}
+#endif /* _ASM_ARM_PERF_COUNTER_H */
Index: b/arch/arm/include/asm/atomic.h
===================================================================
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -225,6 +225,7 @@ static inline int atomic_add_unless(atom
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic64.h>
 #include <asm-generic/atomic.h>
 #endif
 #endif
Index: b/include/asm-generic/atomic64.h
===================================================================
--- /dev/null
+++ b/include/asm-generic/atomic64.h
@@ -0,0 +1,42 @@
+/*
+ * Generic implementation of 64-bit atomics using spinlocks,
+ * useful on processors that don't have 64-bit atomic instructions.
+ *
+ * Copyright ? 2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_GENERIC_ATOMIC64_H
+#define _ASM_GENERIC_ATOMIC64_H
+
+typedef struct {
+	long long counter;
+} atomic64_t;
+
+#define ATOMIC64_INIT(i)	{ (i) }
+
+extern long long atomic64_read(const atomic64_t *v);
+extern void	 atomic64_set(atomic64_t *v, long long i);
+extern void	 atomic64_add(long long a, atomic64_t *v);
+extern long long atomic64_add_return(long long a, atomic64_t *v);
+extern void	 atomic64_sub(long long a, atomic64_t *v);
+extern long long atomic64_sub_return(long long a, atomic64_t *v);
+extern long long atomic64_dec_if_positive(atomic64_t *v);
+extern long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n);
+extern long long atomic64_xchg(atomic64_t *v, long long new);
+extern int	 atomic64_add_unless(atomic64_t *v, long long a, long long u);
+
+#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
+#define atomic64_inc(v)			atomic64_add(1LL, (v))
+#define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
+#define atomic64_inc_and_test(v) 	(atomic64_inc_return(v) == 0)
+#define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
+#define atomic64_dec(v)			atomic64_sub(1LL, (v))
+#define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
+#define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
+#define atomic64_inc_not_zero(v) 	atomic64_add_unless((v), 1LL, 0LL)
+
+#endif  /*  _ASM_GENERIC_ATOMIC64_H  */
Index: b/lib/atomic64.c
===================================================================
--- /dev/null
+++ b/lib/atomic64.c
@@ -0,0 +1,175 @@
+/*
+ * Generic implementation of 64-bit atomics using spinlocks,
+ * useful on processors that don't have 64-bit atomic instructions.
+ *
+ * Copyright ? 2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/types.h>
+#include <linux/cache.h>
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <asm/atomic.h>
+
+/*
+ * We use a hashed array of spinlocks to provide exclusive access
+ * to each atomic64_t variable.  Since this is expected to used on
+ * systems with small numbers of CPUs (<= 4 or so), we use a
+ * relatively small array of 16 spinlocks to avoid wasting too much
+ * memory on the spinlock array.
+ */
+#define NR_LOCKS	16
+
+/*
+ * Ensure each lock is in a separate cacheline.
+ */
+static union {
+	spinlock_t lock;
+	char pad[L1_CACHE_BYTES];
+} atomic64_lock[NR_LOCKS] __cacheline_aligned_in_smp;
+
+static inline spinlock_t *lock_addr(const atomic64_t *v)
+{
+	unsigned long addr = (unsigned long) v;
+
+	addr >>= L1_CACHE_SHIFT;
+	addr ^= (addr >> 8) ^ (addr >> 16);
+	return &atomic64_lock[addr & (NR_LOCKS - 1)].lock;
+}
+
+long long atomic64_read(const atomic64_t *v)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+	long long val;
+
+	spin_lock_irqsave(lock, flags);
+	val = v->counter;
+	spin_unlock_irqrestore(lock, flags);
+	return val;
+}
+
+void atomic64_set(atomic64_t *v, long long i)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+
+	spin_lock_irqsave(lock, flags);
+	v->counter = i;
+	spin_unlock_irqrestore(lock, flags);
+}
+
+void atomic64_add(long long a, atomic64_t *v)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+
+	spin_lock_irqsave(lock, flags);
+	v->counter += a;
+	spin_unlock_irqrestore(lock, flags);
+}
+
+long long atomic64_add_return(long long a, atomic64_t *v)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+	long long val;
+
+	spin_lock_irqsave(lock, flags);
+	val = v->counter += a;
+	spin_unlock_irqrestore(lock, flags);
+	return val;
+}
+
+void atomic64_sub(long long a, atomic64_t *v)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+
+	spin_lock_irqsave(lock, flags);
+	v->counter -= a;
+	spin_unlock_irqrestore(lock, flags);
+}
+
+long long atomic64_sub_return(long long a, atomic64_t *v)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+	long long val;
+
+	spin_lock_irqsave(lock, flags);
+	val = v->counter -= a;
+	spin_unlock_irqrestore(lock, flags);
+	return val;
+}
+
+long long atomic64_dec_if_positive(atomic64_t *v)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+	long long val;
+
+	spin_lock_irqsave(lock, flags);
+	val = v->counter - 1;
+	if (val >= 0)
+		v->counter = val;
+	spin_unlock_irqrestore(lock, flags);
+	return val;
+}
+
+long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+	long long val;
+
+	spin_lock_irqsave(lock, flags);
+	val = v->counter;
+	if (val == o)
+		v->counter = n;
+	spin_unlock_irqrestore(lock, flags);
+	return val;
+}
+
+long long atomic64_xchg(atomic64_t *v, long long new)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+	long long val;
+
+	spin_lock_irqsave(lock, flags);
+	val = v->counter;
+	v->counter = new;
+	spin_unlock_irqrestore(lock, flags);
+	return val;
+}
+
+int atomic64_add_unless(atomic64_t *v, long long a, long long u)
+{
+	unsigned long flags;
+	spinlock_t *lock = lock_addr(v);
+	int ret = 1;
+
+	spin_lock_irqsave(lock, flags);
+	if (v->counter != u) {
+		v->counter += a;
+		ret = 0;
+	}
+	spin_unlock_irqrestore(lock, flags);
+	return ret;
+}
+
+static int init_atomic64_lock(void)
+{
+	int i;
+
+	for (i = 0; i < NR_LOCKS; ++i)
+		spin_lock_init(&atomic64_lock[i].lock);
+	return 0;
+}
+
+pure_initcall(init_atomic64_lock);
Index: b/lib/Makefile
===================================================================
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -88,6 +88,8 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += sys
 
 obj-$(CONFIG_DYNAMIC_PRINTK_DEBUG) += dynamic_printk.o
 
+obj-$(CONFIG_GENERIC_ATOMIC64) += atomic64.o
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
Index: b/lib/Kconfig
===================================================================
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -177,4 +177,10 @@ config DISABLE_OBSOLETE_CPUMASK_FUNCTION
        bool "Disable obsolete cpumask functions" if DEBUG_PER_CPU_MAPS
        depends on EXPERIMENTAL && BROKEN
 
+#
+# Generic 64-bit atomic support is selected if needed
+#
+config GENERIC_ATOMIC64
+       bool
+
 endmenu
Index: b/arch/arm/mm/fault.c
===================================================================
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -16,6 +16,7 @@
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/page-flags.h>
+#include <linux/perf_counter.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -145,7 +146,6 @@ __do_user_fault(struct task_struct *tsk,
 		show_regs(regs);
 	}
 #endif
-
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
@@ -254,6 +254,7 @@ do_page_fault(unsigned long addr, unsign
 	tsk = current;
 	mm  = tsk->mm;
 
+	perf_swcounter_event(PERF_COUNT_SW_PAGE_FAULTS, 1, 0, regs, addr);
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
@@ -281,6 +282,13 @@ do_page_fault(unsigned long addr, unsign
 	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP | VM_FAULT_BADACCESS))))
 		return 0;
 
+	if(tsk->maj_flt)
+		perf_swcounter_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, 0,
+				     regs, addr);
+	if(tsk->min_flt)
+		perf_swcounter_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, 0,
+				     regs, addr);
+
 	/*
 	 * If we are in kernel mode at this point, we
 	 * have no context to handle this fault with.
-------------- next part --------------
int fast_multiply(x,  y)
{
        return x * y;
}
 
int slow_multiply(x, y)
{
        int i, j, z;
        for (i = 0, z = 0; i < x; i++)
                z = z + y;
        return z;
}
 
int main()
{
        int i,j;
        int x,y;
 
        for (i = 0; i < 200; i ++) {
                for (j = 0; j < 3000 ; j++) {
                        x = fast_multiply(i, j);
                        y = slow_multiply(i, j);
                }
        }
        return 0;
}
