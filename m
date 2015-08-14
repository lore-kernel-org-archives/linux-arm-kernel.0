From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Aug 2015 18:43:41 +0100
Subject: [PATCH v2 1/2] ARM: dma-mapping: Don't use outer_flush_range
 when the L2C is coherent
In-Reply-To: <1439568776-17864-2-git-send-email-gregory.clement@free-electrons.com>
References: <1439568776-17864-1-git-send-email-gregory.clement@free-electrons.com>
 <1439568776-17864-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150814174340.GA21966@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 06:12:55PM +0200, Gregory CLEMENT wrote:
> When a L2 cache controller is used in a system that provides hardware
> coherency, the entire outer cache operations are useless, and can be
> skipped.  Moreover, on some systems, it is harmful as it causes
> deadlocks between the Marvell coherency mechanism, the Marvell PCIe
> controller and the Cortex-A9.
> 
> In the current kernel implementation, the outer cache flush range
> operation is triggered by the dma_alloc function.
> This operation can be take place during runtime and in some
> circumstances may lead to the PCIe/PL310 deadlock on Armada 375/38x
> SoCs.
> 
> This patch extends the __dma_clear_buffer() function to receive a
> boolean argument related to the coherency of the system. The same
> things is done for the calling functions.
> 
> Reported-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.16+

Most likely the patch won't apply on kernels before 4.3. But that's
fine, you can send separate patches to stable that work on those kernels
and reference the mainline commit.

> @@ -358,9 +364,14 @@ static int __init atomic_pool_init(void)
>  	if (!atomic_pool)
>  		goto out;
>  
> +	/*
> +	 * Here we don't know if the system is coherent, but it is
> +	 * harmless to use the non-coherent case in the
> +	 * __alloc_from_contiguous() call.
> +	 */
>  	if (dev_get_cma_area(NULL))
>  		ptr = __alloc_from_contiguous(NULL, atomic_pool_size, prot,
> -					      &page, atomic_pool_init, true);
> +					&page, atomic_pool_init, true, false);

This comment is not entirely correct. The atomic pool is only used for
non-coherent allocations (the prot is pgprot_dmacoherent which means
Normal Non-cacheable memory). So we must pass false for is_coherent.

> @@ -474,7 +485,8 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
>  {
>  	struct page *page;
>  	void *ptr = NULL;
> -	page = __dma_alloc_buffer(dev, size, gfp);
> +	/* This function is only called when the arch is non-coherent */
> +	page = __dma_alloc_buffer(dev, size, gfp, false);

Nitpick: "__alloc_remap_buffer() is only called when the arch is
non-coherent". That's to avoid misreading as __dma_alloc_buffer() being
called only for non-coherent cases.

BTW, for other comments as well, instead of "arch" being coherent or not
I would say "device". We check this property on a per-device basis.

> @@ -601,7 +614,8 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
>  				   struct page **ret_page)
>  {
>  	struct page *page;
> -	page = __dma_alloc_buffer(dev, size, gfp);
> +	/* This function is only called when the arch is coherent */
> +	page = __dma_alloc_buffer(dev, size, gfp, true);

Same nitpick as above, "__alloc_simple_buffer() is only called...".

Few minor things above on comments, otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
