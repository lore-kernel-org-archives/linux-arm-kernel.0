From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Aug 2016 13:42:29 +0100
Subject: [PATCH] arm64: Expose TASK_SIZE to userspace via auxv
In-Reply-To: <CAKv+Gu9ki6OHd+7PvHV5271_WQg5vx-rxzRSEgYsDLUho3k-7Q@mail.gmail.com>
References: <20160816183231.21179-1-cov@codeaurora.org>
 <20160817103006.GB20762@e104818-lin.cambridge.arm.com>
 <CED1E802-65C5-48B9-8165-46684BE81164@codeaurora.org>
 <CAKv+Gu9ki6OHd+7PvHV5271_WQg5vx-rxzRSEgYsDLUho3k-7Q@mail.gmail.com>
Message-ID: <20160818124229.GB26614@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 02:00:56PM +0200, Ard Biesheuvel wrote:
> On 17 August 2016 at 13:12, Christopher Covington <cov@codeaurora.org> wrote:
> > On August 17, 2016 6:30:06 AM EDT, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>On Tue, Aug 16, 2016 at 02:32:29PM -0400, Christopher Covington wrote:
> >>> Some userspace applications need to know the maximum virtual address
> >>they can
> >>> use (TASK_SIZE).
> >>
> >>Just curious, what are the cases needing TASK_SIZE in user space?
> >
> > Checkpoint/Restore In Userspace and the Mozilla Javascript Engine
> > https://bugzilla.mozilla.org/show_bug.cgi?id=1143022 are the
> > specific cases I've run into. I've heard LuaJIT might have a similar
> > situation. In general I think making allocations from the top down
> > is a shortcut for finding a large unused region of memory.
> 
> One aspect of this that I would like to discuss is whether the current
> practice makes sense, of tying TASK_SIZE to whatever the size of the
> kernel VA space is.

I'm fine with decoupling them as long as we can have sane
pgd/pud/pmd/pte macros. We rely on generic files line pgtable-nopud.h
etc. currently, so we would have to give up on that and do our own
checks. It's also worth testing any potential performance implication of
creating/tearing down large page tables with the new macros.

> I could imagine simply limiting the user VA space to 39-bits (or even
> 36-bits, depending on how deeply we care about 16 KB pages), and
> implement an arch specific hook (prctl() perhaps?) to increase
> TASK_SIZE on demand.

As you stated below, switching TASK_SIZE on demand is problematic if you
actually want a switch the TCR_EL1.T0SZ. As per other recent
discussions, I'm not sure we can do it safely without full TLBI on
context switch. That's an aspect we'll have to sort out with 52-bit VA
but most likely we'll allow this range in T0SZ and only artificially
limit TASK_SIZE to smaller values so that we don't break any other
tasks. But then you won't gain much from a reduced number of page table
levels.

> That would not only give us a reliable way to check whether this is
> supported (i.e., the prctl() would return error if it isn't), it also
> allows for some optimizations, since a 48-bit VA kernel can run all
> processes using 3 levels with relative ease (and switching between
> 4levels and 3levels processes would also be possible, but would either
> require a TLB flush, or would result in this optimization to be
> disabled globally, whichever is less costly in terms of performance)

I'm more for using 48-bit VA permanently for both user and kernel (and
52-bit VA at some point in the future, though limiting user space to
48-bit VA by default). But it would be good to get some benchmark
numbers on the impact to see whether it's still worth keeping the other
VA combinations around.

-- 
Catalin
