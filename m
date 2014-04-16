From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 16 Apr 2014 18:43:10 +0200
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <20140416.110031.1269128188581361698.davem@davemloft.net>
References: <1397626297-23873-1-git-send-email-victor.kamensky@linaro.org>
 <1397626297-23873-2-git-send-email-victor.kamensky@linaro.org>
 <20140416145107.GA11039@redhat.com>
 <20140416.110031.1269128188581361698.davem@davemloft.net>
Message-ID: <20140416164310.GA15739@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16, David Miller wrote:
>
> From: Oleg Nesterov <oleg@redhat.com>
> Date: Wed, 16 Apr 2014 16:51:07 +0200
>
> > On 04/15, Victor Kamensky wrote:
> >>
> >> --- a/kernel/events/uprobes.c
> >> +++ b/kernel/events/uprobes.c
> >> @@ -1149,7 +1149,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
> >>  	}
> >>
> >>  	ret = install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> >> -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO, &area->page);
> >> +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_WRITE, &area->page);
> >
> > Yes, this is nasty.
> >
> > I would like to have a reason to nack this change ;) Unfortunately the current
> > code is buggy too and we need to protect the kernel from malicious applications
> > which can rewrite the insn we are going to step over in UTASK_SSTEP state anyway.
>
> I think there may be a way to achieve your objectives.
>
> Pass MAP_SHARED into the flags argument of get_unmapped_area(), and
> pass the pfn of the xol page in as "pgoff".
>
> This will make the xol page get mapped into the user process at an
> address which is "D-cache congruent" to the kernel side mapping.
>
> So all kernel stores to the page will use the same D-cache line that
> user space accesses to it will.

Thanks... I didn't know..

But did you really mean get_unmapped_area(pgoff => page_to_pfn(area->page)) ?

I simply can't understand how this can work, arm (and x86) really use it as
"pgoff << PAGE_SHIFT" align_offset accounted in unmapped_area() ?

_Perhaps_ this can help as a "random number" unique for every xol mapping ?
Hmm, no, I don't understand this COLOUR_ALIGN() magic on arm, but unlikely
this is true.

Help!

> So we end up with all of the benefits of storing directly to
> userspace, along with what you're trying to achieve.

And in this case we can avoid copy_to_user(), right ?

Oleg.
