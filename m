From: jamie@shareable.org (Jamie Lokier)
Date: Sun, 13 Sep 2009 20:49:38 +0100
Subject: LDREX/STREX and pre-emption on *non*-SMP hardware
Message-ID: <20090913194938.GA30195@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> Yes, but the exclusives are not affected (see below).
> 
> > Meanwhile, if we could assume that interrupt handlers are always using
> > the LDREX/CLREX in pairs, then the same thing could be assumed for any
> > other contexts in the system, kernel/user threads. Therefore, I do not
> > think that we can make that assumption.
> 
> In user space you can get (T1, T2 are threads):
> 
> T1			T2
> LDREX
> 			LDREX
> STREX (succeeds)
> 			STREX (fails)
> 
> So the STREX in T1 shouldn't really succeed because there was a context
> switch and LDREX in T2 (this particular case may not be a problem but if
> you create a situation with 3 threads that is incorrect).

Hey, wait a moment.  It's true that with >=2 CPUs, another CPU could
write the location used by T1, so T1's STREX should not succeed.

But what about a single CPU system?

Even with 3 or more threads, I do not see how any sequence could
result in the STREX succeeding wrongly, because it can only be wrong
if there's an intermediate write to the same location, and we've
established that all writes to that location (including atomic_set)
use STREX.  And in principle, even if atomic_set is changed in future,
all paths leading to it must clear the monitor flag somehow.

In other words, it looks like CLREX is not required in __switch_to()
on single CPU systems.

What do you think Catalin?  Do you have a counterexample?

-- Jamie
