From: schen@mvista.com (Steve Chen)
Date: Fri, 18 Sep 2009 15:25:34 -0500
Subject: [PATCH v3] arm: remove unused code in delay.S
In-Reply-To: <20090918190920.GB11461@pengutronix.de>
References: <1253292418.3273.257.camel@linux-1lbu>
	<20090918190920.GB11461@pengutronix.de>
Message-ID: <1253305534.3273.283.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-09-18 at 21:09 +0200, Uwe Kleine-K?nig wrote:
> Hello Steve,
> 
> On Fri, Sep 18, 2009 at 11:46:58AM -0500, Steve Chen wrote:
> > Document #if 0 code block in delay.S and make it selectable for compile.
> > 
> > Signed-off-by: Steve Chen <schen@mvista.com>
> > 
> > ---
> >  arch/arm/Kconfig     |   31 +++++++++++++++++++++++++++++++
> >  arch/arm/lib/delay.S |    2 +-
> >  2 files changed, 32 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index aef63c8..f44cb70 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -813,6 +813,37 @@ config ARM_ERRATA_460075
> >  	  ACTLR register. Note that setting specific bits in the ACTLR
> > register
> >  	  may not be available in non-secure mode.
> >  
> > +config OLD_CPU_DELAY
> > +	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
> > +	bool "Different delay() code for some older CPUs"
> > +	def_bool n
> as already noted, n is the default (that would better be expressed using
> "default n" btw).

Jean-Christope/Uwe, I'll change it to "default n".

> 
> > +	help
> > +	  Enable this if observing longer than expected delays.  This code
> > +	  improves delay accuracy for some CPUs.  However, it can also cause
> > +	  delay duration to be too short for others which leads to stability
> > +	  issues.
> > +
> > +	  In other words, do not enable unless you can guarantee that the
> > +	  processor (or ALL of the processors if building a generic kernel)
> > +	  delays for at least the time requested after enabling.
> > +
> > +	  ARM610 and ARM710 are known to benefit from enabling this option.
> > +	  It should not be enabled for StrongARMs, because it is known
> > +	  to produce too short delays on those.
> > +
> > +	  Lastly, below are 2 lists.  The first list contains the processors
> > +	  that would benefit from enabling this flag, and the second list
> > +	  contains processor that are known to have issues.  Please note that
> > +	  both lists are by no means complete.  Entries are expected to be
> > +	  added and refined.  If you like to update the list, please send a
> > +	  patch to Linux ARM mailing list.
> I'd delete the last three sentences.

Well, do.  Anything after "Entries are expected to be..." will be
deleted.

> 
> > +	  CPUs should enable this flag
> > +		ARM610
> > +		ARM710
> > +
> > +	  CPUs should disable this flag
> > +		StrongARM
> everything armv5+ ?

If you know for sure, I'll add it.  Since I don't know if that is true,
I like to have some confirmation.  Come to think of it, it may be a good
idea to include the source of the info in the CPU list.  I'll put

	ARM610 (rmk)
	ARM710 (rmk)
etc. in the next revision since the information was extracted from
Russel's comments in this e-mail thread.

> 
> Best regards
> Uwe
> 
