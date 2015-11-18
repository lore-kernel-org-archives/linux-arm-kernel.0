From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 09:35:20 +0100
Subject: [PATCH v2] SPI: s3c64xx: pass DMA arguments in platform data
In-Reply-To: <564C01EF.60308@samsung.com>
References: <8391350.6B0EUH1WXO@wuerfel> <4634371.Kl2EUjoTtJ@wuerfel>
 <564C01EF.60308@samsung.com>
Message-ID: <3885683.DJ7E2GgAz1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 13:43:27 Krzysztof Kozlowski wrote:
> On 18.11.2015 00:48, Arnd Bergmann wrote:

> >  struct platform_device s3c64xx_device_spi0 = {
> > @@ -1135,11 +1133,13 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
> >  	pd.num_cs = num_cs;
> >  	pd.src_clk_nr = src_clk_nr;
> >  	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
> > -#if defined(CONFIG_PL330_DMA)
> > -	pd.filter = pl330_filter;
> > -#elif defined(CONFIG_S3C64XX_PL080)
> 
> Hmm.... why removing pl330_filter? Is it because of lack of channel
> names? It looks unrelated to this patch.

You are right, it's an unrelated cleanup, I'll drop this change
and add the same lines there.

This code was only there for mach-s5p*, which is DT-only these days
and doesn't need it any more. However, there is a lot of other code
that falls in the same category, and we should clean that up in a
separate patch series.

I'm actually thinking about moving all device definitions from
plat-samsung back to mach-s3c24xx and mach-s3c64xx and then remove
all devices that are unused now. I suspect we end up with an overall
reduction in code size that way, and it will be much easier to keep
track of how things fit together.

> > -	if (!sdd->pdev->dev.of_node) {
> > -		res = platform_get_resource(pdev, IORESOURCE_DMA,  0);
> > -		if (!res) {
> > -			dev_warn(&pdev->dev, "Unable to get SPI tx dma resource. Switching to poll mode\n");
> > -			sdd->port_conf->quirks = S3C64XX_SPI_QUIRK_POLL;
> > -		} else
> > -			sdd->tx_dma.dmach = res->start;
> > -
> > -		res = platform_get_resource(pdev, IORESOURCE_DMA,  1);
> > -		if (!res) {
> > -			dev_warn(&pdev->dev, "Unable to get SPI rx dma resource. Switching to poll mode\n");
> > -			sdd->port_conf->quirks = S3C64XX_SPI_QUIRK_POLL;
> > -		} else
> > -			sdd->rx_dma.dmach = res->start;
> > +	if (sci && (!sci->dma_tx || !sci->dma_rx)) {
> 
> No need for "sci" check. It cannot be NULL at this point - at the
> beginning of probe it is checked already.
> 
> > +		dev_warn(&pdev->dev, "Unable to get SPI tx data. Switching to poll mode\n");
> 
> The message could be now more precise, like:
> "Unable to get SPI rx or tx data. Switching to poll mode\n"

Ok.

> > +		sdd->port_conf->quirks = S3C64XX_SPI_QUIRK_POLL;
> >  	}
> 
> The logic here is now different for DT boards. Previously such board
> would not be marked as polling. Now it is always polling. If needed,
> split it to separate patch.


I think that was a mistake on my side, thanks for finding it.

> >  
> >  	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
> > @@ -1197,9 +1184,10 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
> >  
> >  	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
> >  					sdd->port_id, master->num_chipselect);
> > -	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\tDMA=[Rx-%d, Tx-%d]\n",
> > +	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\tDMA=[Rx-%p, Tx-%p]\n",
> >  					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
> > -					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
> > +					sdd->cntrlr_info->dma_rx,
> > +					sdd->cntrlr_info->dma_tx);
> 
> sci->dma_rx and sci->dma_tx would be equivalent but shorter.

Ok.

	Arnd
