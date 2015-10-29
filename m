From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Oct 2015 14:40:59 +0100
Subject: [PATCH 3/3] arm64/efi: memblock_remove() rather than _reserve UEFI
 reserved memory
In-Reply-To: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1446126059-25336-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory regions that are not advertised as being available for general use
to the kernel should either never be mapped at all (EfiReservedMemory),
since it should not even be accessed speculatively, or they are mapped
and unmapped explicitly when used (UEFI runtime services regions), so
the linear mapping is never used anyway.

This means we are better off removing these regions from the linear
mapping entirely, so memblock_remove() rather than memblock_reserve()
them.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 22 +++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 11b59e9a5954..daafa40d1c19 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -171,7 +171,7 @@ static __init void reserve_regions(void)
 		if (efi_enabled(EFI_DBG)) {
 			char buf[64];
 
-			pr_info("  0x%012llx-0x%012llx %s",
+			pr_info("  0x%012llx-0x%012llx %s\n",
 				paddr, paddr + (npages << EFI_PAGE_SHIFT) - 1,
 				efi_md_typeattr_format(buf, sizeof(buf), md));
 		}
@@ -181,15 +181,17 @@ static __init void reserve_regions(void)
 
 		if (is_normal_ram(md))
 			early_init_dt_add_memory_arch(paddr, size);
+	}
 
-		if (is_reserve_region(md)) {
-			memblock_reserve(paddr, size);
-			if (efi_enabled(EFI_DBG))
-				pr_cont("*");
-		}
+	for_each_efi_memory_desc(&memmap, md) {
+		paddr = md->phys_addr;
+		npages = md->num_pages;
+
+		memrange_efi_to_native(&paddr, &npages);
+		size = npages << PAGE_SHIFT;
 
-		if (efi_enabled(EFI_DBG))
-			pr_cont("\n");
+		if (is_reserve_region(md))
+			memblock_remove(paddr, size);
 	}
 }
 
@@ -203,8 +205,6 @@ void __init efi_init(void)
 
 	efi_system_table = params.system_table;
 
-	memblock_reserve(params.mmap & PAGE_MASK,
-			 PAGE_ALIGN(params.mmap_size + (params.mmap & ~PAGE_MASK)));
 	memmap.phys_map = (void *)params.mmap;
 	memmap.map = early_memremap(params.mmap, params.mmap_size);
 	memmap.map_end = memmap.map + params.mmap_size;
@@ -216,6 +216,8 @@ void __init efi_init(void)
 
 	reserve_regions();
 	early_memunmap(memmap.map, params.mmap_size);
+	memblock_remove(params.mmap & PAGE_MASK,
+			PAGE_ALIGN(params.mmap_size + (params.mmap & ~PAGE_MASK)));
 }
 
 static void __init efi_reserve_iomem_resource(efi_memory_desc_t *md)
-- 
2.1.4
