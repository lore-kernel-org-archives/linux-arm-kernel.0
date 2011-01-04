From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 4 Jan 2011 22:26:44 +0800
Subject: [PATCH v2 06/10] ARM: mx28: update clocks for dual fec support
In-Reply-To: <20110104135818.GD25121@pengutronix.de>
References: <1294133056-21195-1-git-send-email-shawn.guo@freescale.com>
	<1294133056-21195-7-git-send-email-shawn.guo@freescale.com>
	<20110104135818.GD25121@pengutronix.de>
Message-ID: <20110104142643.GB21274@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Jan 04, 2011 at 02:58:18PM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Tue, Jan 04, 2011 at 05:24:12PM +0800, Shawn Guo wrote:
> > Register clocks fec.0 and fec.1 for dual fec support.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> > Changes for v2:
> >  - Rebase the patch against patch below which gets fundamental
> >    clocks explicitly called in clk_enable.
> >    [PATCH v4] ARM: mxs: Change duart device to use amba-pl011
> >  - Register clocks fec.0 and fec.1 respectively than use wildcard
> >    NULL for both instances.
> > 
> >  arch/arm/mach-mxs/clock-mx28.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> > index f20b254..f79587b 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -607,6 +607,7 @@ static struct clk_lookup lookups[] = {
> >  	/* for amba-pl011 driver */
> >  	_REGISTER_CLOCK("duart", NULL, uart_clk)
> >  	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> > +	_REGISTER_CLOCK("fec.1", NULL, fec_clk)
> Did you verify this works as intended?  I didn't and consider it
> possible that after
> 
> 	clk_enable("fec.0");
> 	clk_enable("fec.1");
> 	clk_disable("fec.1");
> 
> the clk is off.  Probably it just works, just want to prevent hard to
> find bugs ...
> 
The clk should not be off.  Looking at _REGISTER_CLOCK below, we are
registering both fec.0 and fec.1 on the same one fec_clk.  IOW, the
usecount of the clk is working to control the on/off of the clk.

#define _REGISTER_CLOCK(d, n, c) \
	{ \
		.dev_id = d, \
		.con_id = n, \
		.clk = &c, \
	},

-- 
Regards,
Shawn
