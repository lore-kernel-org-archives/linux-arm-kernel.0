From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 20 Jul 2018 10:36:22 +0800
Subject: [PATCH] ACPI/IORT: Support address size limit for root complexes
In-Reply-To: <b52cdefb7a3f631340b98dcd38a274ae277bd561.1531239023.git.robin.murphy@arm.com>
References: <b52cdefb7a3f631340b98dcd38a274ae277bd561.1531239023.git.robin.murphy@arm.com>
Message-ID: <43f65aea-ee08-00d5-7cf2-0f14a7fc52d4@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/7/11 0:13, Robin Murphy wrote:
> IORT revision D allows PCI root complex nodes to specify a memory
> address size limit equivalently to named components, to help describe
> straightforward integrations which don't really warrant a full-blown
> _DMA method. Now that our headers are up-to-date, plumb it in.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/iort.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 7a3a541046ed..4a66896e2aa3 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -947,6 +947,24 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
>  	return 0;
>  }
>  
> +static int rc_dma_get_range(struct device *dev, u64 *size)
> +{
> +	struct acpi_iort_node *node;
> +	struct acpi_iort_root_complex *rc;
> +
> +	node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +			      iort_match_node_callback, dev);
> +	if (!node || node->revision < 1)
> +		return -ENODEV;
> +
> +	rc = (struct acpi_iort_root_complex *)node->node_data;
> +
> +	*size = rc->memory_address_limit >= 64 ? U64_MAX :
> +			1ULL<<rc->memory_address_limit;
> +
> +	return 0;
> +}
> +
>  /**
>   * iort_dma_setup() - Set-up device DMA parameters.
>   *
> @@ -975,10 +993,13 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  
>  	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>  
> -	if (dev_is_pci(dev))
> +	if (dev_is_pci(dev)) {
>  		ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> -	else
> +		if (ret == -ENODEV)
> +			ret = rc_dma_get_range(dev, &size);
> +	} else {
>  		ret = nc_dma_get_range(dev, &size);
> +	}
>  
>  	if (!ret) {
>  		msb = fls64(dmaaddr + size - 1);
> 

Looks good to me,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
