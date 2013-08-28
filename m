From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Aug 2013 17:54:27 +0100
Subject: [PATCH 03/19] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
In-Reply-To: <1377639509-22778-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-4-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130828165427.GI3842@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:38:13PM +0100, Ben Dooks wrote:
> The fixup_pv_table assumes that the instructions are in the same
> endian configuration as the data, but when the CPU is running in
> BE8 the instructions stay in little-endian format.
> 
> Make sure if CONFIG_CPU_ENDIAN_BE8 is set that we do all the
> alterations to the instructions taking in to account the LDR/STR
> will be swapping the data endian-ness.
> 
> Since the code is only modifying a byte, we avoid dual-swapping
> the data, and just change the bits we clear and ORR in (in the
> case where the code is not thumb2).
> 
> For thumb2, we add the necessary rev16 instructions to ensure that
> the instructions are processed in the correct format, as it was
> easier than re-writing the code to contain a mask and shift.

Shame about the ifdef, but ARM_LE_OR_BE32(...) or ARM_NOT_BE8(...) seems
too contrived to be practical...

We could probably do bitfield clobber more neatly with BFI, but
unfortunately v6 plain doesn't have that.  Only v6T2 or v7 and later
have it.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/kernel/head.S |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 2c7cc1e..9e5906c 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -582,8 +582,10 @@ __fixup_a_pv_table:
>  	b	2f
>  1:	add     r7, r3
>  	ldrh	ip, [r7, #2]
> +ARM_BE8(rev16	ip, ip)
>  	and	ip, 0x8f00
>  	orr	ip, r6	@ mask in offset bits 31-24
> +ARM_BE8(rev16	ip, ip)
>  	strh	ip, [r7, #2]
>  2:	cmp	r4, r5
>  	ldrcc	r7, [r4], #4	@ use branch for delay slot
> @@ -592,8 +594,14 @@ __fixup_a_pv_table:
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
