From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Oct 2017 15:42:57 +0100
Subject: [PATCH 5/6] kernel/locking: Prevent slowpath writers getting
 held up by fastpath
In-Reply-To: <20171005135618.yufhaklq5cefaiyn@hirez.programming.kicks-ass.net>
References: <1507208097-825-1-git-send-email-will.deacon@arm.com>
 <1507208097-825-6-git-send-email-will.deacon@arm.com>
 <20171005135618.yufhaklq5cefaiyn@hirez.programming.kicks-ass.net>
Message-ID: <20171005144256.GF11088@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Peter,

Thanks for having a look.

On Thu, Oct 05, 2017 at 03:56:18PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 05, 2017 at 01:54:56PM +0100, Will Deacon wrote:
> > When a prospective writer takes the qrwlock locking slowpath due to the
> > lock being held, it attempts to cmpxchg the wmode field from 0 to
> > _QW_WAITING so that concurrent lockers also take the slowpath and queue
> > on the spinlock accordingly, allowing the lockers to drain.
> > 
> > Unfortunately, this isn't fair, because a fastpath writer that comes in
> > after the lock is made available but before the _QW_WAITING flag is set
> > can effectively jump the queue. If there is a steady stream of prospective
> > writers, then the waiter will be held off indefinitely.
> > 
> > This patch restores fairness by separating _QW_WAITING and _QW_LOCKED
> > into two bits in the wmode byte and having the waiter set _QW_WAITING
> > unconditionally. This then forces the slow-path for concurrent lockers,
> > but requires that a writer unlock operation performs an
> > atomic_sub_release instead of a store_release so that the waiting status
> > is preserved.
> 
> > diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> > index 02c0a768e6b0..8b7edef500e5 100644
> > --- a/include/asm-generic/qrwlock.h
> > +++ b/include/asm-generic/qrwlock.h
> > @@ -41,7 +41,7 @@
> >   *       +----+----+----+----+
> >   */
> >  #define	_QW_WAITING	1		/* A writer is waiting	   */
> > -#define	_QW_LOCKED	0xff		/* A writer holds the lock */
> > +#define	_QW_LOCKED	2		/* A writer holds the lock */
> >  #define	_QW_WMASK	0xff		/* Writer mask		   */
> >  #define	_QR_SHIFT	8		/* Reader count shift	   */
> >  #define _QR_BIAS	(1U << _QR_SHIFT)
> > @@ -134,7 +134,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
> >   */
> >  static inline void queued_write_unlock(struct qrwlock *lock)
> >  {
> > -	smp_store_release(&lock->wmode, 0);
> > +	(void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
> >  }
> 
> That is a fairly painful hit on x86. Changes a regular store into an
> "LOCK XADD" +20 cycles right there.

Yeah, I mentioned that in the cover letter which is also why it's at the end
of the series ;) However, it's worth noting that this is the same as the
reader unlock path and, as it stands, there's a real risk of writer
starvation with the current code which isn't great for a queued lock.

> Can't we steal one of the reader bits for waiting?

I considered this at LPC and somehow convinced myself it didn't work, but
actually all it's really doing is making the _QW_LOCKED bit a byte, so it
should work fine.

I'll work that into v2.

Will
