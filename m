From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Sep 2015 17:55:29 +0200
Subject: [PATCH 3/3] arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP
In-Reply-To: <1442246129-13930-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442246129-13930-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1442246129-13930-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the EFI memory reservation logic to use memblock_mark_nomap()
rather than memblock_reserve() to mark UEFI reserved regions as
occupied. In addition to reserving them against allocations done by
memblock, this will also prevent them from being covered by the linear
mapping.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index e8ca6eaedd02..f609325c4a83 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -193,7 +193,7 @@ static __init void reserve_regions(void)
 			early_init_dt_add_memory_arch(paddr, size);
 
 		if (is_reserve_region(md)) {
-			memblock_reserve(paddr, size);
+			memblock_mark_nomap(paddr, size);
 			if (uefi_debug)
 				pr_cont("*");
 		}
@@ -215,8 +215,6 @@ void __init efi_init(void)
 
 	efi_system_table = params.system_table;
 
-	memblock_reserve(params.mmap & PAGE_MASK,
-			 PAGE_ALIGN(params.mmap_size + (params.mmap & ~PAGE_MASK)));
 	memmap.phys_map = (void *)params.mmap;
 	memmap.map = early_memremap(params.mmap, params.mmap_size);
 	memmap.map_end = memmap.map + params.mmap_size;
@@ -228,6 +226,7 @@ void __init efi_init(void)
 
 	reserve_regions();
 	early_memunmap(memmap.map, params.mmap_size);
+	memblock_mark_nomap(params.mmap, params.mmap_size);
 }
 
 static bool __init efi_virtmap_init(void)
-- 
1.9.1
