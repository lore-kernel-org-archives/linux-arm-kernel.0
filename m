From: boqun.feng@gmail.com (Boqun Feng)
Date: Sat, 5 May 2018 18:16:09 +0800
Subject: [PATCH] locking/atomics: Clean up the atomic.h maze of #defines
In-Reply-To: <20180505093829.xfylnedwd5nonhae@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
Message-ID: <20180505101609.5wb56j4mspjkokmw@tardis>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2018 at 11:38:29AM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > So we could do the following simplification on top of that:
> > > > 
> > > >  #ifndef atomic_fetch_dec_relaxed
> > > >  # ifndef atomic_fetch_dec
> > > >  #  define atomic_fetch_dec(v)		atomic_fetch_sub(1, (v))
> > > >  #  define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
> > > >  #  define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
> > > >  #  define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
> > > >  # else
> > > >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> > > >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> > > >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> > > >  # endif
> > > >  #else
> > > >  # ifndef atomic_fetch_dec
> > > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> > > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> > > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> > > >  # endif
> > > >  #endif
> > > 
> > > This would disallow an architecture to override just fetch_dec_release for
> > > instance.
> > 
> > Couldn't such a crazy arch just define _all_ the 3 APIs in this group?
> > That's really a small price and makes the place pay the complexity
> > price that does the weirdness...
> > 
> > > I don't think there currently is any architecture that does that, but the
> > > intent was to allow it to override anything and only provide defaults where it
> > > does not.
> > 
> > I'd argue that if a new arch only defines one of these APIs that's probably a bug. 
> > If they absolutely want to do it, they still can - by defining all 3 APIs.
> > 
> > So there's no loss in arch flexibility.
> 
> BTW., PowerPC for example is already in such a situation, it does not define 
> atomic_cmpxchg_release(), only the other APIs:
> 
> #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
> #define atomic_cmpxchg_relaxed(v, o, n) \
> 	cmpxchg_relaxed(&((v)->counter), (o), (n))
> #define atomic_cmpxchg_acquire(v, o, n) \
> 	cmpxchg_acquire(&((v)->counter), (o), (n))
> 
> Was it really the intention on the PowerPC side that the generic code falls back 
> to cmpxchg(), i.e.:
> 
> #  define atomic_cmpxchg_release(...)           __atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
> 

So ppc has its own definition __atomic_op_release() in
arch/powerpc/include/asm/atomic.h:

	#define __atomic_op_release(op, args...)				\
	({									\
		__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
		op##_relaxed(args);						\
	})

, and PPC_RELEASE_BARRIER is lwsync, so we map to

	lwsync();
	atomic_cmpxchg_relaxed(v, o, n);

And the reason, why we don't define atomic_cmpxchg_release() but define
atomic_cmpxchg_acquire() is that, atomic_cmpxchg_*() could provide no
ordering guarantee if the cmp fails, we did this for
atomic_cmpxchg_acquire() but not for atomic_cmpxchg_release(), because
doing so may introduce a memory barrier inside a ll/sc critical section,
please see the comment before __cmpxchg_u32_acquire() in
arch/powerpc/include/asm/cmpxchg.h:

	/*
	 * cmpxchg family don't have order guarantee if cmp part fails, therefore we
	 * can avoid superfluous barriers if we use assembly code to implement
	 * cmpxchg() and cmpxchg_acquire(), however we don't do the similar for
	 * cmpxchg_release() because that will result in putting a barrier in the
	 * middle of a ll/sc loop, which is probably a bad idea. For example, this
	 * might cause the conditional store more likely to fail.
	 */

Regards,
Boqun


> Which after macro expansion becomes:
> 
> 	smp_mb__before_atomic();
> 	atomic_cmpxchg_relaxed(v, o, n);
> 
> smp_mb__before_atomic() on PowerPC falls back to the generic __smp_mb(), which 
> falls back to mb(), which on PowerPC is the 'sync' instruction.
> 
> Isn't this a inefficiency bug?
> 
> While I'm pretty clueless about PowerPC low level cmpxchg atomics, they appear to 
> have the following basic structure:
> 
> full cmpxchg():
> 
> 	PPC_ATOMIC_ENTRY_BARRIER # sync
> 	ldarx + stdcx
> 	PPC_ATOMIC_EXIT_BARRIER  # sync
> 
> cmpxchg_relaxed():
> 
> 	ldarx + stdcx
> 
> cmpxchg_acquire():
> 
> 	ldarx + stdcx
> 	PPC_ACQUIRE_BARRIER      # lwsync
> 
> The logical extension for cmpxchg_release() would be:
> 
> cmpxchg_release():
> 
> 	PPC_RELEASE_BARRIER      # lwsync
> 	ldarx + stdcx
> 
> But instead we silently get the generic fallback, which does:
> 
> 	smp_mb__before_atomic();
> 	atomic_cmpxchg_relaxed(v, o, n);
> 
> Which maps to:
> 
> 	sync
> 	ldarx + stdcx
> 
> Note that it uses a full barrier instead of lwsync (does that stand for 
> 'lightweight sync'?).
> 
> Even if it turns out we need the full barrier, with the overly finegrained 
> structure of the atomics this detail is totally undocumented and non-obvious.
> 
> Thanks,
> 
> 	Ingo
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180505/84554ee3/attachment.sig>
