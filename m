From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 5 Nov 2013 16:23:47 +0530
Subject: [PATCH 3/3] ARM: fix mov to mvn conversion in case of 64 bit
 phys_addr_t and BE
In-Reply-To: <1383617765-28052-4-git-send-email-victor.kamensky@linaro.org>
References: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
 <1383617765-28052-4-git-send-email-victor.kamensky@linaro.org>
Message-ID: <5278CE3B.7090008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 November 2013 07:46 AM, Victor Kamensky wrote:
> Fix patching code to convert mov instruction into mvn instruction
> in case of CONFIG_ARCH_PHYS_ADDR_T_64BIT and CONFIG_ARM_PATCH_PHYS_VIRT.
>
> In BE case store into r0 proper bits so byte swapped instruction
> could be modified correctly.
>
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/kernel/head.S | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index cd788d5..11d59b3 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -645,7 +645,11 @@ ARM_BE8(rev16	ip, ip)
>  	bcc	1b
>  	bx	lr
>  #else
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +	moveq	r0, #0x00004000	@ set bit 22, mov to mvn instruction
> +#else
>  	moveq	r0, #0x400000	@ set bit 22, mov to mvn instruction
> +#endif
>  	b	2f
>  1:	ldr	ip, [r7, r3]
>  #ifdef CONFIG_CPU_ENDIAN_BE8
> @@ -654,7 +658,7 @@ ARM_BE8(rev16	ip, ip)
>  	tst	ip, #0x000f0000	@ check the rotation field
>  	orrne	ip, ip, r6, lsl #24 @ mask in offset bits 31-24
>  	biceq	ip, ip, #0x00004000 @ clear bit 22
> -	orreq	ip, ip, r0, lsl #24 @ mask in offset bits 7-0
> +	orreq	ip, ip, r0      @ mask in offset bits 7-0
>  #else
>  	bic	ip, ip, #0x000000ff
>  	tst	ip, #0xf00	@ check the rotation field
 Ok, I think for the thumb case this is already taken care because
 of the swap.

Reviewed-by: R Sricharan <r.sricharan@ti.com>

Regards,
 Sricharan
