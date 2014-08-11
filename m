From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Aug 2014 10:24:08 +0100
Subject: [PATCH 2/2] ARM: errata: work around Cortex-A15 erratum 830321 using
 dummy strex
In-Reply-To: <1407749048-18909-1-git-send-email-mark.rutland@arm.com>
References: <1407749048-18909-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1407749048-18909-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On revisions of Cortex-A15 prior to r3p3, a CLREX instruction at PL1 may
falsely trigger a watchpoint exception, leading to potential data aborts
during exception return and/or livelock.

This patch resolves the issue in the following ways:

  - Replacing our uses of CLREX with a dummy STREX sequence instead (as
    we did for v6 CPUs).

  - Removing the clrex code from v7_exit_coherency_flush and derivatives,
    since this only exists as a minor performance improvement when
    non-cached exclusives are in use (Linux doesn't use these).

Benchmarking on a variety of ARM cores revealed no measurable
performance difference with this change applied, so the change is
performed unconditionally and no new Kconfig entry is added.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: stable at vger.kernel.org
---
 arch/arm/include/asm/cacheflush.h  |  1 -
 arch/arm/kernel/entry-header.S     | 29 +++++++++++++++--------------
 arch/arm/mach-exynos/mcpm-exynos.c |  1 -
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index fd43f7f..79ecb4f 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -472,7 +472,6 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
 	"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR \n\t" \
 	"isb	\n\t" \
 	"bl	v7_flush_dcache_"__stringify(level)" \n\t" \
-	"clrex	\n\t" \
 	"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR \n\t" \
 	"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t" \
 	"mcr	p15, 0, r0, c1, c0, 1	@ set ACTLR \n\t" \
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 5d702f8..0325dbf 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -208,26 +208,21 @@
 #endif
 	.endif
 	msr	spsr_cxsf, \rpsr
-#if defined(CONFIG_CPU_V6)
-	ldr	r0, [sp]
-	strex	r1, r2, [sp]			@ clear the exclusive monitor
-	ldmib	sp, {r1 - pc}^			@ load r1 - pc, cpsr
-#elif defined(CONFIG_CPU_32v6K)
-	clrex					@ clear the exclusive monitor
-	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
-#else
-	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
+	@ We must avoid clrex due to Cortex-A15 erratum #830321
+	sub	r0, sp, #4			@ uninhabited address
+	strex	r1, r2, [r0]			@ clear the exclusive monitor
 #endif
+	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
 	.endm
 
 	.macro	restore_user_regs, fast = 0, offset = 0
 	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
 	ldr	lr, [sp, #\offset + S_PC]!	@ get pc
 	msr	spsr_cxsf, r1			@ save in spsr_svc
-#if defined(CONFIG_CPU_V6)
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
+	@ We must avoid clrex due to Cortex-A15 erratum #830321
 	strex	r1, r2, [sp]			@ clear the exclusive monitor
-#elif defined(CONFIG_CPU_32v6K)
-	clrex					@ clear the exclusive monitor
 #endif
 	.if	\fast
 	ldmdb	sp, {r1 - lr}^			@ get calling r1 - lr
@@ -267,7 +262,10 @@
 	.endif
 	ldr	lr, [sp, #S_SP]			@ top of the stack
 	ldrd	r0, r1, [sp, #S_LR]		@ calling lr and pc
-	clrex					@ clear the exclusive monitor
+
+	@ We must avoid clrex due to Cortex-A15 erratum #830321
+	strex	r2, r1, [sp, #S_LR]		@ clear the exclusive monitor
+
 	stmdb	lr!, {r0, r1, \rpsr}		@ calling lr and rfe context
 	ldmia	sp, {r0 - r12}
 	mov	sp, lr
@@ -288,13 +286,16 @@
 	.endm
 #else	/* ifdef CONFIG_CPU_V7M */
 	.macro	restore_user_regs, fast = 0, offset = 0
-	clrex					@ clear the exclusive monitor
 	mov	r2, sp
 	load_user_sp_lr r2, r3, \offset + S_SP	@ calling sp, lr
 	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
 	ldr	lr, [sp, #\offset + S_PC]	@ get pc
 	add	sp, sp, #\offset + S_SP
 	msr	spsr_cxsf, r1			@ save in spsr_svc
+
+	@ We must avoid clrex due to Cortex-A15 erratum #830321
+	strex	r1, r2, [sp]			@ clear the exclusive monitor
+
 	.if	\fast
 	ldmdb	sp, {r1 - r12}			@ get calling r1 - r12
 	.else
diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index ace0ed6..25ef732 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -39,7 +39,6 @@
 	"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR\n\t" \
 	"isb\n\t"\
 	"bl	v7_flush_dcache_"__stringify(level)"\n\t" \
-	"clrex\n\t"\
 	"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR\n\t" \
 	"bic	r0, r0, #(1 << 6)	@ disable local coherency\n\t" \
 	/* Dummy Load of a device register to avoid Erratum 799270 */ \
-- 
1.9.1
