From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 May 2013 11:35:08 +0200
Subject: [RFC PATCH] implement read_cpuid_ext for v7-M (Was: Re: [PATCHv2
 2/3] ARM: Detect support for SDIV/UDIV from ISAR0) register
In-Reply-To: <20130507092209.GD25387@mudshark.cambridge.arm.com>
References: <1363631337-13816-1-git-send-email-sboyd@codeaurora.org>
 <1363631337-13816-3-git-send-email-sboyd@codeaurora.org>
 <20130418091019.GA21099@pengutronix.de>
 <20130506093059.GH23285@pengutronix.de>
 <20130507092209.GD25387@mudshark.cambridge.arm.com>
Message-ID: <20130507093508.GL23285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

On Tue, May 07, 2013 at 10:22:09AM +0100, Will Deacon wrote:
> On Mon, May 06, 2013 at 10:30:59AM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Apr 18, 2013 at 11:10:19AM +0200, Uwe Kleine-K?nig wrote:
> > The patch below fixes the issue for me on V7-M. The only drawback is
> > that the list of registers isn't shared. Maybe someone has a nice idea?
> > 
> > BTW, there doesn't seem to be an equivalent register set for 
> > CPUID_{CACHETYPE,TCM,TLBTYPE,MPIDR} on v7-M.
> 
> That make sense: we don't have caches, MMUs or SMP.
IMHO the sensible thing is to implement the registers then and let them
tell: I don't have these things.

> > diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> > index 4eb94a3..ec635ff 100644
> > --- a/arch/arm/include/asm/cputype.h
> > +++ b/arch/arm/include/asm/cputype.h
> > @@ -10,6 +10,22 @@
> >  #define CPUID_TLBTYPE	3
> >  #define CPUID_MPIDR	5
> >  
> > +#ifdef CONFIG_CPU_V7M
> > +#define CPUID_EXT_PFR0	0x40
> > +#define CPUID_EXT_PFR1	0x44
> > +#define CPUID_EXT_DFR0	0x48
> > +#define CPUID_EXT_AFR0	0x4c
> > +#define CPUID_EXT_MMFR0	0x50
> > +#define CPUID_EXT_MMFR1	0x54
> > +#define CPUID_EXT_MMFR2	0x58
> > +#define CPUID_EXT_MMFR3	0x5c
> > +#define CPUID_EXT_ISAR0	0x60
> > +#define CPUID_EXT_ISAR1	0x64
> > +#define CPUID_EXT_ISAR2	0x68
> > +#define CPUID_EXT_ISAR3	0x6c
> > +#define CPUID_EXT_ISAR4	0x70
> > +#define CPUID_EXT_ISAR5	0x74
> > +#else
> >  #define CPUID_EXT_PFR0	"c1, 0"
> >  #define CPUID_EXT_PFR1	"c1, 1"
> >  #define CPUID_EXT_DFR0	"c1, 2"
> > @@ -24,6 +40,7 @@
> >  #define CPUID_EXT_ISAR3	"c2, 3"
> >  #define CPUID_EXT_ISAR4	"c2, 4"
> >  #define CPUID_EXT_ISAR5	"c2, 5"
> > +#endif
> >  
> >  #define MPIDR_SMP_BITMASK (0x3 << 30)
> >  #define MPIDR_SMP_VALUE (0x2 << 30)
> > @@ -79,7 +96,23 @@ extern unsigned int processor_id;
> >  		__val;							\
> >  	})
> >  
> > -#else /* ifdef CONFIG_CPU_CP15 */
> > +#elif defined(CONFIG_CPU_V7M)
> > +
> > +#include <asm/io.h>
> > +#include <asm/v7m.h>
> > +
> > +#define read_cpuid(reg)							\
> > +	({								\
> > +		WARN_ON_ONCE(1);					\
> > +		0;							\
> > +	})
> 
> We do have an MIDR in PMSAv7 (not to be confused with MPIDR), so why not read
> that here?
I don't know it and it's unrelated to this patch. But I will note it and
check it. In the meantime I'm taking patches of course :-)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
