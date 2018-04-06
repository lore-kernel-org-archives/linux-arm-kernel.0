From: andrea.parri@amarulasolutions.com (Andrea Parri)
Date: Fri, 6 Apr 2018 15:05:12 +0200
Subject: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
In-Reply-To: <20180406113436.GC27619@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
 <20180405172808.GG4082@hirez.programming.kicks-ass.net>
 <20180406113436.GC27619@arm.com>
Message-ID: <20180406130512.GA6631@andrea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Apr 06, 2018 at 12:34:36PM +0100, Will Deacon wrote:
> On Thu, Apr 05, 2018 at 07:28:08PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 05, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> > > @@ -340,12 +341,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> > >  		goto release;
> > >  
> > >  	/*
> > > +	 * Ensure that the initialisation of @node is complete before we
> > > +	 * publish the updated tail and potentially link @node into the
> > > +	 * waitqueue.
> > > +	 */
> > > +	smp_wmb();
> > 
> > Maybe an explicit note to where the matching barrier lives..
> 
> Oh man, that's not a simple thing to write: there isn't a matching barrier!
> 
> Instead, we rely on dependency ordering for two cases:
> 
>   * We access a node by decoding the tail we get back from the xchg
> 
> - or -
> 
>   * We access a node by following our own ->next pointer
> 
> I could say something like:
> 
>   "Pairs with dependency ordering from both xchg_tail and explicit
>    dereferences of node->next"
> 
> but it's a bit cryptic :(

Agreed. ;)  It might be helpful to instead include a snippet to highlight
the interested memory accesses/dependencies; IIUC,

/*
 * Pairs with dependency ordering from both xchg_tail and explicit/?
 * dereferences of node->next:
 *
 *   CPU0
 *
 *   /* get node0, encode node0 in tail */
 *   pv_init_node(node0);
 *     ((struct pv_node *)node0)->cpu   = smp_processor_id();
 *     ((struct pv_node *)node0)->state = vcpu_running;

 *   smp_wmb();
 *   old = xchg_tail(lock, tail);
 *
 *   CPU1:
 *
 *   /* get node1, encode tail from node1 */
 *   old = xchg_tail(lock, tail);   // = tail corresponding to node0
 *                                  // head an addr. dependency
 *   /* decode old in prev */
 *   pv_wait_node(node1, prev);
 *     READ ((struct pv_node *)prev)->cpu   // addr. dependent read
 *     READ ((struct pv_node *)prev)->state // addr. dependend read
 *
 * [More details for the case "following our own ->next pointer" you
 *  mentioned dabove.]
 */

CPU1 would also have:

   WRITE_ONCE(prev->next, node1); // addr. dependent write

but I'm not sure how this pairs: does this belong to the the second
case above? can you elaborate on that?

  Andrea


> 
> Will
