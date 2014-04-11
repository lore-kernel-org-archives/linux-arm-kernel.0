From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 11 Apr 2014 18:22:43 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CAA3XUr0b7W1K85f0kzvodNEpFjhK0XY8AVFTnYzAKOnvCY=JPw@mail.gmail.com>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com>
 <CAA3XUr0b7W1K85f0kzvodNEpFjhK0XY8AVFTnYzAKOnvCY=JPw@mail.gmail.com>
Message-ID: <20140411162243.GA30386@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11, Victor Kamensky wrote:
>
> On 11 April 2014 07:56, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> >         1. First of all, we do not know vma.
> >
> >            OK, we can down_read(mmap_sem) and do find_vma() of course.
> >            This is a bit unfortunate, especially because the architectures
> >            we currently support do not need this.
>
> Question, maybe silly one but I don't know the answer, why can't we just do
> look up for vma once and cache results in place like xol_area (along with
> xol_area.vaddr) and use it all the time. IOW under what circumstances
> vma for xol area can disappear change so we need constant lookup for it?
> Comment in xol_area
>
> >    /*
> >    * We keep the vma's vm_start rather than a pointer to the vma
> >     * itself.  The probed process or a naughty kernel module could make
> >     * the vma go away, and we must handle that reasonably gracefully.
> >     */
> >     unsigned long         vaddr;        /* Page(s) of instruction slots */
>
> alludes to some of those conditions, but I don't quite follow.
> Should not we go after "probed process" ability to unmap xol area.
> xol area is like vdso,

But it is not like vdso. And (unlike vsyscall page) vdso can be unmapped
too (unless it is FIX_VDSO).

> mmap call should ignore
> those..

This is not that simple, this means more ugly uprobe_ hooks in mm/.
And I think we simply do not want/need this.

I didn't write the comment above, but "reasonably gracefully" should mean
"we should not allow unmap/remap/etc(xol_area) crash the kernel, the task
can crashif it does this, we do not care".

The same for vdso, except in this case the kernel can simply forget about
this area after it does setup_additional_pages().

> >         2. The problem is, it would be very nice to remove this vma, or
> >            at least hide it somehow from find_vma/etc. This is the special
> >            mapping we do not want to expose to user-space.
> >
> >            In fact I even have the patches which remove this vma, but they
> >            do not work with compat tasks unfortunately.
>
> I don't think it is right route. Xol area as well as vdso, signal page, etc
> should be visible as regular VMAs. There are other aspects of the system
> where they needed. Like core file collection - I would like to have
> xol area present in my core file if traced process crashed.

It must never crash in xol_area, or we have a kernel bug. (we do have such
a bug which I am trying to fix right now ;)

> /porc/<pid>/maps - I would like to see my memory layout through
> this interface and I would like to see xol area there because I
> can see xol area addresses by some other means.

But it is not "your memory", to some degree. I mean, it would be nice if
it was not.

This should be more like vsyscall page. And indeed, we can move this into
FIXMAP area. The only problem, 32bit task can't use this area in 64-bit
machine.

> Appeal of copy_to_user_page approach is that I don't need to know
> how to handle sync up of icache and dcache on that architecture,

Yes, sure, this is true.

> it is
> already done by someone else when they programmed basic ptrace
> breakpoint write behavior.

Yes, but (rightly or not) I still think that uprobes differs from ptrace.
Perhaps we do not have other choice though.

Oleg.
