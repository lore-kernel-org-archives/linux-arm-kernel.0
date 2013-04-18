From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 18 Apr 2013 18:02:08 +0200
Subject: [PATCH RESEND v5 1/2] dma: imx-dma: Add oftree support
In-Reply-To: <51700DDD.1060801@metafoo.de>
References: <1366291298-30004-1-git-send-email-mpa@pengutronix.de>
 <1366291298-30004-2-git-send-email-mpa@pengutronix.de>
 <51700DDD.1060801@metafoo.de>
Message-ID: <20130418160208.GB4307@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 05:14:37PM +0200, Lars-Peter Clausen wrote:
> Hi,
> 
> On 04/18/2013 03:21 PM, Markus Pargmann wrote:
> [...]
> > +static struct dma_chan *imxdma_xlate(struct of_phandle_args *dma_spec,
> > +						struct of_dma *ofdma)
> > +{
> > +	int count = dma_spec->args_count;
> > +	struct imxdma_engine *imxdma = ofdma->of_dma_data;
> > +	struct imxdma_filter_data fdata = {
> > +		.imxdma = imxdma,
> > +		.request = *(unsigned *)&dma_spec->args[0],
> 
> This cast looks rather bogus and shouldn't be necessary.

Ah right, I was assuming "args" is void*.

> 
> > +	};
> > +
> > +	if (count != 1)
> > +		return NULL;
> 
> I think you need to check count before you access dma_spec->args[0]

dma_spec->args is actually a static array of size MAX_PHANDLE_ARGS.
However it is probably cleaner after the check, so I changed both.

Thanks,

Markus

> 
> > +
> > +	return dma_request_channel(imxdma->dma_device.cap_mask,
> > +					imxdma_filter_fn, &fdata);
> > +}
> > +
> [...]
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
