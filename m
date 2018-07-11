From: yibin.gong@nxp.com (Robin Gong)
Date: Wed, 11 Jul 2018 07:05:23 +0000
Subject: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
In-Reply-To: <20180711070107.roscdmzw4pbyvia6@pengutronix.de>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
 <20180711062434.x6waumlh6wtfmvzy@pengutronix.de>
 <DB6PR04MB3223B22099D9C7A079608409895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <20180711070107.roscdmzw4pbyvia6@pengutronix.de>
Message-ID: <DB6PR04MB32238D762101425CC0CEE0F2895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: 2018?7?11? 15:01
> To: Robin Gong <yibin.gong@nxp.com>
> Cc: vkoul at kernel.org; dan.j.williams at intel.com; shawnguo at kernel.org; Fabio
> Estevam <fabio.estevam@nxp.com>; linux at armlinux.org.uk;
> linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de;
> dmaengine at vger.kernel.org; linux-kernel at vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
> 
> On Wed, Jul 11, 2018 at 06:56:18AM +0000, Robin Gong wrote:
> >
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: 2018?7?11? 14:25
> > > To: Robin Gong <yibin.gong@nxp.com>
> > > Cc: vkoul at kernel.org; dan.j.williams at intel.com; shawnguo at kernel.org;
> > > Fabio Estevam <fabio.estevam@nxp.com>; linux at armlinux.org.uk;
> > > linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de;
> > > dmaengine at vger.kernel.org; linux-kernel at vger.kernel.org;
> > > dl-linux-imx <linux-imx@nxp.com>
> > > Subject: Re: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy
> > > interface
> > >
> > > On Wed, Jul 11, 2018 at 12:23:10AM +0800, Robin Gong wrote:
> > > > Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead of
> > > > '0xffff'.
> > > >
> > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > > ---
> > > > +static struct dma_async_tx_descriptor *sdma_prep_memcpy(
> > > > +		struct dma_chan *chan, dma_addr_t dma_dst,
> > > > +		dma_addr_t dma_src, size_t len, unsigned long flags) {
> > > > +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > > > +	struct sdma_engine *sdma = sdmac->sdma;
> > > > +	int channel = sdmac->channel;
> > > > +	size_t count;
> > > > +	int i = 0, param;
> > > > +	struct sdma_buffer_descriptor *bd;
> > > > +	struct sdma_desc *desc;
> > > > +
> > > > +	if (!chan || !len)
> > > > +		return NULL;
> > > > +
> > > > +	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu,
> channel=%d.\n",
> > > > +		&dma_src, &dma_dst, len, channel);
> > > > +
> > > > +	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM, len /
> > > SDMA_BD_MAX_CNT
> > > > +					+ 1);
> > > > +	if (!desc)
> > > > +		goto err_out;
> > > > +
> > > > +	do {
> > > > +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
> > >
> > > When len is bigger than 0xffff you initialize count to 0xffff...
> > In this case, the data will be split into several bds, for example, If
> > the total count is 0x10000, two bd used then. One is for 0xffff,
> > Another is for the last 1
> 
> And you are doing byte size DMA? Wouldn't word size accesses be more
> optimal?
> 
> Sascha
Default is words, and I'll force the buswidth to word and set into BD.
sdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
> 
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Cyibin.gong%40nxp.com%7C41fbd
> 3765b10424a7f1e08d5e6fc196d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C636668892793035822&amp;sdata=mLKjTKaojuO1Zv%2F4ohwkkzeK
> FDFbmqYturqh6eSblIM%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
