From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Apr 2018 15:06:05 +0100
Subject: [PATCH v2 04/13] locking/qspinlock: Remove unbounded cmpxchg
 loop from locking slowpath
In-Reply-To: <6e6989d0-a6b1-e6fb-4f70-ab6849b715da@redhat.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
 <1523469680-17699-5-git-send-email-will.deacon@arm.com>
 <6e6989d0-a6b1-e6fb-4f70-ab6849b715da@redhat.com>
Message-ID: <20180412140605.GB21296@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 03:53:16PM -0400, Waiman Long wrote:
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index 396701e8c62d..a8fc402b3f3a 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -162,6 +162,17 @@ struct __qspinlock {
> >  
> >  #if _Q_PENDING_BITS == 8
> >  /**
> > + * clear_pending - clear the pending bit.
> > + * @lock: Pointer to queued spinlock structure
> > + *
> > + * *,1,* -> *,0,*
> > + */
> > +static __always_inline void clear_pending(struct qspinlock *lock)
> > +{
> > +	WRITE_ONCE(lock->pending, 0);
> > +}
> > +
> > +/**
> >   * clear_pending_set_locked - take ownership and clear the pending bit.
> >   * @lock: Pointer to queued spinlock structure
> >   *
> > @@ -201,6 +212,17 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> >  #else /* _Q_PENDING_BITS == 8 */
> >  
> >  /**
> > + * clear_pending - clear the pending bit.
> > + * @lock: Pointer to queued spinlock structure
> > + *
> > + * *,1,* -> *,0,*
> > + */
> > +static __always_inline void clear_pending(struct qspinlock *lock)
> > +{
> > +	atomic_andnot(_Q_PENDING_VAL, &lock->val);
> > +}
> > +
> > +/**
> >   * clear_pending_set_locked - take ownership and clear the pending bit.
> >   * @lock: Pointer to queued spinlock structure
> >   *
> 
> BTW, there is a similar clear_pending() function in
> qspinlock_paravirt.c. I think you need to remove that with this patch.

Thanks, I'll do that. I did build and bisect this series... for arm64, which
is completely useless as it doesn't get compiled until the final patch which
I haven't posted here.

Will
