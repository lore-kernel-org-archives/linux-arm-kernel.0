From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 14 Apr 2014 20:59:16 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com> <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
Message-ID: <20140414185916.GA30672@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11, Linus Torvalds wrote:
>
> On Fri, Apr 11, 2014 at 10:24 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > +static void arch_uprobe_copy_ixol(struct xol_area *area, unsigned long vaddr,
> > +                                       struct arch_uprobe *auprobe)
> > +{
> > +#ifndef ARCH_UPROBE_XXX
> > +       copy_to_page(area->page, vaddr, &auprobe->ixol, sizeof(&auprobe->ixol));
> > +       /*
> > +        * We probably need flush_icache_user_range() but it needs vma.
> > +        * If this doesn't work define ARCH_UPROBE_XXX.
> > +        */
> > +       flush_dcache_page(area->page);
> > +#else
> > +       struct mm_struct *mm = current->mm;
> > +       struct vm_area_struct *vma;
> > +
> > +       down_read(&mm->mmap_sem);
> > +       vma = find_exact_vma(mm, area->vaddr, area->vaddr + PAGE_SIZE);
> > +       if (vma) {
> > +               void *kaddr = kmap_atomic(area->page);
> > +               copy_to_user_page(vma, area->page,
> > +                                       vaddr, kaddr + (vaddr & ~PAGE_MASK),
> > +                                       &auprobe->ixol, sizeof(&auprobe->ixol));
> > +               kunmap_atomic(kaddr);
> > +       }
> > +       up_read(&mm->mmap_sem);
> > +#endif
>
> Yeah, no, this is wrong.

Yesss, agreed.

> So I really think we should just have a fixed
> "flush_icache_page(page,vaddr)" function.
> ...
> Then the uprobe case can just do
>
>     copy_to_page()
>     flush_dcache_page()
>     flush_icache_page()


And I obviously like this idea because (iiuc) it more or less matches
flush_icache_page_xxx() I tried to suggest.

But we need a short term solution for arm. And unless I misunderstood
Russell (this is quite possible), arm needs to disable preemption around
copy + flush.

Russel, so what do you think we can do for arm right now? Does the patch
above (and subsequent discussion) answer the "why reinvent" question ?

Oleg.
