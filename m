From: mingo@kernel.org (Ingo Molnar)
Date: Sat, 5 May 2018 11:09:03 +0200
Subject: [PATCH] locking/atomics: Clean up the atomic.h maze of #defines
In-Reply-To: <20180505084721.GA32344@noisy.programming.kicks-ass.net>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
Message-ID: <20180505090903.ebsf5vosgwckxooy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, May 05, 2018 at 10:11:00AM +0200, Ingo Molnar wrote:
> 
> > Before:
> > 
> >  #ifndef atomic_fetch_dec_relaxed
> > 
> >  #ifndef atomic_fetch_dec
> >  #define atomic_fetch_dec(v)	        atomic_fetch_sub(1, (v))
> >  #define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
> >  #define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
> >  #define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
> >  #else /* atomic_fetch_dec */
> >  #define atomic_fetch_dec_relaxed	atomic_fetch_dec
> >  #define atomic_fetch_dec_acquire	atomic_fetch_dec
> >  #define atomic_fetch_dec_release	atomic_fetch_dec
> >  #endif /* atomic_fetch_dec */
> > 
> >  #else /* atomic_fetch_dec_relaxed */
> > 
> >  #ifndef atomic_fetch_dec_acquire
> >  #define atomic_fetch_dec_acquire(...)					\
> > 	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> >  #endif
> > 
> >  #ifndef atomic_fetch_dec_release
> >  #define atomic_fetch_dec_release(...)					\
> > 	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> >  #endif
> > 
> >  #ifndef atomic_fetch_dec
> >  #define atomic_fetch_dec(...)						\
> > 	__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> >  #endif
> >  #endif /* atomic_fetch_dec_relaxed */
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
> > The new variant is readable at a glance, and the hierarchy of defines is very 
> > obvious as well.
> 
> It wraps and looks hideous in my normal setup. And I do detest that indent
> after # thing.

You should use wider terminals if you take a look at such code - there's already 
numerous areas of the kernel that are not readable on 80x25 terminals.

_Please_ try the following experiment, for me:

Enter the 21st century temporarily and widen two of your terminals from 80 cols to 
100 cols - it's only ~20% wider.

Apply the 3 patches I sent and then open the new and the old atomic.h in the two 
terminals and compare them visually.

The new structure is _much_ more compact, it is nicer looking and much more 
readable.

Thanks,

	Ingo
