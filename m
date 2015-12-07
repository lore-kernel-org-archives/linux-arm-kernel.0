From: boqun.feng@gmail.com (Boqun Feng)
Date: Mon, 7 Dec 2015 08:26:01 +0800
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151206192734.GT28602@linux.vnet.ibm.com>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151130155839.GK17308@twins.programming.kicks-ass.net>
 <20151201164035.GE27751@arm.com>
 <20151203001141.GO28602@linux.vnet.ibm.com>
 <20151203132839.GA3816@twins.programming.kicks-ass.net>
 <20151203163243.GI11337@arm.com>
 <20151203172207.GR28602@linux.vnet.ibm.com>
 <20151206081617.GB1549@fixme-laptop.cn.ibm.com>
 <20151206192734.GT28602@linux.vnet.ibm.com>
Message-ID: <20151207002601.GB13845@fixme-laptop.cn.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 06, 2015 at 11:27:34AM -0800, Paul E. McKenney wrote:
> On Sun, Dec 06, 2015 at 04:16:17PM +0800, Boqun Feng wrote:
> > Hi Paul,
> > 
> > On Thu, Dec 03, 2015 at 09:22:07AM -0800, Paul E. McKenney wrote:
> > > On Thu, Dec 03, 2015 at 04:32:43PM +0000, Will Deacon wrote:
> > > > Hi Peter, Paul,
> > > > 
> > > > Firstly, thanks for writing that up. I agree that you have something
> > > > that can work in theory, but see below.
> > > > 
> > > > On Thu, Dec 03, 2015 at 02:28:39PM +0100, Peter Zijlstra wrote:
> > > > > On Wed, Dec 02, 2015 at 04:11:41PM -0800, Paul E. McKenney wrote:
> > > > > > This looks architecture-agnostic to me:
> > > > > > 
> > > > > > a.	TSO systems have smp_mb__after_unlock_lock() be a no-op, and
> > > > > > 	have a read-only implementation for spin_unlock_wait().
> > > > > > 
> > > > > > b.	Small-scale weakly ordered systems can also have
> > > > > > 	smp_mb__after_unlock_lock() be a no-op, but must instead
> > > > > > 	have spin_unlock_wait() acquire the lock and immediately 
> > > > > > 	release it, or some optimized implementation of this.
> > > > > > 
> > > > > > c.	Large-scale weakly ordered systems are required to define
> > > > > > 	smp_mb__after_unlock_lock() as smp_mb(), but can have a
> > > > > > 	read-only implementation of spin_unlock_wait().
> > > > > 
> > > > > This would still require all relevant spin_lock() sites to be annotated
> > > > > with smp_mb__after_unlock_lock(), which is going to be a painful (no
> > > > > warning when done wrong) exercise and expensive (added MBs all over the
> > > > > place).
> > > 
> > > On the lack of warning, agreed, but please see below.  On the added MBs,
> > > the only alternative I have been able to come up with has even more MBs,
> > > as in on every lock acquisition.  If I am missing something, please do
> > > not keep it a secret!
> > > 
> > 
> > Maybe we can treat this problem as a problem of data accesses other than
> > one of locks?
> > 
> > Let's take the example of tsk->flags in do_exit() and tsk->pi_lock, we
> > don't need to add a full barrier for every lock acquisition of
> > ->pi_lock, because some critical sections of ->pi_lock don't access the
> > PF_EXITING bit of ->flags at all. What we only need is to add a full
> > barrier before reading the PF_EXITING bit in a critical section of
> > ->pi_lock. To achieve this, we could introduce a primitive like
> > smp_load_in_lock():
> > 
> > (on PPC and ARM64v8)
> > 
> > 	#define smp_load_in_lock(x, lock) 		\
> > 		({ 					\
> > 			smp_mb();			\
> > 			READ_ONCE(x);			\
> > 		})
> > 
> > (on other archs)
> > 	
> > 	#define smp_load_in_lock(x, lock) READ_ONCE(x)
> > 
> > 
> > And call it every time we read a data which is not protected by the
> > current lock critical section but whose updaters synchronize with the
> > current lock critical section with spin_unlock_wait().
> > 
> > I admit the name may be bad and the second parameter @lock is for a way
> > to diagnosing the usage which I haven't come up with yet ;-)
> > 
> > Thoughts?
> 
> In other words, dispense with smp_mb__after_unlock_lock() in those cases,
> and use smp_load_in_lock() to get the desired effect?
> 

Exactly.

> If so, one concern is how to check for proper use of smp_load_in_lock().

I also propose that on the updaters' side, we merge STORE and smp_mb()
into another primitive, maybe smp_store_out_of_lock(). After that we
make sure a smp_store_out_of_lock() plus a spin_unlock_wait() pairs with
a spin_lock plus a smp_load_in_lock() in the following way:

	CPU 0				CPU 1
	==============================================================
	smp_store_out_of_lock(o, NULL, lock);
	<other stores or reads>
	spin_unlock_wait(lock);		spin_lock(lock);
					<other stores or reads>
					obj = smp_load_in_lock(o, lock);

Their names and this pairing pattern could help us check their usages.
And we can also try to come up with a way to use lockdep to check their
usages automatically. Anyway, I don't think that is more difficult to
check the usage of smp_mb__after_unlock_lock() for the same purpose of
ordering "Prior Write" with "Current Read" ;-)

> Another concern is redundant smp_mb() instances in case of multiple
> accesses to the data under a given critical section.
> 

First, I don't think there would be too many cases which a lock critical
section needs to access multiple variables, which are modified outside
the critical section and synchronized with spin_unlock_wait(). Because
using spin_unlock_wait() to synchronize with lock critical sections is
itself an very weird usage(you could just take the lock).

Second, even if we have redundant smp_mb()s, we avoid to:

1.	use a ll/sc loop on updaters' sides as Will proposed

or

2.	put a full barrier *just* following spin_lock() as you proposed,
	which could forbid unrelated data accesses to be moved before
	the store part of spin_lock().

Whether these two perform better than redundant smp_mb()s in a lock
critical section is uncertain, right?

Third, even if this perform worse than Will's or your proposal, we don't
need to maintain two quite different ways to solve the same problem for
PPC and ARM64v8, that's one benefit of this.

Regards,
Boqun

> Or am I missing your point?
> 
> 							Thanx, Paul
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151207/cf2a48c2/attachment-0001.sig>
