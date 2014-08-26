From: b38343@freescale.com (Robin Gong)
Date: Tue, 26 Aug 2014 15:17:59 +0800
Subject: [PATCH v4] spi: spi-imx: add DMA support
In-Reply-To: <201408251007.22393.marex@denx.de>
References: <1408752835-10995-1-git-send-email-b38343@freescale.com>
 <201408251007.22393.marex@denx.de>
Message-ID: <20140826071757.GA32751@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 10:07:22AM +0200, Marek Vasut wrote:
> On Saturday, August 23, 2014 at 02:13:55 AM, Robin Gong wrote:
> > After enable DMA
> 
> Please also add a commit message which describes the change, not only some test 
> results.
> 
> [...]
> 
 Ok, I will enrich it in next version.
> > @@ -911,6 +1194,13 @@ static int spi_imx_probe(struct platform_device
> > *pdev) goto out_put_per;
> > 
> >  	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
> > +	/*
> > +	 * Only validated on i.mx6 now, can remove the constrain if validated on
> > +	 * other chips.
> > +	 */
> 
> Given that the check below tests for imx51_ecspi_devtype_data ... does that 
> mean, that this code was never tested on MX51 and MX53, yet will be enabled
> for those chips and might possibly break them ?
> 
Yes, because there is no available mx51 mx53 boards in my hands. But I think it
won't bring too much trouble, since they share the same IP.
No, the patch won't break current MX51 and MX53, because they didn't enable dma
in dts setting,and they will keep use pio mode.

> > +	if (spi_imx->devtype_data == &imx51_ecspi_devtype_data
> > +	    && spi_imx_sdma_init(&pdev->dev, spi_imx, master, res))
> > +		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
> > 
> >  	spi_imx->devtype_data->reset(spi_imx);
> > 
> > @@ -949,6 +1239,7 @@ static int spi_imx_remove(struct platform_device
> > *pdev) writel(0, spi_imx->base + MXC_CSPICTRL);
> >  	clk_unprepare(spi_imx->clk_ipg);
> >  	clk_unprepare(spi_imx->clk_per);
> > +	spi_imx_sdma_exit(spi_imx);
> >  	spi_master_put(master);
> > 
> >  	return 0;
> 
> Best regards,
> Marek Vasut
