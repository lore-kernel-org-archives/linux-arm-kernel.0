From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Oct 2012 21:23:08 +0200
Subject: [PATCH 4/9] uprobes: allow arch access to xol slot
In-Reply-To: <1350242593-17761-1-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
Message-ID: <1350242593-17761-4-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow arches to customize how the instruction is filled into the xol
slot.  ARM will use this to insert an undefined instruction after the
real instruction in order to simulate a single step of the instruction
without hardware support.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 include/linux/uprobes.h |    1 +
 kernel/events/uprobes.c |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index da21b66..b4380ad 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -129,6 +129,7 @@ extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
 extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val, void *data);
 extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
+extern void __weak arch_uprobe_xol_copy(struct arch_uprobe *auprobe, void *vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a0e1a38..f7ff3a4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1211,6 +1211,11 @@ static unsigned long xol_take_insn_slot(struct xol_area *area)
 	return slot_addr;
 }
 
+void __weak arch_uprobe_xol_copy(struct arch_uprobe *auprobe, void *vaddr)
+{
+	memcpy(vaddr, auprobe->insn, MAX_UINSN_BYTES);
+}
+
 /*
  * xol_get_insn_slot - If was not allocated a slot, then
  * allocate a slot.
@@ -1240,7 +1245,7 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe, unsigned long slot
 	current->utask->vaddr = slot_addr;
 	offset = current->utask->xol_vaddr & ~PAGE_MASK;
 	vaddr = kmap_atomic(area->page);
-	memcpy(vaddr + offset, uprobe->arch.insn, MAX_UINSN_BYTES);
+	arch_uprobe_xol_copy(&uprobe->arch, vaddr + offset);
 	kunmap_atomic(vaddr);
 
 	return current->utask->xol_vaddr;
-- 
1.7.9.5
