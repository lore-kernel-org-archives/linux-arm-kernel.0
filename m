From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue,  4 Jun 2013 10:34:13 +0100
Subject: [RFC PATCH 2/2] ARM: kernel: implement stack pointer save array
 through MPIDR hashing
In-Reply-To: <1370338453-8749-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1370338453-8749-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1370338453-8749-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current implementation of cpu_{suspend}/cpu_{resume} relies on the MPIDR
to index the array of pointers where the context is saved and restored.
The current approach works as long as the MPIDR can be considered a
linear index, so that the pointers array can simply be dereferenced by
using the MPIDR[7:0] value.
On ARM multi-cluster systems, where the MPIDR may not be a linear index,
to properly dereference the stack pointer array, a mapping function should
be applied to it so that it can be used for arrays look-ups.

This patch adds code in the cpu_{suspend}/cpu_{resume} implementation
that relies on shifting and ORing hashing method to map a MPIDR value to a
set of buckets precomputed at boot to have a collision free mapping from
MPIDR to context pointers.

The hashing algorithm must be simple, fast, and implementable with few
instructions since in the cpu_resume path the mapping is carried out with
the MMU off and the I-cache off, hence code and data are fetched from DRAM
with no-caching available. Simplicity is counterbalanced with a little
increase of memory (allocated dynamically) for stack pointers buckets, that
should be anyway fairly limited on most systems.

Memory for context pointers is allocated in a early_initcall with
size precomputed and stashed previously in kernel data structures.
Memory for context pointers is allocated through kmalloc; this
guarantees contiguous physical addresses for the allocated memory which
is fundamental to the correct functioning of the resume mechanism that
relies on the context pointer array to be a chunk of contiguous physical
memory. Virtual to physical address conversion for the context pointer
array base is carried out at boot to avoid fiddling with virt_to_phys
conversions in the cpu_resume path which is quite fragile and should be
optimized to execute as few instructions as possible.
Virtual and physical context pointer base array addresses are stashed in a
struct that is accessible from assembly using values generated through the
asm-offsets.c mechanism.

Cc: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Colin Cross <ccross@android.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/smp_plat.h | 10 ++++-
 arch/arm/include/asm/suspend.h  |  5 +++
 arch/arm/kernel/asm-offsets.c   |  6 +++
 arch/arm/kernel/sleep.S         | 94 +++++++++++++++++++++++++++++++++--------
 arch/arm/kernel/suspend.c       | 20 +++++++++
 5 files changed, 116 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index d933b03..f15eb6e 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -66,9 +66,15 @@ static inline int get_logical_index(u32 mpidr)
 	return -EINVAL;
 }
 
+/*
+ * NOTE ! Assembly code relies on the following
+ * structure memory layout in order to carry out load
+ * multiple from its base address. For more
+ * information check arch/arm/kernel/sleep.S
+ */
 struct mpidr_hash {
-	u32	mask;
-	u32	shift_aff[3];
+	u32	mask; /* used by sleep.S */
+	u32	shift_aff[3]; /* used by sleep.S */
 	u32	bits;
 };
 
diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index 1c0a551..cd20029 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -1,6 +1,11 @@
 #ifndef __ASM_ARM_SUSPEND_H
 #define __ASM_ARM_SUSPEND_H
 
+struct sleep_save_sp {
+	u32 *save_ptr_stash;
+	u32 save_ptr_stash_phys;
+};
+
 extern void cpu_resume(void);
 extern int cpu_suspend(unsigned long, int (*)(unsigned long));
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index ee68cce..ded0417 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -23,6 +23,7 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/procinfo.h>
+#include <asm/suspend.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
 
@@ -145,6 +146,11 @@ int main(void)
 #ifdef MULTI_CACHE
   DEFINE(CACHE_FLUSH_KERN_ALL,	offsetof(struct cpu_cache_fns, flush_kern_all));
 #endif
