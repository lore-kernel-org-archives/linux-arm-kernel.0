From: boqun.feng@gmail.com (Boqun Feng)
Date: Fri, 11 Dec 2015 16:09:11 +0800
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151207002601.GB13845@fixme-laptop.cn.ibm.com>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151130155839.GK17308@twins.programming.kicks-ass.net>
 <20151201164035.GE27751@arm.com>
 <20151203001141.GO28602@linux.vnet.ibm.com>
 <20151203132839.GA3816@twins.programming.kicks-ass.net>
 <20151203163243.GI11337@arm.com>
 <20151203172207.GR28602@linux.vnet.ibm.com>
 <20151206081617.GB1549@fixme-laptop.cn.ibm.com>
 <20151206192734.GT28602@linux.vnet.ibm.com>
 <20151207002601.GB13845@fixme-laptop.cn.ibm.com>
Message-ID: <20151211080911.GD1072@fixme-laptop.cn.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 08:26:01AM +0800, Boqun Feng wrote:
> On Sun, Dec 06, 2015 at 11:27:34AM -0800, Paul E. McKenney wrote:
> > On Sun, Dec 06, 2015 at 04:16:17PM +0800, Boqun Feng wrote:
> > > Hi Paul,
> > > 
> > > On Thu, Dec 03, 2015 at 09:22:07AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Dec 03, 2015 at 04:32:43PM +0000, Will Deacon wrote:
> > > > > Hi Peter, Paul,
> > > > > 
> > > > > Firstly, thanks for writing that up. I agree that you have something
> > > > > that can work in theory, but see below.
> > > > > 
> > > > > On Thu, Dec 03, 2015 at 02:28:39PM +0100, Peter Zijlstra wrote:
> > > > > > On Wed, Dec 02, 2015 at 04:11:41PM -0800, Paul E. McKenney wrote:
> > > > > > > This looks architecture-agnostic to me:
> > > > > > > 
> > > > > > > a.	TSO systems have smp_mb__after_unlock_lock() be a no-op, and
> > > > > > > 	have a read-only implementation for spin_unlock_wait().
> > > > > > > 
> > > > > > > b.	Small-scale weakly ordered systems can also have
> > > > > > > 	smp_mb__after_unlock_lock() be a no-op, but must instead
> > > > > > > 	have spin_unlock_wait() acquire the lock and immediately 
> > > > > > > 	release it, or some optimized implementation of this.
> > > > > > > 
> > > > > > > c.	Large-scale weakly ordered systems are required to define
> > > > > > > 	smp_mb__after_unlock_lock() as smp_mb(), but can have a
> > > > > > > 	read-only implementation of spin_unlock_wait().
> > > > > > 
> > > > > > This would still require all relevant spin_lock() sites to be annotated
> > > > > > with smp_mb__after_unlock_lock(), which is going to be a painful (no
> > > > > > warning when done wrong) exercise and expensive (added MBs all over the
> > > > > > place).
> > > > 
> > > > On the lack of warning, agreed, but please see below.  On the added MBs,
> > > > the only alternative I have been able to come up with has even more MBs,
> > > > as in on every lock acquisition.  If I am missing something, please do
> > > > not keep it a secret!
> > > > 
> > > 
> > > Maybe we can treat this problem as a problem of data accesses other than
> > > one of locks?
> > > 
> > > Let's take the example of tsk->flags in do_exit() and tsk->pi_lock, we
> > > don't need to add a full barrier for every lock acquisition of
> > > ->pi_lock, because some critical sections of ->pi_lock don't access the
> > > PF_EXITING bit of ->flags at all. What we only need is to add a full
> > > barrier before reading the PF_EXITING bit in a critical section of
> > > ->pi_lock. To achieve this, we could introduce a primitive like
> > > smp_load_in_lock():
> > > 
> > > (on PPC and ARM64v8)
> > > 
> > > 	#define smp_load_in_lock(x, lock) 		\
> > > 		({ 					\
> > > 			smp_mb();			\
> > > 			READ_ONCE(x);			\
> > > 		})
> > > 
> > > (on other archs)
> > > 	
> > > 	#define smp_load_in_lock(x, lock) READ_ONCE(x)
> > > 
> > > 
> > > And call it every time we read a data which is not protected by the
> > > current lock critical section but whose updaters synchronize with the
> > > current lock critical section with spin_unlock_wait().
> > > 
> > > I admit the name may be bad and the second parameter @lock is for a way
> > > to diagnosing the usage which I haven't come up with yet ;-)
> > > 
> > > Thoughts?
> > 
> > In other words, dispense with smp_mb__after_unlock_lock() in those cases,
> > and use smp_load_in_lock() to get the desired effect?
> > 
> 
> Exactly.
> 
> > If so, one concern is how to check for proper use of smp_load_in_lock().
> 
> I also propose that on the updaters' side, we merge STORE and smp_mb()
> into another primitive, maybe smp_store_out_of_lock(). After that we
> make sure a smp_store_out_of_lock() plus a spin_unlock_wait() pairs with
> a spin_lock plus a smp_load_in_lock() in the following way:
> 
> 	CPU 0				CPU 1
> 	==============================================================
> 	smp_store_out_of_lock(o, NULL, lock);
> 	<other stores or reads>
> 	spin_unlock_wait(lock);		spin_lock(lock);
> 					<other stores or reads>
> 					obj = smp_load_in_lock(o, lock);
> 
> Their names and this pairing pattern could help us check their usages.
> And we can also try to come up with a way to use lockdep to check their
> usages automatically. Anyway, I don't think that is more difficult to
> check the usage of smp_mb__after_unlock_lock() for the same purpose of
> ordering "Prior Write" with "Current Read" ;-)
> 
> > Another concern is redundant smp_mb() instances in case of multiple
> > accesses to the data under a given critical section.
> > 
> 
> First, I don't think there would be too many cases which a lock critical
> section needs to access multiple variables, which are modified outside
> the critical section and synchronized with spin_unlock_wait(). Because
> using spin_unlock_wait() to synchronize with lock critical sections is
> itself an very weird usage(you could just take the lock).
> 
> Second, even if we have redundant smp_mb()s, we avoid to:
> 
> 1.	use a ll/sc loop on updaters' sides as Will proposed
> 
> or
> 
> 2.	put a full barrier *just* following spin_lock() as you proposed,
> 	which could forbid unrelated data accesses to be moved before
> 	the store part of spin_lock().
> 
> Whether these two perform better than redundant smp_mb()s in a lock
> critical section is uncertain, right?
> 
> Third, even if this perform worse than Will's or your proposal, we don't
> need to maintain two quite different ways to solve the same problem for
> PPC and ARM64v8, that's one benefit of this.
> 

