From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Nov 2015 17:37:36 +0000
Subject: [PATCH] arm64: efi: correctly align vaddr for runtime maps
Message-ID: <1447954656-10435-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel may use a page granularity of 4K, 16K, or 64K depending on
configuration.

When mapping EFI runtime regions, we use memrange_efi_to_native to round
the physical base address of a region down to a granule-aligned
boundary, and round the size up to a granule-aligned boundary. However,
we fail to similarly round the virtual base address down to a
granule-aligned boundary.

The virtual base address may be up to PAGE_SIZE - 4K above what it
should be, and in create_pgd_mapping, we may erroneously map an
additional page at the end of any region which does not have a
granule-aligned virtual base address.

Depending on the memory map, this page may be in a region we are not
intended/permitted to map, or may clash with a different region that we
wich to map.

Prevent this issue by rounding the virtual base address down to the
kernel page granularity, matching what we do for the physical base
address.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/efi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

I spotted this by playing with Will's break-before-make checker [1], which
detected an erroneously created PTE being overwritten with a different output
address.

It looks like the VA bug was introduced in commit f3cdfd239da56a4c ("arm64/efi:
move SetVirtualAddressMap() to UEFI stub").

Prior to commit 60305db9884515ca ("arm64/efi: move virtmap init to early
initcall") so manual fixup is required, but the logic fix is the same.

Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=aarch64/devel&id=372f39220ad35fa39a75419f2221ffeb6ffd78d3

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index de46b50..7855b69 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -225,7 +225,7 @@ static bool __init efi_virtmap_init(void)
 	efi_memory_desc_t *md;
 
 	for_each_efi_memory_desc(&memmap, md) {
-		u64 paddr, npages, size;
+		u64 paddr, vaddr, npages, size;
 		pgprot_t prot;
 
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
@@ -237,6 +237,8 @@ static bool __init efi_virtmap_init(void)
 		npages = md->num_pages;
 		memrange_efi_to_native(&paddr, &npages);
 		size = npages << PAGE_SHIFT;
+		vaddr = md->virt_addr;
+		vaddr &= PAGE_MASK;
 
 		pr_info("  EFI remap 0x%016llx => %p\n",
 			md->phys_addr, (void *)md->virt_addr);
@@ -254,7 +256,7 @@ static bool __init efi_virtmap_init(void)
 		else
 			prot = PAGE_KERNEL;
 
-		create_pgd_mapping(&efi_mm, paddr, md->virt_addr, size, prot);
+		create_pgd_mapping(&efi_mm, paddr, vaddr, size, prot);
 	}
 	return true;
 }
-- 
1.9.1
