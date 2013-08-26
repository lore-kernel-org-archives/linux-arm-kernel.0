From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 26 Aug 2013 16:16:42 +0530
Subject: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
In-Reply-To: <1377287613-16491-1-git-send-email-joelf@ti.com>
References: <1377287613-16491-1-git-send-email-joelf@ti.com>
Message-ID: <521B3212.3050405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 August 2013 01:23 AM, Joel Fernandes wrote:
> HWMOD removal for MMC and Crypto is breaking edma_start as the events are
> being manually triggered due to unused channel list not being clear. Atleast
> breakage has been seen on these peripherals, but it is expected Audio (McASP)
> maybe breaking too.
> 
> This patch fixes the issue, by reading the "dmas" property from the DT node if
> it exists and clearing the bits in the unused channel list so that these channels
> are not manually triggered.
> 
> v2 changes:
> Reduced indendation by returning from if block.

Is this a v2 or v3 since you already sent a v2 about a month back?

> 
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> Reported-by: Balaji T K <balajitk@ti.com>
> Cc: Pantel Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
> Note:
> Patch should go in for -rc cycle as it fixes existing crypto drivers.

We agreed the patch is not needed in -rc cycle since there are no
current EDMA users in DT-boot?

> 
>  arch/arm/common/edma.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 39ad030..3867e7e 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -560,14 +560,30 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
>  static int prepare_unused_channel_list(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	int i, ctlr;
> +	int i = 0, ctlr;
> +	u32 dma_chan;
> +	const __be32 *dma_chan_p;
> +	struct property *prop;
> +
> +	if (dev->of_node) {
> +		of_property_for_each_u32(dev->of_node, "dmas", prop,
> +					 dma_chan_p, dma_chan) {
> +			if (i++ & 1) {
> +				ctlr = EDMA_CTLR(dma_chan);
> +				clear_bit(EDMA_CHAN_SLOT(dma_chan),
> +					  edma_cc[ctlr]->edma_unused);
> +			}

I thought we agreed to do this differently using
of_property_count_strings() and of_parse_phandle_with_args(). I seemed
to have missed any discussion on why this cannot be done (if such a
discussion took place on the list).

Thanks,
Sekhar
