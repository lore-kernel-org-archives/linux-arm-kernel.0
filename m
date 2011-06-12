From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 12 Jun 2011 01:09:49 -0400 (EDT)
Subject: [PATCH] ARM: zImage: Add build-time check for correctly-sized
	proc_type entries
In-Reply-To: <1307624499-9927-1-git-send-email-dave.martin@linaro.org>
References: <1307624499-9927-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1106120109070.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jun 2011, Dave Martin wrote:

> It is easy to mis-maintain the proc_types table such that the
> entries become wrongly-sized and misaligned when the kernel is
> built in Thumb-2.
> 
> This patch adds an assembly-time check which will turn most
> common size/alignment mistakes in this table into build failures,
> to avoid having to debug the boot-time kernel hang which would
> happen if the resulting kernel were actually booted.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
> KernelVersion: v3.0-rc2
> 
>  arch/arm/boot/compressed/head.S |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index f9da419..0aae741 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -597,6 +597,8 @@ __common_mmu_cache_on:
>  		sub	pc, lr, r0, lsr #32	@ properly flush pipeline
>  #endif
>  
> +#define PROC_ENTRY_SIZE (4*5)
> +
>  /*
>   * Here follow the relocatable cache support functions for the
>   * various processors.  This is a generic hook for locating an
> @@ -624,7 +626,7 @@ call_cache_fn:	adr	r12, proc_types
>   ARM(		addeq	pc, r12, r3		) @ call cache function
>   THUMB(		addeq	r12, r3			)
>   THUMB(		moveq	pc, r12			) @ call cache function
> -		add	r12, r12, #4*5
> +		add	r12, r12, #PROC_ENTRY_SIZE
>  		b	1b
>  
>  /*
> @@ -794,6 +796,16 @@ proc_types:
>  
>  		.size	proc_types, . - proc_types
>  
> +		/*
> +		 * If you get a "non-constant expression in ".if" statement"
> +		 * error from the assembler on this line, check that you have
> +		 * not accidentally written a "b" instruction where you should
> +		 * have written W(b).
> +		 */
> +		.if (. - proc_types) % PROC_ENTRY_SIZE != 0
> +		.error "The size of one or more proc_types entries is wrong."
> +		.endif
> +
>  /*
>   * Turn off the Cache and MMU.  ARMv3 does not support
>   * reading the control register, but ARMv4 does.
> -- 
> 1.7.4.1
> 
