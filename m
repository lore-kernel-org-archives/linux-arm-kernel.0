From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 6 Nov 2018 21:16:56 +0200
Subject: [PATCH] of/device: Really only set bus DMA mask when appropriate
In-Reply-To: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
Message-ID: <20181106191655.GB14958@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 06, 2018 at 11:54:15AM +0000, Robin Murphy wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
> 
> Make sure we only touch it if the DT actually said so.
> 
> Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

This fixes the MMC driver DMA mask issue on OCTEON.

Thanks,

A.

> ---
> 
> Sorry about that... I guess I only have test setups that either have
> dma-ranges or where a 32-bit bus mask goes unnoticed :(
> 
> The Octeon and SMMU issues sound like they're purely down to this, and
> it's probably related to at least one of John's Hikey woes.
> 
> Robin.
> 
>  drivers/of/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 0f27fad9fe94..757ae867674f 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -149,7 +149,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>  	 * set by the driver.
>  	 */
>  	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
> -	dev->bus_dma_mask = mask;
> +	if (!ret)
> +		dev->bus_dma_mask = mask;
>  	dev->coherent_dma_mask &= mask;
>  	*dev->dma_mask &= mask;
>  
> -- 
> 2.19.1.dirty
> 
