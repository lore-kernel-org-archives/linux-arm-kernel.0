From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Jun 2012 08:43:47 +0200
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <1469075585.3041816.1340216842779.JavaMail.root@advansee.com>
References: <20120620091959.GQ28394@pengutronix.de>
 <1469075585.3041816.1340216842779.JavaMail.root@advansee.com>
Message-ID: <20120621064347.GW28394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 08:27:22PM +0200, Beno?t Th?baudeau wrote:
> On Wed, Jun 20, 2012 at 11:19:59AM +0200, Sascha Hauer wrote:
> > To make Shawns suggestion a bit more clear:
> > 
> > What you should do here is to add flags describing differences
> > between
> > SoCs in mxc_gpio_hwdata.
> > 
> > This means that you have to:
> > 
> > - add IMX35_GPIO to enum mxc_gpio_hwtype
> > - add imx35-gpio to mxc_gpio_devtype[]
> > - add "fsl,imx35-gpio" to the compatible list.
> > - fix all devicetree bindings and platform device bindings for
> >   i.MX25,35,51,53 and probably i.MX6
> 
> Thanks for your suggestion. I have implemented it in the reworked patch below.
> 
> I have checked the reference manuals for i.MX25/35/5x and tested it on
> i.MX25/35. The reference manual of the i.MX6Q is not public (yet?), so I need
> someone who has it to check that this change is valid for the i.MX6Q too. I
> assumed in this patch that the i.MX6Q has this EDGE_SEL register at offset 0x1c.

Just checked, that's correct.

> 
> I have a question regarding the fallback mechanism in the i.MX31 case: it has
> been created in commit 910862e using levels instead of edges, and this has not
> been changed since. Why? Is it a bug or on purpose?

I assume that implementing this using level irqs is less racy. If you
implement it using edge irqs the edge could come during the time you
reconfigure the edge in the controller in which case the interrupt would
get lost.


> @@ -338,10 +365,15 @@ static void __devinit mxc_gpio_get_hw(struct platform_device *pdev)
>  		return;
>  	}
>  
> -	if (hwtype == IMX31_GPIO)
> -		mxc_gpio_hwdata = &imx31_gpio_hwdata;
> -	else
> +	switch (hwtype) {
> +	case IMX31_GPIO:
> +		imx31_imx35_gpio_hwdata.edge_sel_reg = -1;

missing 'break'

Also I think we should not modify imx31_gpio_hwdata but instead add an
additional imx35_gpio_hwdata. It will waste a few bytes but make the
code more straightforward.

Sascha

> +	case IMX35_GPIO:
> +		mxc_gpio_hwdata = &imx31_imx35_gpio_hwdata;
> +		break;
> +	default:
>  		mxc_gpio_hwdata = &imx1_imx21_gpio_hwdata;
> +	}
>  
>  	mxc_gpio_hwtype = hwtype;
>  }
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
