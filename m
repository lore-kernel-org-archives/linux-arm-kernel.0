From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 2 Dec 2015 16:11:41 -0800
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151201164035.GE27751@arm.com>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151130155839.GK17308@twins.programming.kicks-ass.net>
 <20151201164035.GE27751@arm.com>
Message-ID: <20151203001141.GO28602@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 04:40:36PM +0000, Will Deacon wrote:
> On Mon, Nov 30, 2015 at 04:58:39PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 27, 2015 at 11:44:06AM +0000, Will Deacon wrote:
> > > Boqun Feng reported a rather nasty ordering issue with spin_unlock_wait
> > > on architectures implementing spin_lock with LL/SC sequences and acquire
> > > semantics:
> > > 
> > >  | CPU 1                   CPU 2                     CPU 3
> > >  | ==================      ====================      ==============
> > >  |                                                   spin_unlock(&lock);
> > >  |                         spin_lock(&lock):
> > >  |                           r1 = *lock; // r1 == 0;
> > >  |                         o = READ_ONCE(object); // reordered here
> > >  | object = NULL;
> > >  | smp_mb();
> > >  | spin_unlock_wait(&lock);
> > >  |                           *lock = 1;
> > >  | smp_mb();
> > >  | o->dead = true;
> > >  |                         if (o) // true
> > >  |                           BUG_ON(o->dead); // true!!
> > > 
> > > The crux of the problem is that spin_unlock_wait(&lock) can return on
> > > CPU 1 whilst CPU 2 is in the process of taking the lock. This can be
> > > resolved by upgrading spin_unlock_wait to a LOCK operation, forcing it
> > > to serialise against a concurrent locker and giving it acquire semantics
> > > in the process (although it is not at all clear whether this is needed -
> > > different callers seem to assume different things about the barrier
> > > semantics and architectures are similarly disjoint in their
> > > implementations of the macro).
> > 
> > Do we want to go do a note with spin_unlock_wait() in
> > include/linux/spinlock.h warning about these subtle issues for the next
> > arch that thinks this is a 'trivial' thing to implement?
> 
> Could do, but I still need agreement from Paul on the solution before I
> can describe it in core code. At the moment, the semantics are,
> unfortunately, arch-specific.
> 
> Paul -- did you have any more thoughts about this? I ended up at:
> 
>   https://lkml.org/lkml/2015/11/16/343
> 
> and then ran out of ideas.

Let me try one step at a time.

First, spin_unlock_wait() guarantees that all current and prior critical
sections for the lock in question have completed, so that any code
following an smp_mb() after the spin_unlock_wait() will see the effect
of those critical sections.  Oddly enough, the example above makes it
clear that this is a rather strange form of RCU.  ;-)

OK, so let me apply smp_mb__after_unlock_lock() to the example above.
For powerpc, smp_mb__after_unlock_lock() is defined as smp_mb().
This prevents the "o = READ_ONCE(object)" from being reordered with
the "*lock = 1", which should avoid the problem.

Which agrees with your first bullet in https://lkml.org/lkml/2015/11/16/343.
And with the following litmus test, which is reassuring:

	PPC spin_unlock_wait.litmus
	""
	(*
	 * Can the smp_mb__after_unlock_lock() trick save spin_unlock_wait()?
	 *)
	(* 2-Dec-2015: ppcmem and herd7 say "yes" *)
	{
	l=0; x2=x3; x3=41; x4=42;
	0:r1=1; 0:r2=x2; 0:r3=x3; 0:r4=x4; 0:r5=l;
	1:r1=1; 1:r2=x2; 1:r3=x3; 1:r4=x4; 1:r5=l;
	}
	 P0                 | P1                 ;
	 stw r4,0(r2)       | stw r1,0(r5)       ;
	 sync               | sync               ;
	 lwz r11,0(r5)      | lwz r10,0(r2)      ;
	 sync               | lwz r11,0(r10)     ;
	 stw r1,0(r3)       | lwsync             ;
			    | xor r1,r1,r1       ;
			    | stw r1,0(r5)       ;
	exists
	(0:r11=0 /\ 1:r11=1)

