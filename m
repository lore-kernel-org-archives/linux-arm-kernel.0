From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 19:21:14 +0800
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <4FEC329C.7070004@pengutronix.de>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEC329C.7070004@pengutronix.de>
Message-ID: <20120628112111.GC22990@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 12:31:56PM +0200, Marc Kleine-Budde wrote:
> Hmm I'm wondering if transceiver or phy is the correct name here. In
> platform_data it's called transceiver_switch.

The transceiver_switch in platform_data names a function, while we are
naming a couple gpios which happen to be access in that function.  It
looks all correct to me.

> > +	int phy_en_gpio = -EINVAL;
> > +	int phy_stby_gpio = -EINVAL;
> > +	bool phy_en_high = true;
> > +	bool phy_stby_high = true;
> >  
> >  	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> >  	if (IS_ERR(pinctrl))
> > @@ -940,11 +962,46 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
> >  
> >  	if (pdev->dev.of_node) {
> >  		const u32 *clock_freq_p;
> > +		enum of_gpio_flags flags;
> >  
> >  		clock_freq_p = of_get_property(pdev->dev.of_node,
> >  						"clock-frequency", NULL);
> >  		if (clock_freq_p)
> >  			clock_freq = *clock_freq_p;
> > +
> > +		phy_en_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
> > +						      "phy-enable-gpios",
> > +						       0, &flags);
> > +		if (gpio_is_valid(phy_en_gpio)) {
> > +			if (flags == OF_GPIO_ACTIVE_LOW)
> > +				phy_en_high = false;
> 
> I really like the "flags" solution, much better than a DT property. What
> about keeping the term active_low instead of en_high? From my limited
> knowledge about electronic I say, that active low is a standard term.
> 
Ok, we will have these two bool variables named phy_en_active_low and
phy_stby_active_low.  Will resend to change them.

-- 
Regards,
Shawn
