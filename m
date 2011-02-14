From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Feb 2011 17:39:53 +0000
Subject: [RFC PATCH 1/2] ARMv7: Use a reserved TTB rather than ASID 0 during
	context switch
Message-ID: <20110214173953.21717.36145.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer processors like Cortex-A15 may cache entries in the higher page
table levels. These cached entries are ASID-tagged and are invalidated
during normal TLB operations.

When using the reserved ASID 0 during a context switch, the processor
may cache an entry from the first level of page tables and tag it with
ASID 0. Later the corresponding first level entry may no longer be valid
(e.g. second level table freed) but the TLB invalidation is done by the
ASID of the corresponding mm structure and not ASID 0. During a
subsequent context switch, the stale level 1 ASID 0 cached entry may be
used to speculatively fetch a TLB entry. If the level 2 page table it
points to contains random data (page freed as the previous process had
been removed) it could create a global TLB entry which is no longer ASID
tagged. This entry is then used in subsequent user space processes.

This patch uses one of the other methods specified in the ARM ARM for
the context switch sequence. It uses the swapper_pg_dir as it only
contains global (kernel) mappings.

Reported-by: Tony Thompson <anthony.thompson@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/head.S |    3 +++
 arch/arm/mm/proc-v7.S  |   11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index c0225da..cc08f1b 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -48,6 +48,9 @@
 	.globl	swapper_pg_dir
 	.equ	swapper_pg_dir, KERNEL_RAM_VADDR - 0x4000
 
+	.globl	swapper_pg_dir_phys
+	.equ	swapper_pg_dir_phys, KERNEL_RAM_PADDR - 0x4000
+
 	.macro	pgtbl, rd
 	ldr	\rd, =(KERNEL_RAM_PADDR - 0x4000)
 	.endm
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 0c1172b..38d6436 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -101,19 +101,22 @@ ENDPROC(cpu_v7_dcache_clean_area)
  */
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
-	mov	r2, #0
 	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
+	ldr	r3, =swapper_pg_dir_phys	@ prepare global-only TTB 0
 	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)
+	ALT_SMP(orr	r3, r3, #TTB_FLAGS_SMP)
+	ALT_UP(orr	r3, r3, #TTB_FLAGS_UP)
 #ifdef CONFIG_ARM_ERRATA_430973
+	mov	r2, #0
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
 #endif
-	mcr	p15, 0, r2, c13, c0, 1		@ set reserved context ID
-	isb
-1:	mcr	p15, 0, r0, c2, c0, 0		@ set TTB 0
+	mcr	p15, 0, r3, c2, c0, 0		@ set global-only TTB 0
 	isb
 	mcr	p15, 0, r1, c13, c0, 1		@ set context ID
 	isb
+	mcr	p15, 0, r0, c2, c0, 0		@ set TTB 0
+	isb
 #endif
 	mov	pc, lr
 ENDPROC(cpu_v7_switch_mm)
