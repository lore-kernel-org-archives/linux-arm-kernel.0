From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 8 Dec 2015 11:17:46 -0800
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151208083956.GA22564@fixme-laptop.cn.ibm.com>
References: <20151204162453.GE15969@arm.com>
 <20151204164446.GF28602@linux.vnet.ibm.com>
 <20151206073712.GA1549@fixme-laptop.cn.ibm.com>
 <20151206192302.GS28602@linux.vnet.ibm.com>
 <20151206232825.GA13845@fixme-laptop.cn.ibm.com>
 <20151207000047.GX28602@linux.vnet.ibm.com>
 <20151207004504.GC13845@fixme-laptop.cn.ibm.com>
 <20151207103455.GO17308@twins.programming.kicks-ass.net>
 <20151207154514.GZ28602@linux.vnet.ibm.com>
 <20151208083956.GA22564@fixme-laptop.cn.ibm.com>
Message-ID: <20151208191746.GQ28602@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 04:42:59PM +0800, Boqun Feng wrote:
> On Mon, Dec 07, 2015 at 07:45:14AM -0800, Paul E. McKenney wrote:
> > On Mon, Dec 07, 2015 at 11:34:55AM +0100, Peter Zijlstra wrote:
> > > On Mon, Dec 07, 2015 at 08:45:04AM +0800, Boqun Feng wrote:
> > > > > > Or maybe, we introduce another address space of sparse like:
> > > > > > 
> > > > > > 	# define __private	__attribute__((noderef, address_space(6)))
> > > > > > 
> > > > > > and macro to dereference private
> > > > > > 
> > > > > > 	# define private_dereference(p) ((typeof(*p) *) p)
> > > > > > 
> > > > > > and define struct rcu_node like:
> > > > > > 
> > > > > > 	struct rcu_node {
> > > > > > 		raw_spinlock_t __private lock;	/* Root rcu_node's lock protects some */
> > > > > > 		...
> > > > > > 	};
> > > > > > 
> > > > > > and finally raw_spin_{un}lock_rcu_node() like:
> > > > > > 
> > > > > > 	static inline void raw_spin_lock_rcu_node(struct rcu_node *rnp)
> > > > > > 	{
> > > > > > 		raw_spin_lock(private_dereference(&rnp->lock));
> > > > > > 		smp_mb__after_unlock_lock();
> > > > > > 	}
> > > > > > 
> > > > > > 	static inline void raw_spin_unlock_rcu_node(struct rcu_node *rnp)
> > > > > > 	{
> > > > > > 		raw_spin_unlock(private_dereference(&rnp->lock));
> > > > > > 	}
> > > > > > 
> > > > > > This __private mechanism also works for others who wants to private
> > > > > > their fields of struct, which is not supported by C.
> > > > > > 
> > > > > > I will send two patches(one introduces __private and one uses it for
> > > > > > rcu_node->lock) if you think this is not a bad idea ;-)
> > > 
> > > > If rcu_node->lock is the only user then this is probably a bad idea, but
> > > > if others also want to have a way to privatize some fields of the
> > > > structure, this may be not that bad?
> > > 
> > > Thomas might also want this for things like
> > > irq_common_data::state_use_accessors for instance.
> 
> Good to know! Thank you, Peter ;-)
> 
> > > 
> > > And I'm fairly sure there's more out there.
> > 
> > If Thomas takes it, I will consider also applying it to RCU.
> 
> Paul, so I played with sparse a little more today, and found out that
> the address_space(6) attribute actually doesn't work here. However, the
> *noderef* attribute does work here, though the warning information is
> not very verbose, as there is no number of the address space, for
> example:
> 
> kernel/rcu/tree.c:4453:25: warning: incorrect type in argument 1 (different modifiers)
> kernel/rcu/tree.c:4453:25:    expected struct raw_spinlock [usertype] *lock
> kernel/rcu/tree.c:4453:25:    got struct raw_spinlock [noderef] *<noident>
> 
> In this example, I made rnp->lock __private and wrap *_{lock,unlock}()
> and this warning refers the raw_spin_lock_init() in rcu_init_one(). If
> we really want to privatize ->lock, we'd better also wrap this, I simply
> make an example here.
> 
> Thoughts?

I don't have any particular objection to noderef.

> The reason why address_space(6) doesn't work is that it's designed as an
> attribute of a pointer other than any type, and sparse will replace the
> members' address spaces with the address spaces of "parents" (objects of
> that struct).

IIRC, we do an artificial dereference in rcu_dereference() and friends
to get around this.  But if the noderef attribute is more natural,
why not go with it?  For one thing, you can have something that is
both __rcu and noderef, which would not be possible with sparse
address space 6.

Probably worth trying it out in a number of use cases, and perhaps you
already tried it out on an int or some such.

							Thanx, Paul
