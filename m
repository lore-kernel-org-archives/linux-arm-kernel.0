From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 16 Sep 2013 17:18:27 +0530
Subject: [PATCH v3] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
In-Reply-To: <5233B471.40603@ti.com>
References: <1378839171-14455-1-git-send-email-joelf@ti.com>
 <5231903F.7080301@ti.com> <5233B471.40603@ti.com>
Message-ID: <5236F00B.5040605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

On Saturday 14 September 2013 06:27 AM, Joel Fernandes wrote:
> From: Joel Fernandes <joelf@ti.com>
> Subject: [PATCH v4] ARM: EDMA: Fix clearing of unused list for DT DMA resources
> 
> HWMOD removal for MMC is breaking edma_start as the events are being manually
> triggered due to unused channel list not being clear.
> 
> This patch fixes the issue, by reading the "dmas" property from the DT node if
> it exists and clearing the bits in the unused channel list. For this purpose
> we use the of_* helpers to parse the arguments in the dmas phandle list.
> 
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> Reported-by: Balaji T K <balajitk@ti.com>
> Cc: Pantel Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
> Changes since v1, in v2 and v3:
> - Reduced indentation of non-of case by returning from of-case
> - Using of_* helpers for parsing
> 
> Note:
> This patch should go into the merge window as it is a critical bug fix.

I still cannot find any users of edma in the device tree sources either
in linux-next or linus/master. Why cannot this wait until v3.13?

> 
>  arch/arm/common/edma.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 39ad030..43c7b22 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -560,14 +560,33 @@ static int reserve_contiguous_slots(int ctlr, unsigned int
> id,
>  static int prepare_unused_channel_list(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	int i, ctlr;
> +	int i, count, ctlr;
> +	struct of_phandle_args  dma_spec;
> 
> +	if (dev->of_node) {
> +		count = of_property_count_strings(dev->of_node, "dma-names");
> +		if (count < 0)
> +			return 0;
> +		for (i = 0; i < count; i++) {
> +			if (of_parse_phandle_with_args(dev->of_node, "dmas",
> +						       "#dma-cells", i,
> +						       &dma_spec))
> +				continue;

This will break for the case where devices on platform bus use non-EDMA
dma controllers like SDMA or CPPI (DRA7x has both EDMA and SDMA on the
same chip). You need to do an additional check to make sure the dma
controller is indeed EDMA. Something like.

	if(!of_device_is_compatible(dma_spec.np, "ti,edma3"))
		continue;

Don forget to call of_node_put() on dma_spec.np (something that needs to
be done even with your current code).

> +
> +			ctlr = EDMA_CTLR(dma_spec.args[0]);
> +			clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]),
> +				  edma_cc[ctlr]->edma_unused);

We don't support the second controller when using DT and the controller
number is not really encoded in the argument to edma phandle. So just
simplify this to:

	clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]), 	
		  edma_cc[0]->edma_unused);

> +		}
> +		return 0;
> +	}
> +
> +	/* For non-OF case */
>  	for (i = 0; i < pdev->num_resources; i++) {
>  		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
>  				(int)pdev->resource[i].start >= 0) {
>  			ctlr = EDMA_CTLR(pdev->resource[i].start);
>  			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
> -					edma_cc[ctlr]->edma_unused);
> +				  edma_cc[ctlr]->edma_unused);

This is a useful change and I am okay with it happening in this
otherwise unrelated patch, but please mention this in changelog.

Thanks,
Sekhar
