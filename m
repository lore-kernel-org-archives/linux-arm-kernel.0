From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 15 Apr 2014 18:42:39 -0700
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415.155330.2253279045572024595.davem@davemloft.net>
References: <534D6A1F.70102@linaro.org> <20140415174330.GA10558@redhat.com>
 <534D8AE6.3090609@linaro.org>
 <20140415.155330.2253279045572024595.davem@davemloft.net>
Message-ID: <CAA3XUr0+u9YCDhRx5xZgKC3GH1Y0Xiwh2731QWkWn0rGu7T2Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2014 12:53, David Miller <davem@davemloft.net> wrote:
> From: David Long <dave.long@linaro.org>
> Date: Tue, 15 Apr 2014 15:39:18 -0400
>
>> Yes, I have that coded for 14 out of 24 architectures (the easy
>> ones). The remaining ones need more work.  Some may prove problematic.
>> The whole approach could yet prove impractical.  More recent suggested
>> approaches may be better too (or Linus's relatively simple change).
>
> BTW, another reason perhaps to write directly to userspace and have
> a uprobes_*() specific interface is that you'll only need to do
> 3 architectures, the ones that support uprobes.
>
> That way, this is just part of what every arch needs to implement in
> order to support uprobes.

David, Russell, I hope I correctly understood your idea of writing
directly into user space. Please check patch below. On my tests
it works ok. Look for arch_uprobe_copy_ixol in
arch/arm/kernel/uprobes.c.

However, I've run into the issue while I've tried that - I had to
add VM_WRITE to xol area mapping. I.e area should be
writable and executable in order for put_user or __copy_to_user
to work. This does not seem right to have such mapping
inside of user-space process. It seems as possible exploitation
point. Especially it seems that xol page is left around even
when tracing is complete. I feel very uneasy about
this direction, unless I am missing something and there is
other way to do that.

Another concern about this approach: will
flush_cache_user_range function take care of smp case
were remove snooping is not supported. I think use
case that Russell mentioned about self modified code
and special system call implies yes.

>From e325a1a1bdddc7bd95301f0031d868bc69ddcddb Mon Sep 17 00:00:00 2001
From: Victor Kamensky <victor.kamensky@linaro.org>
Date: Mon, 7 Apr 2014 17:57:36 -0700
Subject: [PATCH] ARM: uprobes need icache flush after xol write

After instruction write into xol area, on ARM V7
architecture code need to flush dcache and icache to sync
them up for given set of addresses. Having just
'flush_dcache_page(page)' call is not enough - it is
possible to have stale instruction sitting in icache
for given xol area slot address.

Introduce arch_uprobe_ixol_copy weak function
that by default calls uprobes copy_to_page function and
than flush_dcache_page function and on ARM define new one
that handles xol slot copy in ARM specific way

Arm implementation of arch_uprobe_ixol_copy just
makes __copy_to_user which does not have dcache aliasing
issues and then flush_cache_user_range to push dcache
out and invalidate corresponding icache entries.

Note in order to write into uprobes xol area had
to add VM_WRITE to xol area mapping.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/uprobes.c |  8 ++++++++
 include/linux/uprobes.h   |  3 +++
 kernel/events/uprobes.c   | 27 ++++++++++++++++++---------
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/uprobes.c b/arch/arm/kernel/uprobes.c
index f9bacee..4836e54 100644
--- a/arch/arm/kernel/uprobes.c
+++ b/arch/arm/kernel/uprobes.c
@@ -113,6 +113,14 @@ int arch_uprobe_analyze_insn(struct arch_uprobe
*auprobe, struct mm_struct *mm,
     return 0;
 }

+void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
+               void *src, unsigned long len)
+{
+    if (!__copy_to_user((void *) vaddr, src, len))
+        flush_cache_user_range(vaddr, len);
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

 #define UPROBE_HANDLER_REMOVE        1
 #define UPROBE_HANDLER_MASK        1
@@ -127,6 +128,8 @@ extern int  arch_uprobe_exception_notify(struct
notifier_block *self, unsigned l
 extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct
pt_regs *regs);
 extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long
trampoline_vaddr, struct pt_regs *regs);
 extern bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct
pt_regs *regs);
+extern void __weak arch_uprobe_copy_ixol(struct page *page, unsigned
long vaddr,
+                     void *src, unsigned long len);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 04709b6..9e22002 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1149,7 +1149,7 @@ static int xol_add_vma(struct mm_struct *mm,
struct xol_area *area)
     }

     ret = install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-                VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO, &area->page);
+                VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_WRITE, &area->page);
     if (ret)
         goto fail;

@@ -1296,14 +1296,8 @@ static unsigned long xol_get_insn_slot(struct
uprobe *uprobe)
     if (unlikely(!xol_vaddr))
         return 0;

-    /* Initialize the slot */
-    copy_to_page(area->page, xol_vaddr,
-            &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-    /*
-     * We probably need flush_icache_user_range() but it needs vma.
-     * This should work on supported architectures too.
-     */
-    flush_dcache_page(area->page);
+    arch_uprobe_copy_ixol(area->page, xol_vaddr,
+                  &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));

     return xol_vaddr;
 }
@@ -1346,6 +1340,21 @@ static void xol_free_insn_slot(struct task_struct *tsk)
     }
 }

+void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
+                  void *src, unsigned long len)
+{
+    /* Initialize the slot */
+    copy_to_page(page, vaddr, src, len);
+
+    /*
+     * We probably need flush_icache_user_range() but it needs vma.
+     * This should work on most of architectures by default. If
+     * architecture needs to do something different it can define
+     * its own version of the function.
+     */
+    flush_dcache_page(page);
+}
+
 /**
  * uprobe_get_swbp_addr - compute address of swbp given post-swbp regs
  * @regs: Reflects the saved state of the task after it has hit a breakpoint
-- 
1.8.1.4
