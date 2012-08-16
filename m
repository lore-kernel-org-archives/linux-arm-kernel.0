From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 13:00:32 +0000
Subject: [PATCH v2 26/31] arm64: Miscellaneous library functions
In-Reply-To: <20120816105709.GK31784@mudshark.cambridge.arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151521.14663.arnd@arndb.de>
 <20120816105709.GK31784@mudshark.cambridge.arm.com>
Message-ID: <201208161300.32830.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Will Deacon wrote:
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/atomic.h>
> > > +
> > > +#ifdef CONFIG_SMP
> > > +arch_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned = {
> > > +       [0 ... (ATOMIC_HASH_SIZE-1)]  = __ARCH_SPIN_LOCK_UNLOCKED
> > > +};
> > > +#endif
> > 
> > What?
> > 
> > I suppose this is a leftover from an earlier version using the
> > generic bitops, right?
> 
> We currently use the generic atomic bitops (asm-generic/bitops/atomic.h)
> which contains:
> 
> #  define ATOMIC_HASH(a) (&(__atomic_hash[ (((unsigned long) a)/L1_CACHE_BYTES) & (ATOMIC_HASH_SIZE-1) ]))
> 
> so we have to provide a definition for the array. We have additional patches
> containing optimised assembly implementations of the atomic bitops which we
> will push later, once we've got some hardware to benchmark with.
> 

Ah, I was confusing this with the asm/atomic.h stuff, for which you already
provide an optimized version.

The generic atomic bitops are really horrible in performance and I would
expect that there is just one obvious way to implement bitops using ldaxr/stlxr,
so I recommend just doing that even if you have no hardware for benchmarking.

The s390 version should be fairly easy to adapt.

	Arnd
