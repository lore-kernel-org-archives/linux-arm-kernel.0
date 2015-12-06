From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sun, 6 Dec 2015 11:27:34 -0800
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151206081617.GB1549@fixme-laptop.cn.ibm.com>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151130155839.GK17308@twins.programming.kicks-ass.net>
 <20151201164035.GE27751@arm.com>
 <20151203001141.GO28602@linux.vnet.ibm.com>
 <20151203132839.GA3816@twins.programming.kicks-ass.net>
 <20151203163243.GI11337@arm.com>
 <20151203172207.GR28602@linux.vnet.ibm.com>
 <20151206081617.GB1549@fixme-laptop.cn.ibm.com>
Message-ID: <20151206192734.GT28602@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 06, 2015 at 04:16:17PM +0800, Boqun Feng wrote:
> Hi Paul,
> 
> On Thu, Dec 03, 2015 at 09:22:07AM -0800, Paul E. McKenney wrote:
> > On Thu, Dec 03, 2015 at 04:32:43PM +0000, Will Deacon wrote:
> > > Hi Peter, Paul,
> > > 
> > > Firstly, thanks for writing that up. I agree that you have something
> > > that can work in theory, but see below.
> > > 
> > > On Thu, Dec 03, 2015 at 02:28:39PM +0100, Peter Zijlstra wrote:
> > > > On Wed, Dec 02, 2015 at 04:11:41PM -0800, Paul E. McKenney wrote:
> > > > > This looks architecture-agnostic to me:
> > > > > 
> > > > > a.	TSO systems have smp_mb__after_unlock_lock() be a no-op, and
> > > > > 	have a read-only implementation for spin_unlock_wait().
> > > > > 
> > > > > b.	Small-scale weakly ordered systems can also have
> > > > > 	smp_mb__after_unlock_lock() be a no-op, but must instead
> > > > > 	have spin_unlock_wait() acquire the lock and immediately 
> > > > > 	release it, or some optimized implementation of this.
> > > > > 
> > > > > c.	Large-scale weakly ordered systems are required to define
> > > > > 	smp_mb__after_unlock_lock() as smp_mb(), but can have a
> > > > > 	read-only implementation of spin_unlock_wait().
> > > > 
> > > > This would still require all relevant spin_lock() sites to be annotated
> > > > with smp_mb__after_unlock_lock(), which is going to be a painful (no
> > > > warning when done wrong) exercise and expensive (added MBs all over the
> > > > place).
> > 
> > On the lack of warning, agreed, but please see below.  On the added MBs,
> > the only alternative I have been able to come up with has even more MBs,
> > as in on every lock acquisition.  If I am missing something, please do
> > not keep it a secret!
> > 
> 
> Maybe we can treat this problem as a problem of data accesses other than
> one of locks?
> 
> Let's take the example of tsk->flags in do_exit() and tsk->pi_lock, we
> don't need to add a full barrier for every lock acquisition of
> ->pi_lock, because some critical sections of ->pi_lock don't access the
> PF_EXITING bit of ->flags at all. What we only need is to add a full
> barrier before reading the PF_EXITING bit in a critical section of
> ->pi_lock. To achieve this, we could introduce a primitive like
> smp_load_in_lock():
> 
> (on PPC and ARM64v8)
> 
> 	#define smp_load_in_lock(x, lock) 		\
> 		({ 					\
> 			smp_mb();			\
> 			READ_ONCE(x);			\
> 		})
> 
> (on other archs)
> 	
> 	#define smp_load_in_lock(x, lock) READ_ONCE(x)
> 
> 
> And call it every time we read a data which is not protected by the
> current lock critical section but whose updaters synchronize with the
> current lock critical section with spin_unlock_wait().
> 
> I admit the name may be bad and the second parameter @lock is for a way
> to diagnosing the usage which I haven't come up with yet ;-)
> 
> Thoughts?

In other words, dispense with smp_mb__after_unlock_lock() in those cases,
and use smp_load_in_lock() to get the desired effect?

If so, one concern is how to check for proper use of smp_load_in_lock().
Another concern is redundant smp_mb() instances in case of multiple
accesses to the data under a given critical section.

Or am I missing your point?

							Thanx, Paul
