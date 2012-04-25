From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Apr 2012 16:54:20 +0100
Subject: [PATCH 2/2] ARM: cacheflush: return error to userspace when flushing
 syscall fails
In-Reply-To: <1335369260-9761-1-git-send-email-will.deacon@arm.com>
References: <1335369260-9761-1-git-send-email-will.deacon@arm.com>
Message-ID: <1335369260-9761-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cacheflush syscall can fail for two reasons:

(1) The arguments are invalid (nonsensical address range or no VMA)

(2) The region generates a translation fault on a VIPT or PIPT cache

This patch allows do_cache_op to return an error code to userspace in
the case of the above. The various coherent_user_range implementations
are modified to return 0 in the case of VIVT caches or -EFAULT in the
case of an abort on v6/v7 cores.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cacheflush.h |    4 ++--
 arch/arm/kernel/traps.c           |   11 +++++------
 arch/arm/mm/cache-v3.S            |    1 +
 arch/arm/mm/cache-v4.S            |    1 +
 arch/arm/mm/cache-v4wb.S          |    6 +++---
 arch/arm/mm/cache-v4wt.S          |    1 +
 arch/arm/mm/cache-v6.S            |   10 ++++------
 arch/arm/mm/cache-v7.S            |   10 ++++------
 arch/arm/mm/proc-arm1020.S        |    1 +
 arch/arm/mm/proc-arm1020e.S       |    1 +
 arch/arm/mm/proc-arm1022.S        |    1 +
 arch/arm/mm/proc-arm1026.S        |    1 +
 arch/arm/mm/proc-arm920.S         |    1 +
 arch/arm/mm/proc-arm922.S         |    1 +
 arch/arm/mm/proc-arm925.S         |    1 +
 arch/arm/mm/proc-arm926.S         |    1 +
 arch/arm/mm/proc-arm940.S         |    6 +++---
 arch/arm/mm/proc-arm946.S         |    1 +
 arch/arm/mm/proc-feroceon.S       |    1 +
 arch/arm/mm/proc-mohawk.S         |    1 +
 20 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 1252a26..004c1bc 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -101,7 +101,7 @@ struct cpu_cache_fns {
 	void (*flush_user_range)(unsigned long, unsigned long, unsigned int);
 
 	void (*coherent_kern_range)(unsigned long, unsigned long);
-	void (*coherent_user_range)(unsigned long, unsigned long);
+	int  (*coherent_user_range)(unsigned long, unsigned long);
 	void (*flush_kern_dcache_area)(void *, size_t);
 
 	void (*dma_map_area)(const void *, size_t, int);
@@ -142,7 +142,7 @@ extern void __cpuc_flush_kern_all(void);
 extern void __cpuc_flush_user_all(void);
 extern void __cpuc_flush_user_range(unsigned long, unsigned long, unsigned int);
 extern void __cpuc_coherent_kern_range(unsigned long, unsigned long);
-extern void __cpuc_coherent_user_range(unsigned long, unsigned long);
+extern int  __cpuc_coherent_user_range(unsigned long, unsigned long);
 extern void __cpuc_flush_dcache_area(void *, size_t);
 
 /*
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 63d402f..3647170 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -479,14 +479,14 @@ static int bad_syscall(int n, struct pt_regs *regs)
 	return regs->ARM_r0;
 }
 
-static inline void
+static inline int
 do_cache_op(unsigned long start, unsigned long end, int flags)
 {
 	struct mm_struct *mm = current->active_mm;
 	struct vm_area_struct *vma;
 
 	if (end < start || flags)
-		return;
+		return -EINVAL;
 
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, start);
@@ -497,10 +497,10 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
 			end = vma->vm_end;
 
 		up_read(&mm->mmap_sem);
-		flush_cache_user_range(start, end);
-		return;
+		return flush_cache_user_range(start, end);
 	}
 	up_read(&mm->mmap_sem);
+	return -EINVAL;
 }
 
 /*
@@ -546,8 +546,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 	 * the specified region).
 	 */
 	case NR(cacheflush):
-		do_cache_op(regs->ARM_r0, regs->ARM_r1, regs->ARM_r2);
-		return 0;
+		return do_cache_op(regs->ARM_r0, regs->ARM_r1, regs->ARM_r2);
 
 	case NR(usr26):
 		if (!(elf_hwcap & HWCAP_26BIT))
diff --git a/arch/arm/mm/cache-v3.S b/arch/arm/mm/cache-v3.S
index c2301f2..52e35f3 100644
--- a/arch/arm/mm/cache-v3.S
+++ b/arch/arm/mm/cache-v3.S
@@ -78,6 +78,7 @@ ENTRY(v3_coherent_kern_range)
  *	- end	 - virtual end address
  */
 ENTRY(v3_coherent_user_range)
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index fd9bb7a..022135d 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -88,6 +88,7 @@ ENTRY(v4_coherent_kern_range)
  *	- end	 - virtual end address
  */
 ENTRY(v4_coherent_user_range)
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index 4f2c141..8f1eeae 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -167,9 +167,9 @@ ENTRY(v4wb_coherent_user_range)
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mov	ip, #0
-	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	mov	pc, lr
 
 
diff --git a/arch/arm/mm/cache-v4wt.S b/arch/arm/mm/cache-v4wt.S
index 4d7b467..b34a5f9 100644
--- a/arch/arm/mm/cache-v4wt.S
+++ b/arch/arm/mm/cache-v4wt.S
@@ -125,6 +125,7 @@ ENTRY(v4wt_coherent_user_range)
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 74c2e5a..4b10760 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
+#include <asm/errno.h>
 #include <asm/unwind.h>
 
 #include "proc-macros.S"
@@ -135,7 +136,6 @@ ENTRY(v6_coherent_user_range)
 1:
  USER(	mcr	p15, 0, r0, c7, c10, 1	)	@ clean D line
 	add	r0, r0, #CACHE_LINE_SIZE
-2:
 	cmp	r0, r1
 	blo	1b
 #endif
@@ -154,13 +154,11 @@ ENTRY(v6_coherent_user_range)
 
 /*
  * Fault handling for the cache operation above. If the virtual address in r0
- * isn't mapped, just try the next page.
+ * isn't mapped, fail with -EFAULT.
  */
 9001:
-	mov	r0, r0, lsr #12
-	mov	r0, r0, lsl #12
-	add	r0, r0, #4096
-	b	2b
+	mov	r0, #-EFAULT
+	mov	pc, lr
  UNWIND(.fnend		)
 ENDPROC(v6_coherent_user_range)
 ENDPROC(v6_coherent_kern_range)
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index a655d3d..39e3fb3 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
+#include <asm/errno.h>
 #include <asm/unwind.h>
 
 #include "proc-macros.S"
@@ -198,7 +199,6 @@ ENTRY(v7_coherent_user_range)
 	add	r12, r12, r2
 	cmp	r12, r1
 	blo	2b
-3:
 	mov	r0, #0
 	ALT_SMP(mcr	p15, 0, r0, c7, c1, 6)	@ invalidate BTB Inner Shareable
 	ALT_UP(mcr	p15, 0, r0, c7, c5, 6)	@ invalidate BTB
@@ -208,13 +208,11 @@ ENTRY(v7_coherent_user_range)
 
 /*
  * Fault handling for the cache operation above. If the virtual address in r0
- * isn't mapped, just try the next page.
+ * isn't mapped, fail with -EFAULT.
  */
 9001:
-	mov	r12, r12, lsr #12
-	mov	r12, r12, lsl #12
-	add	r12, r12, #4096
-	b	3b
+	mov	r0, #-EFAULT
+	mov	pc, lr
  UNWIND(.fnend		)
 ENDPROC(v7_coherent_kern_range)
 ENDPROC(v7_coherent_user_range)
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 2349513..0650bb8 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -241,6 +241,7 @@ ENTRY(arm1020_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index c244b06..4188478 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -235,6 +235,7 @@ ENTRY(arm1020e_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index 38fe22e..33c6882 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -224,6 +224,7 @@ ENTRY(arm1022_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 3eb9c3c..fbc1d5f 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -218,6 +218,7 @@ ENTRY(arm1026_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index cb941ae..1a8c138 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -210,6 +210,7 @@ ENTRY(arm920_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index 4ec0e07..4c44d7e 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -212,6 +212,7 @@ ENTRY(arm922_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 9dccd9a..ec5b118 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -258,6 +258,7 @@ ENTRY(arm925_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 820259b..c31e62c 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -221,6 +221,7 @@ ENTRY(arm926_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index 9fdc0a1..a613a7d 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -160,7 +160,7 @@ ENTRY(arm940_coherent_user_range)
  *	- size	- region size
  */
 ENTRY(arm940_flush_kern_dcache_area)
-	mov	ip, #0
+	mov	r0, #0
 	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
 1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
 2:	mcr	p15, 0, r3, c7, c14, 2		@ clean/flush D index
@@ -168,8 +168,8 @@ ENTRY(arm940_flush_kern_dcache_area)
 	bcs	2b				@ entries 63 to 0
 	subs	r1, r1, #1 << 4
 	bcs	1b				@ segments 7 to 0
-	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index f684cfe..9f4f299 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -190,6 +190,7 @@ ENTRY(arm946_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index ba3c500..23a8e4c 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -232,6 +232,7 @@ ENTRY(feroceon_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index cdfedc5..b047546 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -193,6 +193,7 @@ ENTRY(mohawk_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
+	mov	r0, #0
 	mov	pc, lr
 
 /*
-- 
1.7.4.1
