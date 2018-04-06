From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Apr 2018 12:34:36 +0100
Subject: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
In-Reply-To: <20180405172808.GG4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
 <20180405172808.GG4082@hirez.programming.kicks-ass.net>
Message-ID: <20180406113436.GC27619@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 07:28:08PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 05, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> > @@ -340,12 +341,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >  		goto release;
> >  
> >  	/*
> > +	 * Ensure that the initialisation of @node is complete before we
> > +	 * publish the updated tail and potentially link @node into the
> > +	 * waitqueue.
> > +	 */
> > +	smp_wmb();
> 
> Maybe an explicit note to where the matching barrier lives..

Oh man, that's not a simple thing to write: there isn't a matching barrier!

Instead, we rely on dependency ordering for two cases:

  * We access a node by decoding the tail we get back from the xchg

- or -

  * We access a node by following our own ->next pointer

I could say something like:

  "Pairs with dependency ordering from both xchg_tail and explicit
   dereferences of node->next"

but it's a bit cryptic :(

Will
