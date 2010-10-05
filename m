From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Oct 2010 20:15:11 +0200
Subject: [PATCH] ARM: imx: Add iram allocator functions
In-Reply-To: <86A0E76937111F4C92FABEC0A2098851050F1387@az33exm21>
References: <1286237007-8463-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101005074423.GI11737@pengutronix.de>
	<20101005075551.GJ11737@pengutronix.de>
	<86A0E76937111F4C92FABEC0A2098851050F1387@az33exm21>
Message-ID: <20101005181511.GV11737@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nguyen (assuming this is the part of your name corresponding to
the first name),

On Tue, Oct 05, 2010 at 09:49:19AM -0700, Nguyen Dinh-R00091 wrote:
> 
> 
> > -----Original Message-----
> > From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> > Sent: Tuesday, October 05, 2010 2:56 AM
> > To: Nguyen Dinh-R00091
> > Cc: linux-kernel at vger.kernel.org; amit.kucheria at canonical.com;
> > s.hauer at pengutronix.de; grant.likely at secretlab.ca;
> > valentin.longchamp at epfl.ch; daniel at caiaq.de; Zhang Lily-R58066;
> > r.schwebel at pengutronix.de; linux-arm-kernel at lists.infradead.org;
> > kernel at pengutronix.de
> > Subject: Re: [PATCH] ARM: imx: Add iram allocator functions
> > 
> > On Tue, Oct 05, 2010 at 09:44:23AM +0200, Uwe Kleine-K?nig wrote:
> > > On Mon, Oct 04, 2010 at 07:03:27PM -0500, Dinh.Nguyen at freescale.com
> > wrote:
> > > > From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> > > >
> > > > Add iram allocation functions using GENERIC_ALLOCATOR. The
> > > > allocation size is 4KB multiples to guarantee alignment. The
> > > > idea for these functions is for i.MX platforms to use them
> > > > to dynamically allocate IRAM usage.
> > > >
> > > > Applies on 2.6.36-rc6
> > > >
> > > > Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> > > > Reviewed-by: Amit Kucheria <amit.kucheria@canonical.com>
> > > > ---
> > > >  arch/arm/plat-mxc/Kconfig                   |   10 ++++
> > > >  arch/arm/plat-mxc/Makefile                  |    1 +
> > > >  arch/arm/plat-mxc/include/mach/iram_alloc.h |   35 +++++++++++++++
> > > >  arch/arm/plat-mxc/iram.c                    |   62
> > +++++++++++++++++++++++++++
> > > >  4 files changed, 108 insertions(+), 0 deletions(-)
> > > >  create mode 100644 arch/arm/plat-mxc/include/mach/iram_alloc.h
> > > >  create mode 100644 arch/arm/plat-mxc/iram.c
> > > >
> > > > diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> > > > index 6785db4..5e4ff93 100644
> > > > --- a/arch/arm/plat-mxc/Kconfig
> > > > +++ b/arch/arm/plat-mxc/Kconfig
> > > > @@ -57,6 +57,16 @@ source "arch/arm/mach-mx5/Kconfig"
> > > >
> > > >  endmenu
> > > >
> > > > +config IRAM_ALLOC
> > > > +	bool "Enable IRAM allocator"
> > > > +	default y
> > > The iram allocator isn't useful taken alone, no?  So I suggest to make
> > > it
> > Hmm.  It seems I forgot to finish this sentence, sorry.
> > 
> > Unless IRAM_ALLOC is an optional feature for new features to come I'd
> > not make it user selectible, but let the new features select IRAM_ALLOC.
> > If it's optional I wonder if "default y" should really be done.
> > 
> > Maybe better call the symbol just IRAM?
> 
> IRAM should be in almost all SoCs, but it will be dependent on various
> drivers to make use of the IRAM. I think not making it user selectable
> and add IRAM_ALLOC to defconfigs where IRAM_ALLOC is needed makes
> sense.
You cannot add something that is not user selectible to a defconfig.
(Well you can, but it won't get selected even if you do.)  You can just
let (say) MX51_PM select IRAM.

> For example, the reason I am adding IRAM_ALLOC is to support
> MX51 suspend code. The MX51 suspend code needs to be run from IRAM. I
> think also IRAM_ALLOC is more descriptive symbol.
I don't care much, still I think _ALLOC doesn't add much information
here.
 
> > 
> > > > +	iram_pool = gen_pool_create(12, -1);
> > > 	if (!iram_pool)
> > > 		...
> > After rereading the commit log I wondered where the 4 KB are enforced.
> > Maybe do
> > 
> > 	s/12/PAGE_SHIFT/
> > 
> > to make it more obvious?
> 
> I'm unclear about your comment. Should I add a comment of something like this?
> /* 12^2 will create a 4KB granularity. */
I suggested to do:

	iram_pool = gen_pool_create(PAGE_SHIFT, -1);

(see sed(1) to understand the syntax I used.)
or maybe something else that more obvious implies 4KiB than 12.
__fls(SZ_4K) comes to mind.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
