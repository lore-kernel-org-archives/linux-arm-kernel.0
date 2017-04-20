From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 20 Apr 2017 21:23:18 +0300
Subject: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
In-Reply-To: <20170413181212.y3ezah76qoztxhnn@hirez.programming.kicks-ass.net>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
 <20170413181212.y3ezah76qoztxhnn@hirez.programming.kicks-ass.net>
Message-ID: <20170420182318.4ddtfiobxz6hgbo4@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 08:12:12PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 11, 2017 at 01:35:04AM +0400, Yury Norov wrote:
> 
> > +++ b/arch/arm64/include/asm/qspinlock.h
> > @@ -0,0 +1,20 @@
> > +#ifndef _ASM_ARM64_QSPINLOCK_H
> > +#define _ASM_ARM64_QSPINLOCK_H
> > +
> > +#include <asm-generic/qspinlock_types.h>
> > +
> > +#define	queued_spin_unlock queued_spin_unlock
> > +/**
> > + * queued_spin_unlock - release a queued spinlock
> > + * @lock : Pointer to queued spinlock structure
> > + *
> > + * A smp_store_release() on the least-significant byte.
> > + */
> > +static inline void queued_spin_unlock(struct qspinlock *lock)
> > +{
> > +	smp_store_release((u8 *)lock, 0);
> > +}
> 
> I'm afraid this isn't enough for arm64. I suspect you want your own
> variant of queued_spin_unlock_wait() and queued_spin_is_locked() as
> well.
> 
> Much memory ordering fun to be had there.

Hi Peter,

Is there some test to reproduce the locking failure for the case. I
ask because I run loctorture for many hours on my qemu (emulating
cortex-a57), and I see no failures in the test reports. And Jan did it
on ThunderX, and Adam on QDF2400 without any problems. So even if I
rework those functions, how could I check them for correctness?

Anyway, regarding the queued_spin_unlock_wait(), is my understanding
correct that you assume adding smp_mb() before entering the for(;;)
cycle, and using ldaxr/strxr instead of atomic_read()?

Yury
