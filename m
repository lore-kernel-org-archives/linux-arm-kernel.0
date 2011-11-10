From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 10 Nov 2011 08:11:10 +0000
Subject: [PATCH] ARM: mx28evk: Simplify GPIO requests for mx28evk_fec_reset
In-Reply-To: <20111110075324.GQ16886@pengutronix.de>
References: <1320865742-16768-1-git-send-email-fabio.estevam@freescale.com>
 <20111110075324.GQ16886@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722CB848@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Sascha Hauer
> Sent: Thursday, November 10, 2011 3:53 PM
> To: Estevam Fabio-R49496
> Cc: Guo Shawn-R65073; kernel at pengutronix.de; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: mx28evk: Simplify GPIO requests for
> mx28evk_fec_reset
> 
> Hi Fabio,
> 
> On Wed, Nov 09, 2011 at 05:09:02PM -0200, Fabio Estevam wrote:
> > Simplify GPIO requests inside mx28evk_fec_reset by using
> gpio_request_array.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  arch/arm/mach-mxs/mach-mx28evk.c |   29 ++++++++---------------------
> >  1 files changed, 8 insertions(+), 21 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/mach-mx28evk.c
> > b/arch/arm/mach-mxs/mach-mx28evk.c
> > index ac2316d..c565c33 100644
> > --- a/arch/arm/mach-mxs/mach-mx28evk.c
> > +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> > @@ -219,6 +219,11 @@ static const struct gpio_led_platform_data
> mx28evk_led_data __initconst = {
> >  	.num_leds = ARRAY_SIZE(mx28evk_leds),  };
> >
> > +static struct gpio mx28evk_fec_gpios[] = {
> > +	{ MX28EVK_FEC_PHY_POWER, GPIOF_OUT_INIT_LOW, "fec-power" },
> > +	{ MX28EVK_FEC_PHY_RESET, GPIOF_OUT_INIT_LOW, "fec-enable" }, };
> > +
> >  /* fec */
> >  static void __init mx28evk_fec_reset(void)  { @@ -231,28 +236,10 @@
> > static void __init mx28evk_fec_reset(void)
> >  		clk_enable(clk);
> >
> >  	/* Power up fec phy */
> > -	ret = gpio_request(MX28EVK_FEC_PHY_POWER, "fec-phy-power");
> > -	if (ret) {
> > -		pr_err("Failed to request gpio fec-phy-%s: %d\n", "power",
> ret);
> > -		return;
> > -	}
> > -
> > -	ret = gpio_direction_output(MX28EVK_FEC_PHY_POWER, 0);
> > -	if (ret) {
> > -		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "power", ret);
> > -		return;
> > -	}
> > -
> > -	/* Reset fec phy */
> > -	ret = gpio_request(MX28EVK_FEC_PHY_RESET, "fec-phy-reset");
> > -	if (ret) {
> > -		pr_err("Failed to request gpio fec-phy-%s: %d\n", "reset",
> ret);
> > -		return;
> > -	}
> > -
> > -	gpio_direction_output(MX28EVK_FEC_PHY_RESET, 0);
> > +	ret = gpio_request_array(mx28evk_fec_gpios,
> > +				ARRAY_SIZE(mx28evk_fec_gpios));
> 
> I think it makes more sense to create an array per board and not per
> board function. In the mx28evk file we use gpios for the fec, we have a
> gpio_request_one for the flexcan switch and a gpio_request_array for the
> lcd pins. All these could be added to a single mx28evk_gpios array.
> Then it would be easy to see which gpios a board uses and it would be
> trivial to add additional gpios. The same applies for other boards aswell
> of course.
> 
One question is that if one gpio, assume in one function like fec, request fail
will cause the whole gpio array request fail.
How should we handle the error for each function?

Originally we may do like:
If (!gpio_request_array(fec_gpios))
	mxs_add_fec(0);
but after change, we do not know which function gpio request fails.

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards
Dong Aisheng
