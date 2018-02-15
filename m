From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 15 Feb 2018 12:49:27 +0100
Subject: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
In-Reply-To: <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
 <20180214150739.GH2992@arm.com>
 <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
 <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
Message-ID: <20180215114927.GV25201@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 06:53:44PM +0000, Mathieu Desnoyers wrote:
> However, given the scenario involves multiples CPUs (one doing exit_mm(),
> the other doing context switch), the actual order of perceived load/store
> can be shuffled. And AFAIU nothing prevents the CPU from ordering the
> atomic_inc() done by mmgrab(mm) _after_ the store to current->mm.
> 
> I wonder if we should not simply add a smp_mb__after_atomic() into
> mmgrab() instead ? I see that e.g. futex.c does:

Don't think so, the futex case is really rather special and I suspect
this one is too. I would much rather have explicit comments rather than
implicit works by magic.

As per the rationale used for refcount_t, increments should be
unordered, because you ACQUIRE your object _before_ you can do the
increment.

The futex thing is simply abusing a bunch of implied barriers and
patching up the holes in paths that didn't already imply a barrier in
order to avoid having to add explicit barriers (which had measurable
performance issues).

And here we have explicit ordering outside of the reference counting
too, we want to ensure the reference is incremented before we modify
a second object.

This ordering is not at all related to acquiring the reference, so
bunding it seems odd.
