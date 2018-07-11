From: yibin.gong@nxp.com (Robin Gong)
Date: Wed, 11 Jul 2018 05:36:09 +0000
Subject: [PATCH v1 2/4] dmaengine: imx-sdma: add check_bd_buswidth() to
 kill the dulicated code
In-Reply-To: <20180710153104.GF3219@vkoul-mobl>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
 <20180710153104.GF3219@vkoul-mobl>
Message-ID: <DB6PR04MB3223A023C9D5CC467FC00214895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod [mailto:vkoul at kernel.org]
> Sent: 2018?7?10? 23:31
> To: Robin Gong <yibin.gong@nxp.com>
> Cc: dan.j.williams at intel.com; shawnguo at kernel.org;
> s.hauer at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> linux at armlinux.org.uk; linux-arm-kernel at lists.infradead.org;
> kernel at pengutronix.de; dmaengine at vger.kernel.org;
> linux-kernel at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v1 2/4] dmaengine: imx-sdma: add check_bd_buswidth() to
> kill the dulicated code
> 
> On 11-07-18, 00:23, Robin Gong wrote:
> > Add check_bd_buswidth() to minimize the code size.
> 
> this looks mostly fine and I think this should be first patch..
Since no need to check bus width in memcpy case, I'll remove this patch too.
> 
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  drivers/dma/imx-sdma.c | 64
> > +++++++++++++++++++++++---------------------------
> >  1 file changed, 29 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > 27ccabf..ed2267d 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -1326,6 +1326,33 @@ static struct sdma_desc
> *sdma_transfer_init(struct sdma_channel *sdmac,
> >  	return NULL;
> >  }
> >
> > +static int check_bd_buswidth(struct sdma_buffer_descriptor *bd,
> > +			     struct sdma_channel *sdmac, int count,
> > +			     dma_addr_t dma_dst, dma_addr_t dma_src) {
> > +	int ret = 0;
> > +
> > +	switch (sdmac->word_size) {
> > +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> > +		bd->mode.command = 0;
> > +		if ((count | dma_dst | dma_src) & 3)
> > +			ret = -EINVAL;
> > +		break;
> 
> empty line after each break please
> 
> > +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> > +		bd->mode.command = 2;
> > +		if ((count | dma_dst | dma_src) & 1)
> > +			ret = -EINVAL;
> > +		break;
> > +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> > +		 bd->mode.command = 1;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> --
> ~Vinod
