From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 5 Nov 2013 20:01:53 +0100
Subject: [PATCH] uprobes: Export write_opcode() as uprobe_write_opcode()
In-Reply-To: <20131105181614.GA7614@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-2-git-send-email-dave.long@linaro.org>
 <20131105160150.GA1539@redhat.com> <20131105181614.GA7614@redhat.com>
Message-ID: <20131105190153.GA32422@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05, Oleg Nesterov wrote:
>
> And I think we can merge this change separately to reduce the
> number of non-arm changes in the next version.

And if you think this can help, I can push another change right
now, see below.

This way v3 will only need a single change outside of arch/arm,
arch_uprobe_ignore(), and this change should be trivial.

Oleg.
---

Subject: [PATCH] uprobes: Export write_opcode() as uprobe_write_opcode()
From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 5 Nov 2013 19:50:39 +0100

set_swbp() and set_orig_insn() are __weak, but this is pointless
because write_opcode() is static.

Export write_opcode() as uprobe_write_opcode() for the upcoming
arm port, this way it can actually override set_swbp() and use
__opcode_to_mem_arm(bpinsn) instead if UPROBE_SWBP_INSN.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/uprobes.h |    1 +
 kernel/events/uprobes.c |   14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 9fd60c5..6d62577 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -109,6 +109,7 @@ extern int __weak set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsign
 extern int __weak set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool __weak is_swbp_insn(uprobe_opcode_t *insn);
 extern bool __weak is_trap_insn(uprobe_opcode_t *insn);
+extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6aef5ad..9081d15 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -244,12 +244,12 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
  * the architecture. If an arch has variable length instruction and the
  * breakpoint instruction is not of the smallest length instruction
  * supported by that architecture then we need to modify is_trap_at_addr and
- * write_opcode accordingly. This would never be a problem for archs that
- * have fixed length instructions.
+ * uprobe_write_opcode accordingly. This would never be a problem for archs
+ * that have fixed length instructions.
  */
 
 /*
- * write_opcode - write the opcode at a given virtual address.
+ * uprobe_write_opcode - write the opcode at a given virtual address.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
@@ -260,7 +260,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
  * For mm @mm, write the opcode at @vaddr.
  * Return 0 (success) or a negative errno.
  */
-static int write_opcode(struct mm_struct *mm, unsigned long vaddr,
+int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
 			uprobe_opcode_t opcode)
 {
 	struct page *old_page, *new_page;
@@ -314,7 +314,7 @@ put_old:
  */
 int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
 }
 
 /**
@@ -329,7 +329,7 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned
 int __weak
 set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return write_opcode(mm, vaddr, *(uprobe_opcode_t *)auprobe->insn);
+	return uprobe_write_opcode(mm, vaddr, *(uprobe_opcode_t *)auprobe->insn);
 }
 
 static int match_uprobe(struct uprobe *l, struct uprobe *r)
@@ -576,7 +576,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	if (ret)
 		goto out;
 
-	/* write_opcode() assumes we don't cross page boundary */
+	/* uprobe_write_opcode() assumes we don't cross page boundary */
 	BUG_ON((uprobe->offset & ~PAGE_MASK) +
 			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
 
-- 
1.5.5.1
