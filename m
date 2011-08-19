From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Aug 2011 13:32:38 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <20110819113740.GF12527@S2100-06.ap.freescale.net>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<20110818161105.GA12527@S2100-06.ap.freescale.net>
	<20110818160712.GA26691@e102144-lin.cambridge.arm.com>
	<20110819045956.GB12527@S2100-06.ap.freescale.net>
	<20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
Message-ID: <20110819123238.GD8918@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 12:37:41PM +0100, Shawn Guo wrote:
> On Fri, Aug 19, 2011 at 12:08:22PM +0100, Will Deacon wrote:
> > On Fri, Aug 19, 2011 at 05:59:57AM +0100, Shawn Guo wrote:
> > > On Thu, Aug 18, 2011 at 05:07:12PM +0100, Will Deacon wrote:
> > > > I'm not sure that sorting this list in alphabetical order is a good idea.
> > > > This is a Kconfig choice, so the default value is the first one in the list
> > > > that has its dependencies satisfied. Therefore, the ordering has a direct
> > > > impact on the default UART selection.
> > > > 
> > > I'm unsure that the default UART selection makes much sense here.
> > > When we build so many platforms into single image, it's hard to say
> > > which one should be the default.  People anyway need to check if the
> > > the UART selection matches the platform they are debugging on.
> > 
> > Ok, how about having the default choice as a dummy option which doesn't
> > correspond to a UART?:
> > 
> To me, it is a little bit overkilled.  Can we just sort them in
> alphabetical order and let the first one be the winner?  We can take
> this as a reward to the good naming :)

We could do this, I just thought it might be better to force the user to
select a UART rather than blindly using the first one in the list. Then
again, as Russell pointed out, DEBUG_LL should only be selected if you know
what you are doing.

> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index f23975a..455bc8c 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -65,8 +65,12 @@ config DEBUG_USER
> >  
> >  # These options are only for real kernel hackers who want to get their hands dirty.
> >  config DEBUG_LL
> > +       bool
> > +
> > +config DEBUG_LL_UART
> >         bool "Kernel low-level debugging functions"
> >         depends on DEBUG_KERNEL
> > +       select DEBUG_LL if !DEBUG_UART_NONE
> >         help
> >           Say Y here to include definitions of printascii, printch, printhex
> >           in the kernel.  This is helpful if you are debugging code that
> > @@ -74,7 +78,12 @@ config DEBUG_LL
> >  
> >  choice
> >         prompt "Kernel low-level debugging port"
> > -       depends on DEBUG_LL
> > +       depends on DEBUG_LL_UART && (FOOTBRIDGE || ARCH_CLPS711X || \
> > +                                    PLAT_SAMSUNG || ARCH_REALVIEW)
> 
> We will have to list a lot of ARCH/PLAT symbols here.  This is what
> I meant overkilled actually.

Ultimately, we will want to have all the platforms using this mechanism so
this list of symbols could eventually be removed. I take your point though;
so I'll leave the patch series as it is for now.

Will
