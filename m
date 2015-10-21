From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 21 Oct 2015 16:26:42 +0100
Subject: [PATCH] arm64: kernel: fix tcr_el1.t0sz restore on systems with
 extended idmap
Message-ID: <1445441202-21484-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit dd006da21646 ("arm64: mm: increase VA range of identity map")
introduced a mechanism to extend the virtual memory map range
to support arm64 systems with system RAM located at very high offset,
where the identity mapping used to enable/disable the MMU requires
additional translation levels to map the physical memory at an equal
virtual offset.

The kernel detects at boot time the tcr_el1.t0sz value required by the
identity mapping and sets-up the tcr_el1.t0sz register field accordingly,
any time the identity map is required in the kernel (ie when enabling the
MMU).

After enabling the MMU, in the cold boot path the kernel resets the
tcr_el1.t0sz to its default value (ie the actual configuration value for
the system virtual address space) so that after enabling the MMU the
memory space translated by ttbr0_el1 is restored as expected.

Commit dd006da21646 ("arm64: mm: increase VA range of identity map")
also added code to set-up the tcr_el1.t0sz value when the kernel resumes
from low-power states with the MMU off through cpu_resume() in order to
effectively use the identity mapping to enable the MMU but failed to add
the code required to restore the tcr_el1.t0sz to its default value, when
the core returns to the kernel with the MMU enabled, so that the kernel
might end up running with tcr_el1.t0sz value set-up for the identity
mapping which can be lower than the value required by the actual virtual
address space, resulting in an erroneous set-up.

This patchs adds code in the resume path that restores the tcr_el1.t0sz
default value upon core resume, mirroring this way the cold boot path
behaviour therefore fixing the issue.

Fixes: 95322526ef62 ("arm64: kernel: cpu_{suspend/resume} implementation")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/suspend.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 8297d50..44ca414 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -80,17 +80,21 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	if (ret == 0) {
 		/*
 		 * We are resuming from reset with TTBR0_EL1 set to the
-		 * idmap to enable the MMU; restore the active_mm mappings in
-		 * TTBR0_EL1 unless the active_mm == &init_mm, in which case
-		 * the thread entered cpu_suspend with TTBR0_EL1 set to
-		 * reserved TTBR0 page tables and should be restored as such.
+		 * idmap to enable the MMU; set the TTBR0 to the reserved
+		 * page tables to prevent speculative TLB allocations, flush
+		 * the local tlb and set the default tcr_el1.t0sz so that
+		 * the TTBR0 address space set-up is properly restored.
+		 * If the current active_mm != &init_mm we entered cpu_suspend
+		 * with mappings in TTBR0 that must be restored, so we switch
+		 * them back to complete the address space configuration
+		 * restoration before returning.
 		 */
-		if (mm == &init_mm)
-			cpu_set_reserved_ttbr0();
-		else
-			cpu_switch_mm(mm->pgd, mm);
-
+		cpu_set_reserved_ttbr0();
 		flush_tlb_all();
+		cpu_set_default_tcr_t0sz();
+
+		if (mm != &init_mm)
+			cpu_switch_mm(mm->pgd, mm);
 
 		/*
 		 * Restore per-cpu offset before any kernel
-- 
2.5.1
