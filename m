From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jan 2012 16:10:09 +0000
Subject: [V3 3/6] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <201201161650.52283.marek.vasut@gmail.com>
References: <1322634646-4460-1-git-send-email-jtzhou@marvell.com>
 <20111130135710.GC18533@game.jcrosoft.org>
 <201201161650.52283.marek.vasut@gmail.com>
Message-ID: <20120116161009.GB32049@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 04:50:52PM +0100, Marek Vasut wrote:
> > On 14:30 Wed 30 Nov     , Jett.Zhou wrote:
> > > Since the regmap of rtc on sa1100, pxa and mmp Marvell soc families are
> > > almost the same, so re-arch the rtc-sa1100 to support them.
> > > 
> > > Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> > > Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > 
> > Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > 
> > just one comment
> > 
> > > ---
> > > 
> > >  arch/arm/mach-pxa/devices.c    |   20 +++
> > >  arch/arm/mach-sa1100/generic.c |   20 +++
> > >  drivers/rtc/Kconfig            |    2 +-
> > >  drivers/rtc/rtc-sa1100.c       |  256
> > >  +++++++++++++++++++++++++++------------ 4 files changed, 218
> > >  insertions(+), 80 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
> > > index 2e04254..8b134c3 100644
> > > --- a/arch/arm/mach-pxa/devices.c
> > > +++ b/arch/arm/mach-pxa/devices.c
> > > @@ -415,9 +415,29 @@ static struct resource pxa_rtc_resources[] = {
> > > 
> > >  	},
> > >  
> > >  };
> > > 
> > > +static struct resource sa1100_rtc_resources[] = {
> > > +	[0] = {
> > > +		.start  = 0x40900000,
> > > +		.end	= 0x409000ff,
> > > +		.flags  = IORESOURCE_MEM,
> > > +	},
> > > +	[1] = {
> > > +		.start  = IRQ_RTC1Hz,
> > > +		.end    = IRQ_RTC1Hz,
> > > +		.flags  = IORESOURCE_IRQ,
> > > +	},
> > > +	[2] = {
> > > +		.start  = IRQ_RTCAlrm,
> > > +		.end    = IRQ_RTCAlrm,
> > > +		.flags  = IORESOURCE_IRQ,
> > > +	},
> > 
> > please the MACRO
> 
> What? You mean "use uppercase" ?

The DEFINE_RES_xxx() macros.
