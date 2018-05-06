From: mingo@kernel.org (Ingo Molnar)
Date: Sun, 6 May 2018 16:57:27 +0200
Subject: [PATCH] locking/atomics: Simplify the op definitions in atomic.h
 some more
In-Reply-To: <20180506141249.GA28723@andrea>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <20180506141249.GA28723@andrea>
Message-ID: <20180506145726.y4jxhvfolzvbuft5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Andrea Parri <andrea.parri@amarulasolutions.com> wrote:

> Hi Ingo,
> 
> > From 5affbf7e91901143f84f1b2ca64f4afe70e210fd Mon Sep 17 00:00:00 2001
> > From: Ingo Molnar <mingo@kernel.org>
> > Date: Sat, 5 May 2018 10:23:23 +0200
> > Subject: [PATCH] locking/atomics: Simplify the op definitions in atomic.h some more
> > 
> > Before:
> > 
> >  #ifndef atomic_fetch_dec_relaxed
> >  # ifndef atomic_fetch_dec
> >  #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
> >  #  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
> >  #  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
> >  #  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
> >  # else
> >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> >  # endif
> >  #else
> >  # ifndef atomic_fetch_dec_acquire
> >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> >  # endif
> >  # ifndef atomic_fetch_dec_release
> >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> >  # endif
> >  # ifndef atomic_fetch_dec
> >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> >  # endif
> >  #endif
> > 
> > After:
> > 
> >  #ifndef atomic_fetch_dec_relaxed
> >  # ifndef atomic_fetch_dec
> >  #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
> >  #  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
> >  #  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
> >  #  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
> >  # else
> >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> >  # endif
> >  #else
> >  # ifndef atomic_fetch_dec
> >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> >  # endif
> >  #endif
> > 
> > The idea is that because we already group these APIs by certain defines
> > such as atomic_fetch_dec_relaxed and atomic_fetch_dec in the primary
> > branches - we can do the same in the secondary branch as well.
> > 
> > ( Also remove some unnecessarily duplicate comments, as the API
> >   group defines are now pretty much self-documenting. )
> > 
> > No change in functionality.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-kernel at vger.kernel.org
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> This breaks compilation on RISC-V. (For some of its atomics, the arch
> currently defines the _relaxed and the full variants and it relies on
> the generic definitions for the _acquire and the _release variants.)

I don't have cross-compilation for RISC-V, which is a relatively new arch.
(Is there any RISC-V set of cross-compilation tools on kernel.org somewhere?)

Could you please send a patch that defines those variants against Linus's tree, 
like the PowerPC patch that does something similar:

  0476a632cb3a: locking/atomics/powerpc: Move cmpxchg helpers to asm/cmpxchg.h and define the full set of cmpxchg APIs

?

... and I'll integrate it into the proper place to make it all bisectable, etc.

Thanks,

	Ingo
