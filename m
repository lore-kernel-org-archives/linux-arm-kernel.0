From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 12 Jan 2011 13:06:44 +0800
Subject: [PATCH 2/2] ARM i.MXS: Add auart platform support for i.MX28
In-Reply-To: <20110111151725.GT24920@pengutronix.de>
References: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
	<1294758545-9445-3-git-send-email-s.hauer@pengutronix.de>
	<20110111151725.GT24920@pengutronix.de>
Message-ID: <20110112050644.GC2888@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 04:17:25PM +0100, Uwe Kleine-K?nig wrote:
> Hello Sascha,
> 
> On Tue, Jan 11, 2011 at 04:09:05PM +0100, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/mach-mxs/clock-mx28.c                  |    5 ++
> >  arch/arm/mach-mxs/devices-mx28.h                |    8 +++
> >  arch/arm/mach-mxs/devices/Kconfig               |    3 +
> >  arch/arm/mach-mxs/devices/Makefile              |    1 +
> >  arch/arm/mach-mxs/devices/platform-auart.c      |   54 +++++++++++++++++++++++
> >  arch/arm/mach-mxs/include/mach/devices-common.h |   10 ++++
> >  6 files changed, 81 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mxs/devices/platform-auart.c
> > 
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> > index 74e2103..9f65934 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -603,6 +603,11 @@ _DEFINE_CLOCK(fec_clk, ENET, DISABLE, &hbus_clk);
> >  
> >  static struct clk_lookup lookups[] = {
> >  	_REGISTER_CLOCK("mxs-duart.0", NULL, uart_clk)
> > +	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
> > +	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
> > +	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
> > +	_REGISTER_CLOCK("mxs-auart.3", NULL, uart_clk)
> > +	_REGISTER_CLOCK("mxs-auart.4", NULL, uart_clk)
> >  	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> >  	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
> >  	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
> > diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
> > index 00b736c..a0b70df 100644
> > --- a/arch/arm/mach-mxs/devices-mx28.h
> > +++ b/arch/arm/mach-mxs/devices-mx28.h
> > @@ -15,6 +15,14 @@ extern const struct mxs_duart_data mx28_duart_data __initconst;
> >  #define mx28_add_duart() \
> >  	mxs_add_duart(&mx28_duart_data)
> >  
> > +extern const struct mxs_auart_data mx28_auart_data[] __initconst;
> > +#define mx28_add_auart(id)	mxs_add_auart(&mx28_auart_data[id])
> > +#define mx28_add_auart0()		mx28_add_auart(0)
> > +#define mx28_add_auart1()		mx28_add_auart(1)
> > +#define mx28_add_auart2()		mx28_add_auart(2)
> > +#define mx28_add_auart3()		mx28_add_auart(3)
> > +#define mx28_add_auart4()		mx28_add_auart(4)
> I wouldn't add the mx28_add_auartX macros, only mx28_add_auart.  The
> former are a relict of the time when we didn't use an array to get the
> data from.
> 
> > +
> >  extern const struct mxs_fec_data mx28_fec_data[] __initconst;
> >  #define mx28_add_fec(id, pdata) \
> >  	mxs_add_fec(&mx28_fec_data[id], pdata)
> > diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
> > index a35a2dc..9d16540 100644
> > --- a/arch/arm/mach-mxs/devices/Kconfig
> > +++ b/arch/arm/mach-mxs/devices/Kconfig
> > @@ -1,5 +1,8 @@
> >  config MXS_HAVE_PLATFORM_DUART
> >  	bool
> >  
> > +config MXS_HAVE_PLATFORM_AUART
> > +	bool
> > +
> This doesn't happen to be an amba device, too?
> 
> >  config MXS_HAVE_PLATFORM_FEC
> >  	bool
> > diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
> > index 4b5266a..b46d18d 100644
> > --- a/arch/arm/mach-mxs/devices/Makefile
> > +++ b/arch/arm/mach-mxs/devices/Makefile
> > @@ -1,2 +1,3 @@
> >  obj-$(CONFIG_MXS_HAVE_PLATFORM_DUART) += platform-duart.o
> > +obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
> >  obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
> this conflicts with the "make duart use amba-pl011 driver" patch.

May I know the reason that the patch is still pending for being
merged? DEBUG_SPINLOCK_SLEEP warning?

[...]

-- 
Regards,
Shawn
