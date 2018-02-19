From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 19 Feb 2018 15:04:34 +0100
Subject: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <20180219140142.GD30394@arm.com>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
 <20180216102100.GB25201@hirez.programming.kicks-ass.net>
 <20180219140142.GD30394@arm.com>
Message-ID: <20180219140434.GS25201@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 02:01:43PM +0000, Will Deacon wrote:
> >     The non serializing __clear_bit() was getting "lost"
> >     
> >      80543b8e:      ld_s       r2,[r13,0] <--- (A) Finds PG_locked is set
> >      80543b90:      or         r3,r2,1    <--- (B) other core unlocks right here
> >      80543b94:      st_s       r3,[r13,0] <--- (C) sets PG_locked (overwrites unlock)
> 
> Ah, so it's problematic for the case where atomics are built using locks.
> Got it. I'll err on the side of caution here and have the asm-generic header
> (which should be bitops/lock.h not bitops/atomic.h) conditionally define
> __clear_bit_unlock as clear_bit_lock unless the architecture has provided
> its own implementation.

So I think we get it all right if we use atomic_set_release(). If the
atomics are implemented using locks, atomic_set*() should be implemented
like atomic_xchg() and avoid the above problem.
