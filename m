From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Oct 2015 14:40:58 +0100
Subject: [PATCH 2/3] arm64: reimplement page_is_ram() using memblock and UEFI
 memory map
In-Reply-To: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1446126059-25336-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch overrides the __weak default implementation of page_is_ram(),
which uses string comparisons to find entries called 'System RAM' in
/proc/iomem. Since we used the contents of memblock to create those entries
in the first place, let's use memblock directly.

Also, since the UEFI memory map may describe regions backed by RAM that are
not in memblock (i.e., reserved regions that were removed from the linear
mapping), check the pfn against the UEFI memory map as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c2fa6b56613c..737bfaecb489 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -19,6 +19,7 @@
 
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/efi.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/libfdt.h>
@@ -31,6 +32,7 @@
 #include <linux/stop_machine.h>
 
 #include <asm/cputype.h>
+#include <asm/efi.h>
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/sections.h>
@@ -743,3 +745,35 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 
 	return dt_virt;
 }
+
+/*
+ * On a UEFI system, the memory map may describe regions that are backed by
+ * memory, but are not covered by the linear mapping and so are not listed as
+ * 'System RAM' in /proc/iomem, which is what the default __weak implementation
+ * of page_is_ram looks for. So check the UEFI memory map as well if the pfn is
+ * not covered by memblock.
+ */
+int page_is_ram(unsigned long pfn)
+{
+	u64 addr = PFN_PHYS(pfn);
+	efi_memory_desc_t *md;
+
+	if (memblock_is_memory(addr))
+		return 1;
+
+	if (!efi_enabled(EFI_MEMMAP))
+		return 0;
+
+	/*
+	 * A pfn could intersect multiple regions in the UEFI memory map if the
+	 * OS page size exceeds 4 KB. However, the UEFI spec explicitly forbids
+	 * mixed attribute mappings within the same 64 KB page frame so just use
+	 * the region that intersects the page address.
+	 */
+	for_each_efi_memory_desc(&memmap, md)
+		if (md->phys_addr <= addr &&
+		    (addr - md->phys_addr) < (md->num_pages << EFI_PAGE_SHIFT))
+			return !!(md->attribute & EFI_MEMORY_WB);
+
+	return 0;
+}
-- 
2.1.4
