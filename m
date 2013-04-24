From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 24 Apr 2013 10:10:18 +0100
Subject: [PATCH v4 03/15] ARM: mcpm: introduce helpers for platform
 coherency exit/setup
In-Reply-To: <20130405230017.GC14308@quad.lixom.net>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-4-git-send-email-nicolas.pitre@linaro.org>
 <20130405230017.GC14308@quad.lixom.net>
Message-ID: <20130424091007.GA2664@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 04:00:17PM -0700, Olof Johansson wrote:
> Hi,
> 
> Just two nits below. One could be fixed incrementally, the other is
> a longer-term potential cleanup.
> 
> On Tue, Feb 05, 2013 at 12:22:00AM -0500, Nicolas Pitre wrote:
> 
> > diff --git a/arch/arm/include/asm/mcpm_entry.h b/arch/arm/include/asm/mcpm_entry.h
> > index 3286d5eb91..e76652209d 100644
> > --- a/arch/arm/include/asm/mcpm_entry.h
> > +++ b/arch/arm/include/asm/mcpm_entry.h
> > @@ -15,8 +15,37 @@
> >  #define MAX_CPUS_PER_CLUSTER	4
> >  #define MAX_NR_CLUSTERS		2
> >  
> > +/* Definitions for mcpm_sync_struct */
> > +#define CPU_DOWN		0x11
> > +#define CPU_COMING_UP		0x12
> > +#define CPU_UP			0x13
> > +#define CPU_GOING_DOWN		0x14
> > +
> > +#define CLUSTER_DOWN		0x21
> > +#define CLUSTER_UP		0x22
> > +#define CLUSTER_GOING_DOWN	0x23
> > +
> > +#define INBOUND_NOT_COMING_UP	0x31
> > +#define INBOUND_COMING_UP	0x32
> > +
> > +/* This is a complete guess. */
> > +#define __CACHE_WRITEBACK_ORDER	6
> > +#define __CACHE_WRITEBACK_GRANULE (1 << __CACHE_WRITEBACK_ORDER)
> 
> Something a little more educational could be useful here. It needs to
> be the max writeback/line size of the supported platforms of the binary
> kernel, i.e. if someone builds an SoC with 128-byte L2 cache lines this
> guess will break.

Will commented on the same thing.  Ideally, a suitable definition should
get selected through Kconfig.

The guess specified here is adequate for known b.L platforms, but a
better framework for configuring this is desirable.

My original comment here is certainly not very informative though --
I'll post a clarification.

> > +/* Offsets for the mcpm_sync_struct members, for use in asm: */
> > +#define MCPM_SYNC_CLUSTER_CPUS	0
> > +#define MCPM_SYNC_CPU_SIZE	__CACHE_WRITEBACK_GRANULE
> > +#define MCPM_SYNC_CLUSTER_CLUSTER \
> > +	(MCPM_SYNC_CLUSTER_CPUS + MCPM_SYNC_CPU_SIZE * MAX_CPUS_PER_CLUSTER)
> > +#define MCPM_SYNC_CLUSTER_INBOUND \
> > +	(MCPM_SYNC_CLUSTER_CLUSTER + __CACHE_WRITEBACK_GRANULE)
> > +#define MCPM_SYNC_CLUSTER_SIZE \
> > +	(MCPM_SYNC_CLUSTER_INBOUND + __CACHE_WRITEBACK_GRANULE)
> > +
> >  #ifndef __ASSEMBLY__
> >  
> > +#include <linux/types.h>
> > +
> >  /*
> >   * Platform specific code should use this symbol to set up secondary
> >   * entry location for processors to use when released from reset.
> > @@ -123,5 +152,39 @@ struct mcpm_platform_ops {
> >   */
> >  int __init mcpm_platform_register(const struct mcpm_platform_ops *ops);
> >  
> > +/* Synchronisation structures for coordinating safe cluster setup/teardown: */
> > +
> > +/*
> > + * When modifying this structure, make sure you update the MCPM_SYNC_ defines
> > + * to match.
> > + */
> 
> It would be nice to introduce something like arch/powerpc/kernel/asm-offsets.c
> on ARM to generate the ASM-side automatically from the C struct instead for
> this and other cases, but that's unrelated to this addition.

ARM already has its own asm-offsets, and we actually used this in an earlier
version of the patches.  However, this felt like pollution of that file for
not a lot of benefit.  Does powerpc have a problem with asm-offsets becoming
a dumping ground for random junk, or is there a better way to organise it?

Cheers
---Dave

> > +struct mcpm_sync_struct {
> > +	/* individual CPU states */
> > +	struct {
> > +		volatile s8 cpu __aligned(__CACHE_WRITEBACK_GRANULE);
> > +	} cpus[MAX_CPUS_PER_CLUSTER];
> > +
> > +	/* cluster state */
> > +	volatile s8 cluster __aligned(__CACHE_WRITEBACK_GRANULE);
> > +
> > +	/* inbound-side state */
> > +	volatile s8 inbound __aligned(__CACHE_WRITEBACK_GRANULE);
> > +};
> 
> 
> -Olof
