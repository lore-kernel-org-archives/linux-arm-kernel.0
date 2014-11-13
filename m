From: joe@perches.com (Joe Perches)
Date: Thu, 13 Nov 2014 09:02:52 -0800
Subject: [PATCH] dmaengine: pl330: Fix linker error "undefined reference
 to `__aeabi_uldivmod'"
In-Reply-To: <1415896047.1787.4.camel@linaro.org>
References: <1415896047.1787.4.camel@linaro.org>
Message-ID: <1415898172.4223.1.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-11-13 at 16:27 +0000, Jon Medhurst (Tixy) wrote:
> 32-bit ARM kernels may have a 64-bit dma_addr_t but have no
> implementation of the compiler helper for 64-bit unsigned division,
> therefore the use of the modulo operator in pl330_prep_dma_memcpy causes
> the link error "undefined reference to `__aeabi_uldivmod'"
> 
> As the burst value is always a power of two we can fix the problem, and
> make the code more efficient, by replacing "% burst" with "& (burst-1)".
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
> 
> Vinod. I haven't added a 'Fixes:' line because I was unsure if the patch
> in linux-next is part of a stable branch or if the SHA1 might change
> before hitting mainline. If it stable then the line should be...
> 
> Fixes: 63369d0a96dc ("dmaengine: pl330: Align DMA memcpy operations to MFIFO width")
> 
> 
>  drivers/dma/pl330.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 38c9617..52c4c62 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2464,11 +2464,8 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
>  	 * parameters because our DMA programming algorithm doesn't cope with
>  	 * transfers which straddle an entry in the DMA device's MFIFO.
>  	 */
> -	while (burst > 1) {
> -		if (!((src | dst | len) % burst))
> -			break;
> +	while ((src | dst | len) & (burst - 1))
>  		burst /= 2;
> -	}

Maybe something like:

	div = ffs(src | dst | len);
	if (burst > 1 && div)
		burst >>= div;

?

dunno if dma_addr_t src or dst can ever be a 64 bit value
for AMBA or not.  If so, the ffs would need to be different.

Maybe:

	if (sizeof(dma_addr_t) == sizeof(u64))
		div = __ffs64(src | dst | len);
	else
		div = ffs(src | dst | len);
	if (burst > 1 && div)
		burst >>= div;
