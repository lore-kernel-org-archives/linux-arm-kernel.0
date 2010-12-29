From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 11:28:19 +0100
Subject: [PATCH 06/10] ARM: mx28: update clocks for dual fec support
In-Reply-To: <20101229101441.GC19347@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-7-git-send-email-shawn.guo@freescale.com>
	<20101229065734.GC31010@jasper.tkos.co.il>
	<20101229081044.GK14221@pengutronix.de>
	<20101229101441.GC19347@freescale.com>
Message-ID: <20101229102819.GS14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 29, 2010 at 06:14:42PM +0800, Shawn Guo wrote:
> On Wed, Dec 29, 2010 at 09:10:44AM +0100, Uwe Kleine-K?nig wrote:
> > On Wed, Dec 29, 2010 at 08:57:34AM +0200, Baruch Siach wrote:
> > > Hi Shawn,
> > > 
> > > On Tue, Dec 28, 2010 at 10:55:51PM +0800, Shawn Guo wrote:
> > > > * Change fec clock registration to use con_id only for looking up,
> > > >   so that dual fec driver can find the same clock for both fec0
> > > >   and fec1.
> > > > 
> > > > * Explicitly call clk_enable for some clocks that have been on to
> > > >   reflect the clock status and get usecount updated. Otherwise,
> > > >   clocks could be turned off by pair call of clk_enable/clk_disable
> > > >   in drivers, because of the incorrect initial usecount.
> > > > 
> > > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > > ---
> > > >  arch/arm/mach-mxs/clock-mx28.c |    7 ++++++-
> > > >  1 files changed, 6 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> > > > index dd6d158..6b77aff 100644
> > > > --- a/arch/arm/mach-mxs/clock-mx28.c
> > > > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > > > @@ -603,7 +603,7 @@ _DEFINE_CLOCK(fec_clk, ENET, DISABLE, &hbus_clk);
> > > >  
> > > >  static struct clk_lookup lookups[] = {
> > > >  	_REGISTER_CLOCK("uart", NULL, uart_clk)
> > > > -	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> > > > +	_REGISTER_CLOCK(NULL, "fec_clk", fec_clk)
> > > 
> > > Looks like a wrong use of the clk API. You should define define two clocks 
> > > "fec.0" and "fec.1".
> > The commit log suggests that both should enable the same (hardware)
> > clock.  Still I agree with Baruch that in this case clk_get() should
> > just return the same clock for both fec.0 and fec.1.
> > I think it's a bit more work than just adding
> > 	_REGISTER_CLOCK("fec.1", NULL, fec_clk)
> > 
> I originally had what you suggest above. But when I found fec driver
> only calls clk_get like below, I change the code to current one to 
> save one line code.
> 
> 	fep->clk = clk_get(&pdev->dev, "fec_clk");
if there is only a single (software) clock for the fec, the driver
should pass NULL as 2nd argument to clk_get.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
