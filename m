From: joelf@ti.com (Joel Fernandes)
Date: Sat, 27 Jul 2013 18:32:46 -0500
Subject: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
In-Reply-To: <1374515989-7391-1-git-send-email-joelf@ti.com>
References: <1374515989-7391-1-git-send-email-joelf@ti.com>
Message-ID: <51F4589E.5070108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony or Sekhar,

If this patch looks ok, could you pick it up for -rc cycle?

It fixes DMA breakages after the merge window for devices for which DMA
resources are being populated in device tree instead pdev.

Thanks,

-Joel


On 07/22/2013 12:59 PM, Joel Fernandes wrote:
> HWMOD removal for MMC is breaking edma_start as the events are being manually
> triggered due to unused channel list not being clear, Thanks to Balaji TK for
> finding this issue.
> 
> This patch fixes the issue, by reading the "dmas" property from the DT node if
> it exists and clearing the bits in the unused channel list.
> 
> Cc: Balaji T K <balajitk@ti.com>
> Cc: Pantel Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
> v2 changes: Fixed compiler warning
> 
>  arch/arm/common/edma.c |   31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index a432e6c..765d578 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -561,14 +561,29 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
>  static int prepare_unused_channel_list(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	int i, ctlr;
> -
> -	for (i = 0; i < pdev->num_resources; i++) {
> -		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
> -				(int)pdev->resource[i].start >= 0) {
> -			ctlr = EDMA_CTLR(pdev->resource[i].start);
> -			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
> -					edma_cc[ctlr]->edma_unused);
> +	int i = 0, ctlr;
> +	u32 dma_chan;
> +	const __be32 *dma_chan_p;
> +	struct property *prop;
> +
> +	if (dev->of_node) {
> +		of_property_for_each_u32(dev->of_node, "dmas", prop, \
> +					 dma_chan_p, dma_chan) {
> +			if (i++ & 1) {
> +				ctlr = EDMA_CTLR(dma_chan);
> +				clear_bit(EDMA_CHAN_SLOT(dma_chan),
> +						edma_cc[ctlr]->edma_unused);
> +			}
> +		}
> +	} else {
> +		for (; i < pdev->num_resources; i++) {
> +			if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
> +			    (int)pdev->resource[i].start >= 0) {
> +				ctlr = EDMA_CTLR(pdev->resource[i].start);
> +				clear_bit(EDMA_CHAN_SLOT(
> +					  pdev->resource[i].start),
> +					  edma_cc[ctlr]->edma_unused);
> +			}
>  		}
>  	}
>  
> 
