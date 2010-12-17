From: nm@ti.com (Nishanth Menon)
Date: Fri, 17 Dec 2010 08:05:22 -0600
Subject: [PATCH 4/7] OMAP3: re-organize the ASM sleep code
In-Reply-To: <1292580506-4421-5-git-send-email-j-pihet@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
	<1292580506-4421-5-git-send-email-j-pihet@ti.com>
Message-ID: <4D0B6E22.7000902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jean.pihet at newoldbits.com had written, on 12/17/2010 04:08 AM, the 
following:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Organize the code in the following sections:
> - register access macros,
> - API functions,
> - internal functions.
> 
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/sleep34xx.S |  114 +++++++++++++++++++++------------------
>  1 files changed, 61 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 8e9f38f..beeb682 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -79,6 +79,7 @@ ENTRY(get_restore_pointer)
>          ldmfd   sp!, {pc}     @ restore regs and return
>  ENTRY(get_restore_pointer_sz)
>          .word   . - get_restore_pointer
> +
formatting change - recommend a separate patch collating other 
formatting changes from other patches as well.

>  	.text
>  /* Function call to get the restore pointer for 3630 resume from OFF */
>  ENTRY(get_omap3630_restore_pointer)
> @@ -89,9 +90,18 @@ ENTRY(get_omap3630_restore_pointer_sz)
>          .word   . - get_omap3630_restore_pointer
>  
>  	.text
> +/* Function call to get the restore pointer for ES3 to resume from OFF */
> +ENTRY(get_es3_restore_pointer)
> +	stmfd	sp!, {lr}	@ save registers on stack
> +	adr	r0, restore_es3
> +	ldmfd	sp!, {pc}	@ restore regs and return
> +ENTRY(get_es3_restore_pointer_sz)
> +	.word	. - get_es3_restore_pointer
> +
> +	.text
btw, if you prefer me to introduce the enable_omap3630_l2_on_restore 
toggle after get_es3_restore_pointer, I can do that.
>  /*
>   * L2 cache needs to be toggled for stable OFF mode functionality on 3630.
> - * This function sets up a fflag that will allow for this toggling to take
> + * This function sets up a flag that will allow for this toggling to take
Thanks on the fflag/flag :) - but this probably belongs to my patch ;) 
could you comment on my latest rev, I will fix it there.

>   * place on 3630. Hopefully some version in the future maynot need this
>   */
>  ENTRY(enable_omap3630_toggle_l2_on_restore)
> @@ -101,58 +111,6 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
>  	str	r1, l2dis_3630
>          ldmfd   sp!, {pc}     @ restore regs and return
>  
> -	.text
> -/* Function call to get the restore pointer for for ES3 to resume from OFF */
> -ENTRY(get_es3_restore_pointer)
> -	stmfd	sp!, {lr}	@ save registers on stack
> -	adr	r0, restore_es3
> -	ldmfd	sp!, {pc}	@ restore regs and return
> -ENTRY(get_es3_restore_pointer_sz)
> -	.word	. - get_es3_restore_pointer
> -
> -ENTRY(es3_sdrc_fix)
> -	ldr	r4, sdrc_syscfg		@ get config addr
> -	ldr	r5, [r4]		@ get value
> -	tst	r5, #0x100		@ is part access blocked
> -	it	eq
> -	biceq	r5, r5, #0x100		@ clear bit if set
> -	str	r5, [r4]		@ write back change
> -	ldr	r4, sdrc_mr_0		@ get config addr
> -	ldr	r5, [r4]		@ get value
> -	str	r5, [r4]		@ write back change
> -	ldr	r4, sdrc_emr2_0		@ get config addr
> -	ldr	r5, [r4]		@ get value
> -	str	r5, [r4]		@ write back change
> -	ldr	r4, sdrc_manual_0	@ get config addr
> -	mov	r5, #0x2		@ autorefresh command
> -	str	r5, [r4]		@ kick off refreshes
> -	ldr	r4, sdrc_mr_1		@ get config addr
> -	ldr	r5, [r4]		@ get value
> -	str	r5, [r4]		@ write back change
> -	ldr	r4, sdrc_emr2_1		@ get config addr
> -	ldr	r5, [r4]		@ get value
> -	str	r5, [r4]		@ write back change
> -	ldr	r4, sdrc_manual_1	@ get config addr
> -	mov	r5, #0x2		@ autorefresh command
> -	str	r5, [r4]		@ kick off refreshes
> -	bx	lr
> -sdrc_syscfg:
> -	.word	SDRC_SYSCONFIG_P
> -sdrc_mr_0:
> -	.word	SDRC_MR_0_P
> -sdrc_emr2_0:
> -	.word	SDRC_EMR2_0_P
> -sdrc_manual_0:
> -	.word	SDRC_MANUAL_0_P
> -sdrc_mr_1:
> -	.word	SDRC_MR_1_P
> -sdrc_emr2_1:
> -	.word	SDRC_EMR2_1_P
> -sdrc_manual_1:
> -	.word	SDRC_MANUAL_1_P
> -ENTRY(es3_sdrc_fix_sz)
> -	.word	. - es3_sdrc_fix
> -
>  /* Function to call rom code to save secure ram context */
>  ENTRY(save_secure_ram_context)
>  	stmfd	sp!, {r1-r12, lr}	@ save registers on stack
> @@ -577,6 +535,56 @@ skip_l2_inval:
>  	/* restore regs and return */
>  	ldmfd   sp!, {r0-r12, pc}
>  
> +
> +/*
> + * Internal functions
> + */
> +
> +	.text
> +ENTRY(es3_sdrc_fix)
> +	ldr	r4, sdrc_syscfg		@ get config addr
> +	ldr	r5, [r4]		@ get value
> +	tst	r5, #0x100		@ is part access blocked
> +	it	eq
> +	biceq	r5, r5, #0x100		@ clear bit if set
> +	str	r5, [r4]		@ write back change
> +	ldr	r4, sdrc_mr_0		@ get config addr
> +	ldr	r5, [r4]		@ get value
> +	str	r5, [r4]		@ write back change
> +	ldr	r4, sdrc_emr2_0		@ get config addr
> +	ldr	r5, [r4]		@ get value
> +	str	r5, [r4]		@ write back change
> +	ldr	r4, sdrc_manual_0	@ get config addr
> +	mov	r5, #0x2		@ autorefresh command
> +	str	r5, [r4]		@ kick off refreshes
> +	ldr	r4, sdrc_mr_1		@ get config addr
> +	ldr	r5, [r4]		@ get value
> +	str	r5, [r4]		@ write back change
> +	ldr	r4, sdrc_emr2_1		@ get config addr
> +	ldr	r5, [r4]		@ get value
> +	str	r5, [r4]		@ write back change
> +	ldr	r4, sdrc_manual_1	@ get config addr
> +	mov	r5, #0x2		@ autorefresh command
> +	str	r5, [r4]		@ kick off refreshes
> +	bx	lr
> +
> +sdrc_syscfg:
> +	.word	SDRC_SYSCONFIG_P
> +sdrc_mr_0:
> +	.word	SDRC_MR_0_P
> +sdrc_emr2_0:
> +	.word	SDRC_EMR2_0_P
> +sdrc_manual_0:
> +	.word	SDRC_MANUAL_0_P
> +sdrc_mr_1:
> +	.word	SDRC_MR_1_P
> +sdrc_emr2_1:
> +	.word	SDRC_EMR2_1_P
> +sdrc_manual_1:
> +	.word	SDRC_MANUAL_1_P
> +ENTRY(es3_sdrc_fix_sz)
> +	.word	. - es3_sdrc_fix
> +
>  /* Make sure SDRC accesses are ok */
>  wait_sdrc_ok:
>  
Tested-by: Nishanth Menon <nm@ti.com>
Tested on:
SDP3630
SDP3430
Test script:
http://pastebin.mozilla.org/889933

-- 
Regards,
Nishanth Menon
