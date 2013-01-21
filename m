From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jan 2013 10:22:37 -0800
Subject: [PATCH 3/4] ARM: mach-omap2: apply the errata at run time rather
In-Reply-To: <20130121131613.GA29876@bnru10>
References: <20130121131613.GA29876@bnru10>
Message-ID: <20130121182236.GE22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* srinidhi kasagar <srinidhi.kasagar@stericsson.com> [130121 05:19]:

Forgot to complete the subject and add the description?

Regards,

Tony

> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> ---
>  arch/arm/mach-omap2/sleep44xx.S |   25 +++++++++++++++++++++----
>  1 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
> index 88ff83a..071ca1f 100644
> --- a/arch/arm/mach-omap2/sleep44xx.S
> +++ b/arch/arm/mach-omap2/sleep44xx.S
> @@ -157,11 +157,19 @@ skip_scu_gp_set:
>  	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]	@ memory.
>  	cmp	r0, #3
>  	bne	do_WFI
> -#ifdef CONFIG_PL310_ERRATA_727915
> +	/* Check for PL310_ERRATA_727915 */
> +	bl	l2x0_get_rtl_release
> +	cmp	r0, #0x4
> +	beq	dosmc
> +	cmp	r0, #0x5
> +	beq	dosmc
> +	b	nosmc
> +dosmc:
>  	mov	r0, #0x03
>  	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
>  	DO_SMC
> -#endif
> +
> +nosmc:
>  	bl	omap4_get_l2cache_base
>  	mov	r2, r0
>  	ldr	r0, =0xffff
> @@ -171,11 +179,20 @@ wait:
>  	ldr	r1, =0xffff
>  	ands	r0, r0, r1
>  	bne	wait
> -#ifdef CONFIG_PL310_ERRATA_727915
> +
> +	/* Check for PL310_ERRATA_727915 */
> +	bl	l2x0_get_rtl_release
> +	cmp	r0, #0x4
> +	beq	dosmc2
> +	cmp	r0, #0x5
> +	beq	dosmc2
> +	b	nosmc2
> +dosmc2:
>  	mov	r0, #0x00
>  	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
>  	DO_SMC
> -#endif
> +
> +nosmc2:
>  l2x_sync:
>  	bl	omap4_get_l2cache_base
>  	mov	r2, r0
> -- 
> 1.7.2.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
