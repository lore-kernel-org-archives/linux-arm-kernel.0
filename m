From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Mon, 14 Jul 2014 10:46:06 -0500
Subject: [PATCH 1/2] ARM: use _install_special_mapping for sigpage
In-Reply-To: <1405352767-28768-1-git-send-email-nathan_lynch@mentor.com>
References: <1405352767-28768-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1405352767-28768-2-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_install_special_mapping allows the VMA to be identifed in
/proc/pid/maps without the use of arch_vma_name, providing a
slight net reduction in object size:

  text    data     bss     dec     hex filename
  2996      96     144    3236     ca4 arch/arm/kernel/process.o (before)
  2956     104     144    3204     c84 arch/arm/kernel/process.o (after)

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/kernel/process.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686a91ca..46fbbb3701a0 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -472,19 +472,23 @@ int in_gate_area_no_mm(unsigned long addr)
 
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
-	return is_gate_vma(vma) ? "[vectors]" :
-		(vma->vm_mm && vma->vm_start == vma->vm_mm->context.sigpage) ?
-		 "[sigpage]" : NULL;
+	return is_gate_vma(vma) ? "[vectors]" : NULL;
 }
 
 static struct page *signal_page;
 extern struct page *get_signal_page(void);
 
+static const struct vm_special_mapping sigpage_mapping = {
+	.name = "[sigpage]",
+	.pages = &signal_page,
+};
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
 	unsigned long addr;
-	int ret;
+	int ret = 0;
 
 	if (!signal_page)
 		signal_page = get_signal_page();
@@ -498,12 +502,16 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		goto up_fail;
 	}
 
-	ret = install_special_mapping(mm, addr, PAGE_SIZE,
+	vma = _install_special_mapping(mm, addr, PAGE_SIZE,
 		VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
-		&signal_page);
+		&sigpage_mapping);
+
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto up_fail;
+	}
 
-	if (ret == 0)
-		mm->context.sigpage = addr;
+	mm->context.sigpage = addr;
 
  up_fail:
 	up_write(&mm->mmap_sem);
-- 
1.9.3
