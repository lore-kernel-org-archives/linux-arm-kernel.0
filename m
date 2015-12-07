From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 7 Dec 2015 11:34:55 +0100
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151207004504.GC13845@fixme-laptop.cn.ibm.com>
References: <20151203172207.GR28602@linux.vnet.ibm.com>
 <20151204092110.GE17308@twins.programming.kicks-ass.net>
 <20151204160706.GC28602@linux.vnet.ibm.com>
 <20151204162453.GE15969@arm.com>
 <20151204164446.GF28602@linux.vnet.ibm.com>
 <20151206073712.GA1549@fixme-laptop.cn.ibm.com>
 <20151206192302.GS28602@linux.vnet.ibm.com>
 <20151206232825.GA13845@fixme-laptop.cn.ibm.com>
 <20151207000047.GX28602@linux.vnet.ibm.com>
 <20151207004504.GC13845@fixme-laptop.cn.ibm.com>
Message-ID: <20151207103455.GO17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 08:45:04AM +0800, Boqun Feng wrote:
> > > Or maybe, we introduce another address space of sparse like:
> > > 
> > > 	# define __private	__attribute__((noderef, address_space(6)))
> > > 
> > > and macro to dereference private
> > > 
> > > 	# define private_dereference(p) ((typeof(*p) *) p)
> > > 
> > > and define struct rcu_node like:
> > > 
> > > 	struct rcu_node {
> > > 		raw_spinlock_t __private lock;	/* Root rcu_node's lock protects some */
> > > 		...
> > > 	};
> > > 
> > > and finally raw_spin_{un}lock_rcu_node() like:
> > > 
> > > 	static inline void raw_spin_lock_rcu_node(struct rcu_node *rnp)
> > > 	{
> > > 		raw_spin_lock(private_dereference(&rnp->lock));
> > > 		smp_mb__after_unlock_lock();
> > > 	}
> > > 
> > > 	static inline void raw_spin_unlock_rcu_node(struct rcu_node *rnp)
> > > 	{
> > > 		raw_spin_unlock(private_dereference(&rnp->lock));
> > > 	}
> > > 
> > > This __private mechanism also works for others who wants to private
> > > their fields of struct, which is not supported by C.
> > > 
> > > I will send two patches(one introduces __private and one uses it for
> > > rcu_node->lock) if you think this is not a bad idea ;-)

> If rcu_node->lock is the only user then this is probably a bad idea, but
> if others also want to have a way to privatize some fields of the
> structure, this may be not that bad?

Thomas might also want this for things like
irq_common_data::state_use_accessors for instance.

And I'm fairly sure there's more out there.
