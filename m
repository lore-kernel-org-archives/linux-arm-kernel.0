From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 6 Apr 2013 09:41:25 -0400 (EDT)
Subject: [PATCH v4 03/15] ARM: mcpm: introduce helpers for platform
 coherency exit/setup
In-Reply-To: <20130405230017.GC14308@quad.lixom.net>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-4-git-send-email-nicolas.pitre@linaro.org>
 <20130405230017.GC14308@quad.lixom.net>
Message-ID: <alpine.LFD.2.03.1304051917520.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Olof Johansson wrote:

> Hi,
> 
> Just two nits below. One could be fixed incrementally, the other is
> a longer-term potential cleanup.

I've updated my branch directly.  Especially the comment addition is 
best presented in the original patch to avoid confusion.

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

The commit log says:

|Also, in order to prevent a cached writer from interfering with an
|adjacent non-cached writer, we ensure each state variable is located to
|a separate cache line.

Although a more explicit comment here would be helpful indeed.

Fixed.

Yet, that part will be reworked once we move to dynamic allocation 
anyway.  But for the time being it is best to keep the code simple while 
people get familiar with it.

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

There is a arch/arm/kernel/asm-offsets.c already.

Here's the answer I provided before:
http://article.gmane.org/gmane.linux.ports.arm.kernel/209009

|That's how that was done initially. But that ended up cluttering
|asm-offsets.h for stuff that actually is really a local implementation
|detail which doesn't need kernel wide scope.  In other words, the end
|result looked worse.
|
|One could argue that they are still exposed too much as the only files
|that need to know about those defines are bL_head.S and bL_entry.c.


Nicolas
