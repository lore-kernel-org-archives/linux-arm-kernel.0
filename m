From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 15 Apr 2014 22:31:37 -0700
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <1397626297-23873-1-git-send-email-victor.kamensky@linaro.org>
References: <1397626297-23873-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1397626297-23873-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After instruction write into xol area, on ARM V7
architecture code need to flush dcache and icache to sync
them up for given set of addresses. Having just
'flush_dcache_page(page)' call is not enough - it is
possible to have stale instruction sitting in icache
for given xol area slot address.

Introduce arch_uprobe_ixol_copy weak function
that by default calls __copy_to_user function, and
that sufficient for CPUs that can snoop instruction
writes from dcache. On ARM define new one
that handles xol slot copy in ARM specific way.

Arm implementation of arch_uprobe_ixol_copy function
makes __copy_to_user call which does not have dcache
aliasing issues and then flush_cache_user_range to
push dcache out and invalidate corresponding icache
entries.

Note in order to write into uprobes xol area had
to add VM_WRITE to xol area mapping.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/uprobes.c |  8 ++++++++
 include/linux/uprobes.h   |  3 +++
 kernel/events/uprobes.c   | 28 +++++++++++++++++++---------
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/uprobes.c b/arch/arm/kernel/uprobes.c
index f9bacee..4836e54 100644
--- a/arch/arm/kernel/uprobes.c
+++ b/arch/arm/kernel/uprobes.c
@@ -113,6 +113,14 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	return 0;
 }
 
+void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
+			   void *src, unsigned long len)
+{
+	if (!__copy_to_user((void *) vaddr, src, len))
+		flush_cache_user_range(vaddr, len);
+}
+
+
 int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index edff2b9..c52f827 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -32,6 +32,7 @@ struct vm_area_struct;
 struct mm_struct;
 struct inode;
 struct notifier_block;
+struct page;
 
 #define UPROBE_HANDLER_REMOVE		1
 #define UPROBE_HANDLER_MASK		1
@@ -127,6 +128,8 @@ extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned l
 extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs);
 extern bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
+extern void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
+					 void *src, unsigned long len);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 04709b6..1038e57 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1149,7 +1149,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	ret = install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO, &area->page);
+				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_WRITE, &area->page);
 	if (ret)
 		goto fail;
 
@@ -1296,14 +1296,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 	if (unlikely(!xol_vaddr))
 		return 0;
 
-	/* Initialize the slot */
-	copy_to_page(area->page, xol_vaddr,
-			&uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-	/*
-	 * We probably need flush_icache_user_range() but it needs vma.
-	 * This should work on supported architectures too.
-	 */
-	flush_dcache_page(area->page);
+	arch_uprobe_copy_ixol(area->page, xol_vaddr,
+			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
 
 	return xol_vaddr;
 }
@@ -1346,6 +1340,22 @@ static void xol_free_insn_slot(struct task_struct *tsk)
 	}
 }
 
+void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
+				  void *src, unsigned long len)
+{
+	/*
+	 * Note if CPU does not support instructions write snooping
+	 * from dcache it needs to define its own version of this
+	 * function that would take care of proper cache flushes.
+	 *
+	 * Nothing we can do if it fails, added if to make unused
+	 * result warning happy. If xol write failed because process
+	 * unmapped xol area by mistake, process will crash in some
+	 * other place.
+	 */
+	if (__copy_to_user((void *) vaddr, src, len));
+}
+
 /**
  * uprobe_get_swbp_addr - compute address of swbp given post-swbp regs
  * @regs: Reflects the saved state of the task after it has hit a breakpoint
-- 
1.8.1.4
