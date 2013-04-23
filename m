From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Apr 2013 21:09:08 +0100
Subject: [PATCH v4 01/15] ARM: multi-cluster PM: secondary kernel entry
 code
In-Reply-To: <alpine.LFD.2.03.1304231524120.17375@syhkavp.arg>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-2-git-send-email-nicolas.pitre@linaro.org>
 <20130423191927.GA5316@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304231524120.17375@syhkavp.arg>
Message-ID: <20130423200908.GX14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 03:34:08PM -0400, Nicolas Pitre wrote:
> On Tue, 23 Apr 2013, Russell King - ARM Linux wrote:
> 
> > On Tue, Feb 05, 2013 at 12:21:58AM -0500, Nicolas Pitre wrote:
> > > +#include <asm/mcpm_entry.h>
> > > +#include <asm/barrier.h>
> > > +#include <asm/proc-fns.h>
> > > +#include <asm/cacheflush.h>
> > > +
> > > +extern volatile unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
> > 
> > This should not be volatile.  You should know by now the stance in the
> > Linux community against using volatile on data declarations.  See
> > Documentation/volatile-considered-harmful.txt to remind yourself of
> > the reasoning.
> 
> That document says:
> 
> |The key point to understand with regard to volatile is that its purpose 
> |is to suppress optimization, which is almost never what one really 
> |wants to do.
> 
> Turns out that this is exactly what we want here: suppress optimization.

What optimization are you trying to suppress in the function below?

> However ...
> 
> > > +
> > > +void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
> > > +{
> > > +	unsigned long val = ptr ? virt_to_phys(ptr) : 0;
> > > +	mcpm_entry_vectors[cluster][cpu] = val;
> > > +	__cpuc_flush_dcache_area((void *)&mcpm_entry_vectors[cluster][cpu], 4);
> > > +	outer_clean_range(__pa(&mcpm_entry_vectors[cluster][cpu]),
> > > +			  __pa(&mcpm_entry_vectors[cluster][cpu + 1]));
> > 
> > And really, if the write hasn't been done by the compiler prior to calling
> > __cpuc_flush_dcache_area() then we're into really bad problems.
> 
> That is indeed true.  The memory might have been uncacheable at some 
> point and then the volatile was necessary in that case.

I don't buy the argument about it being uncachable - the compiler doesn't
know that, and the cacheability of the memory really doesn't change the
code that the compiler produces.

Moreover, the compiler can't really reorder the store to
mcpm_entry_vectors[cluster][cpu] with the calls to the cache flushing
anyway - and as the compiler has no clue what those calls are doing
so it has to ensure that the results of the preceding code is visible
to some "unknown code" which it can't see.  Therefore, it practically
has no option but to issue the store before calling those cache flush
functions.

Also... consider using sizeof() rather than constant 4.
