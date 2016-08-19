From: rui.zhang@intel.com (Zhang Rui)
Date: Fri, 19 Aug 2016 19:29:56 +0800
Subject: [PATCH v3] thermal: tango: add resume support
In-Reply-To: <8406200.nXRkviT67W@wuerfel>
References: <57726196.5060909@free.fr> <4062048.3qHsMMf8fO@wuerfel>
 <5795E07F.6010506@free.fr> <8406200.nXRkviT67W@wuerfel>
Message-ID: <1471606196.2691.58.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?, 2016-07-26 at 14:13 +0200, Arnd Bergmann wrote:
> On Monday, July 25, 2016 11:48:47 AM CEST Mason wrote:
> > 
> > On 25/07/2016 10:52, Arnd Bergmann wrote:
> > 
> > > 
> > > On Monday, July 25, 2016 10:18:22 AM CEST Mason wrote:
> > > 
> > > > 
> > > > Moving the SIMPLE_DEV_PM_OPS macro outside the CONFIG_PM_SLEEP
> > > > guard
> > > > would unconditionally define a struct dev_pm_ops, which just
> > > > wastes
> > > > space when CONFIG_PM_SLEEP is undefined (if I'm not mistaken).
> > > > 
> > > > That's why I put SIMPLE_DEV_PM_OPS inside the CONFIG_PM_SLEEP
> > > > guard.
> > > If you want to avoid the extra few bytes, just use the trick I
> > > suggested:
> > > 
> > > ??????.pm = IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm :
> > > NULL,
> > This would achieve the same result as the solution I proposed
> > in my v2 patch, right?
> > 
> > So you're saying you prefer the IS_ENABLED macro over using
> > #ifdef ... #else define stuff as NULL #endif
> > 
> > Did I get that right?
> Yes, but I'd also prefer not to hide the operations structure
> at all and just rely on the __maybe_unused (ideally) or
> #ifdef (not as good, but commonly used) to leave out the
> functions.
> 
IMO, the typical way is to use #ifdef for the pm callbacks, and leave
SIMPLE_DEV_PM_OPS outside the #ifdef.
For example,?drivers/ata/ahci_imx.c.

thanks,
rui
> > 
> > Eduardo, Zhang, what do thermal maintainers prefer?
> > 
> > > 
> > > You should basically never have that #ifdef inside of the
> > > platform_driver definition.
> > Except when the fields don't exist, like the bug I introduced
> > in struct smp_operations (which you fixed).
> Right.
> 
> 	Arnd
