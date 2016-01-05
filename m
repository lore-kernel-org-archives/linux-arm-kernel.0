From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 05 Jan 2016 20:02:41 +0100
Subject: [RESEND PATCH 2/3] drivers: dma-coherent: use MEMREMAP_WC for
 DMA_MEMORY_MAP
In-Reply-To: <a85c534af867534e6693ce50a746fda096426586.1452010803.git.brian.starkey@arm.com>
References: <cover.1452010802.git.brian.starkey@arm.com>
 <a85c534af867534e6693ce50a746fda096426586.1452010803.git.brian.starkey@arm.com>
Message-ID: <xa1tfuybu9wu.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05 2016, Brian Starkey wrote:
> When the DMA_MEMORY_MAP flag is used, memory which can be accessed
> directly should be returned, so use memremap(..., MEMREMAP_WC) to
> provide a writecombine mapping.
>
> Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  drivers/base/dma-coherent.c |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
> index 55b8398..f98359a 100644
> --- a/drivers/base/dma-coherent.c
> +++ b/drivers/base/dma-coherent.c
> @@ -2,6 +2,7 @@
>   * Coherent per-device memory handling.
>   * Borrowed from i386
>   */
> +#include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -31,7 +32,10 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_add
>  	if (!size)
>  		goto out;
>  
> -	mem_base = ioremap(phys_addr, size);
> +	if (flags & DMA_MEMORY_MAP)
> +		mem_base = memremap(phys_addr, size, MEMREMAP_WC);
> +	else
> +		mem_base = ioremap(phys_addr, size);
>  	if (!mem_base)
>  		goto out;
>  
> @@ -58,8 +62,12 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_add
>  
>  out:
>  	kfree(dma_mem);
> -	if (mem_base)
> -		iounmap(mem_base);
> +	if (mem_base) {
> +		if (flags & DMA_MEMORY_MAP)
> +			memunmap(mem_base);
> +		else
> +			iounmap(mem_base);
> +	}
>  	return 0;
>  }
>  
> @@ -67,7 +75,11 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
>  {
>  	if (!mem)
>  		return;
> -	iounmap(mem->virt_base);
> +
> +	if (mem->flags & DMA_MEMORY_MAP)
> +		memunmap(mem->virt_base);
> +	else
> +		iounmap(mem->virt_base);
>  	kfree(mem->bitmap);
>  	kfree(mem);
>  }
> -- 
> 1.7.9.5
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  ??? ?mina86? ??????  (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
