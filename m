From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 1 Aug 2017 18:20:43 +0800
Subject: [PATCH v2 5/5] ACPI/IORT: Add IORT named component memory address
 limits
In-Reply-To: <20170731152323.32488-6-lorenzo.pieralisi@arm.com>
References: <20170731152323.32488-1-lorenzo.pieralisi@arm.com>
 <20170731152323.32488-6-lorenzo.pieralisi@arm.com>
Message-ID: <35b7d17a-7ab2-9b36-9482-33a7449691d2@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 2017/7/31 23:23, Lorenzo Pieralisi wrote:
> IORT named components provide firmware configuration describing
> how many address bits a given device is capable of generating
> to address memory.
> 
> Add code to the kernel to retrieve memory address limits
> configuration for IORT named components and configure DMA masks
> accordingly.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Nate Watterson <nwatters@codeaurora.org>
> ---
>   drivers/acpi/arm64/iort.c | 40 ++++++++++++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 67b85ae..b85d19f 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -680,6 +680,24 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
>   	return ret ? NULL : ops;
>   }
>   
> +static int nc_dma_get_range(struct device *dev, u64 *size)
> +{
> +	struct acpi_iort_node *node;
> +	struct acpi_iort_named_component *ncomp;
> +
> +	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> +			      iort_match_node_callback, dev);
> +	if (!node)
> +		return -ENODEV;
> +
> +	ncomp = (struct acpi_iort_named_component *)node->node_data;
> +
> +	*size = ncomp->memory_address_limit >= 64 ? ~0ULL :
> +			1ULL<<ncomp->memory_address_limit;

Just a question here, if the IORT table didn't configure this
value properly, will the device working properly? I'm asking this
because in the table of IORT of D05, this value is set to 0 so far
(SAS and network), but I can boot D05 OK with your patch set, not
sure if any further issues.

Thanks
Hanjun
