From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Jun 2016 10:48:10 +0100
Subject: [PATCH] arm64: Handle el1 synchronous instruction aborts cleanly
In-Reply-To: <1465522928-22421-1-git-send-email-labbott@redhat.com>
References: <1465522928-22421-1-git-send-email-labbott@redhat.com>
Message-ID: <20160610094810.GA24528@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 06:42:08PM -0700, Laura Abbott wrote:
> Executing from a non-executable area gives an ugly message:
> 
> lkdtm: Performing direct entry EXEC_RODATA
> lkdtm: attempting ok execution at ffff0000084c0e08
> lkdtm: attempting bad execution at ffff000008880700
> Bad mode in Synchronous Abort handler detected on CPU2, code 0x8400000e -- IABT (current EL)
> CPU: 2 PID: 998 Comm: sh Not tainted 4.7.0-rc2+ #13
> 
> The 'IABT (current EL)' indicates the error but isn't as obvious as a
> regular fault message. The increase in kernel page permissions makes
> hitting this case more likely and bad mode should not be a common
> ocurrence. Handle this case in the vectors to give a better message.

Could you add something about why the new message will be better? e.g.
do we get more info, is it more consistent with the behaviour of other
architectures?

Bad mode is still a rare occurrence, even if triggered deliberately by a
test, but anything that makes debugging easier is good!

> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> Came up during some lkdtm testing
> http://article.gmane.org/gmane.linux.kernel.hardened.devel/2524
> ---
>  arch/arm64/kernel/entry.S | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 12e8d2b..37f3694 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -336,6 +336,8 @@ el1_sync:
>  	lsr	x24, x1, #ESR_ELx_EC_SHIFT	// exception class
>  	cmp	x24, #ESR_ELx_EC_DABT_CUR	// data abort in EL1
>  	b.eq	el1_da
> +	cmp	x24, #ESR_ELx_EC_IABT_CUR	// instruction abort in EL1
> +	b.eq	el1_ia
>  	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
>  	b.eq	el1_undef
>  	cmp	x24, #ESR_ELx_EC_SP_ALIGN	// stack alignment exception
> @@ -347,6 +349,23 @@ el1_sync:
>  	cmp	x24, #ESR_ELx_EC_BREAKPT_CUR	// debug exception in EL1
>  	b.ge	el1_dbg
>  	b	el1_inv
> +el1_ia:
> +	/*
> +	 * Instruction abort handling
> +	 */
> +	mrs	x0, far_el1
> +	enable_dbg
> +	// re-enable interrupts if they were enabled in the aborted context
> +	tbnz	x23, #7, 1f			// PSR_I_BIT
> +	enable_irq
> +	orr	x1, x1, #1 << 24		// use reserved ISS bit for instruction aborts

I'm planning to kill ESR_LNX_EXEC (the reserved ISS bit here), for v4.8
[1,2], so we'll need to figure out how to avoid problems when merging.
My patch only handles the ESR_ELx_EC_IABT_LOW case, but it should be
simple to add ESR_ELx_EC_IABT_CUR.

If you're happy for me to do so, I could take this into my ESR_LNX_EXEC
series.

> +1:
> +	mov	x2, sp				// struct pt_regs
> +	bl	do_mem_abort
> +
> +	// disable interrupts before pulling preserved data off the stack
> +	disable_irq
> +	kernel_exit 1
>  el1_da:
>  	/*
>  	 * Data abort handling
> -- 
> 2.5.5
> 

Otherwise this looks good to me. Modulo the above:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/432107.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/433682.html
