From: m.slodczyk2@partner.samsung.com (Maciej Slodczyk)
Date: Fri, 16 Feb 2018 12:23:07 +0100
Subject: [PATCH 3/7 RESEND] arm64: introduce get_swbp_insn() instead of
 static assignment
In-Reply-To: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
References: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180216112322eucas1p2b170bbf0687ebbc03110e42ff807342f@eucas1p2.samsung.com>
Message-ID: <1518780191-31094-4-git-send-email-m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In uprobes generic code, an arch specific software breakpoint instruction
is statically assigned with a #define statement. It does not allow to examine
the context and set the proper arch on runtime, which is the case of uprobing
either a 32 or 64 bit app on a 64-bit kernel. Introduce get_swbp_insn() with
weak attribute that will allow to be redefined in ARM64 uprobes code.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e9..ef61d79 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -117,6 +117,7 @@ struct uprobes_state {
 
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern uprobe_opcode_t get_swbp_insn(void);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 267f6ef..cb7a573 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -216,6 +216,16 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
+ * get_swbp_insn - return breakpoint instruction.
+ * Default implementation of get_swbp_insn
+ * Returns architecture-dependent breakpoint instruction opcode
+ */
+uprobe_opcode_t __weak get_swbp_insn(void)
+{
+	return UPROBE_SWBP_INSN;
+}
+
+/**
  * is_swbp_insn - check if instruction is breakpoint instruction.
  * @insn: instruction to be checked.
  * Default implementation of is_swbp_insn
@@ -1178,7 +1188,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	uprobe_opcode_t insn = get_swbp_insn();
 	struct xol_area *area;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
-- 
2.7.4
