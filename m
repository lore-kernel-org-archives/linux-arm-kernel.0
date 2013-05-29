From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 29 May 2013 11:28:59 -0400 (EDT)
Subject: [PATCH 3/8] ARM: introduce common set_auxcr/get_auxcr
 functions
In-Reply-To: <1369834937.3715.64.camel@linaro1.home>
References: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
 <1369374311-21260-4-git-send-email-nicolas.pitre@linaro.org>
 <1369834937.3715.64.camel@linaro1.home>
Message-ID: <alpine.LFD.2.03.1305291128180.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Jon Medhurst (Tixy) wrote:

> On Fri, 2013-05-24 at 01:45 -0400, Nicolas Pitre wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Move the private set_auxcr/get_auxcr functions from
> > drivers/cpuidle/cpuidle-calxeda.c so they can be used across platforms.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/include/asm/cp15.h       | 14 ++++++++++++++
> >  drivers/cpuidle/cpuidle-calxeda.c | 14 +-------------
> >  2 files changed, 15 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
> > index 1f3262e99d..cedd372131 100644
> > --- a/arch/arm/include/asm/cp15.h
> > +++ b/arch/arm/include/asm/cp15.h
> > @@ -61,6 +61,20 @@ static inline void set_cr(unsigned int val)
> >  	isb();
> >  }
> >  
> > +static inline unsigned int get_auxcr(void)
> > +{
> > +	unsigned int val;
> > +	asm("mrc p15, 0, %0, c1, c0, 1	@ get AUXCR" : "=r" (val));
> > +	return val;
> > +}
> > +
> > +static inline void set_auxcr(unsigned int val)
> > +{
> > +	asm volatile("mcr p15, 0, %0, c1, c0, 1	@ set AUXCR"
> > +	  : : "r" (val));
> > +	isb();
> > +}
> > +
> >  #ifndef CONFIG_SMP
> >  extern void adjust_cr(unsigned long mask, unsigned long set);
> >  #endif
> > diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
> > index 223379169c..8a08e04c0e 100644
> > --- a/drivers/cpuidle/cpuidle-calxeda.c
> > +++ b/drivers/cpuidle/cpuidle-calxeda.c
> > @@ -37,19 +37,7 @@
> >  extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
> >  extern void *scu_base_addr;
> >  
> > -static inline unsigned int get_auxcr(void)
> > -{
> > -	unsigned int val;
> > -	asm("mrc p15, 0, %0, c1, c0, 1	@ get AUXCR" : "=r" (val) : : "cc");
> > -	return val;
> > -}
> > -
> > -static inline void set_auxcr(unsigned int val)
> > -{
> > -	asm volatile("mcr p15, 0, %0, c1, c0, 1	@ set AUXCR"
> > -	  : : "r" (val) : "cc");
> > -	isb();
> > -}
> > +static struct cpuidle_device __percpu *calxeda_idle_cpuidle_devices;
> 
> The added line above looks like a merge error to me.

Yep, good catch.


Nicolas
