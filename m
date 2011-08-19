From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 19 Aug 2011 10:54:59 -0400 (EDT)
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting DEBUG_LL
	UART
In-Reply-To: <20110819113740.GF12527@S2100-06.ap.freescale.net>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<20110818161105.GA12527@S2100-06.ap.freescale.net>
	<20110818160712.GA26691@e102144-lin.cambridge.arm.com>
	<20110819045956.GB12527@S2100-06.ap.freescale.net>
	<20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
Message-ID: <alpine.LFD.2.00.1108191048510.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Aug 2011, Shawn Guo wrote:

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

Just use the alphabetical order, except for the first entry which could 
be a noop.

> >  choice
> >         prompt "Kernel low-level debugging port"
> > -       depends on DEBUG_LL
> > +       depends on DEBUG_LL_UART && (FOOTBRIDGE || ARCH_CLPS711X || \
> > +                                    PLAT_SAMSUNG || ARCH_REALVIEW)
> 
> We will have to list a lot of ARCH/PLAT symbols here.  This is what
> I meant overkilled actually.

Agreed.  Please avoid the need for such localized long lists of 
dependencies which are going to create merge conflicts for sure, and 
which grow into a mess after a while.


Nicolas
