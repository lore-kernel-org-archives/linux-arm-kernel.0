From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:17 -0400
Subject: [PATCH 01/13] ARM: suspend: use hash of cpu_logical_map value to index
 into save array
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we hash the MPIDR of the CPU being suspended to determine which
entry in the sleep_save_sp array to use. In some situations, such as when
we want to resume on another physical CPU, the MPIDR of another CPU should
be used instead.

So let's use the value of cpu_logical_map(smp_processor_id()) in place
of the MPIDR in the suspend path.  This will result in the same index
being used as with the previous code unless the caller has modified
cpu_logical_map() beforehand.

The register allocation in __cpu_suspend is reworked in order to better
accommodate the additional argument.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/sleep.S   | 25 +++++++++++--------------
 arch/arm/kernel/suspend.c |  8 +++++---
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index db1536b8b3..836d10e698 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -55,6 +55,7 @@
  * specific registers and some other data for resume.
  *  r0 = suspend function arg0
  *  r1 = suspend function
+ *  r2 = MPIDR value used to index into sleep_save_sp
  */
 ENTRY(__cpu_suspend)
 	stmfd	sp!, {r4 - r11, lr}
@@ -67,23 +68,19 @@ ENTRY(__cpu_suspend)
 	mov	r5, sp			@ current virtual SP
 	add	r4, r4, #12		@ Space for pgd, virt sp, phys resume fn
 	sub	sp, sp, r4		@ allocate CPU state on stack
-	stmfd	sp!, {r0, r1}		@ save suspend func arg and pointer
-	add	r0, sp, #8		@ save pointer to save block
-	mov	r1, r4			@ size of save block
-	mov	r2, r5			@ virtual SP
 	ldr	r3, =sleep_save_sp
+	stmfd	sp!, {r0, r1}		@ save suspend func arg and pointer
 	ldr	r3, [r3, #SLEEP_SAVE_SP_VIRT]
-	ALT_SMP(mrc p15, 0, r9, c0, c0, 5)
-        ALT_UP_B(1f)
-	ldr	r8, =mpidr_hash
-	/*
-	 * This ldmia relies on the memory layout of the mpidr_hash
-	 * struct mpidr_hash.
-	 */
-	ldmia	r8, {r4-r7}	@ r4 = mpidr mask (r5,r6,r7) = l[0,1,2] shifts
-	compute_mpidr_hash	lr, r5, r6, r7, r9, r4
-	add	r3, r3, lr, lsl #2
+	ALT_SMP(ldr r0, =mpidr_hash)
+       ALT_UP_B(1f)
+	/* This ldmia relies on the memory layout of the mpidr_hash struct */
+	ldmia	r0, {r1, r6-r8}	@ r1 = mpidr mask (r6,r7,r8) = l[0,1,2] shifts
+	compute_mpidr_hash	r0, r6, r7, r8, r2, r1
+	add	r3, r3, r0, lsl #2
 1:
+	mov	r2, r5			@ virtual SP
+	mov	r1, r4			@ size of save block
+	add	r0, sp, #8		@ pointer to save block
 	bl	__cpu_suspend_save
 	adr	lr, BSYM(cpu_suspend_abort)
 	ldmfd	sp!, {r0, pc}		@ call suspend fn
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 41cf3cbf75..2835d35234 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -10,7 +10,7 @@
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 
-extern int __cpu_suspend(unsigned long, int (*)(unsigned long));
+extern int __cpu_suspend(unsigned long, int (*)(unsigned long), u32 cpuid);
 extern void cpu_resume_mmu(void);
 
 #ifdef CONFIG_MMU
@@ -21,6 +21,7 @@ extern void cpu_resume_mmu(void);
 int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {
 	struct mm_struct *mm = current->active_mm;
+	u32 __mpidr = cpu_logical_map(smp_processor_id());
 	int ret;
 
 	if (!idmap_pgd)
@@ -32,7 +33,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 * resume (indicated by a zero return code), we need to switch
 	 * back to the correct page tables.
 	 */
-	ret = __cpu_suspend(arg, fn);
+	ret = __cpu_suspend(arg, fn, __mpidr);
 	if (ret == 0) {
 		cpu_switch_mm(mm->pgd, mm);
 		local_flush_bp_all();
@@ -44,7 +45,8 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 #else
 int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {
-	return __cpu_suspend(arg, fn);
+	u32 __mpidr = cpu_logical_map(smp_processor_id());
+	return __cpu_suspend(arg, fn, __mpidr);
 }
 #define	idmap_pgd	NULL
 #endif
-- 
1.8.1.2
