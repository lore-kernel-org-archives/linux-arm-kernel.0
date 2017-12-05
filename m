From: julien.thierry@arm.com (Julien Thierry)
Date: Tue,  5 Dec 2017 17:38:27 +0000
Subject: [PATCH] arm64/mm: Do not write ASID generation to ttbr0
Message-ID: <1512495507-23259-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When writing the user ASID to ttbr0, 16bit get copied to ttbr0, potentially
including part of the ASID generation in the ttbr0.ASID. If the kernel is
using less than 16bits ASIDs and the other ttbr0 bits aren't RES0, two
tasks using the same mm context might end up running with different
ttbr0.ASID values.
This would be triggered by one of the threads being scheduled before a
roll-over and the second one scheduled after a roll-over.

Pad the generation out of the 16bits of the mm id that are written to
ttbr0. Thus, what the hardware sees is what the kernel considers ASID.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Reported-by: Will Deacon <will.deacon@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm64/include/asm/mmu.h |  8 +++++++-
 arch/arm64/mm/context.c      | 21 +++++++++++++++++++--
 arch/arm64/mm/proc.S         |  3 ++-
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 0d34bf0..61e5436 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -16,6 +16,10 @@
 #ifndef __ASM_MMU_H
 #define __ASM_MMU_H

+#define ASID_MAX_BITS	16
+
+#ifndef __ASSEMBLY__
+
 #define MMCF_AARCH32	0x1	/* mm context flag for AArch32 executables */

 typedef struct {
@@ -29,7 +33,8 @@
  * ASID change and therefore doesn't need to reload the counter using
  * atomic64_read.
  */
-#define ASID(mm)	((mm)->context.id.counter & 0xffff)
+#define ASID(mm)							\
+	((mm)->context.id.counter & GENMASK(ASID_MAX_BITS - 1, 0))

 extern void paging_init(void);
 extern void bootmem_init(void);
@@ -41,4 +46,5 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 extern void mark_linear_text_alias_ro(void);

+#endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 6f40170..a7c72d4 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -37,9 +37,9 @@
 static DEFINE_PER_CPU(u64, reserved_asids);
 static cpumask_t tlb_flush_pending;

+#define ASID_FIRST_VERSION	(1UL << ASID_MAX_BITS)
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
-#define ASID_FIRST_VERSION	(1UL << asid_bits)
-#define NUM_USER_ASIDS		ASID_FIRST_VERSION
+#define NUM_USER_ASIDS		(1UL << asid_bits)

 /* Get the ASIDBits supported by the current CPU */
 static u32 get_cpu_asid_bits(void)
@@ -60,6 +60,8 @@ static u32 get_cpu_asid_bits(void)
 		asid = 16;
 	}

+	WARN_ON(asid > ASID_MAX_BITS);
+
 	return asid;
 }

@@ -142,6 +144,14 @@ static bool check_update_reserved_asid(u64 asid, u64 newasid)
 	return hit;
 }

+/*
+ * Format of ASID is:
+ * - bits <asid_bits - 1>.. 0 -> actual ASID
+ * - bits 63..16 -> ASID generation
+ *
+ * Generation is padded to the maximum supported ASID size
+ * to avoid it being taken into account in the ttbr.
+ */
 static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 {
 	static u32 cur_idx = 1;
@@ -180,6 +190,13 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 	/* We're out of ASIDs, so increment the global generation count */
 	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION,
 						 &asid_generation);
+
+	/*
+	 * It is unlikely the generation will ever overflow, but if this
+	 * happens, let it be known strange things can occur.
+	 */
+	WARN_ON(generation == ASID_FIRST_VERSION);
+
 	flush_context(cpu);

 	/* We have more ASIDs than CPUs, so this will always succeed */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 95233df..33c7f13 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -23,6 +23,7 @@
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
+#include <asm/mmu.h>
 #include <asm/pgtable.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/cpufeature.h>
@@ -140,7 +141,7 @@ ENDPROC(cpu_do_resume)
 ENTRY(cpu_do_switch_mm)
 	pre_ttbr0_update_workaround x0, x2, x3
 	mmid	x1, x1				// get mm->context.id
-	bfi	x0, x1, #48, #16		// set the ASID
+	bfi	x0, x1, #48, #ASID_MAX_BITS	// set the ASID
 	msr	ttbr0_el1, x0			// set TTBR0
 	isb
 	post_ttbr0_update_workaround
--
1.9.1
