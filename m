From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 22 Nov 2010 14:06:35 -0500 (EST)
Subject: [PATCH v2 6/9] ARM: Thumb-2: Fix CONFIG_THUMB2_KERNEL breakage in
	compressed/head.S
In-Reply-To: <1290449065-28843-7-git-send-email-dave.martin@linaro.org>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-7-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1011221406040.9313@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Nov 2010, Dave Martin wrote:

> Some instruction operand combinations are used here
> which are nor permitted in Thumb-2.
> 
> In particular, most uses of pc as an operand are
> disallowed in Thumb-2, and deprecated in ARM from
> ARMv7 onwards.
> 
> The modified code introduced by this patch should be
> compatible with all architecture versions >= v3, with
> or without CONFIG_THUMB2_KERNEL.
> 
> Applies cleanly on v2.6.37-rc1.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/boot/compressed/head.S |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 6825c34..1f65080 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -174,7 +174,8 @@ not_angel:
>  		ldr	sp, [r0, #28]
>  #ifdef CONFIG_AUTO_ZRELADDR
>  		@ determine final kernel image address
> -		and	r4, pc, #0xf8000000
> +		mov	r4, pc
> +		and	r4, r4, #0xf8000000
>  		add	r4, r4, #TEXT_OFFSET
>  #else
>  		ldr	r4, =zreladdr
> @@ -445,7 +446,8 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
>   */
>  		mov	r1, #0x1e
>  		orr	r1, r1, #3 << 10
> -		mov	r2, pc, lsr #20
> +		mov	r2, pc
> +		mov	r2, r2, lsr #20
>  		orr	r1, r1, r2, lsl #20
>  		add	r0, r3, r2, lsl #2
>  		str	r1, [r0], #4
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
