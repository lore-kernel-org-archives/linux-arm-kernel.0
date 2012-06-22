From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 22 Jun 2012 15:46:25 +0200 (CEST)
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <1469075585.3041816.1340216842779.JavaMail.root@advansee.com>
References: <1469075585.3041816.1340216842779.JavaMail.root@advansee.com>
Message-ID: <Pine.LNX.4.64.1206221540390.17552@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno??t

Sorry for a delay, just a minor nit-pick below:

On Wed, 20 Jun 2012, Beno??t Th??baudeau wrote:

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
> 
> I have a question regarding the fallback mechanism in the i.MX31 case: it has
> been created in commit 910862e using levels instead of edges, and this has not
> been changed since. Why? Is it a bug or on purpose?
> 
> Regards,
> Beno??t
> 
> 
> [PATCH] gpio/mxc: use the edge_sel feature if available
> 
> Some mxc processors have an edge_sel feature, which allows the IRQ to be
> triggered by any edge.
> 
> This patch makes use of this feature if available, which skips mxc_flip_edge().
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Beno??t Th??baudeau <benoit.thebaudeau@advansee.com>
> ---
>  .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |    2 +-
>  .../arch/arm/boot/dts/imx51.dtsi                   |    8 +--
>  .../arch/arm/boot/dts/imx53.dtsi                   |   14 ++---
>  .../arch/arm/boot/dts/imx6q.dtsi                   |   14 ++---
>  .../arch/arm/mach-imx/mm-imx25.c                   |   10 +--
>  .../arch/arm/mach-imx/mm-imx3.c                    |    7 +--
>  .../arch/arm/mach-imx/mm-imx5.c                    |   40 ++++++------
>  .../drivers/gpio/gpio-mxc.c                        |   66 +++++++++++++++-----
>  8 files changed, 96 insertions(+), 65 deletions(-)

[snip]

> @@ -74,13 +77,14 @@ static struct mxc_gpio_hwdata imx1_imx21_gpio_hwdata = {
>  	.icr2_reg	= 0x2c,
>  	.imr_reg	= 0x30,
>  	.isr_reg	= 0x34,
> +	.edge_sel_reg	= -1,

Maybe better use a meaningful error code like -EINVAL?

[snip]

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

ditto

> +	case IMX35_GPIO:
> +		mxc_gpio_hwdata = &imx31_imx35_gpio_hwdata;
> +		break;
> +	default:
>  		mxc_gpio_hwdata = &imx1_imx21_gpio_hwdata;
> +	}
>  
>  	mxc_gpio_hwtype = hwtype;
>  }

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
