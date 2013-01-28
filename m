From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 28 Jan 2013 10:23:18 -0500 (EST)
Subject: [PATCH v2 01/16] ARM: introduce common set_auxcr/get_auxcr
 functions
In-Reply-To: <20130128143904.GB23470@mudshark.cambridge.arm.com>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
 <1359008879-9015-2-git-send-email-nicolas.pitre@linaro.org>
 <20130128143904.GB23470@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1301281022210.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jan 2013, Will Deacon wrote:

> On Thu, Jan 24, 2013 at 06:27:44AM +0000, Nicolas Pitre wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Move the private set_auxcr/get_auxcr functions from
> > drivers/cpuidle/cpuidle-calxeda.c so they can be used across platforms.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  arch/arm/include/asm/cp15.h       | 14 ++++++++++++++
> >  drivers/cpuidle/cpuidle-calxeda.c | 14 --------------
> >  2 files changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
> > index 5ef4d8015a..ef0094abf2 100644
> > --- a/arch/arm/include/asm/cp15.h
> > +++ b/arch/arm/include/asm/cp15.h
> > @@ -59,6 +59,20 @@ static inline void set_cr(unsigned int val)
> >  	isb();
> >  }
> >  
> > +static inline unsigned int get_auxcr(void)
> > +{
> > +	unsigned int val;
> > +	asm("mrc p15, 0, %0, c1, c0, 1	@ get AUXCR" : "=r" (val) : : "cc");
> > +	return val;
> > +}
> > +
> > +static inline void set_auxcr(unsigned int val)
> > +{
> > +	asm volatile("mcr p15, 0, %0, c1, c0, 1	@ set AUXCR"
> > +	  : : "r" (val) : "cc");
> > +	isb();
> > +}
> 
> Oh no! It's the return of the magic "cc" clobber! Could we have an extra
> patch to remove those please (since this is just a move)?

I've removed the CC clobber from my copy of this patch.


Nicolas
