From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Thu, 28 Jun 2018 10:52:04 +0530
Subject: [PATCH v5 05/10] Uprobe: Change uprobe_write_opcode definition
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
Message-ID: <20180628052209.13056-6-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add addition argument 'uprobe' to uprobe_write_opcode(). We need
this in later set of patches.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/arm/probes/uprobes/core.c | 2 +-
 arch/mips/kernel/uprobes.c     | 2 +-
 include/linux/uprobes.h        | 2 +-
 kernel/events/uprobes.c        | 9 +++++----
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index c678a5c4a284..a4856a904a0a 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -32,7 +32,7 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 int set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	     unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr,
+	return uprobe_write_opcode(uprobe, mm, vaddr,
 		   __opcode_to_mem_arm(uprobe->arch.bpinsn));
 }
 
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 2aaa378a46e6..8bdf4b54c4a7 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -224,7 +224,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
 int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(uprobe, mm, vaddr, UPROBE_SWBP_INSN);
 }
 
 void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 85db5918f675..88942b1f0a3e 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -146,7 +146,7 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t opcode);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 04fe80057331..3e0426c76376 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -268,6 +268,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
  * that have fixed length instructions.
  *
  * uprobe_write_opcode - write the opcode at a given virtual address.
+ * @uprobe: uprobe object.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
@@ -275,8 +276,8 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
  * Called with mm->mmap_sem held for write.
  * Return 0 (success) or a negative errno.
  */
-int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
-			uprobe_opcode_t opcode)
+int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
+			unsigned long vaddr, uprobe_opcode_t opcode)
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
@@ -327,7 +328,7 @@ int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
  */
 int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(uprobe, mm, vaddr, UPROBE_SWBP_INSN);
 }
 
 /**
@@ -342,7 +343,7 @@ int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long v
 int __weak
 set_orig_insn(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr,
+	return uprobe_write_opcode(uprobe, mm, vaddr,
 			*(uprobe_opcode_t *)&(uprobe->arch.insn));
 }
 
-- 
2.14.4
