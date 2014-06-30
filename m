From: a.heider@gmail.com (Andre Heider)
Date: Mon, 30 Jun 2014 21:39:40 +0200
Subject: [PATCH 09/13] uio: uio_pruss: add devicetree support
In-Reply-To: <20140630093606.GU7262@leverpostej>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-10-git-send-email-a.heider@gmail.com>
 <20140630093606.GU7262@leverpostej>
Message-ID: <20140630193940.GB78749@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 10:36:06AM +0100, Mark Rutland wrote:
> On Sun, Jun 29, 2014 at 05:21:43PM +0100, Andre Heider wrote:
> > -	/* Power on PRU in case its not done as part of boot-loader */
> > -	gdev->pruss_clk = clk_get(dev, "pruss");
> > -	if (IS_ERR(gdev->pruss_clk)) {
> > -		dev_err(dev, "Failed to get clock\n");
> > -		return PTR_ERR(gdev->pruss_clk);
> > +	if (dev->of_node) {
> > +		match = of_match_device(pruss_of_match_table, dev);
> > +		params = match->data;
> > +		gdev->pintc_base = params->pintc_offset;
> >  	} else {
> > +		/* Power on PRU in case its not done as part of boot-loader */
> > +		gdev->pruss_clk = clk_get(dev, "pruss");
> > +		if (IS_ERR(gdev->pruss_clk)) {
> > +			dev_err(dev, "Failed to get clock\n");
> > +			return PTR_ERR(gdev->pruss_clk);
> > +		}
> 
> The "pruss" clock was not documented in the binding.
> 
> Is the clock really called "pruss", or is it given a specific name in
> the manual?

That hunk was moved, see above. It's not the devicetree path, it's for
non-DT TI DaVinci:

	arch/arm/mach-davinci/da850.c:static struct clk pruss_clk = {
	arch/arm/mach-davinci/da850.c:  .name       = "pruss",

The DT path already has a clocks associated at the hwmod level.
>From arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:

		struct omap_hwmod am33xx_pruss_hwmod = {
					.name		= "pruss",
					.class		= &am33xx_pruss_hwmod_class,
					.clkdm_name	= "pruss_ocp_clkdm",
					.flags		= HWMOD_INIT_DEASSERT_HARD_RESET,
					.main_clk	= "pruss_ocp_gclk",

and doesn't require any additional clock entries as far as the binding is
concerned.

Thanks,
Andre
