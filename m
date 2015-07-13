From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 16:58:30 +0100
Subject: [PATCH 13/18] arm64: cmpxchg: avoid memory barrier on comparison
 failure
In-Reply-To: <20150713153226.GA19282@twins.programming.kicks-ass.net>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-14-git-send-email-will.deacon@arm.com>
 <20150713102848.GX19282@twins.programming.kicks-ass.net>
 <20150713112226.GC2632@arm.com>
 <20150713133912.GZ19282@twins.programming.kicks-ass.net>
 <20150713145225.GG2632@arm.com>
 <20150713153226.GA19282@twins.programming.kicks-ass.net>
Message-ID: <20150713155830.GL2632@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 04:32:26PM +0100, Peter Zijlstra wrote:
> On Mon, Jul 13, 2015 at 03:52:25PM +0100, Will Deacon wrote:
> > That's an interesting case, and I think it's also broken on Alpha and Power
> > (which don't use this code). It's fun actually, because a failed cmpxchg
> > on those architectures gives you the barrier *before* the cmpxchg, but not
> > the one afterwards so it doesn't actually help here.
> > 
> > So there's three options afaict:
> > 
> >   (1) Document failed cmpxchg as having ACQUIRE semantics, and change this
> >       patch (and propose changes for Alpha and Power).
> > 
> > -or-
> > 
> >   (2) Change pv_unhash to use fake dependency ordering across the hash.
> > 
> > -or-
> > 
> >   (3) Put down an smp_rmb() between the cmpxchg and pv_unhash
> > 
> > The first two sound horrible, so I'd err towards 3, particularly as this
> > is x86-only code atm and I don't think it will have an effect there.
> 
> Right, I would definitely go for 3, but it does show there is code out
> there :/

Yeah... but I think it's rare enough that I'd be willing to call it a bug
and fix it up. Especially as the code in question is both (a) new and (b)
only built for x86 atm (which doesn't have any of these issues).

FWIW, patch below. A future change would be making the cmpxchg a
cmpxchg_release, which looks good in the unlock path and makes the need
for the smp_rmb more obvious imo.

Anyway, one step at a time.

Will

--->8

commit e24f911487db52898b7f0567a9701e93d3c3f13a
Author: Will Deacon <will.deacon@arm.com>
Date:   Mon Jul 13 16:46:59 2015 +0100

    locking/pvqspinlock: order pv_unhash after cmpxchg on unlock slowpath
    
    When we unlock in __pv_queued_spin_unlock, a failed cmpxchg on the lock
    value indicates that we need to take the slow-path and unhash the
    corresponding node blocked on the lock.
    
    Since a failed cmpxchg does not provide any memory-ordering guarantees,
    it is possible that the node data could be read before the cmpxchg on
    weakly-ordered architectures and therefore return a stale value, leading
    to hash corruption and/or a BUG().
    
    This patch adds an smb_rmb() following the failed cmpxchg operation, so
    that the unhashing is ordered after the lock has been checked.
    
    Reported-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 04ab18151cc8..f216200dea3e 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -296,6 +296,13 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 		return;
 
 	/*
+	 * A failed cmpxchg doesn't provide any memory-ordering guarantees,
+	 * so we need a barrier to order the read of the node data in
+	 * pv_unhash *after* we've read the lock being _Q_SLOW_VAL.
+	 */
+	smp_rmb();
+
+	/*
 	 * Since the above failed to release, this must be the SLOW path.
 	 * Therefore start by looking up the blocked node and unhashing it.
 	 */
