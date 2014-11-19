From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 19 Nov 2014 11:14:03 +0100
Subject: [PATCH] i2c: at91: introduce probe deferring
In-Reply-To: <5216790.dAh2H6iKq8@wuerfel>
References: <1415972879-26509-1-git-send-email-ludovic.desroches@atmel.com>
 <20141119091647.GB1439@katana> <5216790.dAh2H6iKq8@wuerfel>
Message-ID: <20141119101403.GE3639@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 10:47:15AM +0100, Arnd Bergmann wrote:
> On Wednesday 19 November 2014 10:16:47 Wolfram Sang wrote:
> > On Fri, Nov 14, 2014 at 02:47:59PM +0100, Ludovic Desroches wrote:
> > > Return probe defer if requesting a dma channel without a dma controller probed.
> > > 
> > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > ---
> > >  drivers/i2c/busses/i2c-at91.c | 22 ++++++++++++++++------
> > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> > > index 77fb647..df3f4c4 100644
> > > --- a/drivers/i2c/busses/i2c-at91.c
> > > +++ b/drivers/i2c/busses/i2c-at91.c
> > > @@ -679,14 +679,21 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
> > >  	dma_cap_zero(mask);
> > >  	dma_cap_set(DMA_SLAVE, mask);
> > >  
> > > -	dma->chan_tx = dma_request_slave_channel_compat(mask, filter, pdata,
> > > -							dev->dev, "tx");
> > > -	if (!dma->chan_tx) {
> > > +	dma->chan_tx = dma_request_slave_channel_reason(dev->dev, "tx");
> > 
> > Will it cause regressions if you drop the compat-version of requesting
> > a channel?
> 
> I got curious about this, since the patch looks obviously wrong, but
> actually it's ok. However the entire DMA support for non-DT platforms
> can be dropped in this driver, see patch below
> 
> > > +	if (IS_ERR(dma->chan_tx)) {
> > > +		ret = PTR_ERR(dma->chan_tx);
> > > +		if (ret == -EPROBE_DEFER) {
> > > +			dev_warn(dev->dev, "no DMA channel available at the moment\n");
> > 
> > I'd say drop this warning. The core usually prints when deferred probing
> > takes place.
> 
> Definitely yes.
> 
> 	Arnd
> 8<---
> [PATCH] i2c: at91: remove legacy DMA supoprt
> 
> Since at91sam9g45 is now DT-only, all DMA capable users of this driver are
> using the DT case, and the legacy support can be removed. While at it, fix
> the deferred probe case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 917d54588d95..534f4c07bfb6 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -72,8 +72,6 @@ struct at91_twi_pdata {
>  	unsigned clk_max_div;
>  	unsigned clk_offset;
>  	bool has_unre_flag;
> -	bool has_dma_support;
> -	struct at_dma_slave dma_slave;
>  };
>  
>  struct at91_twi_dma {
> @@ -541,35 +539,30 @@ static struct at91_twi_pdata at91rm9200_config = {
>  	.clk_max_div = 5,
>  	.clk_offset = 3,
>  	.has_unre_flag = true,
> -	.has_dma_support = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9261_config = {
>  	.clk_max_div = 5,
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
> -	.has_dma_support = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9260_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
> -	.has_dma_support = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9g20_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
> -	.has_dma_support = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9g10_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
> -	.has_dma_support = false,
>  };
>  
>  static const struct platform_device_id at91_twi_devtypes[] = {
> @@ -598,7 +591,6 @@ static struct at91_twi_pdata at91sam9x5_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
> -	.has_dma_support = true,
>  };
>  
>  static const struct of_device_id atmel_twi_dt_ids[] = {
> @@ -627,30 +619,11 @@ static const struct of_device_id atmel_twi_dt_ids[] = {
>  MODULE_DEVICE_TABLE(of, atmel_twi_dt_ids);
>  #endif
>  
> -static bool filter(struct dma_chan *chan, void *pdata)
> -{
> -	struct at91_twi_pdata *sl_pdata = pdata;
> -	struct at_dma_slave *sl;
> -
> -	if (!sl_pdata)
> -		return false;
> -
> -	sl = &sl_pdata->dma_slave;
> -	if (sl && (sl->dma_dev == chan->device->dev)) {
> -		chan->private = sl;
> -		return true;
> -	} else {
> -		return false;
> -	}
> -}
> -
>  static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
>  {
>  	int ret = 0;
> -	struct at91_twi_pdata *pdata = dev->pdata;
>  	struct dma_slave_config slave_config;
>  	struct at91_twi_dma *dma = &dev->dma;
> -	dma_cap_mask_t mask;
>  
>  	memset(&slave_config, 0, sizeof(slave_config));
>  	slave_config.src_addr = (dma_addr_t)phy_addr + AT91_TWI_RHR;
> @@ -661,22 +634,17 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
>  	slave_config.dst_maxburst = 1;
>  	slave_config.device_fc = false;
>  
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -
> -	dma->chan_tx = dma_request_slave_channel_compat(mask, filter, pdata,
> -							dev->dev, "tx");
> -	if (!dma->chan_tx) {
> -		dev_err(dev->dev, "can't get a DMA channel for tx\n");
> -		ret = -EBUSY;
> +	dma->chan_tx = dma_request_slave_channel_reason(dev->dev, "tx");
> +	if (IS_ERR(dma->chan_tx)) {
> +		ret = PTR_ERR(dma->chan_tx);
> +		dma->chan_tx = NULL;
>  		goto error;
>  	}
>  
> -	dma->chan_rx = dma_request_slave_channel_compat(mask, filter, pdata,
> -							dev->dev, "rx");
> -	if (!dma->chan_rx) {
> -		dev_err(dev->dev, "can't get a DMA channel for rx\n");
> -		ret = -EBUSY;
> +	dma->chan_rx = dma_request_slave_channel_reason(dev->dev, "rx");
> +	if (IS_ERR(dma->chan_rx)) {
> +		ret = PTR_ERR(dma->chan_rx);
> +		dma->chan_rx = NULL;
>  		goto error;
>  	}
>  
> @@ -697,6 +665,7 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
>  	sg_init_table(&dma->sg, 1);
>  	dma->buf_mapped = false;
>  	dma->xfer_in_progress = false;
> +	dev->use_dma = true;
>  
>  	dev_info(dev->dev, "using %s (tx) and %s (rx) for DMA transfers\n",
>  		 dma_chan_name(dma->chan_tx), dma_chan_name(dma->chan_rx));
> @@ -704,7 +673,8 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
>  	return ret;
>  
>  error:
> -	dev_info(dev->dev, "can't use DMA\n");
> +	if (ret != -EPROBE_DEFER)
> +		dev_info(dev->dev, "can't use DMA, error %d\n", ret);
>  	if (dma->chan_rx)
>  		dma_release_channel(dma->chan_rx);
>  	if (dma->chan_tx)
> @@ -772,10 +742,8 @@ static int at91_twi_probe(struct platform_device *pdev)
>  	}
>  	clk_prepare_enable(dev->clk);
>  
> -	if (dev->pdata->has_dma_support) {
> -		if (at91_twi_configure_dma(dev, phy_addr) == 0)
> -			dev->use_dma = true;
> -	}
> +	if (dev->of_node)
> +		at91_twi_configure_dma(dev, phy_addr);
>  
>  	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
>  			&bus_clk_rate);
> 
