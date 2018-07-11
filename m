From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Wed, 11 Jul 2018 08:53:38 +0200
Subject: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
In-Reply-To: <DB6PR04MB3223F93E1566A97857FD2FF4895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
 <20180710153326.GG3219@vkoul-mobl>
 <DB6PR04MB3223F93E1566A97857FD2FF4895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <20180711065338.3ka4yibxkawgo4fd@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 06:37:02AM +0000, Robin Gong wrote:
> 
> > -----Original Message-----
> > From: Vinod [mailto:vkoul at kernel.org]
> > Sent: 2018?7?10? 23:33
> > To: Robin Gong <yibin.gong@nxp.com>
> > Cc: dan.j.williams at intel.com; shawnguo at kernel.org;
> > s.hauer at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > linux at armlinux.org.uk; linux-arm-kernel at lists.infradead.org;
> > kernel at pengutronix.de; dmaengine at vger.kernel.org;
> > linux-kernel at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
> > 
> > On 11-07-18, 00:23, Robin Gong wrote:
> > > dmatest(memcpy) will never call dmaengine_slave_config before prep,
> > 
> > and that should have been a hint to you that you should not expect that
> > 
> > > so jobs in dmaengine_slave_config need to be moved into somewhere
> > > before device_prep_dma_memcpy. Besides, dmatest never setup chan
> > > ->private as other common case like uart/audio/spi will always setup
> > > chan->private. Here check it to judge if it's dmatest case and do
> > > jobs in slave_config.
> > 
> > and you should not do anything for dmatest. Supporting it means memcpy
> > implementation is not correct :)
> Okay, I will any word about dmatest here since memcpy assume no calling
> slave_config.
> > 
> > >
> > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > ---
> > >  drivers/dma/imx-sdma.c | 37 ++++++++++++++++++++++++++++---------
> > >  1 file changed, 28 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > > ed2267d..48f3749 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -1222,10 +1222,36 @@ static int sdma_alloc_chan_resources(struct
> > > dma_chan *chan)  {
> > >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > >  	struct imx_dma_data *data = chan->private;
> > > +	struct imx_dma_data default_data;
> > >  	int prio, ret;
> > >
> > > -	if (!data)
> > > -		return -EINVAL;
> > > +	ret = clk_enable(sdmac->sdma->clk_ipg);
> > > +	if (ret)
> > > +		return ret;
> > > +	ret = clk_enable(sdmac->sdma->clk_ahb);
> > > +	if (ret)
> > > +		goto disable_clk_ipg;
> > > +	/*
> > > +	 * dmatest(memcpy) will never call dmaengine_slave_config before prep,
> > > +	 * so jobs in dmaengine_slave_config need to be moved into somewhere
> > > +	 * before device_prep_dma_memcpy. Besides, dmatest never setup chan
> > > +	 * ->private as other common cases like uart/audio/spi will setup
> > > +	 * chan->private always. Here check it to judge if it's dmatest case
> > > +	 * and do jobs in slave_config.
> > > +	 */
> > > +	if (!data) {
> > > +		dev_warn(sdmac->sdma->dev, "dmatest is running?\n");
> > 
> > why is that a warning!
> Current SDMA driver assume filter function to set chan->private with specific data 
> (struct imx_dma_data dma_data)like below (sound/soc/fsl/fsl_asrc_dma.c):
> static bool filter(struct dma_chan *chan, void *param)
> {
>         if (!imx_dma_is_general_purpose(chan))
>                 return false;
>         chan->private = param;
>         return true;
> }
> 
> But in memcpy case, at lease dmatest case, no chan->private set in its filter function.
> So here take dmatest a special case and do some prepare jobs for memcpy. But if the
> Upper device driver call dma_request_channel() with their specific filter without
> 'chan->private' setting in the future. The warning message is a useful hint to them to
> Add 'chan->private' in filter function.  Or doc it somewhere?

Instead of doing heuristics to guess whether we are doing memcpy you
could instead make memcpy the default when slave_config is not called,
i.e. drop the if (!data) check completely.

> > 
> > > +		sdmac->word_size  =  sdmac->sdma->dma_device.copy_align;
> > > +		default_data.priority = 2;
> > > +		default_data.peripheral_type = IMX_DMATYPE_MEMORY;
> > > +		default_data.dma_request = 0;
> > > +		default_data.dma_request2 = 0;
> > > +		data = &default_data;
> > > +
> > > +		sdma_config_ownership(sdmac, false, true, false);
> > > +		sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
> > > +		sdma_load_context(sdmac);
> > > +	}
> > 
> > this needs to be default for memcpy

The problem seems to be that we do not know whether we are doing memcpy
or not. Normally we get the information how a channel is to be
configured in dma_device->device_config, but this function is not called
in the memcpy case.

An alternative might also be to do the setup in dma_device->device_prep_dma_memcpy.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
