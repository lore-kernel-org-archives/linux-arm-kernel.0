From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:45 +0000
Subject: [RFC PATCH 10/20] arm64: mm: add code to safely replace TTBR1_EL1
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-11-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If page tables are modified without suitable TLB maintenance, the ARM
architecture permits multiple TLB entries to be allocated for the same
VA. When this occurs, it is permitted that TLB conflict aborts are
raised in response to synchronous data/instruction accesses, and/or and
amalgamation of the TLB entries may be used as a result of a TLB lookup.

The presence of conflicting TLB entries may result in a variety of
behaviours detrimental to the system (e.g. erroneous physical addresses
may be used by I-cache fetches and/or page table walks). Some of these
cases may result in unexpected changes of hardware state, and/or result
in the (asynchronous) delivery of SError.

To avoid these issues, we must avoid situations where conflicting
entries may be allocated into TLBs. For user and module mappings we can
follow a strict break-before-make approach, but this cannot work for
modifications to the swapper page tables that cover the kernel text and
data.

Instead, this patch adds code which is intended to be executed from the
idmap, which can safely unmap the swapper page tables as it only
requires the idmap to be active. This enables us to uninstall the active
TTBR1_EL1 entry, invalidate TLBs, then install a new TTBR1_EL1 entry
without potentially unmapping code or data required for the sequence.
This avoids the risk of conflict, but requires that updates are staged
in a copy of the swapper page tables prior to being installed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 20 ++++++++++++++++++++
 arch/arm64/mm/proc.S                 | 27 +++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 944f273..280ce2e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -127,6 +127,26 @@ static inline void cpu_install_idmap(void)
 }
 
 /*
+ * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
+ * avoiding the possibility of conflicting TLB entries being allocated.
+ */
+static inline void cpu_replace_ttbr1(pgd_t *pgd)
+{
+	typedef void (ttbr_replace_func)(phys_addr_t, phys_addr_t);
+	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
+	ttbr_replace_func *replace_phys;
+
+	phys_addr_t pgd_phys = virt_to_phys(pgd);
+	phys_addr_t reserved_phys = virt_to_phys(empty_zero_page);
+
+	replace_phys = (void*)virt_to_phys(idmap_cpu_replace_ttbr1);
+
+	cpu_install_idmap();
+	replace_phys(pgd_phys, reserved_phys);
+	cpu_uninstall_idmap();
+}
+
+/*
  * It would be nice to return ASIDs back to the allocator, but unfortunately
  * that introduces a race with a generation rollover where we could erroneously
  * free an ASID allocated in a future generation. We could workaround this by
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index cacecc4..d97c461 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -139,6 +139,33 @@ ENTRY(cpu_do_switch_mm)
 	ret
 ENDPROC(cpu_do_switch_mm)
 
+	.pushsection ".idmap.text", "ax"
+/*
+ * void idmap_cpu_replace_ttbr1(phys_addr_t new_pgd, phys_addr_t reserved_pgd)
+ *
+ * This is the low-level counterpart to cpu_replace_ttbr1, and should not be
+ * called by anything else. It can only be executed from a TTBR0 mapping.
+ */
+ENTRY(idmap_cpu_replace_ttbr1)
+	mrs	x2, daif
+	msr	daifset, #0xf
+
+	msr	ttbr1_el1, x1
+	isb
+
+	tlbi	vmalle1
+	dsb	nsh
+	isb
+
+	msr	ttbr1_el1, x0
+	isb
+
+	msr	daif, x2
+
+	ret
+ENDPROC(idmap_cpu_replace_ttbr1)
+	.popsection
+
 	.section ".text.init", #alloc, #execinstr
 
 /*
-- 
1.9.1
