From: labbott@fedoraproject.org (Laura Abbott)
Date: Wed,  4 Nov 2015 17:00:39 -0800
Subject: [PATCH] arm: Use kernel mm when updating section permissions
Message-ID: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, read only permissions are not being applied even
when CONFIG_DEBUG_RODATA is set. This is because section_update
uses current->mm for adjusting the page tables. current->mm
need not be equivalent to the kernel version. Use pgd_offset_k
to get the proper page directory for updating.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
I found this while trying to convince myself of something.
Dumping the page table via debugfs and writing to kernel text were both
showing the lack of mappings. This was observed on QEMU. Maybe it's just a
QEMUism but if not it probably should go to stable.
---
 arch/arm/mm/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 8a63b4c..4bb936a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -629,11 +629,9 @@ static struct section_perm ro_perms[] = {
 static inline void section_update(unsigned long addr, pmdval_t mask,
 				  pmdval_t prot)
 {
-	struct mm_struct *mm;
 	pmd_t *pmd;
 
-	mm = current->active_mm;
-	pmd = pmd_offset(pud_offset(pgd_offset(mm, addr), addr), addr);
+	pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
 
 #ifdef CONFIG_ARM_LPAE
 	pmd[0] = __pmd((pmd_val(pmd[0]) & mask) | prot);
-- 
2.5.0
