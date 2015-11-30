From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 30 Nov 2015 10:21:37 -0800
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151130155839.GK17308@twins.programming.kicks-ass.net>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151130155839.GK17308@twins.programming.kicks-ass.net>
Message-ID: <20151130182137.GY26643@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 04:58:39PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 27, 2015 at 11:44:06AM +0000, Will Deacon wrote:
> > Boqun Feng reported a rather nasty ordering issue with spin_unlock_wait
> > on architectures implementing spin_lock with LL/SC sequences and acquire
> > semantics:
> > 
> >  | CPU 1                   CPU 2                     CPU 3
> >  | ==================      ====================      ==============
> >  |                                                   spin_unlock(&lock);
> >  |                         spin_lock(&lock):
> >  |                           r1 = *lock; // r1 == 0;
> >  |                         o = READ_ONCE(object); // reordered here
> >  | object = NULL;
> >  | smp_mb();
> >  | spin_unlock_wait(&lock);
> >  |                           *lock = 1;
> >  | smp_mb();
> >  | o->dead = true;
> >  |                         if (o) // true
> >  |                           BUG_ON(o->dead); // true!!
> > 
> > The crux of the problem is that spin_unlock_wait(&lock) can return on
> > CPU 1 whilst CPU 2 is in the process of taking the lock. This can be
> > resolved by upgrading spin_unlock_wait to a LOCK operation, forcing it
> > to serialise against a concurrent locker and giving it acquire semantics
> > in the process (although it is not at all clear whether this is needed -
> > different callers seem to assume different things about the barrier
> > semantics and architectures are similarly disjoint in their
> > implementations of the macro).
> 
> Do we want to go do a note with spin_unlock_wait() in
> include/linux/spinlock.h warning about these subtle issues for the next
> arch that thinks this is a 'trivial' thing to implement?

Hear, hear!!!

							Thanx, Paul
