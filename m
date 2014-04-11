From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 11 Apr 2014 10:50:31 -0700
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411172456.GA20506@redhat.com>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com>
 <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
Message-ID: <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 10:24 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> +static void arch_uprobe_copy_ixol(struct xol_area *area, unsigned long vaddr,
> +                                       struct arch_uprobe *auprobe)
> +{
> +#ifndef ARCH_UPROBE_XXX
> +       copy_to_page(area->page, vaddr, &auprobe->ixol, sizeof(&auprobe->ixol));
> +       /*
> +        * We probably need flush_icache_user_range() but it needs vma.
> +        * If this doesn't work define ARCH_UPROBE_XXX.
> +        */
> +       flush_dcache_page(area->page);
> +#else
> +       struct mm_struct *mm = current->mm;
> +       struct vm_area_struct *vma;
> +
> +       down_read(&mm->mmap_sem);
> +       vma = find_exact_vma(mm, area->vaddr, area->vaddr + PAGE_SIZE);
> +       if (vma) {
> +               void *kaddr = kmap_atomic(area->page);
> +               copy_to_user_page(vma, area->page,
> +                                       vaddr, kaddr + (vaddr & ~PAGE_MASK),
> +                                       &auprobe->ixol, sizeof(&auprobe->ixol));
> +               kunmap_atomic(kaddr);
> +       }
> +       up_read(&mm->mmap_sem);
> +#endif

Yeah, no, this is wrong.

the fact is, the *only* possible use for the whole "vma" argument is
the "can this be executable" optimization, afaik.

So I really think we should just have a fixed
"flush_icache_page(page,vaddr)" function. Maybe add a "len" argument,
to allow architectures that have to loop over cachelines to do just a
minimal loop.

Then, to do the vma optimization, let's introduce a new

    arch_needs_icache_flush(vma, page)

function, which on cache coherent architectures can just be zero (or
one, since the icache flush itself will be a no-op, so it doesn't
really matter), and on others it can do the "have we executed from
this page", which may involve just looking at the vma..

Then the uprobe case can just do

    copy_to_page()
    flush_dcache_page()
    flush_icache_page()

and be done with it.

Hmm?

                Linus
