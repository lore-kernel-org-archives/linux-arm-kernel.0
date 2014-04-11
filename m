From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 11 Apr 2014 16:56:25 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411.003636.272212797007496394.davem@davemloft.net>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
Message-ID: <20140411145625.GA27493@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First of all: I do not pretend I really understand the problems with
icache/etc coherency and how flush_icache_range() actually works on
alpha. Help.

For those who were not cc'ed. A probed task has a special "xol" vma,
it is used to execute the probed insn out of line.

Initial implementation was x86 only, so we simply copied the probed
insn into this vma and everything was fine, flush_icache_range() is
nop on x86.

Then we added flush_dcache_page() for powerpc,

	// this is just kmap() + memcpy()
	copy_to_page(area->page, xol_vaddr,
			&uprobe->arch.ixol, sizeof(uprobe->arch.ixol));

	/*
	 * We probably need flush_icache_user_range() but it needs vma.
	 * This should work on supported architectures too.
	 */
	flush_dcache_page(area->page);

but this doesn't work on arm. So we need another fix.

On 04/11, David Miller wrote:
>
> From: David Long <dave.long@linaro.org>
> Date: Thu, 10 Apr 2014 23:45:31 -0400
>
> > Replace memcpy and dcache flush in generic uprobes with a call to
> > copy_to_user_page(), which will do a proper flushing of kernel and
> > user cache.  Also modify the inmplementation of copy_to_user_page
> > to assume a NULL vma pointer means the user icache corresponding
> > to this right is stale and needs to be flushed.  Note that this patch
> > does not fix copy_to_user page for the sh, alpha, sparc, or mips
> > architectures (which do not currently support uprobes).
> >
> > Signed-off-by: David A. Long <dave.long@linaro.org>
>
> You really need to pass the proper VMA down to the call site
> rather than pass NULL, that's extremely ugly and totally
> unnecesary.

I agree that we should not change copy_to_user_page(), but I am not sure
the code above should use copy_to_user_page().

Because the code above really differs in my opinion from the only user of
copy_to_user_page(), __access_remote_vm().

	1. First of all, we do not know vma.

	   OK, we can down_read(mmap_sem) and do find_vma() of course.
	   This is a bit unfortunate, especially because the architectures
	   we currently support do not need this.

	   But,

	2. The problem is, it would be very nice to remove this vma, or
	   at least hide it somehow from find_vma/etc. This is the special
	   mapping we do not want to expose to user-space.

	   In fact I even have the patches which remove this vma, but they
	   do not work with compat tasks unfortunately.

	3. Unlike __access_remote_vm() we always use current->mm, and the
	   memory range changed by the code above can only be used by
	   "current" thread.

	   So (perhaps) flush_icache_user_range() can even treat this case
	   as "mm->mm_users) <= 1" and avoid ipi_flush_icache_page (just in
	   case, of course I do not know if this is actually possible).

So can't we do something else? Lets forget about arch/arm for the moment,
suppose that we want to support uprobes on alpha. Can't we do _something_
like below?

And perhap we can do something like this on arm? it can do kmap(page) /
page_address(page) itself.

Oleg.

--- x/arch/alpha/kernel/smp.c
+++ x/arch/alpha/kernel/smp.c
@@ -751,15 +751,9 @@ ipi_flush_icache_page(void *x)
 		flush_tlb_other(mm);
 }
 
-void
-flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
-			unsigned long addr, int len)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	if ((vma->vm_flags & VM_EXEC) == 0)
-		return;
 
+void __flush_icache_page_xxx(struct mm_struct *mm, struct page *page) // addr, len ?
+{
 	preempt_disable();
 
 	if (mm == current->active_mm) {
@@ -783,3 +777,24 @@ flush_icache_user_range(struct vm_area_s
 
 	preempt_enable();
 }
+
+void flush_icache_page_xxx(struct mm_struct *mm, struct page *page)
+{
+	struct mm_struct *mm = current->mm;
+
+	down_read(&mm->mmap_sem);
+	__flush_icache_page_xxx(mm, page);
+	up_read(&mm->mmap_sem);
+}
+
+void
+flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			unsigned long addr, int len)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if ((vma->vm_flags & VM_EXEC) == 0)
+		return;
+
+	__flush_icache_page_xxx(mm, page);
+}
