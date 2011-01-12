From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 12 Jan 2011 14:59:39 -0600
Subject: BUG: spinlock recursion (sys_chdir, user_path_at,
	do_path_lookup ...)
Message-ID: <AANLkTimb3i4BiuXvnCdhXn-xnN==NjVg8MDLsDkuFwLC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I picked this mail from google so I might be missing some recipients.

On Wed, 12 Jan 2011, Russell King - ARM Linux wrote:
> On Wed, Jan 12, 2011 at 12:35:08PM +0000, Russell King - ARM Linux wrote:
> > ARM doesn't implement save_stack_trace_regs() nor save_stack_trace_bp()
> > so if the compiler referenced these, you'd have a kernel which doesn't
> > link.  The only places that this symbol appears is:
> >
> > arch/x86/kernel/stacktrace.c:void save_stack_trace_regs(struct stack_trace *trac
> > arch/x86/mm/kmemcheck/error.c:  save_stack_trace_regs(&e->trace, regs);
> > include/linux/stacktrace.h:extern void save_stack_trace_regs(struct stack_trace
> >
> > So, if this is where your bisect decided was the problem, your bisect
> > was faulty.
>
> BTW, a useful thing to do after a bisect is to return to the point in
> the history where you first noticed the regression (so Linus' tip,
> your tip, or whatever).  Then try reverting the commit which git bisect
> _thinks_ is the cause of your problem and re-test that.
>
> If the problem is fixed, you have greater confidence that the commit is
> the problem.

Reverting this commit (9c0729dc8062bed96189bd14ac6d4920f3958743 )
didn't improve in my case.

> If it made no difference, then you know that something else (maybe in
> combination) is causing the problem.

I tried to narrow it down using the dump and another thread mentioning
recent changes from "Nick" (might be Nick Piggin).

Reverting: fs: rcu-walk aware d_revalidate method
commit: 34286d6662308d82aed891852d04c7c3a2649b16

Seems to get rid of the bug, hopefully it will give more information
to someone more experienced with this code (than me).

Regards,

Omar
