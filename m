From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 May 2015 09:12:59 +0200
Subject: [PATCH 01/10] arm64/efi: use dynamically allocated space for EFI pgd
In-Reply-To: <1431328388-3051-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1431328388-3051-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1431328388-3051-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we populate the EFI page tables during an initcall, we
can allocate the root pgd dynamically instead of statically in .bss.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 5369b4f96dd1..f3ba25621f7a 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -32,17 +32,15 @@
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/mmu.h>
+#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
 struct efi_memory_map memmap;
 
 static u64 efi_system_table;
 
-static pgd_t efi_pgd[PTRS_PER_PGD] __page_aligned_bss;
-
 static struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
-	.pgd			= efi_pgd,
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
 	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
@@ -227,6 +225,10 @@ static bool __init efi_virtmap_init(void)
 {
 	efi_memory_desc_t *md;
 
+	efi_mm.pgd = pgd_alloc(&efi_mm);
+	if (!efi_mm.pgd)
+		return false;
+
 	for_each_efi_memory_desc(&memmap, md) {
 		u64 paddr, npages, size;
 		pgprot_t prot;
@@ -313,7 +315,7 @@ static int __init arm64_enable_runtime_services(void)
 
 	return 0;
 }
-early_initcall(arm64_enable_runtime_services);
+postcore_initcall(arm64_enable_runtime_services);
 
 static int __init arm64_dmi_init(void)
 {
-- 
1.9.1
