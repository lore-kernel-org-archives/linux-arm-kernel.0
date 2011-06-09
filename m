From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 9 Jun 2011 10:47:10 +0100
Subject: [PATCH] ARM: zImage: fix Thumb2 breakage
In-Reply-To: <alpine.LFD.2.00.1106082350500.2142@xanadu.home>
References: <alpine.LFD.2.00.1106082350500.2142@xanadu.home>
Message-ID: <20110609094710.GB2208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 11:53:02PM -0400, Nicolas Pitre wrote:
> 
> Commit af3e4fd37a "ARM: 6859/1: Add writethrough dcache support for
> ARM926EJS processor" broke Thumb2 compilation by omitting to maintain
> the wide encoding for the added branch instructions which made the
> ARM926EJ-S record smaller than expected, breaking the record walk code.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> CC: Mark A. Greer <mgreer@mvista.com>

This patch looks right, and works for me.

Acked-by: Dave Martin <dave.martin@linaro.org>

> ---
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index f9da419..942fad9 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -691,9 +691,9 @@ proc_types:
>  
>  		.word	0x41069260		@ ARM926EJ-S (v5TEJ)
>  		.word	0xff0ffff0
> -		b	__arm926ejs_mmu_cache_on
> -		b	__armv4_mmu_cache_off
> -		b	__armv5tej_mmu_cache_flush
> +		W(b)	__arm926ejs_mmu_cache_on
> +		W(b)	__armv4_mmu_cache_off
> +		W(b)	__armv5tej_mmu_cache_flush
>  
>  		.word	0x00007000		@ ARM7 IDs
>  		.word	0x0000f000
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
