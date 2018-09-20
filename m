From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 20 Sep 2018 18:22:16 +0200
Subject: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <20180920160832.GZ24124@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com> <20180409145409.GA9661@arm.com>
 <20180409155420.GB4082@hirez.programming.kicks-ass.net>
 <20180409171959.GB9661@arm.com>
 <20180920160832.GZ24124@hirez.programming.kicks-ass.net>
Message-ID: <20180920162216.GR24142@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 06:08:32PM +0200, Peter Zijlstra wrote:
> Another approach might be to use something like:
> 
> 	val = xchg_relaxed(&lock->locked_pending, _Q_PENDING_VAL | _Q_LOCKED_VAL);
> 	val |= atomic_read_acquire(&lock->val) & _Q_TAIL_MASK;
> 
> combined with something like:
> 
> 	/* 0,0,0 -> 0,1,1 - we won trylock */
> 	if (!(val & _Q_LOCKED_MASK)) {

That one doesn't actually work... let me think about this more.

> 		clear_pending(lock);
> 		return;
> 	}
> 
> 	/* 0,0,1 -> 0,1,1 - we won pending */
> 	if (!(val & ~_Q_LOCKED_MASK)) {
> 		...
> 	}
> 
> 	/* *,0,1 -> *,1,1 - we won pending, but there's queueing */
> 	if (!(val & _Q_PENDING_VAL))
> 		clear_pending(lock);
> 
> 	...
> 
> 
> Hmmm?
