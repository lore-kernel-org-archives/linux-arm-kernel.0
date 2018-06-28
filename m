From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Thu, 28 Jun 2018 10:52:02 +0530
Subject: [PATCH v5 03/10] Uprobe: Change set_swbp definition
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
Message-ID: <20180628052209.13056-4-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of arch_uprobe, pass uprobe object to set_swbp(). We need
this in later set of patches.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/arm/probes/uprobes/core.c | 4 ++--
 arch/mips/kernel/uprobes.c     | 4 ++--
 include/linux/uprobes.h        | 2 +-
 kernel/events/uprobes.c        | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index d1329f1ba4e4..c678a5c4a284 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -29,11 +29,11 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 		(UPROBE_SWBP_ARM_INSN & 0x0fffffff);
 }
 
-int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
+int set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	     unsigned long vaddr)
 {
 	return uprobe_write_opcode(mm, vaddr,
-		   __opcode_to_mem_arm(auprobe->bpinsn));
+		   __opcode_to_mem_arm(uprobe->arch.bpinsn));
 }
 
 bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index f7a0645ccb82..2aaa378a46e6 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -211,7 +211,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
 
 /**
  * set_swbp - store breakpoint at a given address.
- * @auprobe: arch specific probepoint information.
+ * @uprobe: uprobe object.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to insert the opcode.
  *
@@ -221,7 +221,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
  * This version overrides the weak version in kernel/events/uprobes.c.
  * It is required to handle MIPS16 and microMIPS.
  */
-int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
+int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	unsigned long vaddr)
 {
 	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 044359083a57..7a77bd57c9e7 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -140,7 +140,7 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
-extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern int set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 26c2d95c55fa..8de52bcd1a18 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -318,14 +318,14 @@ int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
 
 /**
  * set_swbp - store breakpoint at a given address.
- * @auprobe: arch specific probepoint information.
+ * @uprobe: uprobe object.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to insert the opcode.
  *
  * For mm @mm, store the breakpoint instruction at @vaddr.
  * Return 0 (success) or a negative errno.
  */
-int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
 }
@@ -642,7 +642,7 @@ install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
 	if (first_uprobe)
 		set_bit(MMF_HAS_UPROBES, &mm->flags);
 
-	ret = set_swbp(&uprobe->arch, mm, vaddr);
+	ret = set_swbp(uprobe, mm, vaddr);
 	if (!ret)
 		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
 	else if (first_uprobe)
-- 
2.14.4