+#ifdef CONFIG_ARM_CPU_SUSPEND
+  DEFINE(SLEEP_SAVE_SP_SZ,	sizeof(struct sleep_save_sp));
+  DEFINE(SLEEP_SAVE_SP_PHYS,	offsetof(struct sleep_save_sp, save_ptr_stash_phys));
+  DEFINE(SLEEP_SAVE_SP_VIRT,	offsetof(struct sleep_save_sp, save_ptr_stash));
+#endif
   BLANK();
   DEFINE(DMA_BIDIRECTIONAL,	DMA_BIDIRECTIONAL);
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 987dcf3..da1b65f 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -7,6 +7,48 @@
 	.text
 
 /*
+ * Implementation of MPIDR hash algorithm through shifting
+ * and OR'ing.
+ *
+ * @dst: register containing hash result
+ * @rtemp0: scratch register 0
+ * @rtemp1: scratch register 1
+ * @rtemp2: scratch register 2
+ * @rs0: register containing affinity level 0 bit shift
+ * @rs1: register containing affinity level 1 bit shift
+ * @rs2: register containing affinity level 2 bit shift
+ * @mpidr: register containing MPIDR value
+ * @mask: register containing MPIDR mask
+ *
+ * Pseudo C-code:
+ *
+ *u32 dst;
+ *
+ *compute_mpidr_hash(u32 rs0, u32 rs1, u32 rs2, u32 mpidr, u32 mask) {
+ *	u32 rtemp0, rtemp1, rtemp2;
+ *	u32 mpidr_masked = mpidr & mask;
+ *	rtemp0 = mpidr_masked & 0xff;
+ *	rtemp1 = mpidr_masked & 0xff00;
+ *	rtemp2 = mpidr_masked & 0xff0000;
+ *	dst = (rtemp0 >> rs0 | rtemp1 >> rs1 | rtemp2 >> rs2);
+ *}
+ */
+.macro compute_mpidr_hash dst, rtemp0, rtemp1, rtemp2, rs0, rs1, rs2, mpidr, mask
+	and	\mpidr, \mpidr, \mask		@ mask out unused MPIDR bits
+	and	\rtemp0, \mpidr, #0xff		@ extracts aff0
+	and	\rtemp1, \mpidr, #0xff00	@ extracts aff1
+	and	\rtemp2, \mpidr, #0xff0000	@ extracts aff2
+  ARM(	mov	\dst, \rtemp0, lsr \rs0)	@ dst=aff0>>rs0
+  ARM(	orr	\dst, \dst, \rtemp1, lsr \rs1)	@ dst|=(aff1>>rs1)
+  ARM(	orr	\dst, \dst, \rtemp2, lsr \rs2)		@ dst|=(aff2>>rs2)
+THUMB(	mov	\rtemp0, \rtemp0, lsr \rs0)		@ aff0>>=rs0
+THUMB(	mov	\rtemp1, \rtemp1, lsr \rs1)		@ aff1>>=rs1
+THUMB(	mov	\rtemp2, \rtemp2, lsr \rs2)		@ aff2>>=rs2
+THUMB(	orr	\dst, \rtemp0, \rtemp1)			@ dst = aff0 | aff1
+THUMB(	orr	\dst, \dst, \rtemp2)			@ dts |= aff2
+.endm
+
+/*
  * Save CPU state for a suspend.  This saves the CPU general purpose
  * registers, and allocates space on the kernel stack to save the CPU
  * specific registers and some other data for resume.
@@ -29,12 +71,18 @@ ENTRY(__cpu_suspend)
 	mov	r1, r4			@ size of save block
 	mov	r2, r5			@ virtual SP
 	ldr	r3, =sleep_save_sp
-#ifdef CONFIG_SMP
+	ldr	r3, [r3, #SLEEP_SAVE_SP_VIRT]
 	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
-	ALT_UP(mov lr, #0)
-	and	lr, lr, #15
+        ALT_UP_B(1f)
+	ldr	r11, =mpidr_hash
+	/*
+	 * This ldmia relies on the memory layout of the mpidr_hash
+	 * struct mpidr_hash.
+	 */
+	ldmia	r11, {r4-r7}	@ r4 = mpidr mask (r5,r6,r7) = l[0,1,2] shifts
+	compute_mpidr_hash	lr, r8, r9, r10, r5, r6, r7, lr, r4
 	add	r3, r3, lr, lsl #2
