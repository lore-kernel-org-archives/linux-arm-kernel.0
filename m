From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 May 2014 17:50:37 +0200
Subject: [RFC PATCHv1 3/7] ARM: mm: enable SMP bit and TLB broadcast bit on
 !SMP when needed
In-Reply-To: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400082641-23871-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Cortex-A9 systems, configured in !SMP, proc-v7.S does not set the
SMP bit and the TLB broadcast bit. However, these are needed to use
the shareable attribute on page tables, which in turn is needed for
certain systems that provide hardware I/O coherency.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mm/mmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ad6557e..6929e67 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -539,6 +539,22 @@ static void __init build_mem_type_table(const struct machine_desc *mdesc)
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 #endif
 
+		/*
+		 * On Cortex-A9 systems, configured in !SMP, proc-v7.S
+		 * has not set the SMP bit and the TLB broadcast
+		 * bit. However, these are needed to use the shareable
+		 * attribute on page tables, which in turn is needed
+		 * for certain systems that provide hardware I/O
+		 * coherency.
+		 */
+		if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9 &&
+		    !is_smp() && (mdesc->flags & MACHINE_NEEDS_SHAREABLE_PAGES)) {
+			u32 reg;
+			asm("mrc p15, 0, %0, c1, c0, 1" : "=r" (reg));
+			reg |= (1 << 6) | (1 << 0);
+			asm("mcr p15, 0, %0, c1, c0, 1" : : "r" (reg));
+		}
+
 		if (is_smp() || (mdesc->flags & MACHINE_NEEDS_SHAREABLE_PAGES)) {
 			/*
 			 * Mark memory with the "shared" attribute
-- 
1.9.3
