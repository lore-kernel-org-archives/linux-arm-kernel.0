From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 23 Sep 2013 15:42:22 +0530
Subject: [alsa-devel] [PATCH 23/51] DMA-API: dma: pl08x: add
 dma_set_mask_and_coherent() call
In-Reply-To: <E1VMm4v-0007hz-RC@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm4v-0007hz-RC@rmk-PC.arm.linux.org.uk>
Message-ID: <20130923101222.GH17188@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 10:48:01PM +0100, Russell King wrote:
> The DMA API requires drivers to call the appropriate dma_set_mask()
> functions before doing any DMA mapping.  Add this required call to
> the AMBA PL08x driver.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Vinod Koul <vinod.koul@intel.com>

~Vinod
> ---
>  drivers/dma/amba-pl08x.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index fce46c5..e51a983 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -2055,6 +2055,11 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (ret)
>  		return ret;
>  
> +	/* Ensure that we can do DMA */
> +	ret = dma_set_mask_and_coherent(&adev->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		goto out_no_pl08x;
> +
>  	/* Create the driver state holder */
>  	pl08x = kzalloc(sizeof(*pl08x), GFP_KERNEL);
>  	if (!pl08x) {
> -- 
> 1.7.4.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
