From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Aug 2014 13:34:19 -0700
Subject: [PATCHv3 3/7] arm64: Move cpu_resume into the text section
In-Reply-To: <1408584039-12735-4-git-send-email-lauraa@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
 <1408584039-12735-4-git-send-email-lauraa@codeaurora.org>
Message-ID: <53FB9DCB.3080602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/14 18:20, Laura Abbott wrote:
> The function cpu_resume currently lives in the .data
> section. This breaks functionality to make .data no
> execute. Move cpu_resume to .text which is where it
> actually belongs.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---

This is similar to arm (where I don't see a similar patch to this in
Kees' patchset for RO). In arm we have this comment:

/*
 * Note: Yes, part of the following code is located into the .data section.
 *       This is to allow sleep_save_sp to be accessed with a relative load
 *       while we can't rely on any MMU translation.  We could have put
 *       sleep_save_sp in the .text section as well, but some setups might
 *       insist on it to be truly read-only.
 */

Doesn't the same situation apply here? How is this problem overcome?

But I'm a little confused, shouldn't this code run with the MMU disabled?

>  ENDPROC(cpu_resume_after_mmu)
>  
> -	.data
>  ENTRY(cpu_resume)
>  	bl	el2_setup		// if in EL2 drop to EL1 cleanly
>  #ifdef CONFIG_SMP
>  	mrs	x1, mpidr_el1
> -	adr	x4, mpidr_hash_ptr
> +	adrp	x4, mpidr_hash_ptr
> +	add	x4, x4, #:lo12:mpidr_hash_ptr
>  	ldr	x5, [x4]
>  	add	x8, x4, x5		// x8 = struct mpidr_hash phys address
>          /* retrieve mpidr_hash members to compute the hash */
> @@ -143,14 +143,15 @@ ENTRY(cpu_resume)
>  #else
>  	mov	x7, xzr
>  #endif
> -	adr	x0, sleep_save_sp
> +	adrp	x0, sleep_save_sp
> +	add	x0, x0, #:lo12:sleep_save_sp
>  	ldr	x0, [x0, #SLEEP_SAVE_SP_PHYS]
>  	ldr	x0, [x0, x7, lsl #3]
>  	/* load sp from context */
>  	ldr	x2, [x0, #CPU_CTX_SP]
> -	adr	x1, sleep_idmap_phys
> +	adrp	x1, sleep_idmap_phys
>  	/* load physical address of identity map page table in x1 */
> -	ldr	x1, [x1]
> +	ldr	x1, [x1, #:lo12:sleep_idmap_phys]
>  	mov	sp, x2
>  	/*
>  	 * cpu_do_resume expects x0 to contain context physical address
> @@ -160,6 +161,7 @@ ENTRY(cpu_resume)
>  	b	cpu_resume_mmu		// Resume MMU, never returns
>  ENDPROC(cpu_resume)
>  
> +	.data
>  	.align 3
>  mpidr_hash_ptr:
>  	/*


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
