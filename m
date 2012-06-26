From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2012 11:37:18 +0100
Subject: [PATCH 1/2] ARM: arch timer: implement read_current_timer and
 get_cycles
In-Reply-To: <4FE8DA78.5070804@codeaurora.org>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <1340377774-17173-2-git-send-email-will.deacon@arm.com>
 <4FE8DA78.5070804@codeaurora.org>
Message-ID: <20120626103718.GD27996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 10:39:04PM +0100, Stephen Boyd wrote:
> On 06/22/12 08:09, Will Deacon wrote:
> > diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
> > index 3be8de3..ce11944 100644
> > --- a/arch/arm/include/asm/timex.h
> > +++ b/arch/arm/include/asm/timex.h
> > @@ -12,13 +12,15 @@
> >  #ifndef _ASMARM_TIMEX_H
> >  #define _ASMARM_TIMEX_H
> >  
> > +#include <asm/arch_timer.h>
> 
> This seems to cause compilation failures if you aren't building with
> architected timers enabled.
> 
> In file included from arch/arm/include/asm/timex.h:15,
>                  from include/linux/timex.h:174,
>                  from include/linux/sched.h:57,
>                  from arch/arm/kernel/asm-offsets.c:13:
> arch/arm/include/asm/arch_timer.h: In function 'arch_timer_of_register':
> arch/arm/include/asm/arch_timer.h:11: error: 'ENXIO' undeclared (first use in this function)

Thanks, will fix for v2. I tested on a platform without the timers but I
must've left them compiled in.

> 
> >  #include <mach/timex.h>
> >  
> >  typedef unsigned long cycles_t;
> >  
> > -static inline cycles_t get_cycles (void)
> > -{
> > -	return 0;
> > -}
> > +#ifdef ARCH_HAS_READ_CURRENT_TIMER
> > +#define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
> > +#else
> > +#define get_cycles()	(0)
> > +#endif
> >  
> >  #endif
> > diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> > index dd58035..dbbeec4 100644
> > --- a/arch/arm/kernel/arch_timer.c
> > +++ b/arch/arm/kernel/arch_timer.c
> > @@ -223,6 +223,14 @@ static cycle_t arch_counter_read(struct clocksource *cs)
> >  	return arch_counter_get_cntpct();
> >  }
> >  
> > +int read_current_timer(unsigned long *timer_val)
> > +{
> > +	if (!arch_timer_rate)
> > +		return -ENXIO;
> 
> Shouldn't this be returning 0? Otherwise get_cycles() up there will
> evaluate to -ENXIO?

I don't think so. The cycle count is returned via the timer_val parameter
and the get_cycles code checks the return value, so will give 0 if
read_current_timer returns anything other than 0. The core calibration code
(not that we call it) also expects a return value < 0 to indicate failure.

Will

> -- 
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
> 
