From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Aug 2016 11:19:43 +0530
Subject: [PATCH v5 5/6] dmaengine: pl330: Make sure microcode is privileged
In-Reply-To: <20160727234208.2101-6-mitchelh@codeaurora.org>
References: <20160727234208.2101-1-mitchelh@codeaurora.org>
 <20160727234208.2101-6-mitchelh@codeaurora.org>
Message-ID: <20160808054943.GT9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 04:42:07PM -0700, Mitchel Humpherys wrote:
> The PL330 performs privileged instruction fetches.  This can result in
> SMMU permission faults on SMMUs that implement the ARMv8 VMSA, which

Lot of acronyms with no explanation whatsoever

> specifies that mappings that are writeable at one execution level shall
> not be executable at any higher-privileged level.  Fix this by using the
> DMA_ATTR_PRIVILEGED attribute, which will ensure that the microcode
> IOMMU mapping is only accessible to the privileged level.

And I get satndalone patch with no context for the series!

> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
> 
> Notes:
>     v3..v4
>     
>       - Reworked against the new dma attrs format.
> 
>  drivers/dma/pl330.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 4fc3ffbd5ca0..8cd624fc3760 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1854,14 +1854,16 @@ static int dmac_alloc_resources(struct pl330_dmac *pl330)
>  {
>  	int chans = pl330->pcfg.num_chan;
>  	int ret;
> +	unsigned long dma_attrs = DMA_ATTR_PRIVILEGED;
>  
>  	/*
>  	 * Alloc MicroCode buffer for 'chans' Channel threads.
>  	 * A channel's buffer offset is (Channel_Id * MCODE_BUFF_PERCHAN)
>  	 */
> -	pl330->mcode_cpu = dma_alloc_coherent(pl330->ddma.dev,
> +	pl330->mcode_cpu = dma_alloc_attrs(pl330->ddma.dev,
>  				chans * pl330->mcbufsz,
> -				&pl330->mcode_bus, GFP_KERNEL);
> +				&pl330->mcode_bus, GFP_KERNEL,
> +				dma_attrs);
>  	if (!pl330->mcode_cpu) {
>  		dev_err(pl330->ddma.dev, "%s:%d Can't allocate memory!\n",
>  			__func__, __LINE__);
> -- 
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
~Vinod
