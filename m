From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Sep 2012 12:37:16 -0400
Subject: [PATCH] ARM: Orion5x: Fix too small coherent pool.
In-Reply-To: <1348466073-22726-1-git-send-email-andrew@lunn.ch>
References: <1348466073-22726-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120924163716.GR5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 07:54:33AM +0200, Andrew Lunn wrote:
> Some Orion5x devices allocate their coherent buffers from atomic
> context. Increase size of atomic coherent pool to make sure such the
> allocations won't fail during boot.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Jason Cooper <jason@lakedaemon.net>

btw - we should take this to it's logical conclusion and have Sebastian
check Dove.  Sebastian?

thx,

Jason.

> ---
>  arch/arm/mach-orion5x/common.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> index 410291c..a6cd14a 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -204,6 +204,13 @@ void __init orion5x_wdt_init(void)
>  void __init orion5x_init_early(void)
>  {
>  	orion_time_set_base(TIMER_VIRT_BASE);
> +
> +	/*
> +	 * Some Orion5x devices allocate their coherent buffers from atomic
> +	 * context. Increase size of atomic coherent pool to make sure such
> +	 * the allocations won't fail.
> +	 */
> +	init_dma_coherent_pool_size(SZ_1M);
>  }
>  
>  int orion5x_tclk;
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
