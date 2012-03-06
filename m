From: will.deacon@arm.com (Will Deacon)
Date: Tue,  6 Mar 2012 16:54:04 +0000
Subject: [PATCH 4/6] ARM: suspend: fix CPU suspend code for !CONFIG_MMU
 configurations
In-Reply-To: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
References: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
Message-ID: <1331052846-19144-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM CPU suspend code can be selected even for a !CONFIG_MMU
configuration. The resulting kernel will not compile and, even if it did,
would access undefined co-processor registers when executing.

This patch fixes the v6 and v7 CPU suspend code for the nommu case.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/suspend.c |   52 ++++++++++++++++++++++++++-------------------
 arch/arm/mm/proc-v6.S     |    6 ++++-
 arch/arm/mm/proc-v7.S     |   14 +++++++----
 3 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 1794cc3..073601e 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -10,28 +10,7 @@
 extern int __cpu_suspend(unsigned long, int (*)(unsigned long));
 extern void cpu_resume_mmu(void);
 
-/*
- * This is called by __cpu_suspend() to save the state, and do whatever
- * flushing is required to ensure that when the CPU goes to sleep we have
- * the necessary data available when the caches are not searched.
- */
-void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
-{
-	*save_ptr = virt_to_phys(ptr);
-
-	/* This must correspond to the LDM in cpu_resume() assembly */
-	*ptr++ = virt_to_phys(idmap_pgd);
-	*ptr++ = sp;
-	*ptr++ = virt_to_phys(cpu_do_resume);
-
-	cpu_do_suspend(ptr);
-
-	flush_cache_all();
-	outer_clean_range(*save_ptr, *save_ptr + ptrsz);
-	outer_clean_range(virt_to_phys(save_ptr),
-			  virt_to_phys(save_ptr) + sizeof(*save_ptr));
-}
-
+#ifdef CONFIG_MMU
 /*
  * Hide the first two arguments to __cpu_suspend - these are an implementation
  * detail which platform code shouldn't have to know about.
@@ -58,3 +37,32 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 
 	return ret;
 }
+#else
+int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
+{
+	return __cpu_suspend(arg, fn);
+}
+#define	idmap_pgd	NULL
+#endif
+
+/*
+ * This is called by __cpu_suspend() to save the state, and do whatever
+ * flushing is required to ensure that when the CPU goes to sleep we have
+ * the necessary data available when the caches are not searched.
+ */
+void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
+{
+	*save_ptr = virt_to_phys(ptr);
+
+	/* This must correspond to the LDM in cpu_resume() assembly */
+	*ptr++ = virt_to_phys(idmap_pgd);
+	*ptr++ = sp;
+	*ptr++ = virt_to_phys(cpu_do_resume);
+
+	cpu_do_suspend(ptr);
+
+	flush_cache_all();
+	outer_clean_range(*save_ptr, *save_ptr + ptrsz);
+	outer_clean_range(virt_to_phys(save_ptr),
+			  virt_to_phys(save_ptr) + sizeof(*save_ptr));
+}
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 5900cd5..2f702fd 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -136,8 +136,10 @@ ENTRY(cpu_v6_set_pte_ext)
 ENTRY(cpu_v6_do_suspend)
 	stmfd	sp!, {r4 - r9, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+#ifdef CONFIG_MMU
 	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
 	mrc	p15, 0, r6, c2, c0, 1	@ Translation table base 1
+#endif
 	mrc	p15, 0, r7, c1, c0, 1	@ auxiliary control register
 	mrc	p15, 0, r8, c1, c0, 2	@ co-processor access control
 	mrc	p15, 0, r9, c1, c0, 0	@ control register
@@ -154,14 +156,16 @@ ENTRY(cpu_v6_do_resume)
 	mcr	p15, 0, ip, c13, c0, 1	@ set reserved context ID
 	ldmia	r0, {r4 - r9}
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+#ifdef CONFIG_MMU
 	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
 	ALT_SMP(orr	r1, r1, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r1, r1, #TTB_FLAGS_UP)
 	mcr	p15, 0, r1, c2, c0, 0	@ Translation table base 0
 	mcr	p15, 0, r6, c2, c0, 1	@ Translation table base 1
+	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
+#endif
 	mcr	p15, 0, r7, c1, c0, 1	@ auxiliary control register
 	mcr	p15, 0, r8, c1, c0, 2	@ co-processor access control
-	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
 	mcr	p15, 0, ip, c7, c5, 4	@ ISB
 	mov	r0, r9			@ control register
 	b	cpu_resume_mmu
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 0404ccb..5903ceb 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -98,9 +98,11 @@ ENTRY(cpu_v7_do_suspend)
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mrc	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
 	stmia	r0!, {r4 - r5}
+#ifdef CONFIG_MMU
 	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
 	mrc	p15, 0, r7, c2, c0, 1	@ TTB 1
 	mrc	p15, 0, r11, c2, c0, 2	@ TTB control register
+#endif
 	mrc	p15, 0, r8, c1, c0, 0	@ Control register
 	mrc	p15, 0, r9, c1, c0, 1	@ Auxiliary control register
 	mrc	p15, 0, r10, c1, c0, 2	@ Co-processor access control
@@ -110,13 +112,14 @@ ENDPROC(cpu_v7_do_suspend)
 
 ENTRY(cpu_v7_do_resume)
 	mov	ip, #0
-	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
 	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
 	mcr	p15, 0, ip, c13, c0, 1	@ set reserved context ID
 	ldmia	r0!, {r4 - r5}
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mcr	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
 	ldmia	r0, {r6 - r11}
+#ifdef CONFIG_MMU
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
 	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
 #ifndef CONFIG_ARM_LPAE
 	ALT_SMP(orr	r1, r1, #TTB_FLAGS_SMP)
@@ -125,14 +128,15 @@ ENTRY(cpu_v7_do_resume)
 	mcr	p15, 0, r1, c2, c0, 0	@ TTB 0
 	mcr	p15, 0, r7, c2, c0, 1	@ TTB 1
 	mcr	p15, 0, r11, c2, c0, 2	@ TTB control register
-	mrc	p15, 0, r4, c1, c0, 1	@ Read Auxiliary control register
-	teq	r4, r9			@ Is it already set?
-	mcrne	p15, 0, r9, c1, c0, 1	@ No, so write it
-	mcr	p15, 0, r10, c1, c0, 2	@ Co-processor access control
 	ldr	r4, =PRRR		@ PRRR
 	ldr	r5, =NMRR		@ NMRR
 	mcr	p15, 0, r4, c10, c2, 0	@ write PRRR
 	mcr	p15, 0, r5, c10, c2, 1	@ write NMRR
+#endif	/* CONFIG_MMU */
+	mrc	p15, 0, r4, c1, c0, 1	@ Read Auxiliary control register
+	teq	r4, r9			@ Is it already set?
+	mcrne	p15, 0, r9, c1, c0, 1	@ No, so write it
+	mcr	p15, 0, r10, c1, c0, 2	@ Co-processor access control
 	isb
 	dsb
 	mov	r0, r8			@ control register
-- 
1.7.4.1
