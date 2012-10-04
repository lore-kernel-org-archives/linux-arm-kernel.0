From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Oct 2012 17:18:41 +0530
Subject: [PATCH v3 1/6] ARM: davinci: sram: ioremap the davinci_soc_info
 specified sram regions
In-Reply-To: <1349276133-26408-2-git-send-email-mporter@ti.com>
References: <1349276133-26408-1-git-send-email-mporter@ti.com>
 <1349276133-26408-2-git-send-email-mporter@ti.com>
Message-ID: <506D7799.2090307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/3/2012 8:25 PM, Matt Porter wrote:
> From: Ben Gardiner <bengardiner@nanometrics.ca>
> 
> The current davinci init sets up SRAM in iotables. There has been an observed
> failure to boot a da850 with 128K specified in the iotable.
> 
> Make the davinci sram allocator -- now based on RMK's consolidated SRAM
> support -- do an ioremap of the region specified by the entries in

The part about being based on RMK's consolidated SRAM support should be
dropped.

> davinci_soc_info before registering with gen_pool_add_virt().
> 
> This commit breaks runtime of davinci boards since the regions that
> the sram init is now trying to ioremap have been iomapped by their
> iotable entries. The iotable entries will be removed in the patches
> to come.

I would prefer merging 2/6 into this for this reason.

> 
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> [rebased to mainline as the consolidated SRAM support was dropped]
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/mach-davinci/sram.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
> index db0f778..0e8ca4f 100644
> --- a/arch/arm/mach-davinci/sram.c
> +++ b/arch/arm/mach-davinci/sram.c
> @@ -10,6 +10,7 @@
>   */
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/io.h>
>  #include <linux/genalloc.h>
>  
>  #include <mach/common.h>
> @@ -32,7 +33,7 @@ void *sram_alloc(size_t len, dma_addr_t *dma)
>  		return NULL;
>  
>  	if (dma)
> -		*dma = dma_base + (vaddr - SRAM_VIRT);
> +		*dma = gen_pool_virt_to_phys(sram_pool, vaddr);
>  	return (void *)vaddr;
>  
>  }
> @@ -53,8 +54,10 @@ EXPORT_SYMBOL(sram_free);
>   */
>  static int __init sram_init(void)
>  {
> +	phys_addr_t phys = davinci_soc_info.sram_dma;
>  	unsigned len = davinci_soc_info.sram_len;
>  	int status = 0;
> +	void *addr;
>  
>  	if (len) {
>  		len = min_t(unsigned, len, SRAM_SIZE);
> @@ -62,8 +65,16 @@ static int __init sram_init(void)
>  		if (!sram_pool)
>  			status = -ENOMEM;
>  	}
> -	if (sram_pool)
> -		status = gen_pool_add(sram_pool, SRAM_VIRT, len, -1);
> +
> +	if (sram_pool) {
> +		addr = ioremap(phys, len);
> +		if (!addr)
> +			return -ENOMEM;
> +		if((status = gen_pool_add_virt(sram_pool, (unsigned)addr,
> +					       phys, len, -1)))

Nit: prefer to set status outside of if().

Looks good otherwise. Thanks for reviving this.

Thanks,
Sekhar
