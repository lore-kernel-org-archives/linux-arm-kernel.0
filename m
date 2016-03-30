From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 18:38:49 +0200
Subject: [PATCH v2 1/5] ARM: efi: apply strict permissons for UEFI Runtime
 Services regions
In-Reply-To: <1459355933-13529-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459355933-13529-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459355933-13529-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent UEFI versions expose permission attributes for runtime services
memory regions, either in the UEFI memory map or in the separate memory
attributes table.  This allows the kernel to map these regions with
stricter permissions, rather than the RWX permissions that are used by
default. So wire this up in our mapping routine.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/efi.h |  1 +
 arch/arm/kernel/efi.c      | 41 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index e0eea72deb87..b0c341d7ceee 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -22,6 +22,7 @@
 void efi_init(void);
 
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
+int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define efi_call_virt(f, ...)						\
 ({									\
diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
index ff8a9d8acfac..9f43ba012d10 100644
--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -11,6 +11,41 @@
 #include <asm/mach/map.h>
 #include <asm/mmu_context.h>
 
+static int __init set_permissions(pte_t *ptep, pgtable_t token,
+				  unsigned long addr, void *data)
+{
+	efi_memory_desc_t *md = data;
+	pte_t pte = *ptep;
+
+	if (md->attribute & EFI_MEMORY_RO)
+		pte = set_pte_bit(pte, __pgprot(L_PTE_RDONLY));
+	if (md->attribute & EFI_MEMORY_XP)
+		pte = set_pte_bit(pte, __pgprot(L_PTE_XN));
+	set_pte_ext(ptep, pte, PTE_EXT_NG);
+	return 0;
+}
+
+int __init efi_set_mapping_permissions(struct mm_struct *mm,
+				       efi_memory_desc_t *md)
+{
+	unsigned long base, size;
+
+	base = md->virt_addr;
+	size = md->num_pages << EFI_PAGE_SHIFT;
+
+	/*
+	 * We can only use apply_to_page_range() if we can guarantee that the
+	 * entire region was mapped using pages. This should be the case if the
+	 * region does not cover any naturally aligned SECTION_SIZE sized
+	 * blocks.
+	 */
+	if (round_down(base + size, SECTION_SIZE) <
+	    round_up(base, SECTION_SIZE) + SECTION_SIZE)
+		return apply_to_page_range(mm, base, size, set_permissions, md);
+
+	return 0;
+}
+
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
 	struct map_desc desc = {
@@ -34,5 +69,11 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 		desc.type = MT_DEVICE;
 
 	create_mapping_late(mm, &desc, true);
+
+	/*
+	 * If stricter permissions were specified, apply them now.
+	 */
+	if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
+		return efi_set_mapping_permissions(mm, md);
 	return 0;
 }
-- 
2.5.0
