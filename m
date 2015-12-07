From: boqun.feng@gmail.com (Boqun Feng)
Date: Mon, 7 Dec 2015 08:45:04 +0800
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151207000047.GX28602@linux.vnet.ibm.com>
References: <20151203163243.GI11337@arm.com>
 <20151203172207.GR28602@linux.vnet.ibm.com>
 <20151204092110.GE17308@twins.programming.kicks-ass.net>
 <20151204160706.GC28602@linux.vnet.ibm.com>
 <20151204162453.GE15969@arm.com>
 <20151204164446.GF28602@linux.vnet.ibm.com>
 <20151206073712.GA1549@fixme-laptop.cn.ibm.com>
 <20151206192302.GS28602@linux.vnet.ibm.com>
 <20151206232825.GA13845@fixme-laptop.cn.ibm.com>
 <20151207000047.GX28602@linux.vnet.ibm.com>
Message-ID: <20151207004504.GC13845@fixme-laptop.cn.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 06, 2015 at 04:00:47PM -0800, Paul E. McKenney wrote:
> On Mon, Dec 07, 2015 at 07:28:25AM +0800, Boqun Feng wrote:
> > On Sun, Dec 06, 2015 at 11:23:02AM -0800, Paul E. McKenney wrote:
> > > On Sun, Dec 06, 2015 at 03:37:23PM +0800, Boqun Feng wrote:
> > > > Hi Paul,
> > > > 
> > > > On Fri, Dec 04, 2015 at 08:44:46AM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Dec 04, 2015 at 04:24:54PM +0000, Will Deacon wrote:
> > > > > > On Fri, Dec 04, 2015 at 08:07:06AM -0800, Paul E. McKenney wrote:
> > > > > > > On Fri, Dec 04, 2015 at 10:21:10AM +0100, Peter Zijlstra wrote:
> > > > > > > > On Thu, Dec 03, 2015 at 09:22:07AM -0800, Paul E. McKenney wrote:
> > > > > > > > > >   2. Only PowerPC is going to see the (very occassional) failures, so
> > > > > > > > > >      testing this is nigh on impossible :(
> > > > > > > > > 
> > > > > > > > > Indeed, we clearly cannot rely on normal testing, witness rcutorture
> > > > > > > > > failing to find the missing smp_mb__after_unlock_lock() instances that
> > > > > > > > > Peter found by inspection.  So I believe that augmented testing is
> > > > > > > > > required, perhaps as suggested above.
> > > > > > > > 
> > > > > > > > To be fair, those were in debug code and non critical for correctness
> > > > > > > > per se. That is, at worst the debug print would've observed an incorrect
> > > > > > > > value.
> > > > > > > 
> > > > > > > True enough, but there is still risk from people repurposing debug code
> > > > > > > for non-debug uses.  Still, thank you, I don't feel -quite- so bad about
> > > > > > > rcutorture's failure to find these.  ;-)
> > > > > > 
> > > > > > It's the ones that it's yet to find that you should be worried about,
> > > > > > and the debug code is all fixed ;)
> > > > > 
> > > > > Fortunately, when Peter sent the patch fixing the debug-only
> > > > > cases, he also created wrapper functions for the various types of
> > > > > lock acquisition for rnp->lock.  Of course, the danger is that I
> > > > > might type "raw_spin_lock_irqsave(&rnp->lock, flags)" instead of
> > > > > "raw_spin_lock_irqsave_rcu_node(rnp, flags)" out of force of habit.
> > > > > So I must occasionally scan the RCU source code for "spin_lock.*->lock",
> > > > > which I just now did.  ;-)
> > > > 
> > > > Maybe you can rename ->lock of rnp to ->lock_acquired_on_your_own_risk
> > > > to avoid the force of habit ;-)
> > > 
> > > Sold!  Though with a shorter alternate name...  And timing will be an
> > > issue.  Probably needs to go into the first post-v4.5 set (due to the
> > > high expected conflict rate), and probably needs to create wrappers for
> > > the spin_unlock functions.
> > 
> > Or maybe, we introduce another address space of sparse like:
> > 
> > 	# define __private	__attribute__((noderef, address_space(6)))
> > 
> > and macro to dereference private
> > 
> > 	# define private_dereference(p) ((typeof(*p) *) p)
> > 
> > and define struct rcu_node like:
> > 
> > 	struct rcu_node {
> > 		raw_spinlock_t __private lock;	/* Root rcu_node's lock protects some */
> > 		...
> > 	};
> > 
> > and finally raw_spin_{un}lock_rcu_node() like:
> > 
> > 	static inline void raw_spin_lock_rcu_node(struct rcu_node *rnp)
> > 	{
> > 		raw_spin_lock(private_dereference(&rnp->lock));
> > 		smp_mb__after_unlock_lock();
> > 	}
> > 
> > 	static inline void raw_spin_unlock_rcu_node(struct rcu_node *rnp)
> > 	{
> > 		raw_spin_unlock(private_dereference(&rnp->lock));
> > 	}
> > 
> > This __private mechanism also works for others who wants to private
> > their fields of struct, which is not supported by C.
> > 
> > I will send two patches(one introduces __private and one uses it for
> > rcu_node->lock) if you think this is not a bad idea ;-)
> 
> This approach reminds me of an old saying from my childhood: "Attacking
> a flea with a sledgehammer".  ;-)
> 

;-) ;-) ;-)

We have a similar saying in Chinese, using a different animal and a
different tool ;-)

If rcu_node->lock is the only user then this is probably a bad idea, but
if others also want to have a way to privatize some fields of the
structure, this may be not that bad?

Regards,
Boqun

> 							Thanx, Paul
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151207/a9c5f026/attachment.sig>
