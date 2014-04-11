From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 11 Apr 2014 19:38:53 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411172456.GA20506@redhat.com>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com> <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
Message-ID: <20140411173853.GA21370@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11, Oleg Nesterov wrote:
>
> +static void arch_uprobe_copy_ixol(struct xol_area *area, unsigned long vaddr,
> +				 	struct arch_uprobe *auprobe)
> +{
> +#ifndef ARCH_UPROBE_XXX
> +	copy_to_page(area->page, vaddr, &auprobe->ixol, sizeof(&auprobe->ixol));
> +	/*
> +	 * We probably need flush_icache_user_range() but it needs vma.
> +	 * If this doesn't work define ARCH_UPROBE_XXX.
> +	 */
> +	flush_dcache_page(area->page);
> +#else
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +
> +	down_read(&mm->mmap_sem);
> +	vma = find_exact_vma(mm, area->vaddr, area->vaddr + PAGE_SIZE);
> +	if (vma) {
> +		void *kaddr = kmap_atomic(area->page);
> +		copy_to_user_page(vma, area->page,
> +					vaddr, kaddr + (vaddr & ~PAGE_MASK),
> +					&auprobe->ixol, sizeof(&auprobe->ixol));
> +		kunmap_atomic(kaddr);
> +	}
> +	up_read(&mm->mmap_sem);
> +#endif

And perhaps the patch is not complete. "if (vma)" is not enough, a probed
task can mmap something else at this vaddr.

copy_to_user_page() should only change the contents of area->page, so memcpy
should be fine. But I am not sure that flush_icache_user_range() or
flush_ptrace_access() is always safe on every arch if "struct page *page"
doesn't match vma.

Oleg.