-#endif
+1:
 	bl	__cpu_suspend_save
 	adr	lr, BSYM(cpu_suspend_abort)
 	ldmfd	sp!, {r0, pc}		@ call suspend fn
@@ -81,15 +129,23 @@ ENDPROC(cpu_resume_after_mmu)
 	.data
 	.align
 ENTRY(cpu_resume)
-#ifdef CONFIG_SMP
-	adr	r0, sleep_save_sp
-	ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
-	ALT_UP(mov r1, #0)
-	and	r1, r1, #15
-	ldr	r0, [r0, r1, lsl #2]	@ stack phys addr
-#else
-	ldr	r0, sleep_save_sp	@ stack phys addr
-#endif
+	mov	r1, #0
+	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
+	ALT_UP_B(1f)
+	adr	r2, mpidr_hash_ptr
+	ldr	r3, [r2]
+	add	r2, r2, r3		@ r2 = struct mpidr_hash phys address
+	/*
+	 * This ldmia relies on the memory layout of the mpidr_hash
+	 * struct mpidr_hash.
+	 */
+	ldmia	r2, { r3-r6 }	@ r3 = mpidr mask (r4,r5,r6) = l[0,1,2] shifts
+	compute_mpidr_hash	r1, r7, r8, r9, r4, r5, r6, r0, r3
+1:
+	adr	r0, _sleep_save_sp
+	ldr	r0, [r0, #SLEEP_SAVE_SP_PHYS]
+	ldr	r0, [r0, r1, lsl #2]
+
 	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r1  @ set SVC, irqs off
 	@ load phys pgd, stack, resume fn
   ARM(	ldmia	r0!, {r1, sp, pc}	)
@@ -98,7 +154,11 @@ THUMB(	mov	sp, r2			)
 THUMB(	bx	r3			)
 ENDPROC(cpu_resume)
 
-sleep_save_sp:
-	.rept	CONFIG_NR_CPUS
-	.long	0				@ preserve stack phys ptr here
-	.endr
+	.align 2
+mpidr_hash_ptr:
+	.long	mpidr_hash - .			@ mpidr_hash struct offset
+
+	.type	sleep_save_sp, #object
+ENTRY(sleep_save_sp)
+_sleep_save_sp:
+	.space	SLEEP_SAVE_SP_SZ		@ struct sleep_save_sp
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index c59c97e..17d02f6 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -1,9 +1,12 @@
 #include <linux/init.h>
+#include <linux/slab.h>
 
+#include <asm/cacheflush.h>
 #include <asm/idmap.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/memory.h>
+#include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 
@@ -74,3 +77,20 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 
 	return ret;
 }
+
+extern struct sleep_save_sp sleep_save_sp;
+
+static int cpu_suspend_alloc_sp(void)
+{
+	void *ctx_ptr;
+	/* ctx_ptr is an array of physical addresses */
+	ctx_ptr = kcalloc(mpidr_hash_size(), sizeof(u32), GFP_KERNEL);
+
+	if (WARN_ON(!ctx_ptr))
+		return -ENOMEM;
+	sleep_save_sp.save_ptr_stash = ctx_ptr;
+	sleep_save_sp.save_ptr_stash_phys = virt_to_phys(ctx_ptr);
+	sync_cache_w(&sleep_save_sp);
+	return 0;
+}
+early_initcall(cpu_suspend_alloc_sp);
-- 
1.8.2.2
