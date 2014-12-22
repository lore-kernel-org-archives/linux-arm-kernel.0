From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Dec 2014 19:08:40 +0000
Subject: [PATCH 6/8] arm64/efi: register physmem in reserve_regions()
In-Reply-To: <1419275322-29811-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1419275322-29811-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1419275322-29811-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After traversing the UEFI memory map to discover the regions that are backed
by normal RAM, register the resulting minimal memory map into the physmem
memblock table.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index ba5fe66c3634..b1b816ecf3b3 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -155,6 +155,7 @@ static __init void reserve_regions(void)
 {
 	efi_memory_desc_t *md;
 	u64 paddr, npages, size;
+	struct memblock_region *r;
 
 	if (uefi_debug)
 		pr_info("Processing EFI memory map:\n");
@@ -187,6 +188,14 @@ static __init void reserve_regions(void)
 			pr_cont("\n");
 	}
 
+	/*
+	 * After memblock has stitched all the regions together, copy the
+	 * resulting map of physical memory from the memory memblock table into
+	 * the physmem memblock table.
+	 */
+	for_each_memblock(memory, r)
+		memblock_add_phys(r->base, r->size);
+
 	set_bit(EFI_MEMMAP, &efi.flags);
 }
 
-- 
1.8.3.2
