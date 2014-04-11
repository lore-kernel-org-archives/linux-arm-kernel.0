From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 11 Apr 2014 19:24:56 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411153041.GQ16119@n2100.arm.linux.org.uk>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com> <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
Message-ID: <20140411172456.GA20506@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11, Russell King - ARM Linux wrote:
>
> On Fri, Apr 11, 2014 at 05:22:07PM +0200, Oleg Nesterov wrote:
>
> I wonder whether you've read this yet:
>
> 	http://lkml.iu.edu//hypermail/linux/kernel/1404.1/00725.html

it seems that the only result of this discussion is "stop trying to
reinvent" you already quoted. Thanks.

> where I proposed removing flush_icache_user_range() since it's not used
> on a great many architectures.

Or at least it and its usage can be cleanuped somehow...

> > And I am just curious, why arm's copy_to_user_page() disables premption
> > before memcpy?
>
> flush_ptrace_access() needs to run on the CPU which ended up with the
> dirty cache line(s) to cope with those which do not have hardware
> broadcasting of cache maintanence operations.

Aha, thanks.

But you know, perhaps I'll ask you another stupid question later. Because
it still seems to me that we can do something better/cheaper in uprobe case.
Nevermind.

> This is why the hacks that you're doing are just that - they're hacks
> and are all broken in some way.

OK.

> I fail to see what your problem is with keeping the vma around,

We can't pin vm_area_struct.

> Let's not go inventing a whole new interface
> solving the same problem.

OK. How about the patch below?

Oleg.
---

index 2adbc97..9d45a4a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1274,6 +1274,33 @@ static unsigned long xol_take_insn_slot(struct xol_area *area)
 	return slot_addr;
 }
 
+static void arch_uprobe_copy_ixol(struct xol_area *area, unsigned long vaddr,
+				 	struct arch_uprobe *auprobe)
+{
+#ifndef ARCH_UPROBE_XXX
+	copy_to_page(area->page, vaddr, &auprobe->ixol, sizeof(&auprobe->ixol));
+	/*
+	 * We probably need flush_icache_user_range() but it needs vma.
+	 * If this doesn't work define ARCH_UPROBE_XXX.
+	 */
+	flush_dcache_page(area->page);
+#else
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	down_read(&mm->mmap_sem);
+	vma = find_exact_vma(mm, area->vaddr, area->vaddr + PAGE_SIZE);
+	if (vma) {
+		void *kaddr = kmap_atomic(area->page);
+		copy_to_user_page(vma, area->page,
+					vaddr, kaddr + (vaddr & ~PAGE_MASK),
+					&auprobe->ixol, sizeof(&auprobe->ixol));
+		kunmap_atomic(kaddr);
+	}
+	up_read(&mm->mmap_sem);
+#endif
+}
+
 /*
  * xol_get_insn_slot - allocate a slot for xol.
  * Returns the allocated slot address or 0.
@@ -1291,15 +1318,7 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
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
-
+	arch_uprobe_copy_ixol(area, xol_vaddr, &uprobe->arch);
 	return xol_vaddr;
 }
 
