From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Oct 2017 12:30:44 +0100
Subject: [PATCH v2 3/5] kernel/locking: Use atomic_cond_read_acquire when
 spinning in qrwlock
In-Reply-To: <20171008005841.gznbomnstzhxwyfm@tardis>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
 <1507296882-18721-4-git-send-email-will.deacon@arm.com>
 <20171008005841.gznbomnstzhxwyfm@tardis>
Message-ID: <20171009113044.GB7128@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 08, 2017 at 09:03:34AM +0800, Boqun Feng wrote:
> On Fri, Oct 06, 2017 at 01:34:40PM +0000, Will Deacon wrote:
> > The qrwlock slowpaths involve spinning when either a prospective reader
> > is waiting for a concurrent writer to drain, or a prospective writer is
> > waiting for concurrent readers to drain. In both of these situations,
> > atomic_cond_read_acquire can be used to avoid busy-waiting and make use
> > of any backoff functionality provided by the architecture.
> > 
> > This patch replaces the open-code loops and rspin_until_writer_unlock
> > implementation with atomic_cond_read_acquire. The write mode transition
> > zero to _QW_WAITING is left alone, since (a) this doesn't need acquire
> > semantics and (b) should be fast.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  kernel/locking/qrwlock.c | 47 +++++++++++------------------------------------
> >  1 file changed, 11 insertions(+), 36 deletions(-)
> > 
> > diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> > index 1af791e37348..b7ea4647c74d 100644
> > --- a/kernel/locking/qrwlock.c
> > +++ b/kernel/locking/qrwlock.c
> > @@ -24,23 +24,6 @@
> >  #include <asm/qrwlock.h>
> >  
> >  /**
> > - * rspin_until_writer_unlock - inc reader count & spin until writer is gone
> > - * @lock  : Pointer to queue rwlock structure
> > - * @writer: Current queue rwlock writer status byte
> > - *
> > - * In interrupt context or at the head of the queue, the reader will just
> > - * increment the reader count & wait until the writer releases the lock.
> > - */
> > -static __always_inline void
> > -rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
> > -{
> > -	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
> > -		cpu_relax();
> > -		cnts = atomic_read_acquire(&lock->cnts);
> > -	}
> > -}
> > -
> > -/**
> >   * queued_read_lock_slowpath - acquire read lock of a queue rwlock
> >   * @lock: Pointer to queue rwlock structure
> >   * @cnts: Current qrwlock lock value
> > @@ -53,13 +36,12 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
> 
> So the second parameter(@cnts) could be removed entirely, right?
> Any reason we still keep it?

Well spotted! I'll remove it.

Will