All well and good, but your https://lkml.org/lkml/2015/11/16/343 example
had three threads, not two.  Sounds like another litmus test is required,
which is going to require a more realistic emulation of locking.
Perhaps like this one, where P2 is modeled as initially holding the lock:

	PPC spin_unlock_wait2.litmus
	""
	(*
	 * Can the smp_mb__after_unlock_lock() trick save spin_unlock_wait()?
	 * In the case where there is a succession of two critical sections.
	 *)
	(* 2-Dec-2015: herd7 says yes, ppcmem still thinking about it. *)
	{
	l=1; x2=x3; x3=41; x4=42; x5=43;
	0:r0=0; 0:r1=1; 0:r2=x2; 0:r3=x3; 0:r4=x4; 0:r5=x5; 0:r9=l;
	1:r0=0; 1:r1=1; 1:r2=x2; 1:r3=x3; 1:r4=x4; 1:r5=x5; 1:r9=l;
	2:r0=0; 2:r1=1; 2:r2=x2; 2:r3=x3; 2:r4=x4; 2:r5=x5; 2:r9=l;
	}
	 P0                 | P1                 | P2                 ;
	 stw r4,0(r2)       | lwarx r12,r0,r9    | stw r1,0(r5)       ;
	 sync               | cmpwi r12,0        | lwsync             ;
	 lwz r11,0(r9)      | bne FAIL           | stw r0,0(r9)       ;
	 sync               | stwcx. r1,r0,r9    |                    ;
	 stw r1,0(r3)       | bne FAIL           |                    ;
	 lwz r12,0(r5)      | sync               |                    ;
			    | lwz r10,0(r2)      |                    ;
			    | lwz r11,0(r10)     |                    ;
			    | lwsync             |                    ;
			    | stw r0,0(r9)       |                    ;
			    | FAIL:              |                    ;


	exists
	(0:r11=0 /\ 1:r12=0 /\ (1:r11=1 \/ 0:r12=43))

Now herd7 says that the desired ordering is preserved, but I just
now hacked this litmus test together, and therefore don't completely
trust it.  Plus I don't completely trust herd7 with this example, and
I expect ppcmem to take some time cranking through it.

Thoughts?

For the moment, let's assume that this is correct, addressing Will's
first bullet in https://lkml.org/lkml/2015/11/16/343.  There is still
his second bullet and subsequent discussion on semantics.  I believe
that we are OK if we take this approach:

1.	If you hold a given lock, you will see all accesses done by
	all prior holders of that lock.  Here "see" splits out as
	follows:

	   Access
	Prior	Current		Result
	---------------         ---------------------------------------
	Read	Read		Current access sees same value as prior
				access, or some later value.
	Read	Write		Prior read unaffected by current write.
	Write	Read		Current read sees value written by
				prior write, or some later value.
	Write	Write		Subsequent reads see value written by
				current write, or some later value.
				Either way, the value prior write has
				been overwritten.

	This is as you would expect, but I am feeling pedantic today.

2.	If you hold a given lock, all other wannabe holders of that
	same lock are excluded.

3.	If smp_mb__after_unlock_lock() immediately follows each acquisition
	of the lock, then the spin_unlock_wait() does #1, but not #2.
	The way that #1 works is that "Current Access" is any access
	following an smp_mb() following the spin_unlock_wait(), and
	"Prior Access" is from the critical section in effect at the
	time spin_unlock_wait() started, or some earlier critical section
	for that same lock.  In some cases, you can use barriers weaker
	than smp_mb(), but you are on your own on that one.  ;-)

4.	In addition, if smp_mb__after_unlock_lock() immediately follows
	each acquisition of the lock, then code not protected by that
	lock will agree on the ordering of the accesses within critical
	sections.  This is RCU's use case.

This looks architecture-agnostic to me:

a.	TSO systems have smp_mb__after_unlock_lock() be a no-op, and
	have a read-only implementation for spin_unlock_wait().

b.	Small-scale weakly ordered systems can also have
	smp_mb__after_unlock_lock() be a no-op, but must instead
	have spin_unlock_wait() acquire the lock and immediately 
	release it, or some optimized implementation of this.

c.	Large-scale weakly ordered systems are required to define
	smp_mb__after_unlock_lock() as smp_mb(), but can have a
	read-only implementation of spin_unlock_wait().

Or am I still missing some subtle aspect of how spin_unlock_wait()
is supposed to work?  (A soberingly likely possibility, actually...)

							Thanx, Paul
