From: tpiepho@impinj.com (Trent Piepho)
Date: Mon, 30 Oct 2017 23:47:37 +0000
Subject: [PATCH 3/4] spi: imx: Don't require platform data chipselect array
In-Reply-To: <36d381de-ee3f-26d4-59c3-b9d361758ace@arm.com>
References: <20171013195410.30767-1-tpiepho@impinj.com>
 <20171013195410.30767-3-tpiepho@impinj.com>
 <36d381de-ee3f-26d4-59c3-b9d361758ace@arm.com>
Message-ID: <1509407257.5473.7.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-18 at 10:02 +0100, Julien Thierry wrote:
> --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -1364,13 +1364,15 @@ static int spi_imx_probe(struct platform_device *pdev)
> >   
> >   	if (mxc_platform_info) {
> >   		master->num_chipselect = mxc_platform_info->num_chipselect;
> 
> nit:
> This is only useful when num_chipselect is non-zero (master's memory is 
> zeroed on allocation). So maybe this could be simplified a bit more as:
> 
> if (mxc_platform_info && mxc_platform_info->chipselect) {
> 	master->num_chipselect = mxc_platform_info->num_chipselect;
> 	[...]
> }
> 
> Reducing an indentation level for all the following statements.

Thought about this some more, and it doesn't work to do that.  If
chipselect is NULL, platform data is still allowed to set the number of
chipselects using mcx_platform_info->num_chipselect.

> 
> > -			sizeof(int) * master->num_chipselect, GFP_KERNEL);
> > -		if (!master->cs_gpios)
> > -			return -ENOMEM;
> > -
> > -		for (i = 0; i < master->num_chipselect; i++)
> > -			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
> > +		if (mxc_platform_info->chipselect) {
> > +			master->cs_gpios = devm_kzalloc(&master->dev,
> > +				sizeof(int) * master->num_chipselect, GFP_KERNEL);
> > +			if (!master->cs_gpios)
> > +				return -ENOMEM;
> > +
> > +			for (i = 0; i < master->num_chipselect; i++)
> > +				master->cs_gpios[i] = mxc_platform_info->chipselect[i];
> > +		}
> >    	}
> >   
> >   	spi_imx->bitbang.chipselect = spi_imx_chipselect;
> > 
> 
> 
