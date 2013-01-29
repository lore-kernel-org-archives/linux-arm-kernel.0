From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 29 Jan 2013 17:04:42 +0400
Subject: [PATCH v2 5/5] ARM: mach-omap2: apply the errata at run time
 rather
In-Reply-To: <20130129101711.GA23311@bnru10>
References: <20130129101711.GA23311@bnru10>
Message-ID: <5107C8EA.5000209@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 29-01-2013 14:17, srinidhi kasagar wrote:

> Get the pl310 rtl revision number which is stashed by the l2x0
> driver and apply the required errata ERRATA_727915 accordingly.

> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> ---
>   arch/arm/mach-omap2/sleep44xx.S |   25 +++++++++++++++++++++----
>   1 files changed, 21 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
> index 88ff83a..7440f65 100644
> --- a/arch/arm/mach-omap2/sleep44xx.S
> +++ b/arch/arm/mach-omap2/sleep44xx.S
> @@ -157,11 +157,19 @@ skip_scu_gp_set:
>   	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]	@ memory.
>   	cmp	r0, #3
>   	bne	do_WFI
> -#ifdef CONFIG_PL310_ERRATA_727915
> +	/* Check for PL310_ERRATA_727915 */
> +	ldr	r0, =l2x0_revision
> +	cmp	r0, #0x4
> +	beq	dosmc
> +	cmp	r0, #0x5
> +	beq	dosmc
> +	b	nosmc

    Why not just:
	bne	nosmc

> +dosmc:
>   	mov	r0, #0x03
>   	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
>   	DO_SMC
> -#endif
> +
> +nosmc:
>   	bl	omap4_get_l2cache_base
>   	mov	r2, r0
>   	ldr	r0, =0xffff
> @@ -171,11 +179,20 @@ wait:
>   	ldr	r1, =0xffff
>   	ands	r0, r0, r1
>   	bne	wait
> -#ifdef CONFIG_PL310_ERRATA_727915
> +
> +	/* Check for PL310_ERRATA_727915 */
> +	ldr	r0, =l2x0_revision
> +	cmp	r0, #0x4
> +	beq	dosmc2
> +	cmp	r0, #0x5
> +	beq	dosmc2
> +	b	nosmc2

    Same question.

> +dosmc2:
>   	mov	r0, #0x00
>   	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
>   	DO_SMC
> -#endif
> +
> +nosmc2:
>   l2x_sync:
>   	bl	omap4_get_l2cache_base
>   	mov	r2, r0

WBR, Sergei
