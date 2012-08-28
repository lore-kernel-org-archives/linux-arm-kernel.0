From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Aug 2012 14:25:23 -0400
Subject: [PATCH 3/3] ARM: Kirkwood: increase atomic coherent pool size
In-Reply-To: <1345459648-24263-4-git-send-email-m.szyprowski@samsung.com>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
 <1345459648-24263-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120828182523.GI19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 12:47:28PM +0200, Marek Szyprowski wrote:
> The default 256 KiB coherent pool may be too small for some of the Kirkwood
> devices, so increase it to make sure that devices will be able to allocate
> their buffers with GFP_ATOMIC flag.
> 
> Suggested-by: Josh Coombs <josh.coombs@gmail.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

I assume this will go through the dma tree.  Or, if they want to Ack it,
I'll take it through mine since I have boards depending on this.

thx,

Jason.

> ---
>  arch/arm/mach-kirkwood/common.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index c4b64ad..d748f50 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -517,6 +517,13 @@ void __init kirkwood_wdt_init(void)
>  void __init kirkwood_init_early(void)
>  {
>  	orion_time_set_base(TIMER_VIRT_BASE);
> +
> +	/*
> +	 * Some Kirkwood devices allocate their coherent buffers from atomic
> +	 * context. Increase size of atomic coherent pool to make sure such
> +	 * the allocations won't fail.
> +	 */
> +	init_dma_coherent_pool_size(SZ_1M);
>  }
>  
>  int kirkwood_tclk;
> -- 
> 1.7.1.569.g6f426
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
