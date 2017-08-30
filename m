From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Aug 2017 13:48:05 +0300
Subject: [RFC PATCH] arm64: move THREAD_* definitions to separated header
In-Reply-To: <20170830095854.GA17353@leverpostej>
References: <20170830092249.20638-1-ynorov@caviumnetworks.com>
 <20170830095854.GA17353@leverpostej>
Message-ID: <20170830104805.cl44gwqslocnr5w4@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 10:58:54AM +0100, Mark Rutland wrote:
> On Wed, Aug 30, 2017 at 12:22:49PM +0300, Yury Norov wrote:
> > Hi Mark, all.
> 
> Hi Yury, 
> 
> > In patch 'dbc9344a68e506f19f8 ("arm64: clean up THREAD_* definitions")'
> > you move THREAD_* definitions from arch/arm64/include/asm/thread_info.h
> > to asm/memory.h. After that asm/thread_info.h starts to depend on
> > asm/memory.h.
> > 
> > When I try to apply ilp32 series on top of it [1], it causes circular
> > dependencies like this one:
> > 
> > In file included from ./arch/arm64/include/asm/memory.h:30:0,
> >                  from ./arch/arm64/include/asm/thread_info.h:30,
> >                  from ./include/linux/thread_bits.h:20,
> >                  from ./include/linux/thread_info.h:13,
> >                  from ./include/asm-generic/preempt.h:4,
> >                  from ./arch/arm64/include/generated/asm/preempt.h:1,
> >                  from ./include/linux/preempt.h:80,
> >                  from ./include/linux/rcupdate.h:40,
> >                  from ./include/linux/rculist.h:10,
> >                  from ./include/linux/pid.h:4,
> >                  from ./include/linux/sched.h:13,
> >                  from arch/arm64/kernel/asm-offsets.c:21:
> > ./arch/arm64/include/asm/is_compat.h: In function ?is_a32_compat_task?:
> > ./arch/arm64/include/asm/is_compat.h:25:9: error: implicit declaration of function ?test_thread_flag? [-Werror=implicit-function-declaration]
> >   return test_thread_flag(TIF_32BIT);
> >          ^~~~~~~~~~~~~~~~
> > 
> > The problem is that asm/memory.h depends on asm/is_compat.h to define
> > TASK_SIZE, which in turn requires asm/thread_info.h.
> 
> ... and <asm/thread_info.h> include <asm/memory.h>, giving a circular
> dependency.
> 
> In other architectures, TASK_SIZE is defined in processor.h. Can we not
> move TASK_SIZE instead of THREAD_SIZE, given that TASK_SIZE is what
> causes the dependency?
> 
> We'd need a new __ASSEMBLY__ guard, but otherwise it looks like that
> would solve the issue.
> 
> > The most obvious solution for it is to create is_compat.c file and make
> > is_*_compat() real functions. The other option is to move THREAD_*
> > definitions to separated macro. I would prefer 2nd one because of following
> > reasons:
> >  - TASK_SIZE macro is used many times in kernel, including hot paths;
> >  - asm/memory.h is included widely, as well as asm/thread_info.h, and it's
> >    better not to make them depend one from another;
> >  - THREAD_SIZE etc are not memory-related definitions.
> 
> I disagree with this last point. THREAD_SIZE is in <asm/memory.h>
> because it affects the kernel's memory layout, as with other definitions
> at the top of <asm/memory.h>.
> 
> I would much prefer keeping those definitions together.
> 
> > In this patch THREAD_* definitions moved to separated asm/thread_size.h
> > header. It's enough to resolve dependency above.
> >
> > If you find this approach useful, I can prepare other patch that moves
> > TASK_* definitions from asm/memory.h to new header to remove the dependency
> > from asm/is_compat.h.
> 
> I'd prefer that we moved the TASK_SIZE* definitions first, but if
> necessary, I'm ok with seeing the THREAD_SIZE* definitions move.

OK, I will try this, and if it's be enough will send new patch. If not -
I'll resend this patch and one that moves TASK_SIZE* together in series.

> [...]
> 
> > diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> 
> > -#include <asm/memory.h>
> > +#include <asm/thread_size.h>
> >  #include <asm/stack_pointer.h>
> >  #include <asm/types.h>
> 
> Nit: please keep includes ordered alphabetically.

OK

> [...]
> 
> > diff --git a/arch/arm64/include/asm/thread_size.h b/arch/arm64/include/asm/thread_size.h
> 
> > +#ifdef __KERNEL__
> 
> This can go. We haven't needed __KERNEL__ ifdefs for a long time now...

OK

> [...]
> 
> > diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
> > index e56d848b6466..46b91702ea26 100644
> > --- a/arch/arm64/kernel/hibernate-asm.S
> > +++ b/arch/arm64/kernel/hibernate-asm.S
> > @@ -22,7 +22,6 @@
> >  #include <asm/asm-offsets.h>
> >  #include <asm/assembler.h>
> >  #include <asm/cputype.h>
> > -#include <asm/memory.h>
> >  #include <asm/page.h>
> >  #include <asm/virt.h>
> 
> AFAICT, we can also lose <linux/errno.h>, <asm/cputype.h>, and
> <asm/virt.h>.
> 
> Changes to this file might be better as a preparatory cleanup.

OK.

Yury
