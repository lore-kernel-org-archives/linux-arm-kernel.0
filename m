From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Apr 2018 11:47:07 +0100
Subject: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
In-Reply-To: <20180407054711.rldyfcmni2wtblyu@tardis>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
 <20180407054711.rldyfcmni2wtblyu@tardis>
Message-ID: <20180409104707.GB23134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boqun,

On Sat, Apr 07, 2018 at 01:47:11PM +0800, Boqun Feng wrote:
> On Thu, Apr 05, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> > @@ -340,12 +341,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >  		goto release;
> >  
> >  	/*
> > +	 * Ensure that the initialisation of @node is complete before we
> > +	 * publish the updated tail and potentially link @node into the
> 
> I think it might be better if we mention exactly where we "publish the
> updated tail" and "link @node", how about:
> 
> 	* publish the update tail via xchg_tail() and potentially link
> 	* @node into the waitqueue via WRITE_ONCE(->next,..) below.
> 
> and also add comments below like:
> 
> > +	 * waitqueue.
> > +	 */
> > +	smp_wmb();
> > +
> > +	/*
> >  	 * We have already touched the queueing cacheline; don't bother with
> >  	 * pending stuff.
> >  	 *
> >  	 * p,*,* -> n,*,*
> > -	 *
> > -	 * RELEASE, such that the stores to @node must be complete.
> 
> 	* publish the updated tail
> 
> >  	 */
> >  	old = xchg_tail(lock, tail);
> >  	next = NULL;
> > @@ -356,15 +362,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >  	 */
> >  	if (old & _Q_TAIL_MASK) {
> >  		prev = decode_tail(old);
> > -
> > -		/*
> > -		 * We must ensure that the stores to @node are observed before
> > -		 * the write to prev->next. The address dependency from
> > -		 * xchg_tail is not sufficient to ensure this because the read
> > -		 * component of xchg_tail is unordered with respect to the
> > -		 * initialisation of @node.
> > -		 */
> > -		smp_store_release(&prev->next, node);
> 
> 		/* Eventually link @node to the wait queue */
> 	
> Thoughts?

I'll make some changes along these lines for v2. Thanks!

Will
