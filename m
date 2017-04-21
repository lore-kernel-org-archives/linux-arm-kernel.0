From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 21 Apr 2017 19:24:53 +0100
Subject: [PATCH 3/4] arm64: entry: improve data abort handling of tagged
 pointers
In-Reply-To: <1492712234-4950-4-git-send-email-kristina.martsenko@arm.com>
References: <1492712234-4950-1-git-send-email-kristina.martsenko@arm.com>
 <1492712234-4950-4-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20170421182450.GR3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 07:17:13PM +0100, Kristina Martsenko wrote:
> When handling a data abort from EL0, we currently zero the top byte of
> the faulting address, as we assume the address is a TTBR0 address, which
> may contain a non-zero address tag. However, the address may be a TTBR1
> address, in which case we should not zero the top byte. This patch fixes
> that. The effect is that the full TTBR1 address is passed to the task's
> signal handler (or printed out in the kernel log).
> 
> When handling a data abort from EL1, we leave the faulting address
> intact, as we assume it's either a TTBR1 address or a TTBR0 address with
> tag 0x00. This is true as far as I'm aware, we don't seem to access a
> tagged TTBR0 address anywhere in the kernel. Regardless, it's easy to
> forget about address tags, and code added in the future may not always
> remember to remove tags from addresses before accessing them. So add tag
> handling to the EL1 data abort handler as well. This also makes it
> consistent with the EL0 data abort handler.

Possibly it doesn't matter whether the tag bits are cleared for an EL0
fault on a TTBR1 address, since userspace can't have a valid pointer in
this range to (mis)match the fault address against ... or did I miss
something?

Factoring out the tag handling makes the intent of the code clearer
though, either way.

Cheers
---Dave

> Fixes: d50240a5f6ce ("arm64: mm: permit use of tagged pointers at EL0")
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>  arch/arm64/include/asm/asm-uaccess.h | 9 +++++++++
>  arch/arm64/kernel/entry.S            | 4 +++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index df411f3e083c..790ce8e64f8d 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -62,4 +62,13 @@ alternative_if ARM64_ALT_PAN_NOT_UAO
>  alternative_else_nop_endif
>  	.endm
>  
> +/*
> + * Remove the address tag from a virtual address, if present.
> + */
> +	.macro	clear_address_tag, addr, tmp
> +	bic	\tmp, \addr, #(0xff << 56)
> +	tst	\addr, #(1 << 55)
> +	csel	\addr, \tmp, \addr, eq
> +	.endm
> +
>  #endif
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 43512d4d7df2..2f7ec392ef50 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -434,6 +434,7 @@ el1_da:
>  	tbnz	x23, #7, 1f			// PSR_I_BIT
>  	enable_irq
>  1:
> +	clear_address_tag x0, x3
>  	mov	x2, sp				// struct pt_regs
>  	bl	do_mem_abort
>  
> @@ -594,7 +595,8 @@ el0_da:
>  	// enable interrupts before calling the main handler
>  	enable_dbg_and_irq
>  	ct_user_exit
> -	bic	x0, x26, #(0xff << 56)
> +	mov	x0, x26
> +	clear_address_tag x0, x3
>  	mov	x1, x25
>  	mov	x2, sp
>  	bl	do_mem_abort
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
