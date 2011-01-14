From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 12:04:37 +0000
Subject: ARM: CPU hotplug: fix hard-coded control register constants
In-Reply-To: <4D30386B.7020200@st.com>
References: <4D303758.4060608@st.com> <4D30386B.7020200@st.com>
Message-ID: <20110114120437.GB15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 05:20:03PM +0530, viresh kumar wrote:
> > diff --git a/arch/arm/mach-s5pv310/hotplug.c b/arch/arm/mach-s5pv310/hotplug.c
> > index 951ba6d..afa5392 100644
> > --- a/arch/arm/mach-s5pv310/hotplug.c
> > +++ b/arch/arm/mach-s5pv310/hotplug.c
> > @@ -30,13 +30,13 @@ static inline void cpu_enter_lowpower(void)
> >  	 * Turn off coherency
> >  	 */
> >  	"	mrc	p15, 0, %0, c1, c0, 1\n"
> > -	"	bic	%0, %0, #0x20\n"
> > +	"	bic	%0, %0, %2\n"
> 
> but why replace 0x20 with CR_C instead of CR_D

Looks like a mistake - it should've been the one below.

> >  	"	mcr	p15, 0, %0, c1, c0, 1\n"
> >  	"	mrc	p15, 0, %0, c1, c0, 0\n"
> >  	"	bic	%0, %0, #0x04\n"
> >  	"	mcr	p15, 0, %0, c1, c0, 0\n"
> >  	  : "=&r" (v)
> > -	  : "r" (0)
> > +	  : "r" (0), "Ir" (CR_C)
> >  	  : "cc");

In any case, this code is probably doing the wrong thing - if s5pv310
is not an ARMv6 MPCore the its fiddling with the auxillary control
register is already broken.

> > diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
> > index 17faf77..a5cb1ce 100644
> > --- a/arch/arm/mach-tegra/hotplug.c
> > +++ b/arch/arm/mach-tegra/hotplug.c
> > @@ -26,13 +26,13 @@ static inline void cpu_enter_lowpower(void)
> >  	 * Turn off coherency
> >  	 */
> >  	"	mrc	p15, 0, %0, c1, c0, 1\n"
> > -	"	bic	%0, %0, #0x20\n"
> > +	"	bic	%0, %0, %2\n"
> 
> here also.

Same comment.
