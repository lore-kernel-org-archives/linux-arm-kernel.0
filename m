From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 16 Jan 2015 18:24:39 -0800
Subject: [RFC][PATCH] arm64: efi: Obey EFI memory type in dmi_remap
Message-ID: <1421461479-31608-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, dmi_remap unconditionally calls ioremap_cache for dmi_remap.
The memory that's being remapped may be part of the existing EFI
memory map and already remapped as uncached. Remapping as cached can
created unexpected behavior so check the physical address against the
EFI memory type before remapping.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
Actual bug, not just theoretical problem. I'm marking this as RFC
because I'm not sure what any kind of specificaiton may have to say.
---
 arch/arm64/include/asm/dmi.h |  5 +++--
 arch/arm64/kernel/efi.c      | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
index 69d37d8..f0cc8d0 100644
--- a/arch/arm64/include/asm/dmi.h
+++ b/arch/arm64/include/asm/dmi.h
@@ -22,9 +22,10 @@
  * request a virtual mapping for configuration tables such as SMBIOS.
  * This means we have to map them before use.
  */
-#define dmi_early_remap(x, l)		ioremap_cache(x, l)
+#define dmi_early_remap(x, l)		dmi_remap(x, l)
 #define dmi_early_unmap(x, l)		iounmap(x)
-#define dmi_remap(x, l)			ioremap_cache(x, l)
+
+extern void __iomem *dmi_remap(phys_addr_t phys_addr, size_t size);
 #define dmi_unmap(x)			iounmap(x)
 #define dmi_alloc(l)			kzalloc(l, GFP_KERNEL)
 
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 82f27c3..139666e 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 
 #include <asm/cacheflush.h>
+#include <asm/io.h>
 #include <asm/efi.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -321,6 +322,28 @@ void __init efi_init(void)
 	reserve_regions();
 }
 
+static bool is_phys_addr_normal_ram(unsigned long phys_addr)
+{
+	efi_memory_desc_t *md;
+
+	for_each_efi_memory_desc(&memmap, md) {
+		if ((md->phys_addr <= phys_addr) &&
+		    (phys_addr < (md->phys_addr +
+				  (md->num_pages << EFI_PAGE_SHIFT))))
+			return is_normal_ram(md);
+	}
+	return false;
+}
+
+void __iomem *dmi_remap(phys_addr_t phys_addr, size_t size)
+{
+	if (is_phys_addr_normal_ram(phys_addr))
+		return ioremap_cache(phys_addr, size);
+	else
+		return ioremap(phys_addr, size);
+}
+
+
 void __init efi_idmap_init(void)
 {
 	if (!efi_enabled(EFI_BOOT))
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
