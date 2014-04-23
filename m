From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 15:33:29 +0200
Subject: [PATCH v6 2/8] ARM: sunxi: Split out the various machines into
 separate files
In-Reply-To: <20140423132829.GT24905@lukather>
References: <1397724379-15398-1-git-send-email-maxime.ripard@free-electrons.com>
 <201404231433.51129.arnd@arndb.de> <20140423132829.GT24905@lukather>
Message-ID: <6249453.RCSRl1Jr3F@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014 15:28:29 Maxime Ripard wrote:
> On Wed, Apr 23, 2014 at 02:33:50PM +0200, Arnd Bergmann wrote:
> > On Thursday 17 April 2014, Maxime Ripard wrote:
> > > This will allow to add per-SoC hooks more easily.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > >  arch/arm/mach-sunxi/Makefile  |   6 +-
> > >  arch/arm/mach-sunxi/restart.c | 104 +++++++++++++++++++++++++++
> > >  arch/arm/mach-sunxi/restart.h |  20 ++++++
> > >  arch/arm/mach-sunxi/sun4i.c   |  36 ++++++++++
> > >  arch/arm/mach-sunxi/sun5i.c   |  37 ++++++++++
> > >  arch/arm/mach-sunxi/sun6i.c   |  49 +++++++++++++
> > >  arch/arm/mach-sunxi/sun7i.c   |  36 ++++++++++
> > >  arch/arm/mach-sunxi/sunxi.c   | 164 ------------------------------------------
> > >  8 files changed, 287 insertions(+), 165 deletions(-)
> > 
> > This doesn't look like a move in the right direction, and I don't see
> > the connection with the DMA driver.
> 
> This is actually not adding any code at all, just reorganizing it.
> 
> This was also something that would allow to have per-family
> configuration options, and hence not select drivers like the pinctrl
> one that are pretty huge if they're not needed.

I don't mind having split Kconfig entries to control which drivers
are used. It was more about the absolute growth in C source code
lines above.

> > Splitting out the restart code is good, but please complete this by
> > moving it into a driver directory. My preferred location would be
> > within the watchdog driver, since it's really the same registers.
> > You can turn on the watchdog driver as built-in in the defconfig.
> > While it's not ideal that you can end up without a restart function
> > if the driver does not get loaded, I would still prefer that over
> > having the driver in the mach-sunxi directory.
> 
> Ok. The thing is, we don't have any watchdog driver for the A31 for
> the moment, so the restart code will have to stay there. But I can
> totally do that for the A10/A20.
> 
> > An alternative would be to move the restart code into
> > drivers/power/reset.
> 
> That would be a good place for the A31 code then.

Ok, good.

> > > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > > deleted file mode 100644
> > > index 460b5a4962ef..000000000000
> > > --- a/arch/arm/mach-sunxi/sunxi.c
> > 
> > Instead of splitting up this file, I think it would be better to
> > reduce the number of special hacks required per machine. Note that
> > for arm64 we require platforms not to have any code outside of
> > the drivers directory, and I'd like to get to the same situation
> > for much of arch/arm/mach-* as well.
> 
> I think it's fair.
> 
> How would you enforce default clock parenting and/or rate then?

See my other reply.

	Arnd
