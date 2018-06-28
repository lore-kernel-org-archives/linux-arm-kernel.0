From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Thu, 28 Jun 2018 10:52:03 +0530
Subject: [PATCH v5 04/10] Uprobe: Change set_orig_insn definition
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
Message-ID: <20180628052209.13056-5-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of arch_uprobe, pass uprobe object to set_orig_insn(). We
need this in later set of patches.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 include/linux/uprobes.h | 2 +-
 kernel/events/uprobes.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 7a77bd57c9e7..85db5918f675 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -141,7 +141,7 @@ struct uprobes_state {
 };
 
 extern int set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr);
-extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern int set_orig_insn(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8de52bcd1a18..04fe80057331 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -333,16 +333,17 @@ int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long v
 /**
  * set_orig_insn - Restore the original instruction.
  * @mm: the probed process address space.
- * @auprobe: arch specific probepoint information.
+ * @uprobe: uprobe object.
  * @vaddr: the virtual address to insert the opcode.
  *
  * For mm @mm, restore the original opcode (opcode) at @vaddr.
  * Return 0 (success) or a negative errno.
  */
 int __weak
-set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+set_orig_insn(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr, *(uprobe_opcode_t *)&auprobe->insn);
+	return uprobe_write_opcode(mm, vaddr,
+			*(uprobe_opcode_t *)&(uprobe->arch.insn));
 }
 
 static struct uprobe *get_uprobe(struct uprobe *uprobe)
@@ -655,7 +656,7 @@ static int
 remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
-	return set_orig_insn(&uprobe->arch, mm, vaddr);
+	return set_orig_insn(uprobe, mm, vaddr);
 }
 
 static inline bool uprobe_is_active(struct uprobe *uprobe)
-- 
2.14.4
