From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Mar 2015 15:43:00 +0000
Subject: [PATCH] arm64: efi: don't restore TTBR0 if active_mm points at init_mm
Message-ID: <1426779780-4706-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

init_mm isn't a normal mm: it has swapper_pg_dir as its pgd (which
contains kernel mappings) and is used as the active_mm for the idle
thread.

When restoring the pgd after an EFI call, we write current->active_mm
into TTBR0. If the current task is actually the idle thread (e.g. when
initialising the EFI RTC before entering userspace), then the TLB can
erroneously populate itself with junk global entries as a result of
speculative table walks.

When we do eventually return to userspace, the task can end up hitting
these junk mappings leading to lockups, corruption or crashes.

This patch fixes the problem in the same way as the CPU suspend code by
ensuring that we never switch to the init_mm in efi_set_pgd and instead
point TTBR0 at the zero page. A check is also added to cpu_switch_mm to
BUG if we get passed swapper_pg_dir.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Fixes: f3cdfd239da5 ("arm64/efi: move SetVirtualAddressMap() to UEFI stub")
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

This patch gets armhf Debian booting again on my Juno (I guess 64-bit
userspace tends to use virtual addresses that are high enough to avoid
hitting the junk TLB entries!).

 arch/arm64/include/asm/proc-fns.h | 6 +++++-
 arch/arm64/kernel/efi.c           | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 9a8fd84f8fb2..941c375616e2 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -39,7 +39,11 @@ extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
 #include <asm/memory.h>
 
-#define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
+#define cpu_switch_mm(pgd,mm)				\
+do {							\
+	BUG_ON(pgd == swapper_pg_dir);			\
+	cpu_do_switch_mm(virt_to_phys(pgd),mm);		\
+} while (0)
 
 #define cpu_get_pgd()					\
 ({							\
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 2b8d70164428..ab21e0d58278 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -337,7 +337,11 @@ core_initcall(arm64_dmi_init);
 
 static void efi_set_pgd(struct mm_struct *mm)
 {
-	cpu_switch_mm(mm->pgd, mm);
+	if (mm == &init_mm)
+		cpu_set_reserved_ttbr0();
+	else
+		cpu_switch_mm(mm->pgd, mm);
+
 	flush_tlb_all();
 	if (icache_is_aivivt())
 		__flush_icache_all();
-- 
2.1.4
