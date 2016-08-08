From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  8 Aug 2016 11:10:50 +0100
Subject: [PATCH] arm64: suspend: avoid potential TLB conflict
Message-ID: <1470651050-18291-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In create_safe_exec_page we install a set of global mappings in TTBR0,
then subsequently invalidate TLBs. While TTBR0 points at the zero page,
and the TLBs should be free of stale global entries, we may have stale
ASID-tagged entries (e.g. from the EFI runtime services mappings) for
the same VAs. Per the ARM ARM these ASID-tagged entries may conflict
with newly-allocated global entries, and we must follow a
Break-Before-Make approach to avoid issues resulting from this.

This patch reworks create_safe_exec_page to invalidate TLBs while the
zero page is still in place, ensuring that there are no potential
conflicts when the new TTBR0 value is installed. As a single CPU is
online while this code executes, we do not need to perform broadcast TLB
maintenance, and can call local_flush_tlb_all(), which also subsumes
some barriers. The remaining assembly is converted to use write_sysreg()
and isb().

Other than this, we safely manipulate TTBRs in the hibernate dance. The
code we install as part of the new TTBR0 mapping (the hibernated
kernel's swsusp_arch_suspend_exit) installs a zero page into TTBR1,
invalidates TLBs, then installs its preferred value. Upon being restored
to the middle of swsusp_arch_suspend, the new image will call
__cpu_suspend_exit, which will call cpu_uninstall_idmap, installing the
zero page in TTBR0 and invalidating all TLB entries.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 82869ac57b5d3b55 ("arm64: kernel: Add support for hibernate/suspend-to-disk")
---
 arch/arm64/kernel/hibernate.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 21ab5df..c59d3e4 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -35,6 +35,7 @@
 #include <asm/sections.h>
 #include <asm/smp.h>
 #include <asm/suspend.h>
+#include <asm/sysreg.h>
 #include <asm/virt.h>
 
 /*
@@ -217,12 +218,16 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	set_pte(pte, __pte(virt_to_phys((void *)dst) |
 			 pgprot_val(PAGE_KERNEL_EXEC)));
 
-	/* Load our new page tables */
-	asm volatile("msr	ttbr0_el1, %0;"
-		     "isb;"
-		     "tlbi	vmalle1is;"
-		     "dsb	ish;"
-		     "isb" : : "r"(virt_to_phys(pgd)));
+	/*
+	 * Load our new page tables. TTBR0 currently points to the zero page,
+	 * and the TLBs should be free of global entries, but may contain stale
+	 * ASID-tagged entries (e.g. from the EFI runtime services). A strict
+	 * BBM approach requires that we destroy these before installing
+	 * overlapping global mappings.
+	 */
+	local_flush_tlb_all();
+	write_sysreg(virt_to_phys(pgd), ttbr0_el1);
+	isb();
 
 	*phys_dst_addr = virt_to_phys((void *)dst);
 
-- 
1.9.1
