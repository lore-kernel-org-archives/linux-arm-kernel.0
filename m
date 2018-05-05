From: mingo@kernel.org (Ingo Molnar)
Date: Sat, 5 May 2018 11:38:29 +0200
Subject: [PATCH] locking/atomics: Clean up the atomic.h maze of #defines
In-Reply-To: <20180505090403.p2ywuen42rnlwizq@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
Message-ID: <20180505093829.xfylnedwd5nonhae@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Ingo Molnar <mingo@kernel.org> wrote:

> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > So we could do the following simplification on top of that:
> > > 
> > >  #ifndef atomic_fetch_dec_relaxed
> > >  # ifndef atomic_fetch_dec
> > >  #  define atomic_fetch_dec(v)		atomic_fetch_sub(1, (v))
> > >  #  define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
> > >  #  define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
> > >  #  define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
> > >  # else
> > >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> > >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> > >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> > >  # endif
> > >  #else
> > >  # ifndef atomic_fetch_dec
> > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> > >  # endif
> > >  #endif
> > 
> > This would disallow an architecture to override just fetch_dec_release for
> > instance.
> 
> Couldn't such a crazy arch just define _all_ the 3 APIs in this group?
> That's really a small price and makes the place pay the complexity
> price that does the weirdness...
> 
> > I don't think there currently is any architecture that does that, but the
> > intent was to allow it to override anything and only provide defaults where it
> > does not.
> 
> I'd argue that if a new arch only defines one of these APIs that's probably a bug. 
> If they absolutely want to do it, they still can - by defining all 3 APIs.
> 
> So there's no loss in arch flexibility.

BTW., PowerPC for example is already in such a situation, it does not define 
atomic_cmpxchg_release(), only the other APIs:

#define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
#define atomic_cmpxchg_relaxed(v, o, n) \
	cmpxchg_relaxed(&((v)->counter), (o), (n))
#define atomic_cmpxchg_acquire(v, o, n) \
	cmpxchg_acquire(&((v)->counter), (o), (n))

Was it really the intention on the PowerPC side that the generic code falls back 
to cmpxchg(), i.e.:

#  define atomic_cmpxchg_release(...)           __atomic_op_release(atomic_cmpxchg, __VA_ARGS__)

Which after macro expansion becomes:

	smp_mb__before_atomic();
	atomic_cmpxchg_relaxed(v, o, n);

smp_mb__before_atomic() on PowerPC falls back to the generic __smp_mb(), which 
falls back to mb(), which on PowerPC is the 'sync' instruction.

Isn't this a inefficiency bug?

While I'm pretty clueless about PowerPC low level cmpxchg atomics, they appear to 
have the following basic structure:

full cmpxchg():

	PPC_ATOMIC_ENTRY_BARRIER # sync
	ldarx + stdcx
	PPC_ATOMIC_EXIT_BARRIER  # sync

cmpxchg_relaxed():

	ldarx + stdcx

cmpxchg_acquire():

	ldarx + stdcx
	PPC_ACQUIRE_BARRIER      # lwsync

The logical extension for cmpxchg_release() would be:

cmpxchg_release():

	PPC_RELEASE_BARRIER      # lwsync
	ldarx + stdcx

But instead we silently get the generic fallback, which does:

	smp_mb__before_atomic();
	atomic_cmpxchg_relaxed(v, o, n);

Which maps to:

	sync
	ldarx + stdcx

Note that it uses a full barrier instead of lwsync (does that stand for 
'lightweight sync'?).

Even if it turns out we need the full barrier, with the overly finegrained 
structure of the atomics this detail is totally undocumented and non-obvious.

Thanks,

	Ingo
