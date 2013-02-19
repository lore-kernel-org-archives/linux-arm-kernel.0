From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 19 Feb 2013 12:04:11 +0000
Subject: [PATCH 2/9] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
In-Reply-To: <1360752927-29331-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360752927-29331-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130219120411.GC1978@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 10:55:20AM +0000, Ben Dooks wrote:
> The fixup_pv_table assumes that the instructions are in the same
> endian configuration as the data, but when the CPU is running in
> BE8 the instructions stay in little-endian format.
> 
> Make sure if CONFIG_CPU_ENDIAN_BE8 is set that we do all the
> alterations to the instructions taking in to account the LDR/STR
> will be swapping the data endian-ness.
> 
> Since the code is only modifying a byte, we avoid dual-swapping
> the data, and just change the bits we clear and ORR in.
> 
> Note, not tested against an actual bug, it looked wrong.

This looks reasonable, but the Thumb case code would need a similar fix.

Should we have LE()/BE8() macros etc. in assembler.h, similar to
ARM()/THUMB()?  This would help save on #ifdefs.

Cheers
---Dave

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/kernel/head.S |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 486a15a..cc15384 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -576,8 +576,14 @@ __fixup_a_pv_table:
>  #else
>  	b	2f
>  1:	ldr	ip, [r7, r3]
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +	@ in BE8, we load data in BE, but instructions still in LE
> +	bic	ip, ip, #0xff000000
> +	orr	ip, ip, r6, lsl#24
> +#else
>  	bic	ip, ip, #0x000000ff
>  	orr	ip, ip, r6	@ mask in offset bits 31-24
> +#endif
>  	str	ip, [r7, r3]
>  2:	cmp	r4, r5
>  	ldrcc	r7, [r4], #4	@ use branch for delay slot
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
