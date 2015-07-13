From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 15:52:25 +0100
Subject: [PATCH 13/18] arm64: cmpxchg: avoid memory barrier on comparison
 failure
In-Reply-To: <20150713133912.GZ19282@twins.programming.kicks-ass.net>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-14-git-send-email-will.deacon@arm.com>
 <20150713102848.GX19282@twins.programming.kicks-ass.net>
 <20150713112226.GC2632@arm.com>
 <20150713133912.GZ19282@twins.programming.kicks-ass.net>
Message-ID: <20150713145225.GG2632@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 02:39:12PM +0100, Peter Zijlstra wrote:
> On Mon, Jul 13, 2015 at 12:22:27PM +0100, Will Deacon wrote:
> > Happy to update the docs. In terms of code audit, I couldn't find any
> > cmpxchg users that do something along the lines of "if the comparison
> > fails, don't loop, and instead do something to an independent address,
> > without barrier semantics that must be observed after the failed CAS":
> > 
> >   - Most (as in, it's hard to find other cases) users just loop until
> >     success, so there's no issue there.
> > 
> >   - One use-case with work on the failure path is stats update (e.g.
> >     drivers/net/ethernet/intel/ixgbe/ixgbe.h), but barrier semantics
> >     aren't required here anyway.
> > 
> >   - Another use-case is where you optimistically try a cmpxchg, then
> >     fall back on a lock if you fail (e.g. slub and cmpxchg_double).
> > 
> >   - Some other archs appear to do the same trick (alpha and powerpc).
> > 
> > So I'm confident with this change, but agree that a Docs update would
> > be beneficial. Something like below, or do you want some additional text,
> > too?
> 
> How about kernel/locking/qspinlock_paravirt.h:__pv_queued_spin_unlock()
> 
> In that case we rely on the full memory barrier of the failed cmpxchg()
> to order the load of &l->locked vs the content of node.
> 
> So in pv_wait_head() we:
> 
>   pv_hash(lock)
>     MB
>   ->locked = _SLOW_VAL
> 
> And in __pv_queued_spin_unlock() we fail the cmpxchg when _SLOW_VAL and
> rely on the barrier to ensure we observe the results of pv_hash().

That's an interesting case, and I think it's also broken on Alpha and Power
(which don't use this code). It's fun actually, because a failed cmpxchg
on those architectures gives you the barrier *before* the cmpxchg, but not
the one afterwards so it doesn't actually help here.

So there's three options afaict:

  (1) Document failed cmpxchg as having ACQUIRE semantics, and change this
      patch (and propose changes for Alpha and Power).

-or-

  (2) Change pv_unhash to use fake dependency ordering across the hash.

-or-

  (3) Put down an smp_rmb() between the cmpxchg and pv_unhash

The first two sound horrible, so I'd err towards 3, particularly as this
is x86-only code atm and I don't think it will have an effect there.

Will
