From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Feb 2018 18:04:36 +0000
Subject: revisit arm64 per-task stack canaries
In-Reply-To: <CAKv+Gu-WVMnk2AhB9ziupL-TQoR8gZ121mkQAV9mvbgjirhbmg@mail.gmail.com>
References: <CAKv+Gu9RAXhMAwKJgNAZEBZRMNfpyDNS-rxa+U2EpNxEVq77vQ@mail.gmail.com>
 <20180213125201.otz3cse4wftcq4fe@lakrids.cambridge.arm.com>
 <CAKv+Gu-WVMnk2AhB9ziupL-TQoR8gZ121mkQAV9mvbgjirhbmg@mail.gmail.com>
Message-ID: <20180213180436.GA21758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, Feb 13, 2018 at 01:56:49PM +0000, Ard Biesheuvel wrote:
> On 13 February 2018 at 12:52, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Feb 13, 2018 at 12:36:02PM +0000, Ard Biesheuvel wrote:
> >> Instead, I have proposed a proof of concept [0] where the compiler
> >> emits an instruction sequence that loads the canary directly from the
> >> task struct, which is the per-thread data structure maintained by the
> >> kernel. Accessing that can be done safely without any of the
> >> limitations per-CPU variables have. The task struct pointer is kept in
> >> system register sp_el0 while running in the kernel.
> >
> > My major concern here is being tied to using sysregs in a particular
> > way. We might want to fiddle with that in future (e.g. using the
> > platform register as an optimization, or switching to a different sysreg
> > due to architectural extensions).
> >
> 
> Yes. Also, there is a disparity between userland (using tpidr_el0) and
> kernel (using sp_el0), and perhaps it would make more sense to switch
> to tpidr_el0 in the kernel as well. But the general objection remains.

Indeed, and I share Mark's view that we don't want to commit to a specific
sequence here. Ideally, we'd have a way to pass whatever thunk we need to
the compiler and have the freedom to implement it as we see fit (and to
change that implementation at a whim).

> >> The purpose of this email to reach agreement between the various
> >> stakeholders (mainly the arm64 linux maintainers and the ARM GCC
> >> maintainers) on a way to proceed with implementing this in GCC.
> >
> > Would it be possible to have an always inline function to get the
> > canary, which GCC would implicitly fold into functions as necessary?
> >
> > ... then we could have something in a header, like:
> >
> > static __always_inline unsigned long get_task_canary(void)
> > {
> >         return current->canary;
> > }
> >
> > ... which we could change in future as needs change.
> >
> 
> This is a question to the compiler folks, I suppose, but I'd venture a
> guess that this is rather hard. Perhaps a true function call would be
> better if it is done in a way that can be optimized by LTO (this is of
> course assuming that by GCC 9, this is something we are likely to use
> in the kernel)
> 
> An alternative could be to decide to rely on a GCC plugin instead
> (although this would not be my preference). My poc implementation is a
> bit clunky, but I did not spend a lot of time on it. If we can refine
> it to replace the high/lo ref to __stack_chk_guard with something more
> robust, then we remain in control of which register and/or symbol ref
> we use and we don't paint ourselves into a corner.

I'm wary of our ability to maintain a GCC plugin in the kernel source tree.
I would *much* prefer to have proper support in the compiler.

Will
