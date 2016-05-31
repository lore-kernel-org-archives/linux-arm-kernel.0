From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2016 16:14:31 +0100
Subject: [PATCH 2/3] arm64: efi: Ensure efi_create_mapping() does not map
 overlapping regions
In-Reply-To: <1464707672-21882-1-git-send-email-catalin.marinas@arm.com>
References: <1464707672-21882-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1464707672-21882-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the EFI page size is 4KB, it is possible for a !4KB page kernel to
align an EFI runtime map boundaries in a way that they can overlap
within the same page. This requires the current create_pgd_mapping()
code to be able to split existing larger mappings when an overlapping
region needs to be mapped.

With this patch, efi_create_mapping() scans the EFI memory map for
overlapping regions and trims the length of the current map to avoid a
large block mapping and subsequent split.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/efi.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 78f52488f9ff..0d5753c31c7f 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -62,10 +62,26 @@ struct screen_info screen_info __section(.data);
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
 	pteval_t prot_val = create_mapping_protection(md);
+	phys_addr_t length = md->num_pages << EFI_PAGE_SHIFT;
+	efi_memory_desc_t *next = md;
 
-	create_pgd_mapping(mm, md->phys_addr, md->virt_addr,
-			   md->num_pages << EFI_PAGE_SHIFT,
-			   __pgprot(prot_val | PTE_NG));
+	/*
+	 * Search for the next EFI runtime map and check for any overlap with
+	 * the current map when aligned to PAGE_SIZE. In such case, defer
+	 * mapping the end of the current range until the next
+	 * efi_create_mapping() call.
+	 */
+	for_each_efi_memory_desc_continue(next) {
+		if (!(next->attribute & EFI_MEMORY_RUNTIME))
+			continue;
+		if (next->phys_addr < PAGE_ALIGN(md->phys_addr + length))
+			length -= (md->phys_addr + length) & ~PAGE_MASK;
+		break;
+	}
+
+	if (length)
+		create_pgd_mapping(mm, md->phys_addr, md->virt_addr, length,
+				   __pgprot(prot_val | PTE_NG));
 	return 0;
 }
 
