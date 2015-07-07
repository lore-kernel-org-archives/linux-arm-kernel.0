From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 7 Jul 2015 23:30:01 +0200
Subject: [PATCH 2/9] locking/qrwlock: avoid redundant atomic_add_return
 on read_lock_slowpath
In-Reply-To: <559C11BA.1070309@hp.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-3-git-send-email-will.deacon@arm.com>
 <559C11BA.1070309@hp.com>
Message-ID: <20150707213000.GL19282@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 01:51:54PM -0400, Waiman Long wrote:
> >-	cnts = atomic_add_return(_QR_BIAS,&lock->cnts) - _QR_BIAS;
> >+	atomic_add(_QR_BIAS,&lock->cnts);
> >+	cnts = smp_load_acquire((u32 *)&lock->cnts);
> >  	rspin_until_writer_unlock(lock, cnts);
> >
> >  	/*
> 
> Atomic add in x86 is actually a full barrier too. The performance difference
> between "lock add" and "lock xadd" should be minor. The additional load,
> however, could potentially cause an additional cacheline load on a contended
> lock. So do you see actual performance benefit of this change in ARM?

Yes, atomic_add() does not imply (and does not have) any memory barriers
on ARM.
