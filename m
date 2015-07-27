From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 27 Jul 2015 12:22:53 +0200
Subject: [RESEND PATCH 2/6] soc: Mediatek: Add SCPSYS CPU power domain
 driver
In-Reply-To: <1437815580.4505.14.camel@mtkswgap22>
References: <srv_scott.shu@mediatek.com>
 <20150724055038.GJ18700@pengutronix.de> <1437815580.4505.14.camel@mtkswgap22>
Message-ID: <2571387.7bo8Q3dx7z@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, July 25, 2015 05:13:00 PM Scott Shu wrote:
> On Fri, 2015-07-24 at 07:50 +0200, Sascha Hauer wrote:
> > On Fri, Jul 24, 2015 at 10:02:03AM +0800, Scott Shu wrote:
> > > On Tue, 2015-06-23 at 07:53 +0200, Sascha Hauer wrote:
> > > > Hi Scott,
> > > > 
> > > > On Fri, Jun 19, 2015 at 02:01:17AM +0800, Scott Shu wrote:
> > > > > This adds a CPU power domain driver for the Mediatek SCPSYS unit on
> > > > > MT6580.
> > > > 
> > > > This seems to be support for the very same hardware as I am posting
> > > > here:
> > > > 
> > > > https://lkml.org/lkml/2015/6/22/41
> > > > 
> > > > We should consolidate this.
> > > > 
> > > > My driver is currently handles all power domains except the CPUs while
> > > > yours handles only the CPUs.
> > > > I currently haven't looked whether CPUs can just be part of a power
> > > > domain aswell, but if that works this would probably be the way to go.
> > > > 
> > > > Sascha
> > > 
> > > Hi Sascga,
> > > 
> > > We had posted new patch set in following link, but still keep our
> > > original framework.
> > > http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001498.htm
> > > l
> > > 
> > > As we mentioned in the new email thread, the SMP operations
> > > (smp_boot_secondary) will be executed before registering the scpsys_drv
> > > driver, so the CPUs power domain is controlled on
> > > arch/arm/mach-$(MACHINE) directory.
> > > 
> > > Please kindly provide your comments and suggestion. Thank you very much.
> > 
> > I think that instead of explaining why have to duplicate the code you
> > should rather search for ways how the code can be shared. Yes, we'll
> > need a second (early) entry point to the driver. Maybe we even have to
> > create the shared code which is then called from the driver and your
> > early architecture code.
> > You'll probably have to do this separation between early code and
> > regular driver code in your driver anyway, since I bet the MT6580 also
> > has some power domains which shall be controlled by the regular Linux
> > power domain code later. Also we probably could control the CPU power
> > domains for the MT8173 in the SCPSYS driver aswell, we just don't have
> > to because we use PSCI there. You see we are approaching the same
> > problem from two different corners. Let's find a way to share the code.
> > 
> > Sascha
> 
> Hi Sascha,
>    Thanks. OK, we move all CPU MTCMOS driver from hotplug.c to
> mtk-scpsys.c and the test is passed. Next, we need spend some time to
> integrate the code better.
> 

Good to hear that. We should try to keep mach-mediatek code a little as 
possible.

Cheers,
Matthias
