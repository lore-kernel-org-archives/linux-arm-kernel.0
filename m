From: mporter@ti.com (Matt Porter)
Date: Thu, 10 Jan 2013 17:54:34 -0500
Subject: [RFC PATCH v3 05/16] ARM: edma: add AM33XX crossbar event support
In-Reply-To: <508D12DC.8010400@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-6-git-send-email-mporter@ti.com>
 <508D12DC.8010400@ti.com>
Message-ID: <20130110225434.GT14660@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 04:41:24PM +0530, Sekhar Nori wrote:
> On 10/18/2012 6:56 PM, Matt Porter wrote:
> > Adds support for the per-EDMA channel event mux. This is required
> > for any peripherals using DMA crossbar mapped events.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > ---
> >  arch/arm/common/edma.c             |   63 +++++++++++++++++++++++++++++++++++-
> >  include/linux/platform_data/edma.h |    1 +
> >  2 files changed, 63 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> > index 6d2a590..b761b7a 100644
> > --- a/arch/arm/common/edma.c
> > +++ b/arch/arm/common/edma.c
> > @@ -1425,6 +1425,53 @@ static int edma_of_read_u32_to_s16_array(const struct device_node *np,
> >  	return 0;
> >  }
> >  
> > +static int edma_xbar_event_map(struct device *dev,
> > +			       struct device_node *node,
> > +			       struct edma_soc_info *pdata, int len)
> > +{
> > +	int ret = 0;
> > +	int i;
> > +	struct resource res;
> > +	void *xbar;
> > +	s16 (*xbar_chans)[2];
> > +	u32 shift, offset, mux;
> > +
> > +	xbar_chans = devm_kzalloc(dev,
> > +				  len/sizeof(s16) + 2*sizeof(s16),
> > +				  GFP_KERNEL);
> > +	if (!xbar_chans)
> > +		return -ENOMEM;
> > +
> > +	ret = of_address_to_resource(node, 1, &res);
> > +	if (IS_ERR_VALUE(ret))
> > +		return -EIO;
> > +
> > +	xbar = devm_ioremap(dev, res.start, resource_size(&res));
> > +	if (!xbar)
> > +		return -EIO;
> 
> -ENOMEM is more appropiate for ioremap failures.

Fixed in v4.

> 
> > +
> > +	ret = edma_of_read_u32_to_s16_array(node,
> > +					    "ti,edma-xbar-event-map",
> > +					    (s16 *)xbar_chans,
> > +					    len/sizeof(u32));
> > +	if (IS_ERR_VALUE(ret))
> > +		return -EIO;
> > +
> > +	for (i = 0; xbar_chans[i][0] != -1; i++) {
> > +		shift = (xbar_chans[i][1] % 4) * 8;
> > +		offset = xbar_chans[i][1] >> 2;
> > +		offset <<= 2;
> > +		mux = __raw_readl((void *)((u32)xbar + offset));
> 
> Dont use __raw* variants of io accessors. There will be ordering issues
> on ARMv7.

Fixed in v4.

> 
> > +		mux &= (~(0xff << shift));
> > +		mux |= (xbar_chans[i][0] << shift);
> 
> Unnecessary parens above.

Fixed in v4.

> 
> > +		__raw_writel(mux, (void *)((u32)xbar + offset));
> > +	}
> > +
> > +	pdata->xbar_chans = xbar_chans;
> > +
> > +	return 0;
> > +}
> > +
> >  static int edma_of_parse_dt(struct device *dev,
> >  			    struct device_node *node,
> >  			    struct edma_soc_info *pdata)
> > @@ -1453,7 +1500,6 @@ static int edma_of_parse_dt(struct device *dev,
> >  	pdata->n_slot = value;
> >  
> >  	pdata->n_cc = 1;
> > -	/* This is unused */
> 
> The comment should have not been part of 4/16?

Correct. I moved the change to the correct patch in v4.

> 
> Thanks,
> Sekhar
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
