From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Jun 2013 15:49:59 +0530
Subject: [PATCH v11 3/8] ARM: edma: Add EDMA crossbar event mux support
In-Reply-To: <1371537499-12970-4-git-send-email-joelagnel@ti.com>
References: <1371537499-12970-1-git-send-email-joelagnel@ti.com>
 <1371537499-12970-4-git-send-email-joelagnel@ti.com>
Message-ID: <51C0344F.6010709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/18/2013 12:08 PM, Joel A Fernandes wrote:
> From: Matt Porter <mporter@ti.com>
> 
> Changes by Joel:
> * Split EDMA xbar support out of original EDMA DT parsing patch
> to keep it easier for review.
> * Rewrite shift and offset calculation.
> 
> Suggested-by: Sekhar Nori <nsekhar@ti.com>
> Suggested by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
> 
> Reference:
> [1] https://patchwork.kernel.org/patch/2226991/
> ---
>  arch/arm/common/edma.c             |   59 ++++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/edma.h |    1 +
>  2 files changed, 60 insertions(+)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 9823b79..1c2fb15 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1410,6 +1410,52 @@ static int edma_of_read_u32_to_s16_array(const struct device_node *np,
>  	return 0;
>  }
>  
> +static int edma_xbar_event_map(struct device *dev,
> +			       struct device_node *node,
> +			       struct edma_soc_info *pdata, int len)
> +{
> +	int ret = 0;
> +	int i;
> +	struct resource res;
> +	void *xbar;

void __iomem *xbar;

> +	const s16 (*xbar_chans)[2];
> +	u32 shift, offset, mux;
> +
> +	xbar_chans = devm_kzalloc(dev,
> +				  len/sizeof(s16) + 2*sizeof(s16),
> +				  GFP_KERNEL);
> +	if (!xbar_chans)
> +		return -ENOMEM;
> +
> +	ret = of_address_to_resource(node, 1, &res);
> +	if (ret)
> +		return -EIO;
> +
> +	xbar = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!xbar)
> +		return -ENOMEM;
> +
> +	ret = edma_of_read_u32_to_s16_array(node,
> +					    "ti,edma-xbar-event-map",
> +					    (s16 *)xbar_chans,
> +					    len/sizeof(u32));
> +	if (ret)
> +		return -EIO;
> +
> +	for (i = 0; xbar_chans[i][0] != -1; i++) {
> +		shift = (xbar_chans[i][1] & 0x03) << 3;
> +		offset = xbar_chans[i][1] & 0xfffffffc;
> +		mux = readl((void *)((u32)xbar + offset));

Please drop unnecessary casting. Simply:

	mux = readl(xbar + offset);

> +		mux &= ~(0xff << shift);
> +		mux |= xbar_chans[i][0] << shift;
> +		writel(mux, (void *)((u32)xbar + offset));

Fix the writel likewise.

> +	}
> +
> +	pdata->xbar_chans = xbar_chans;
> +
> +	return 0;
> +}
> +
>  static int edma_of_parse_dt(struct device *dev,
>  			    struct device_node *node,
>  			    struct edma_soc_info *pdata)
> @@ -1470,6 +1516,9 @@ static int edma_of_parse_dt(struct device *dev,
>  
>  	pdata->default_queue = 0;
>  
> +	prop = of_find_property(node, "ti,edma-xbar-event-map", &sz);
> +	if (prop)
> +		ret = edma_xbar_event_map(dev, node, pdata, sz);
>  
>  	return ret;
>  }
> @@ -1489,6 +1538,7 @@ static int edma_probe(struct platform_device *pdev)
>  	int			status = -1;
>  	const s16		(*rsv_chans)[2];
>  	const s16		(*rsv_slots)[2];
> +	const s16		(*xbar_chans)[2];
>  	int			irq[EDMA_MAX_CC] = {0, 0};
>  	int			err_irq[EDMA_MAX_CC] = {0, 0};
>  	struct resource		*r[EDMA_MAX_CC] = {NULL, NULL};
> @@ -1617,6 +1667,15 @@ static int edma_probe(struct platform_device *pdev)
>  			}
>  		}
>  
> +		/* Clear the xbar mapped channels in unused list */
> +		xbar_chans = info[j]->xbar_chans;
> +		if (xbar_chans) {
> +			for (i = 0; xbar_chans[i][1] != -1; i++) {
> +				off = xbar_chans[i][1];
> +				clear_bits(off, 1,
> +					edma_cc[j]->edma_unused);

Please fix the alignment here.

Thanks,
Sekhar
