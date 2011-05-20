From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 May 2011 12:19:56 +0100
Subject: [PATCH 2/5] ARM: mm: make TTBR1 always point to swapper_pg_dir on
	ARMv6/7
In-Reply-To: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
References: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1305890399-29075-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch makes TTBR1 point to swapper_pg_dir so that global, kernel
mappings can be used exclusively on v6 and v7 cores where they are
needed.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/smp.h |    1 +
 arch/arm/kernel/head.S     |    7 +++++--
 arch/arm/kernel/smp.c      |    1 +
 arch/arm/mm/proc-v6.S      |    4 +++-
 arch/arm/mm/proc-v7.S      |    4 +++-
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 96ed521..be4b588 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -78,6 +78,7 @@ extern void platform_smp_prepare_cpus(unsigned int);
  */
 struct secondary_data {
 	unsigned long pgdir;
+	unsigned long swapper_pg_dir;
 	void *stack;
 };
 extern struct secondary_data secondary_data;
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index c9173cf..8224b1d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -113,6 +113,7 @@ ENTRY(stext)
 	ldr	r13, =__mmap_switched		@ address to jump to after
 						@ mmu has been enabled
 	adr	lr, BSYM(1f)			@ return (PIC) address
+	mov	r8, r4				@ set TTBR1 to swapper_pg_dir
  ARM(	add	pc, r10, #PROCINFO_INITFUNC	)
  THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
  THUMB(	mov	pc, r12				)
@@ -302,8 +303,10 @@ ENTRY(secondary_startup)
 	 */
 	adr	r4, __secondary_data
 	ldmia	r4, {r5, r7, r12}		@ address to jump to after
-	sub	r4, r4, r5			@ mmu has been enabled
-	ldr	r4, [r7, r4]			@ get secondary_data.pgdir
+	sub	lr, r4, r5			@ mmu has been enabled
+	ldr	r4, [r7, lr]			@ get secondary_data.pgdir
+	add	r7, r7, #4
+	ldr	r8, [r7, lr]			@ get secondary_data.swapper_pg_dir
 	adr	lr, BSYM(__enable_mmu)		@ return address
 	mov	r13, r12			@ __secondary_switched address
  ARM(	add	pc, r10, #PROCINFO_INITFUNC	) @ initialise processor
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index f29b8a2..10b5d55 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -105,6 +105,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
 	secondary_data.pgdir = virt_to_phys(pgd);
+	secondary_data.swapper_pg_dir = virt_to_phys(swapper_pg_dir);
 	__cpuc_flush_dcache_area(&secondary_data, sizeof(secondary_data));
 	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
 
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 7c99cb4..55ca716 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -218,7 +218,9 @@ __v6_setup:
 	mcr	p15, 0, r0, c2, c0, 2		@ TTB control register
 	ALT_SMP(orr	r4, r4, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r4, r4, #TTB_FLAGS_UP)
-	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
+	ALT_SMP(orr	r8, r8, #TTB_FLAGS_SMP)
+	ALT_UP(orr	r8, r8, #TTB_FLAGS_UP)
+	mcr	p15, 0, r8, c2, c0, 1		@ load TTB1
 #endif /* CONFIG_MMU */
 	adr	r5, v6_crval
 	ldmia	r5, {r5, r6}
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index babfba0..3c38678 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -368,7 +368,9 @@ __v7_setup:
 	mcr	p15, 0, r10, c2, c0, 2		@ TTB control register
 	ALT_SMP(orr	r4, r4, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r4, r4, #TTB_FLAGS_UP)
-	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
+	ALT_SMP(orr	r8, r8, #TTB_FLAGS_SMP)
+	ALT_UP(orr	r8, r8, #TTB_FLAGS_UP)
+	mcr	p15, 0, r8, c2, c0, 1		@ load TTB1
 	ldr	r5, =PRRR			@ PRRR
 	ldr	r6, =NMRR			@ NMRR
 	mcr	p15, 0, r5, c10, c2, 0		@ write PRRR
-- 
1.7.0.4
