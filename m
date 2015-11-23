From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 Nov 2015 11:09:11 +0000
Subject: [PATCHv3] arm64: efi: correctly map runtime regions
Message-ID: <1448276951-13335-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel may use a page granularity of 4K, 16K, or 64K depending on
configuration.

When mapping EFI runtime regions, we use memrange_efi_to_native to round
the physical base address of a region down to a kernel page boundary,
and round the size up to a kernel page boundary, adding the residue left
over from rounding down the physical base address. We do not round down
the virtual base address.

In __create_mapping we account for the offset of the virtual base from a
granule boundary, adding the residue to the size before rounding the
base down to said granule boundary.

Thus we account for the residue twice, and when the residue is non-zero
will cause __create_mapping to map an additional page at the end of the
region. Depending on the memory map, this page may be in a region we are
not intended/permitted to map, or may clash with a different region that
we wish to map. In typical cases, mapping the next item in the memory
map will overwrite the erroneously created entry, as we sort the memory
map in the stub.

As __create_mapping can cope with base addresses which are not page
aligned, we can instead rely on it to map the region appropriately, and
simplify efi_virtmap_init by removing the unnecessary code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/efi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Since v1 [1]:
* Rely on create_pgd_mapping to handle alignment.
Since v2 [2]:
* Describe why this case is unlikely in practice.
* Calculate size in create_pgd_mapping_call.
* Rebase to v4.4-rc2, avoiding clash with [3].

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386536.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386908.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/385524.html

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index fc5508e..fe7cd1a 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -227,7 +227,6 @@ static bool __init efi_virtmap_init(void)
 	init_new_context(NULL, &efi_mm);
 
 	for_each_efi_memory_desc(&memmap, md) {
-		u64 paddr, npages, size;
 		pgprot_t prot;
 
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
@@ -235,11 +234,6 @@ static bool __init efi_virtmap_init(void)
 		if (md->virt_addr == 0)
 			return false;
 
-		paddr = md->phys_addr;
-		npages = md->num_pages;
-		memrange_efi_to_native(&paddr, &npages);
-		size = npages << PAGE_SHIFT;
-
 		pr_info("  EFI remap 0x%016llx => %p\n",
 			md->phys_addr, (void *)md->virt_addr);
 
@@ -256,7 +250,8 @@ static bool __init efi_virtmap_init(void)
 		else
 			prot = PAGE_KERNEL;
 
-		create_pgd_mapping(&efi_mm, paddr, md->virt_addr, size,
+		create_pgd_mapping(&efi_mm, md->phys_addr, md->virt_addr,
+				   md->num_pages << EFI_PAGE_SHIFT, 
 				   __pgprot(pgprot_val(prot) | PTE_NG));
 	}
 	return true;
-- 
1.9.1
