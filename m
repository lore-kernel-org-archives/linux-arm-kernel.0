From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 15 Apr 2014 17:46:37 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CAA3XUr3BGA55JF_cgH=cqbo1wAK0773P1fvnG9dBjLU2KzBdKA@mail.gmail.com>
References: <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com> <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
 <20140414185916.GA30672@redhat.com>
 <CAA3XUr3BGA55JF_cgH=cqbo1wAK0773P1fvnG9dBjLU2KzBdKA@mail.gmail.com>
Message-ID: <20140415154637.GA3560@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14, Victor Kamensky wrote:
>
> On 14 April 2014 11:59, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 04/11, Linus Torvalds wrote:
> >>
> >> So I really think we should just have a fixed
> >> "flush_icache_page(page,vaddr)" function.
> >> ...
> >> Then the uprobe case can just do
> >>
> >>     copy_to_page()
> >>     flush_dcache_page()
> >>     flush_icache_page()
> >
> >
> > And I obviously like this idea because (iiuc) it more or less matches
> > flush_icache_page_xxx() I tried to suggest.
>
> Would not page granularity to be too expensive? Note you need to do that on
> each probe hit and you flushing whole data and instruction page every time.
> IMHO it will work correctly when you flush just few dcache/icache lines that
> correspond to xol slot that got modified. Note copy_to_user_page takes
> len that describes size of area that has to be flushed. Given that we are
> flushing xol area page at this case; and nothing except one xol slot is
> any interest for current task, and if CPU can flush one dcache and icache
> page as quickly as it can flush range, my remark may not matter.

We can add "vaddr, len" to the argument list.

> I personally would prefer if we could have function like copy_to_user_page
> but without requirement to pass vma to it.

I won't argue, but you need to convince maintainers.


And to remind, we need something simple/nonintrusive for arm right now.
Again, I won't argue if we turn copy_to_page() + flush_dcache_page() into
__weak arch_uprobe_copy_ixol(), and add the necessary hacks into arm's
implementatiion. This is up to you and Russel.



But. Please do not add copy_to_user_page() into copy_to_page() (as your patch
did). This is certainly not what uprobe_write_opcode() wants, we do not want
or need "flush" in this case. The same for __create_xol_area().

Note also that currently copy_to_user_page() is always called under mmap_sem.
I do not know if arm actually needs ->mmap_sem, but if you propose it as a
generic solution we should probably take this lock.

Also. Even if we have copy_to_user_page_no_vma() or change copy_to_user_page()
to accept vma => NULL, I am not sure this will work fine on arm when the probed
application unmaps xol_area and mmaps something else at the same vaddr. I mean,
in this case we do not care if the application crashes, but please verify that
something really bad can't happen.

Let me repeat just in case, I know nothing about arm/. I can't even understand
how, say, flush_pfn_alias() works, and how it should work if 2 threads call it
at the same time with the same vaddr (or CACHE_COLOUR(vaddr)).

Oleg.
