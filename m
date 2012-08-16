From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Aug 2012 15:11:53 +0100
Subject: [PATCH v2 26/31] arm64: Miscellaneous library functions
In-Reply-To: <201208161300.32830.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151521.14663.arnd@arndb.de>
 <20120816105709.GK31784@mudshark.cambridge.arm.com>
 <201208161300.32830.arnd@arndb.de>
Message-ID: <20120816141153.GC30876@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 02:00:32PM +0100, Arnd Bergmann wrote:
> On Thursday 16 August 2012, Will Deacon wrote:
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/spinlock.h>
> > > > +#include <linux/atomic.h>
> > > > +
> > > > +#ifdef CONFIG_SMP
> > > > +arch_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned = {
> > > > +       [0 ... (ATOMIC_HASH_SIZE-1)]  = __ARCH_SPIN_LOCK_UNLOCKED
> > > > +};
> > > > +#endif
> > > 
> > > What?
> > > 
> > > I suppose this is a leftover from an earlier version using the
> > > generic bitops, right?
> > 
> > We currently use the generic atomic bitops (asm-generic/bitops/atomic.h)
> > which contains:
> > 
> > #  define ATOMIC_HASH(a) (&(__atomic_hash[ (((unsigned long) a)/L1_CACHE_BYTES) & (ATOMIC_HASH_SIZE-1) ]))
> > 
> > so we have to provide a definition for the array. We have additional patches
> > containing optimised assembly implementations of the atomic bitops which we
> > will push later, once we've got some hardware to benchmark with.
> > 
> 
> Ah, I was confusing this with the asm/atomic.h stuff, for which you already
> provide an optimized version.
> 
> The generic atomic bitops are really horrible in performance and I would
> expect that there is just one obvious way to implement bitops using ldaxr/stlxr,
> so I recommend just doing that even if you have no hardware for benchmarking.

As Will said, we have the code already but I dropped it from the initial
set patches to be reviewed to keep them simpler. They will be added
later.

-- 
Catalin
