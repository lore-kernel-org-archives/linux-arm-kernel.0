From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Apr 2016 17:24:02 +0100
Subject: [PATCH v7 09/16] arm64: Change cpu_resume() to enable mmu early
 then access sleep_sp by va
In-Reply-To: <1459529620-22150-10-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-10-git-send-email-james.morse@arm.com>
Message-ID: <20160420162402.GC11377@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 05:53:33PM +0100, James Morse wrote:
>  ENTRY(cpu_resume)
>  	bl	el2_setup		// if in EL2 drop to EL1 cleanly
> +	/* enable the MMU early - so we can access sleep_save_stash by va */
> +	adr_l	lr, __enable_mmu	/* __cpu_setup will return here */
> +	ldr	x27, =_cpu_resume	/* __enable_mmu will branch here */
> +	adrp	x25, idmap_pg_dir
> +	adrp	x26, swapper_pg_dir
> +	b	__cpu_setup

You need an ENDPROC(cpu_resume) here.

> +
> +ENTRY(_cpu_resume)
>  	mrs	x1, mpidr_el1
>  	adrp	x8, mpidr_hash
>  	add x8, x8, #:lo12:mpidr_hash // x8 = struct mpidr_hash phys address
> @@ -134,29 +116,32 @@ ENTRY(cpu_resume)
>  	ldp	w5, w6, [x8, #(MPIDR_HASH_SHIFTS + 8)]
>  	compute_mpidr_hash x7, x3, x4, x5, x6, x1, x2
>          /* x7 contains hash index, let's use it to grab context pointer */
> -	ldr_l	x0, sleep_save_sp + SLEEP_SAVE_SP_PHYS
> +	ldr_l	x0, sleep_save_stash
>  	ldr	x0, [x0, x7, lsl #3]
>  	add	x29, x0, #SLEEP_STACK_DATA_CALLEE_REGS
>  	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS
>  	/* load sp from context */
>  	ldr	x2, [x0, #CPU_CTX_SP]
> -	/* load physical address of identity map page table in x1 */
> -	adrp	x1, idmap_pg_dir
>  	mov	sp, x2
>  	/* save thread_info */
>  	and	x2, x2, #~(THREAD_SIZE - 1)
>  	msr	sp_el0, x2
>  	/*
> -	 * cpu_do_resume expects x0 to contain context physical address
> -	 * pointer and x1 to contain physical address of 1:1 page tables
> +	 * cpu_do_resume expects x0 to contain context address pointer
>  	 */
> -	bl	cpu_do_resume		// PC relative jump, MMU off
> -	/* Can't access these by physical address once the MMU is on */
> +	bl	cpu_do_resume
> +
> +#ifdef CONFIG_KASAN
> +	mov	x0, sp
> +	bl	kasan_unpoison_remaining_stack
> +#endif
> +
>  	ldp	x19, x20, [x29, #16]
>  	ldp	x21, x22, [x29, #32]
>  	ldp	x23, x24, [x29, #48]
>  	ldp	x25, x26, [x29, #64]
>  	ldp	x27, x28, [x29, #80]
>  	ldp	x29, lr, [x29]
> -	b	cpu_resume_mmu		// Resume MMU, never returns
> +	mov	x0, #0
> +	ret
>  ENDPROC(cpu_resume)

and ENDPROC(_cpu_resume) here.

Otherwise it looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
