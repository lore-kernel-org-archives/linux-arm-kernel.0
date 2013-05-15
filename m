From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 15 May 2013 10:38:44 +0100
Subject: [PATCH 3/3 v3] net/macb: Try to optimize struct macb layout
In-Reply-To: <d0bc206ace3baaf681e111ba07c4d0b576839bb4.1368608928.git.nicolas.ferre@atmel.com>
References: <cover.1368608928.git.nicolas.ferre@atmel.com>
 <d0bc206ace3baaf681e111ba07c4d0b576839bb4.1368608928.git.nicolas.ferre@atmel.com>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B723B@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Move TX-related fields to the top of the struct so that they end up on
> the same cache line. Move the NAPI struct below that since it is used
> from the interrupt handler. This field is also marked as
> ___cacheline_aligned_in_smp.
> RX-related fields go below those.
> Function pointers and capability mask are immediately after that as
> they are also used in the hot path.
> 
> Move the spinlock before regs since they are usually used together.

Haven't you introduced some holes in the structure?
I suspect that spinloack_t might only be 32bits on
some 64bit systems.
There is certainly one where 'caps' used to be.

...> 
>  struct macb {
> +	spinlock_t		lock;
>  	void __iomem		*regs;
...
> +	struct macb_or_gem_ops	macbgem_ops;
> +
> +	u32			caps;
> 
> -	spinlock_t		lock;
>  	struct platform_device	*pdev;

	David
