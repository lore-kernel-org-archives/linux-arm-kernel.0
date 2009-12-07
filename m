From: ra7055@freescale.com (Herring Robert-RA7055)
Date: Mon, 7 Dec 2009 10:17:52 -0700
Subject: [RFC][PATCH 03/10] arm: mxc: changes to common plat-mxc codeto
	add support for i.MX5
In-Reply-To: <20091204105908.GJ15126@pengutronix.de>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
	<DE2504B3A515524BBE6934369EFDC0DA08C2A56C@az33exm20.fsl.freescale.net>
	<20091204083451.GG15126@pengutronix
	<20091204105908.GJ15126@pengutronix.de>
Message-ID: <DE2504B3A515524BBE6934369EFDC0DA08C2A879@az33exm20.fsl.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sasha, Amit,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de] 
> Sent: Friday, December 04, 2009 4:59 AM
> To: Amit Kucheria
> Cc: Herring Robert-RA7055; List Linux Kernel; 
> linux-arm-kernel at lists.infradead.org; 
> valentin.longchamp at epfl.ch; daniel at caiaq.de; 
> grant.likely at secretlab.ca; Nguyen Dinh-R00091
> Subject: Re: [RFC][PATCH 03/10] arm: mxc: changes to common 
> plat-mxc codeto add support for i.MX5
> 
> On Fri, Dec 04, 2009 at 12:31:02PM +0200, Amit Kucheria wrote:
> > Some comments below:
> > 
> > On 09 Dec 04, Sascha Hauer wrote:
> > > On Thu, Dec 03, 2009 at 08:12:58PM -0700, Herring 
> Robert-RA7055 wrote:
> > > > Amit,
> > > > 
> > > > I would suggest you refactor the timer code into 
> version 1 and version 2
> > > > either as 2 separate files or with a timer_is_v2() 
> function rather than
> > > > the mess of cpu_is_X macros it currently has. 
> Essentially there are 2
> > > > versions of the timer hardware. Version 1 is found on 
> MX1/MXL and MX21.
> > > > Version 2 is found on MX25, MX27, MX31, MX35, MX37, 
> MX51, and future
> > > > parts. I will send you what we have done in our tree.
> > > Like this:
> > > 
> > > 
> > > commit ed6bbc59e3f6b33b48a0d5ac053220cd318ceee7
> > > Author: Sascha Hauer <s.hauer@pengutronix.de>
> > > Date:   Tue Nov 17 16:31:13 2009 +0100
> > > 
> > >     mxc timer: Add mx51 support
> > >     
> > >     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
> > > index 844567e..0c45509 100644
> > > --- a/arch/arm/plat-mxc/time.c
> > > +++ b/arch/arm/plat-mxc/time.c
> > > @@ -57,6 +57,9 @@
> > >  #define MX3_TCN			0x24
> > >  #define MX3_TCMP		0x10
> > >  
> > > +#define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx27())
> >                                                         ^^^^
> >                                       Shouldn't this be 
> mx21 according to
> > 				      Rob's comment?
> 
> i.MX1, i.MX21 and i.MX27 are identical, at least that's what the code
> shows, so it should be:
> 
> #define timer_is_v1()      (cpu_is_mx1() || cpu_is_mx21() || 
> cpu_is_mx27())
> #define timer_is_v2()      (cpu_is_mx3() || cpu_is_mx25() || 
> cpu_is_mx51() || cpu_is_mxc91231())

Sorry, my mistake. Sasha is correct that MX27 is v1 and MX25 is v2.

timer_is_v1 is just !timer_is_v2, so really only one is needed. I would
define it like this to avoid having to change the timer code again for
any new chips:

#define timer_is_v2()   (!(cpu_is_mx1() || cpu_is_mx21() ||
cpu_is_mx27()))

Regards,
Rob
 
