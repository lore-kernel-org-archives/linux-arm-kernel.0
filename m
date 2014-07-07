From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 7 Jul 2014 18:16:57 +0200
Subject: [PATCH v4 2/2] ARM: i.MX53: globally disable supervisor protect
In-Reply-To: <20140707140416.GT30239@dragon>
References: <1404726087-2069-1-git-send-email-s.trumtrar@pengutronix.de>
 <1404726087-2069-2-git-send-email-s.trumtrar@pengutronix.de>
 <20140707140416.GT30239@dragon>
Message-ID: <20140707161657.GA8178@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Jul 07, 2014 at 10:04:18PM +0800, Shawn Guo wrote:
> On Mon, Jul 07, 2014 at 11:41:27AM +0200, Steffen Trumtrar wrote:
> > Most peripherals on the i.MX53 have an
> >   Off-Platform Peripheral Access Control Register (OPACR)
> > in which the access rights (together with the MPROT registers) can be declared.
> > However, this does not seem to work for example for SSI1+SDMA, because the
> > supervisor bit is not set for the SDMA unit.
> > It does work for SSI2, the QSB for example uses SSI2 for its audio. But SSI2 only
> > works because it does NOT have an OPACR.
> > 
> > The right solution would be to fix the access rights for the SDMA, but the unit
> > responsible for this is the Central Security Unit (CSU), which of course is NOT
> > documented. So, until documentation for this is openly available, turn off the
> > supervisor protection because it cripples the hardware.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  arch/arm/mach-imx/mach-imx53.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> > index 2bad387..1fbd77d 100644
> > --- a/arch/arm/mach-imx/mach-imx53.c
> > +++ b/arch/arm/mach-imx/mach-imx53.c
> > @@ -26,9 +26,13 @@
> >  
> >  static void __init imx53_dt_init(void)
> >  {
> > +	const char *aips_compatible = "fsl,imx53-aipstz";
> > +
> 
> The variable is not really necessary, since we can just do:
> 
> 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
> 
> I'm going to fix it up and apply both patches.  Let me know if you have
> concern with that.
> 

I'm okay with that. I don't really have any preference here, so
do as you like best.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