Perhaps it's better if we could look into the use cases before we make a
move. So I have gone through all the uses of spin_unlock_wait() and
friends, and there is a lot of fun ;-)

Cscope tells me there are 7 uses of spin_unlock_wait() and friends. And
AFAICS, a fix is really needed, only if spin_unlock_wait() with a
smp_mb() preceding it wants to synchronize the memory accesses before
the smp_mb() with the memory accesses in the next lock critical section.
So in these 7 uses, 3 of them surely don't need to fix, which are
(according to Linus and Peter:
http://marc.info/?l=linux-kernel&m=144768943410858):

*	spin_unlock_wait() in sem_wait_array()
*	spin_unlock_wait() in exit_sem()
*	spin_unlock_wait() in completion_done()

And for the rest four, I think one of them doesn't need to fix either:

*	spin_unlock_wait() in ata_scsi_cmd_error_handler()

as there is no smp_mb() before it, and the logic here seems to be simply
waiting for the erred host to release its lock so that the error handler
can begin, though I'm not 100% sure because I have zero knowledge of the
ata stuff.

For the rest three, related lock critical sections and related varibles
are as follow:

1.	raw_spin_unlock_wait() after exit_signals() in do_exit()

	wants to synchronize the STORE to PF_EXITING bit in task->flags
	with the LOAD from PF_EXITING bit in task->flags in the critical
	section of task->pi_lock in attach_to_pi_owner()

2.	raw_spin_unlock_wait() after exit_rcu() in do_exit()

	wants to synchronize the STORE to task->state
	with the LOAD from task->state in the critical section of
	task->pi_lock in try_to_wake_up()

3.	raw_spin_unlock_wait() in task_work_run()

	wants to synchronize the STORE to task->task_works
	with the LOAD from task->task_works in the critical section of
	task->pi_lock in task_work_cancel()

(One interesting thing is that in use #3, the critical section of
->pi_lock protects nothing but the the task->task_works and other
operations on task->task_works don't use a lock, which at least
indicates we can use a different lock there.)

In conclusion, we have more than a half of uses working well already,
and each of the fix-needed ones has only one related critical section
and only one related data access in it. So on PPC, I think my proposal
won't have more smp_mb() instances to fix all current use cases than
adding smp_mb__after_unlock_lock() after the lock acquisition in each
related lock critical section.

Of course, my proposal needs the buy-ins of both PPC and ARM64v8, so
Paul and Will, what do you think? ;-)

Regards,
Boqun
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151211/0a071fed/attachment.sig>
